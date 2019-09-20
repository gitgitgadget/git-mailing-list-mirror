Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6E4F1F463
	for <e@80x24.org>; Fri, 20 Sep 2019 18:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405210AbfITSRg (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 14:17:36 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:39751 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389097AbfITSRg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 14:17:36 -0400
Received: by mail-wm1-f41.google.com with SMTP id v17so3152625wml.4
        for <git@vger.kernel.org>; Fri, 20 Sep 2019 11:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7S4755HLjC6LuEo8DI8NGsa4T/9I3BZHhBzvaGwbODQ=;
        b=QhlfJMZ5QclpwGoiq/Egq4qw/4Kn+2eHwCexCRAnMLwnYS4YYj4JVf/5/KzoUcekfG
         kPymSvnPlIlM4KRERnbr9FXNZfdMX9xYRQC188YhvKPbYAK8weRS3/w80GLE+DR3+20Y
         ILavJiKoeiys3qTAWFsj7Y/KmGmzIuNPt6dWj9zfZfWkrSnhswdcffXzikIJfreDsag8
         RcGT+WIVFr58ndWHEbizm59I+tOqs4hYzv8nsw8Cnm0QjHA/t5QJg7ElQdKFG+IGYZyE
         cZ6DZ9OsanJz76mKKrZgS/RFEISM+nL8JHOhMEMkLPW4lHclDpMS6RKEMJSmczxesoMU
         2t4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7S4755HLjC6LuEo8DI8NGsa4T/9I3BZHhBzvaGwbODQ=;
        b=IHdvRa7sjuiBvcamAWRoz9UwkvZgtd9DtHdj41Ev4/CKD71rfmjV8rGhtxRfrKwaas
         w9FK8a+Nc/5OtQofIRkfMHpDWQpV3aSdoJSfPpt+sEOTDUA6q8CsVV1FY3O7CuHkIxru
         FwbnobzZn5NTKFlWk0ffbj5gsY+aBTuKhEXjf+vpwH2RfV8xd6tdwW5zVUdUmPZmrMCa
         Qbuz+cY6UZ04KBoOYJF0fvGI9vil4UITbwVnyhBhWAeAWS+Tm9PK21XX61DBjRiMjWWp
         a5gf/enqKWceMga5hdRum7vg2qhajczQhHTAErgCXdOhLOjMvNLDU8DX1WCJN0FmozY2
         008Q==
X-Gm-Message-State: APjAAAXr5PclWq9MnIrof0h1d9UATsJpA0Mhpja7WUa/j8lnQXemAPfb
        LE4E4lPCSxXTjRwuuvNAXPa2iZPV
X-Google-Smtp-Source: APXvYqz/P935f7LU1qid0tZFB5G/kn8k9ByTnXnwAJq1SRItQz1XDj7PVtu9S9IYjN/29WYfaOT4AQ==
X-Received: by 2002:a1c:980e:: with SMTP id a14mr4261601wme.99.1569003454338;
        Fri, 20 Sep 2019 11:17:34 -0700 (PDT)
Received: from szeder.dev (x4db40123.dyn.telefonica.de. [77.180.1.35])
        by smtp.gmail.com with ESMTPSA id e6sm3211745wrp.91.2019.09.20.11.17.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 11:17:33 -0700 (PDT)
Date:   Fri, 20 Sep 2019 20:17:32 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] travis-ci: ignore already tested trees in debug mode
Message-ID: <20190920181732.GC26402@szeder.dev>
References: <20190919173514.24074-1-szeder.dev@gmail.com>
 <xmqqftkqvo8r.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqftkqvo8r.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 20, 2019 at 11:03:48AM -0700, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> >  skip_good_tree () {
> > +	if test "$TRAVIS_DEBUG_MODE" = true
> > +	then
> > +		return
> > +	fi
> 
> I think you convinced readers why it is a good idea to avoid
> skipping an already tested tree, and technically the title of this
> commit is not incorrect per-se.  You are teaching to ignore
> "already-tested-ness" from a part of the logic).

Hrm, that's subtle, but you are right.

> But in the larger picture, I would expect that readers would more
> immediately grasp what it is about if it were titled "do not skip
> versions that have already tested good in debug mode"

Will try to come up with a better subject line, but I don't have any
usable ideas at the moment.

> or something
> like that (IOW, we do not want to ignore such trees, we want to test
> them again).
> 
