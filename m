Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57D3C433EF
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 18:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240536AbiGNSMM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240546AbiGNSMJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 14:12:09 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCD468DE2
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 11:12:08 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id g67-20020a636b46000000b0040e64eee874so1580503pgc.4
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 11:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=81KSJu50ooAt3tSGZ1n6xhQbmrKnFZN/I6334clMoEw=;
        b=Cfhvjlk4WS47EIQ13iqcHtrhfnI4XpPeBJm0oli3jNnX5ULvo2UCKWGri5NPmkKhcq
         MklPG3yuypgUVKF426rGs0/+zVHeX4DgiIgLzM8aOt2KYqvl6YSIV2lUbn+UpRVeVcK6
         2nT0ftnBnXTFWzd4AbtTNmHQUUrlQXBWdhiP9KUZyTfp2wn8TekWkBhwxojoI5qb4+1m
         0IWtLg9WRHj/xZHZOSkST63QPzUlpYEp454mZnyer1bfslzYXSPAb48xkutZKBHkYkqs
         DT9L0m2ySPP/bQ/SBOxKgkS4NfA91NFyJRLHfQsjnHFshsvihD7/0VrkNz0xGakfzPUU
         wIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=81KSJu50ooAt3tSGZ1n6xhQbmrKnFZN/I6334clMoEw=;
        b=QC/DMTnZIS1rTEmG4eLS8AnbFgiD2H/M1mwUzlZrPx2lJq5KLX679e2HCKWkAJumxf
         GI2XWnj1iz61fzQHrjralJDH02GPdsJGO5stNN73lzuo/oHJRtXFPHkgd9booEON5t5c
         OBLr9GOHqgD6P2PPUWFershYEd/oub+QvZczq227egGiZmNMJ2rjvYzrI0FCn1vM8mO4
         qn+iKbgbnqkTxQSEVXl0z+EsUhIQLdhrUMOMfdaDbf3X1uGS5rs8NyarUWJiJMSwMEg3
         Dcip4Iv+abCoPI9rl0F0u7YkR4riuMnS/n/0r7pMvhKsRf4Gf7cjgt/IHL3eXg9s+Xq9
         74Wg==
X-Gm-Message-State: AJIora/vNgLOwbj6dwzM26cQyjt9KBF+0iH5njapBbaYR/e2MfCKGpQM
        0aZrN4CkWN45xp0v6IVHn2u/A5E0LRMk6Q==
X-Google-Smtp-Source: AGRyM1uOe8CaRxEzYLHqmmtkSjFpTbUMAyGV81HQAcdqBUm+RDcqB0WWYpBXOkVeGtaE3WORnOdrqFeaEK1MBg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:c792:b0:16b:e725:6f65 with SMTP
 id w18-20020a170902c79200b0016be7256f65mr9540543pla.58.1657822328085; Thu, 14
 Jul 2022 11:12:08 -0700 (PDT)
Date:   Thu, 14 Jul 2022 11:11:59 -0700
In-Reply-To: <patch-06.11-b9984e982db-20220713T131601Z-avarab@gmail.com>
Message-Id: <kl6lzghb4l8w.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com> <patch-06.11-b9984e982db-20220713T131601Z-avarab@gmail.com>
Subject: Re: [PATCH 06/11] submodule--helper: add and use *_release() functions
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

> Add release functions for "struct module_list", "struct
> submodule_update_clone" and "struct update_data". For now we're
> leaving some of the "struct update_data" members, we'll deal with
> those in a subsequent commit.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 2099c5774b2..a964dbeec38 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1910,6 +1921,13 @@ struct submodule_update_clone {
>  };
>  #define SUBMODULE_UPDATE_CLONE_INIT { 0 }
> =20
> +static void submodule_update_clone_release(struct submodule_update_clone=
 *suc)
> +{
> +	/* Not "update_data", owned by update_data_release() */
> +	free(suc->update_clone);
> +	free(suc->failed_clones);
> +}
> +

To make this ownership clearer, should we also make
submodule_update_clone.update_data const? i.e.

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a964dbeec3..79fd901e5a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1906,7 +1906,7 @@ struct submodule_update_clone {
 	int current;
=20
 	/* configuration parameters which are passed on to the children */
-	struct update_data *update_data;
+	const struct update_data *update_data;
=20
 	/* to be consumed by update_submodule() */
 	struct update_clone_data *update_clone;
@@ -2003,7 +2003,7 @@ static int prepare_to_clone_next_submodule(const stru=
ct cache_entry *ce,
 	const char *update_string;
 	enum submodule_update_type update_type;
 	char *key;
-	struct update_data *ud =3D suc->update_data;
+	const struct update_data *ud =3D suc->update_data;
 	char *displaypath =3D get_submodule_displaypath(ce->name, ud->prefix);
 	struct strbuf sb =3D STRBUF_INIT;
 	int needs_cloning =3D 0;
