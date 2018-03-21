Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01C591F404
	for <e@80x24.org>; Wed, 21 Mar 2018 21:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753824AbeCUVty (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 17:49:54 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40898 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753749AbeCUVtx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 17:49:53 -0400
Received: by mail-wm0-f68.google.com with SMTP id t6so12557664wmt.5
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 14:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jcfOj1HtzOjncv03oSeBhi/gV5ndCzXRrG1ghefzyFg=;
        b=DxOOqD34PybXaZVqx94++8AN1p7jyBlTA1FgA0PNe/uBGaXFV1FWDfHk4StH2foskv
         fKoboFNBAY1QeCW5C0LTLLOtzeGHSoq8vd3x0dZbHE24O4MHnIBaxg6ReLCz1CbD/Kt1
         SS8rFUtYCU1jaHF+3YVHQSBN/pByZmBornTjm/HPFTHD0nsGrgAPK1D2OrCBo67XaLqA
         FJyy6fH6rqc/LPwgypA4QUEfat5m7e8pV+Tlyeqne1JyFpdSEiFQfSIBOtd/XgcZivWE
         /tsIBxZJHgRSazLyVQ/eEQhbbkz8U11bgQRypUmdQqWuF0XW9WxdV60379vgl5wIdHgb
         /GDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jcfOj1HtzOjncv03oSeBhi/gV5ndCzXRrG1ghefzyFg=;
        b=W8oObq2w5tqxv6PFn9xBixsRjPFKczMVd59wzZfd91ZFEw57SVUfreocZH8Rss1ZXE
         O3egZCbyr39AJB8cT6ujJKDBmJHfKLQCgKAdpmhUt5LcabKPNB/5l+EY9azaPipwzlT+
         DpC1wmfMIHIe7mVvT8MGzMW+WfDv36NyB28o3HF4x9TfvCRBqR7rQ8wh92qefbtHweu2
         bMd9Pc5RnUYKYKSeDnfkRuM3nT8hTf/P1psDnx/VU4ptNn6Vhmi2GzgU9SiKeFrttMKN
         HSBUE/7zE/a4uIIOCVWge8Z7Qoxn/6fFilSNFQApI7CqB4cwMz8mG4dYSqDUh7ZA4d+e
         h0Ig==
X-Gm-Message-State: AElRT7Halz1LmqXKtosB/vy7DCcL50rUjXdIoF2I/a1CZ9evifP2Ws9+
        ZXgw12MDlDfr8tnbmn7DwHE=
X-Google-Smtp-Source: AG47ELtP16PangfV8ouYcjbyfYy9j53G3BucX00f4o80ixMB2hnUEMyKRqlmbqMo9vk8giOOob2qeA==
X-Received: by 10.28.170.5 with SMTP id t5mr3777335wme.116.1521668992044;
        Wed, 21 Mar 2018 14:49:52 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id l22sm5157207wmi.39.2018.03.21.14.49.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Mar 2018 14:49:51 -0700 (PDT)
Date:   Wed, 21 Mar 2018 21:53:10 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Marc Strapetz <marc.strapetz@syntevo.com>
Subject: [PATCH] stash: drop superfluos pathspec parameter (was: Re: [PATCH
 v5 2/3] stash push: avoid printing errors)
Message-ID: <20180321215310.GH2224@hank>
References: <20180316223715.108044-1-gitster@pobox.com>
 <20180319232156.30916-1-t.gummerer@gmail.com>
 <20180319232156.30916-3-t.gummerer@gmail.com>
 <xmqqzi32sn5u.fsf@gitster-ct.c.googlers.com>
 <20180321213626.GG2224@hank>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321213626.GG2224@hank>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/21, Thomas Gummerer wrote:
>
> Argh I just noticed we could drop the "$@" here, as this is no longer
> the pathspec case.  It doesn't hurt anything, except it may be a bit
> confusing when reading the code.
> 
> Although if we end up implementing 'git checkout --index <pathspec>',
> we'd have to add it back, but we do have a test covering this case, so
> there's no worries about forgetting to add it back.

Here's a patch for that.  Not sure it's worth doing, but since we're
already touching the area, this may be a good cleanup.

This is based on top of tg/stash-untracked-with-pathspec-fix.

--- >8 ---
Subject: [PATCH] stash: drop superfluos pathspec parameter

Since 833622a945 ("stash push: avoid printing errors", 2018-03-19) we
don't use the 'git clean' call for the pathspec case anymore.  The
commit however forgot to remove the pathspec argument to the call.
Remove the superfluos argument to make the code a little more obvious.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 git-stash.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-stash.sh b/git-stash.sh
index 4e55f278bd..d31924aea3 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -310,7 +310,7 @@ push_stash () {
 		test "$untracked" = "all" && CLEAN_X_OPTION=-x || CLEAN_X_OPTION=
 		if test -n "$untracked" && test $# = 0
 		then
-			git clean --force --quiet -d $CLEAN_X_OPTION -- "$@"
+			git clean --force --quiet -d $CLEAN_X_OPTION
 		fi
 
 		if test $# != 0
-- 
2.15.1.33.g3165b24a68

