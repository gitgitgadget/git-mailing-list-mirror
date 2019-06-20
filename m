Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C10811F462
	for <e@80x24.org>; Thu, 20 Jun 2019 12:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730886AbfFTMmP (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 08:42:15 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35003 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfFTMmP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 08:42:15 -0400
Received: by mail-qk1-f196.google.com with SMTP id l128so1784792qke.2
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 05:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=pbcrH8ESIbLdoWVIfm3pwtVv1JLd7AyetIHY6AjIq3U=;
        b=cliP9HhldVKB/qooGGkjLJ3OQrSygCPgV2U9yEJX9sl8lvG2yp65oDg4VRLTq38vdi
         SwcTWhh7SHmJxwMrKgnOX/WvttIfi3jUX/bXwiz5Os8ihwlIKCsSId8jb3P0pcM7Trw5
         +P3cQmWy8fgF0YT3eveXZ1tKu1B3pEWSNEVpvJWT1h5WNIMVAIV0TPtvVmYQx1s+SXZ3
         dFlpCRzTwFs1bapD8C2LHGOtsdh0R7h5/RQuS1JfXDeQx/RB+4jG7T4x+e2ypMjr2Szz
         G615jd3tXd61n++CvsRe3yeefFztX04yA5BjlSn6Uu/54NAShqRoDnARuow9Ugjy6lEf
         MeyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pbcrH8ESIbLdoWVIfm3pwtVv1JLd7AyetIHY6AjIq3U=;
        b=BSe1DI2TH1/nGvsWz4r09LnucXU4DH0TVZtTLqdYLKgMhRE4J5w9FDYhurBZQgxEt8
         xlU12FTCoOVt4FVv0yxn9IhBWQ/ATi8i1Ak22svBfzJeyirmfZvgFRmplyceVG4Z3cuK
         NLTMV9/30pRz6IfNAwFsMc2PLZTdoN49gVassUEAzyK7HRxxckcXMXAapxW6fB8Bj70k
         fwJz6AOfP+YMmSu04NcR0BJ3n4zLl61OnOqpli3JjT207NAa1P9+JVyF64T6M1Azo0gv
         olF2GdbdcccvUqtmUuAytpovEsliEaKY4BJQicqJLr3w+V4z7HvsIwuWOvri4GHF2h5f
         YExw==
X-Gm-Message-State: APjAAAWmKwbgo9IIH8XE+PeNNU2GWRUO3Wz/QStPY51zpFW6X6Owk6E6
        cRXbZ6AKLq/K8ilZcAtWceDbZVlN
X-Google-Smtp-Source: APXvYqyZwaotQhPVXqrSYKDrb8QE2JILq5Z1TVCtvsgNqjxfW6sXmV4f8QiXu4fOvnZAzvboLVy+gA==
X-Received: by 2002:a37:6a87:: with SMTP id f129mr21648507qkc.183.1561034534324;
        Thu, 20 Jun 2019 05:42:14 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:a934:2ce3:312e:b671? ([2001:4898:a800:1010:5a6a:2ce3:312e:b671])
        by smtp.gmail.com with ESMTPSA id k33sm12369663qte.69.2019.06.20.05.42.13
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 05:42:13 -0700 (PDT)
Subject: Re: [PATCH] delta-islands: respect progress flag
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20190620085832.GA5039@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <77c41405-2270-1a48-2277-533f26ac1530@gmail.com>
Date:   Thu, 20 Jun 2019 08:42:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <20190620085832.GA5039@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/20/2019 4:58 AM, Jeff King wrote:
> The delta island code always prints "Marked %d islands", even if
> progress has been suppressed with --no-progress or by sending stderr to
> a non-tty.
> 
> Let's pass a progress boolean to load_delta_islands(). We already do
> the same thing for the progress meter in resolve_tree_islands().
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Arguably this should be a real progress meter that counts up, but I'm
> not sure what it should be counting. Refs we analyzed? Islands found?
> Unless you have a ton of refs, it doesn't really matter, so I just
> punted on that part for now and only fixed the egregious bug. :)

I agree that the first goal should be to stop writing 'progress' output
to stderr when progress is disabled. Changing this to a full progress
indicator can be done on top of this patch later (without changing the
method prototypes again) if desired.

LGTM.
-Stolee

