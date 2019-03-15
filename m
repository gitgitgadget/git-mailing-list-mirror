Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E5E9202BB
	for <e@80x24.org>; Fri, 15 Mar 2019 13:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbfCONZy (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 09:25:54 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40624 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbfCONZy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 09:25:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id u10so3508213wmj.5
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 06:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LCnMqGQtzxehzZWY0GPRtoo7WOMMFEaokcA6BFmQxYU=;
        b=fXFGxSBiIyfrbQl0LrN04af8BcFnnwTPPHlznNIzO5NEcZmT8Eig1GdUEuvmVHiGJr
         qCD9afoXjE8hUuol0xRMiNhK9EzykUFJsJuovkHRGhD2ENYuAkofrVCwJCRglJvyCCjS
         YVMdDJMLAZqFW9eoM+LMiogxBuPdeWPrrfVQL7Vtzgft4D167log7tbxIQONIaGQXhcy
         +OD/xq/PDHNiA0UcC2LsAB5PoNCT7z/mRZ/HIde+ojeJx0zNBXyFiroyTmwo5IdhMUVn
         WuQixB7BoG+d/B5VuVgvdQSRl0WRLt7SA011KI4cnuOMjhT2DGfbbBzqR1ubFa9nS5w6
         4kOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LCnMqGQtzxehzZWY0GPRtoo7WOMMFEaokcA6BFmQxYU=;
        b=UooZIXoWsTSRGIKZH+zfX8ZlYvnKllgrySx85wcJ4HlYKCLb4ZYvGWkyTkVlxqi3d5
         kl+gt0YzfmPwJQnV5c7Qd9Mbb5PWtfWfhxQjIC/4QRtSXu/EgiGhPw2wK2E6ng446PNW
         T0IL0mVb6B0DD+zrDDaAGBIFPWF0k38QWmq8p4pWS5rhh43vVDcby7KhP7OV3hcVBVMu
         u/ueuFIBBgu0IoWZrIPZglJgE/QJNgD1iHb/SGBYXsoMSPRTpSA7Jr2AGDXk+wc1fPpc
         vEFv93gTzJ976UD5N4n4Rq1zrMsTSuhln/kJw7UWBPDn4/qGhyXbHX93FAtEqWdOJ/ot
         PgAg==
X-Gm-Message-State: APjAAAWCVtW13PPCI3hTG3JwXaGre4EVLpiPZd/Peg2lh5f+Aapyjp2h
        ltj6obyPJ8bQbcPIG9Sx4VQ=
X-Google-Smtp-Source: APXvYqxVe9G2SlZL0KXDSItDS2LrH73k+WSCP80hYNKvevgYPRBnQ4vpChJiuHz+BW3hjYwyi5XERQ==
X-Received: by 2002:a1c:80d6:: with SMTP id b205mr2247310wmd.109.1552656352037;
        Fri, 15 Mar 2019 06:25:52 -0700 (PDT)
Received: from szeder.dev (x4db40a84.dyn.telefonica.de. [77.180.10.132])
        by smtp.gmail.com with ESMTPSA id m15sm1992558wrx.30.2019.03.15.06.25.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 06:25:51 -0700 (PDT)
Date:   Fri, 15 Mar 2019 14:25:45 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/2] t5310: correctly remove bitmaps for jgit test
Message-ID: <20190315132545.GA24175@szeder.dev>
References: <20190315062133.GA13385@sigill.intra.peff.net>
 <20190315062243.GA13466@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190315062243.GA13466@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 15, 2019 at 02:22:44AM -0400, Jeff King wrote:
> We use "jgit gc" to generate a pack bitmap file, and then make sure our
> implementation can read it. To prepare the repo before running jgit, we
> try to "rm -f" any existing bitmap files. But we got the path wrong;
> we're in a bare repo, so looking in ".git/" finds nothing. Our "rm"
> doesn't complain because of the "-f", and when we run "rev-list" there
> are two bitmap files (ours and jgit's).

Oh, indeed.

> Our reader implementation will ignore one of the bitmap files, but it's
> likely non-deterministic which one we will use. We'd prefer the one with
> the more recent timestamp (just because of the way the packed_git list
> is sorted), but in most test runs they'd have identical timestamps.
> 
> So this was probably actually testing something useful about 50% of the
> time, and other half just testing that we could read our own bitmaps
> (which is covered elsewhere).

At least it was testing the right thing up until 87a6bb701a
(t5310-pack-bitmaps: make JGit tests work with GIT_TEST_SPLIT_INDEX,
2018-05-10) came along.


>  t/t5310-pack-bitmaps.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
> index 82d7f7f6a5..44a038881a 100755
> --- a/t/t5310-pack-bitmaps.sh
> +++ b/t/t5310-pack-bitmaps.sh
> @@ -269,7 +269,7 @@ test_expect_success JGIT 'we can read jgit bitmaps' '
>  	git clone --bare . compat-jgit.git &&
>  	(
>  		cd compat-jgit.git &&
> -		rm -f .git/objects/pack/*.bitmap &&
> +		rm -f objects/pack/*.bitmap &&
>  		jgit gc &&
>  		git rev-list --test-bitmap HEAD
>  	)
> -- 
> 2.21.0.543.g90eed137f3
> 
