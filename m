Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE33CC433F5
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 21:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbiJFVmi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 17:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiJFVmg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 17:42:36 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D78BB052
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 14:42:35 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id r17so7440979eja.7
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 14:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cmpI/yCKCJwQHPAR1aowWZsAWm0e8euVErr7uoxv2OA=;
        b=JEeAIger52GyfVZijO/WXRnFiE2o8Wr7vr/w43z3UJhyeXt9GA15yAvX3JGrWOvjr2
         eHpXPteyVC2NBTZtmPHMlWBMcU0Qh3OPUqtAmxgGJsI8zvJUi6RfbrDtdUQetXe4jNJK
         bb4m0jI9iYLxdJAFZuX4XC3CfYTnN29+P3M8+y/B2ouvL8Yysvm6uqS4jyfDmGRoe+MT
         o6HFD7VCZBhojtIgk423OAKfMRLTKjRxxFUZFh38OmmmYfa8ZbWNIYCvHF78StfAvOBK
         V5kCAkEJKr5EbCSB510YZ/nLi3T+SyCuw118xhwX41h+EVgTpV7q5sqqqLZFH23KhKUR
         jn7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cmpI/yCKCJwQHPAR1aowWZsAWm0e8euVErr7uoxv2OA=;
        b=I51zDZtrfjQML/pZw6r+yvCNKHDJfWHI8EFXlIpOCqlMurXR4lBDSLXxldyWuo6o2E
         tBeslXGOSAExHgcA/O0aBum2+zQoTE6KV0HRXN+SN7fKZNzIf/8XJZAp+b32uCIIgI5b
         myMCL0fm++djD7n9AambbAIiKtWTqqsFpPYdeexHmOSI3IOzV5GVBw7lC2bt5AsQZMT4
         T0Yp/uAHwi9Tdvc4j7uWmJQuXAMbOnd0BNth449OZBc7YK3vt6vylLnLW2xy6cVAerKq
         vCkQpprbJMTnuMBtIemXQYVqDSSkrpzDCRjzNhHFOupuZ0I1Po6NKgBXrtiAi4y7GA/0
         iKow==
X-Gm-Message-State: ACrzQf2QZ2XQ4vI13rpW+iQguPMpGSq8mb/v1Ggr5K6rzRii7L/WPRNF
        GsNqtPQMki5EowFVqUdVOgU=
X-Google-Smtp-Source: AMsMyM5Upf/8yXlme9/8LT37nOJxHBRw2acvbxa3YTdswu9KW74HsW1lpN0FGDwCUD/9HL9YX1L/+Q==
X-Received: by 2002:a17:907:75ec:b0:78d:2492:d8af with SMTP id jz12-20020a17090775ec00b0078d2492d8afmr1611384ejc.654.1665092554134;
        Thu, 06 Oct 2022 14:42:34 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id d16-20020a056402079000b004587c2b5048sm197114edy.52.2022.10.06.14.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 14:42:33 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ogYdU-0036Bw-2f;
        Thu, 06 Oct 2022 23:42:32 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: PATCH] bisect--helper: plug strvec leak in bisect_start()
Date:   Thu, 06 Oct 2022 23:35:19 +0200
References: <5c6a4c30-d454-51b6-ec57-9af036b9c4e0@web.de>
 <221005.8635c2u3k5.gmgdl@evledraar.gmail.com> <xmqqy1tunjgp.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqqy1tunjgp.fsf@gitster.g>
Message-ID: <221006.86a668r5mf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 05 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> But I don't get it in this case, why not just:
>>=20=09
>> 	diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>> 	index 4e97817fba5..f9645a9d0df 100644
>> 	--- a/builtin/bisect--helper.c
>> 	+++ b/builtin/bisect--helper.c
>> 	@@ -763,11 +763,9 @@ static enum bisect_error bisect_start(struct bisec=
t_terms *terms, const char **a
>> 	 		strbuf_read_file(&start_head, git_path_bisect_start(), 0);
>> 	 		strbuf_trim(&start_head);
>> 	 		if (!no_checkout) {
>> 	-			struct strvec argv =3D STRVEC_INIT;
>> 	+			const char *argv[] =3D { "checkout", start_head.buf, "--", NULL };
>>=20=09=20
>> 	-			strvec_pushl(&argv, "checkout", start_head.buf,
>> 	-				     "--", NULL);
>> 	-			if (run_command_v_opt(argv.v, RUN_GIT_CMD)) {
>> 	+			if (run_command_v_opt(argv, RUN_GIT_CMD)) {
>> 	 				res =3D error(_("checking out '%s' failed."
>> 	 						 " Try 'git bisect start "
>> 	 						 "<valid-branch>'."),
>>
>> The common pattern for run_command_v_opt() callers that don't need a
>> dynamic list is exactly that.
>
> I think you answered it yourself.  start_head.buf is not known at
> compilation time, and there may be some superstition (it may not be
> a mere superstition, but conservatism) about older compiler not
> grokking it.

I think we're thoroughly past that hump as we have a hard requirement on
designated initializers.

Anyway, I believe GCC's -std=3Dc89 wtith -pedantic catches this, e.g. for
bisect--helper.c (the latter is the above patch):

	$ make -k git-objs CFLAGS=3D-std=3Dc89 2>&1|grep 'initializer element is n=
ot computable at load time'|grep bisect
	builtin/bisect--helper.c:534:43: error: initializer element is not computa=
ble at load time [-Werror=3Dpedantic]
	builtin/bisect--helper.c:768:60: error: initializer element is not computa=
ble at load time [-Werror=3Dpedantic]

For the former we've had:

	static int prepare_revs(struct bisect_terms *terms, struct rev_info *revs)
	[...]
		struct add_bisect_ref_data cb =3D { revs };

In the same file since 517ecb3161d (bisect--helper: reimplement
`bisect_next` and `bisect_auto_next` shell functions in C, 2020-09-24).

Other prior art, just taking the char[] ones (and not even all of them):
=09
	builtin/merge-index.c:12:37: error: initializer element is not computable =
at load time [-Werror=3Dpedantic]
	   12 |         const char *arguments[] =3D { pgm, "", "", "", path, "", "=
", "", NULL };
	builtin/remote.c:95:41: error: initializer element is not computable at lo=
ad time [-Werror=3Dpedantic]
	   95 |         const char *argv[] =3D { "fetch", name, NULL, NULL };
	archive.c:408:33: error: initializer element is not computable at load tim=
e [-Werror=3Dpedantic]
	  408 |         const char *paths[] =3D { path, NULL };
	merge-ort.c:1699:45: error: initializer element is not computable at load =
time [-Werror=3Dpedantic]
	 1699 |                                    "--all", merged_revision, NULL =
};

So I think we can safely use this.=09


