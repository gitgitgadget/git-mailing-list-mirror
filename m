Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B5F21F404
	for <e@80x24.org>; Mon, 19 Mar 2018 14:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755757AbeCSOgq (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 10:36:46 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:54552 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755745AbeCSOgn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 10:36:43 -0400
Received: by mail-wm0-f53.google.com with SMTP id h76so15637712wme.4
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 07:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=3cghDmR3NAG3tpX5LOp7pOheXENNnKZvb7iVxGUMaQ8=;
        b=uDjOu96JmcX+SW1ZejlDjDS6r5g2EDin2tRX1DovtFQ++7ZcNqTmHGWt88e1faEs3p
         K1hIPOERXHJVRaJ2IxDXqqx2y87L5bXC0kBG5GZWbR5+UmOGS+jc5FQdsIFR24QH0sYA
         zWzdFgPAbA6OilSgi/pUdQ1lN6dJDHWGcp8MfYdE0BzYhNMrvVeNVFm+kz5JeuwLL83Y
         AJRCY89XT2DuqLlep12kLW2d6ecfKMvbellCrCeABLoE1KZIEKzHrGcaAhHS6rjmMdwW
         s6AdWI0f1plVLH/70Gljgf8XCqR6t7BiA7NriNvhj8JBP6FvUa2svg58Cu0EpVHLMF1a
         TNAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=3cghDmR3NAG3tpX5LOp7pOheXENNnKZvb7iVxGUMaQ8=;
        b=fjqQfFhs5Qu57j+8yTgIQuLek5rQXtk7gZtp4AsKWpMHRshdFNjR2H8Ph/QBCj93rS
         mAcqa2Bjr6uB125eEbPPzCLdrdXFF+inTpJmFoNB6YA6swuHOApHenMAm4d1zSTa8shq
         7mzSvKVWB4mX3qOu+fDbw+QEghAxfbIzsfK57bnL/4IU4rIUke4oe3+5Xn9U7mMcGrFe
         pzDXhWelp46tXEwJg7CSusI/0ZlE0eIk4Jk+c9qpZZF0rKAY1m4KM7KNRWzJ8yVIYd5y
         u4IpA/p8N0IlwVlZtX/vnzeSG3EMYkuDlPw6JkR+KjTuWEmFPRFJWdrd1hK2zuMy0GW7
         b5HQ==
X-Gm-Message-State: AElRT7HB2ICGoGXZeojxcLrEfevHs0c/xqU/ILqvc/esiOKVhqT2IlHD
        pFBZES8bplWVMjIhz0z20oB9z2Z/
X-Google-Smtp-Source: AG47ELtex8d6weFSazbgzXGs0uPmpYlpFt73GXWLaQfCY4m+IttW+e0brRlJONZPQH028V4+04pn/w==
X-Received: by 10.80.194.10 with SMTP id n10mr13663746edf.84.1521470201473;
        Mon, 19 Mar 2018 07:36:41 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id c7sm296019edn.15.2018.03.19.07.36.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Mar 2018 07:36:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        sbeller@google.com, szeder.dev@gmail.com,
        ramsay@ramsayjones.plus.com, git@jeffhostetler.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v6 07/14] commit-graph: implement 'git-commit-graph write'
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com> <20180314192736.70602-1-dstolee@microsoft.com> <20180314192736.70602-8-dstolee@microsoft.com> <87bmflcy8a.fsf@evledraar.gmail.com> <5e394b91-fa78-5b70-8c5e-b06cc332bb3a@gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <5e394b91-fa78-5b70-8c5e-b06cc332bb3a@gmail.com>
Date:   Mon, 19 Mar 2018 15:36:34 +0100
Message-ID: <874llccetp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 19 2018, Derrick Stolee jotted:

> On 3/18/2018 9:25 AM, Ævar Arnfjörð Bjarmason wrote:
>> On Wed, Mar 14 2018, Derrick Stolee jotted:
>>
>>> +'git commit-graph write' <options> [--object-dir <dir>]
>>> +
>>> +
>>> +DESCRIPTION
>>> +-----------
>>> +
>>> +Manage the serialized commit graph file.
>>> +
>>> +
>>> +OPTIONS
>>> +-------
>>> +--object-dir::
>>> +	Use given directory for the location of packfiles and commit graph
>>> +	file. The commit graph file is expected to be at <dir>/info/commit-graph
>>> +	and the packfiles are expected to be in <dir>/pack.
>> Maybe this was covered in a previous round, this series is a little hard
>> to follow since each version isn't In-Reply-To the version before it,
>> but why is this option needed, i.e. why would you do:
>>
>>      git commit-graph write --object-dir=/some/path/.git/objects
>>
>> As opposed to just pigging-backing on what we already have with both of:
>>
>>      git --git-dir=/some/path/.git commit-graph write
>>      git -C /some/path commit-graph write
>>
>> Is there some use-case where you have *just* the objects dir and not the
>> rest of the .git folder?
>
> Yes, such as an alternate. If I remember correctly, alternates only
> need the objects directory.
>
> In the GVFS case, we place prefetch packfiles in an alternate so there
> is only one copy of the "remote objects" per drive. The commit graph
> will be stored in that alternate.

Makes sense, but we should really document this as being such an unusual
option, i.e. instead say something like.

    Use given directory for the location of packfiles and commit graph
    file. Usually you'd use the `--git-dir` or `-C` arguments to `git`
    itself. This option is here to support obscure use-cases where we
    have a stand-alone object directory. The commit graph file is
    expected to be at <dir>/info/commit-graph and the packfiles are
    expected to be in <dir>/pack.
