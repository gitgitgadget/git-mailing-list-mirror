Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9ADC433EF
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 19:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237257AbiBRT3D (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 14:29:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbiBRT3C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 14:29:02 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D5635865
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 11:28:45 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id x5so17116892edd.11
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 11:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=5vQA+GkZ3g1eIRyHEbkFhH/kwKfkadHdZwjVyb4+COQ=;
        b=kr8OcfrCMSysjjr7Tw2/leP2y2U6rwfbXbs4qF7DSuPKRcm1R28ovlQT3XWU2yfLmC
         o/U+q/OUuK0K5CAx74TOOhsJ5CVU1T2y0J2Y2jDExjIKbJ1aOEP/7nPDuAkqIKCabukF
         K/vFzf0U1IXCVjddddkC1CNYSPUFIi5MRvPTbycBuzPkvvLEdvJ0Ysd7psZSqttilvoN
         vxzC2fPjgsz5FpN9nVXWIpL6fgz8h1wM1a2bTMhPmSF4f3tpnLY4dEHqnDQiEKRWk5Uc
         vwN5OwwWqKR3Vw3TGAvnHEYTHbmisuJYmEdKPcPV6XNalLaTNuO7YIdPapj31TLpzJV1
         ASdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=5vQA+GkZ3g1eIRyHEbkFhH/kwKfkadHdZwjVyb4+COQ=;
        b=GDWaRsicG+UpH/hz3UPWslPd2MM9qN31CaoWl74Xt2BPD9z9yO61nwlQD/524lDIcp
         0Lk8Y0oFwhskkTVA2J120A88fMUiERTuup5InFqLzpkzIL09EoiWqbOhnDIvYZO9XSFG
         5Y8me6vPZARL0rtZURelku9XXz7GsMiQbHoZhmgjqQOtQxmEm2GabHAWFDQDcPweGOA+
         wSK7HxPuMow0b2KDh5EKd2rPCr8pGpAmOyoKor3HeKaikao9HDD7iIG1mlzyWr5m+HPh
         4U603ptdUIUMf2XO6evrufl0q8UEGSX4Qg+VknqHFBdBz4q/TJXsOqOai9mHMo4kxLSw
         WMow==
X-Gm-Message-State: AOAM533Xe/jjwyhJ3MmUC6AaMOuLBHrZi9LxuCgkCwZrnSci7ypz6H9n
        Qes15ZPrhLw44aHCA16wY7+5sd/Nsy0=
X-Google-Smtp-Source: ABdhPJzKr94GEjgcCIHdclg5UzOGrTQ7LCtrdnmoxgoXJKhYa02swbNN2qI3HJ7Fy85dH8R/wmu9kA==
X-Received: by 2002:a50:e0c7:0:b0:410:a63f:e1d with SMTP id j7-20020a50e0c7000000b00410a63f0e1dmr9626260edl.391.1645212523677;
        Fri, 18 Feb 2022 11:28:43 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id i28sm2573783ejo.49.2022.02.18.11.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 11:28:43 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nL8vq-004MKM-PJ;
        Fri, 18 Feb 2022 20:28:42 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 3/3] stash: call reflog_delete from reflog.c
Date:   Fri, 18 Feb 2022 20:20:13 +0100
References: <pull.1218.git.git.1645209647.gitgitgadget@gmail.com>
 <bcc1eae053124f6e68f60a7a02cbee4744a022f0.1645209647.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <bcc1eae053124f6e68f60a7a02cbee4744a022f0.1645209647.git.gitgitgadget@gmail.com>
Message-ID: <220218.86o834gej9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 18 2022, John Cai via GitGitGadget wrote:

> From: John Cai <johncai86@gmail.com>
>
> Now that cmd_reflog_delete has been libified an exported it into a new
> reflog.c library so we can call it directly from builtin/stash.c. This
> not only gives us a performance gain since we don't need to create a
> subprocess, but it also allows us to use the ref transactions api in the
> future.
>
> Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: John Cai <johncai86@gmail.com>

Very nicely done, and nice that despite the ~500 lines added/removed in
the diffstat that the "actual" changes in this series are so small.q

> @@ -635,18 +636,9 @@ static int reflog_is_empty(const char *refname)
>  static int do_drop_stash(struct stash_info *info, int quiet)
>  {
>  	int ret;
> -	struct child_process cp_reflog =3D CHILD_PROCESS_INIT;
> -

Nit: We usually separate variables decls with a \n\n, as is done in the
pre-image, but you end up dropping that.

> -	/*
> -	 * reflog does not provide a simple function for deleting refs. One will
> -	 * need to be added to avoid implementing too much reflog code here
> -	 */
> -
> -	cp_reflog.git_cmd =3D 1;
> -	strvec_pushl(&cp_reflog.args, "reflog", "delete", "--updateref",
> -		     "--rewrite", NULL);
> -	strvec_push(&cp_reflog.args, info->revision.buf);
> -	ret =3D run_command(&cp_reflog);
> +	ret =3D reflog_delete(info->revision.buf,
> +			    EXPIRE_REFLOGS_REWRITE | EXPIRE_REFLOGS_REWRITE,
> +			    0);
>  	if (!ret) {
>  		if (!quiet)
>  			printf_ln(_("Dropped %s (%s)"), info->revision.buf,

I think per the above squashing this in would be nice, i.e. you get rid
of the long line & it'sclear that "ret" is not used for anything now:

diff --git a/builtin/stash.c b/builtin/stash.c
index d0967b3d3c3..7b939576720 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -635,11 +635,9 @@ static int reflog_is_empty(const char *refname)
=20
 static int do_drop_stash(struct stash_info *info, int quiet)
 {
-	int ret;
-	ret =3D reflog_delete(info->revision.buf,
-			    EXPIRE_REFLOGS_REWRITE | EXPIRE_REFLOGS_REWRITE,
-			    0);
-	if (!ret) {
+	unsigned int flags =3D EXPIRE_REFLOGS_REWRITE | EXPIRE_REFLOGS_REWRITE;
+
+	if (!reflog_delete(info->revision.buf, flags, 0)) {
 		if (!quiet)
 			printf_ln(_("Dropped %s (%s)"), info->revision.buf,
 				  oid_to_hex(&info->w_commit));

But, having written that I notice that we have *_REWRITE twice there, so
I almost just carried forward a new bug in 3/3 when composing this :)

So one should be EXPIRE_REFLOGS_UPDATE_REF, presumably.

And perhaps it's a big pain, but that suggests that the code isn't
either used at all, or that we're missing a test for it.

So adding a prep commit to this series where we either drop it, or add
the missing test would be a very nice addition.

See my quite recent 5ac15ad2509 (reflog tests: add --updateref tests,
2021-10-16) for adding such tests, but in that case I just covered "git
reflog" itself, not "git stash". Maybe we can just add something to that
for-loop in t1417 (or similar for a new stash test).

Also, a s/unsigned int flags/enum expire_reflog_flags/ while we're at it
would be very nice here, but that could be done as another small prep
commit. I.e. it's *not* a new issue since cmd_reflog_delete() had it
before, but when converting this to a documented API it would be very
nice to have it reflect the actual type we end up using.
