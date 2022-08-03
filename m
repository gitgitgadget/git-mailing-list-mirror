Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEF0C19F2B
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 23:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236902AbiHCXK2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 19:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiHCXK1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 19:10:27 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFECB7D6
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 16:10:26 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id c20-20020a6566d4000000b0041c325bd8ffso3625910pgw.4
        for <git@vger.kernel.org>; Wed, 03 Aug 2022 16:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc;
        bh=529e8nFfquDEEwqEB/rOLkt9tRSMIPb7X0w/oOwvfvc=;
        b=hFJjHTAOosUmaUiL18ZUcYLrg90UaO8PbnqmfHt8N9fNFdZXyCvvB+qr27DLtxH278
         +NTeXm6Ki/f0o3GhKWWsISAuzM7Zbo7F7R32rJctpzB9bRGqgCtcgPhi+I8vtxYaYwwj
         KcuXUDbfHV5V3XvIO9mXcVRUZPWEpOJXi8i9i+oET59b7q/U460VdPg+BI+wdvlAudW4
         qsbb18Loe87w5Qh03wJyDp67gvVzsrBghfpeTWcTsHWwRAdiacoxYCXvjZSFpbpJsUvN
         AXNLDRvOCZBU98M3hZnRcmCMUiH4RDVKMzZX+mzOm4W8xme99HyY456CespdquUebuLx
         mBeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc;
        bh=529e8nFfquDEEwqEB/rOLkt9tRSMIPb7X0w/oOwvfvc=;
        b=miXLPdl/mIDwW8VGeDAqy2j+GfewO+C8sC6Kszb1gYHI+M5TvKqE/NhrQcnDIf6gz9
         kHzMUNI8sMsZbh1kb/Yfm6Ky41u8T1ZK4jyKufjH/zP53CJaKe3F/jZlwSFJdPFC2Tqr
         4NHv+pH1XGeU0Ie8w5imaLlBGKHFjBBNU86Lm7bCUWtUOE9w4RQjdlCA1F2mkPwfRYhn
         TFQps3KQ/MvsjuTTJnpt3DEivnq8snSvb+L7HBJz8cLeptTuGAwAAh15EJBQMK23lAYf
         Iotixiadfh2bhjYdkhKa7Gaqs1zhlBRMnSsUr4G+Dz6I7TE+B9amJRDRatB0rrG07l9V
         xkEQ==
X-Gm-Message-State: ACgBeo2iRt1OqTOQ2Rst9zeY9gr5HqqV3iIk4GzlU/fGGVQrru6JEmOI
        J8uL8IujOYWXH8CC+g5T7LNFeXT4eQ5uxw==
X-Google-Smtp-Source: AA6agR7sNwO4S+EepwPZRAXWTu8Bn9YaJ/hyZ3WCQPMG/4M1Az9HDTXeh87TPn69CPaqigdgnJ37Hjr6caxCqQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:7e84:b0:16d:be50:f729 with SMTP
 id z4-20020a1709027e8400b0016dbe50f729mr28569981pla.16.1659568226176; Wed, 03
 Aug 2022 16:10:26 -0700 (PDT)
Date:   Wed, 03 Aug 2022 16:10:24 -0700
In-Reply-To: <patch-v5-08.17-3c4f734e958-20220802T155002Z-avarab@gmail.com>
Message-Id: <kl6l8ro4udnj.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com>
 <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com> <patch-v5-08.17-3c4f734e958-20220802T155002Z-avarab@gmail.com>
Subject: Re: [PATCH v5 08/17] submodule--helper: fix "sm_path" and other
 "module_cb_list" leaks
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Fix leaks in "struct module_cb_list" and the "struct module_cb" which
> it contains, these fixes leaks in e83e3333b57 (submodule: port

s/fixes/fix

The diff itself LGTM.

> submodule subcommand 'summary' from shell to C, 2020-08-13).
>
> The "sm_path" should always have been a "char *", not a "const
> char *", we always create it with xstrdup().
>
> We can't mark any tests passing passing with SANITIZE=3Dleak using
> "TEST_PASSES_SANITIZE_LEAK=3Dtrue" as a result of this change, but
> "t7401-submodule-summary.sh" gets closer to passing as a result of
> this change.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/submodule--helper.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 68bf0f9178f..f332627d19e 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -755,16 +755,34 @@ struct module_cb {
>  	struct object_id oid_src;
>  	struct object_id oid_dst;
>  	char status;
> -	const char *sm_path;
> +	char *sm_path;
>  };
>  #define MODULE_CB_INIT { 0 }
> =20
> +static void module_cb_release(struct module_cb *mcb)
> +{
> +	free(mcb->sm_path);
> +}
> +
>  struct module_cb_list {
>  	struct module_cb **entries;
>  	int alloc, nr;
>  };
>  #define MODULE_CB_LIST_INIT { 0 }
> =20
> +static void module_cb_list_release(struct module_cb_list *mcbl)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < mcbl->nr; i++) {
> +		struct module_cb *mcb =3D mcbl->entries[i];
> +
> +		module_cb_release(mcb);
> +		free(mcb);
> +	}
> +	free(mcbl->entries);
> +}
> +
>  struct summary_cb {
>  	int argc;
>  	const char **argv;
> @@ -1108,6 +1126,7 @@ static int compute_summary_module_list(struct objec=
t_id *head_oid,
>  cleanup:
>  	strvec_clear(&diff_args);
>  	release_revisions(&rev);
> +	module_cb_list_release(&list);
>  	return ret;
>  }
> =20
> --=20
> 2.37.1.1233.ge8b09efaedc
