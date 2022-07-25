Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD6FC433EF
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 17:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236106AbiGYRHQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 13:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiGYRHO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 13:07:14 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C0DA462
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 10:07:13 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id cu3-20020a056a00448300b0052ae559108fso3953744pfb.9
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 10:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=sSt96N2F9rbh6/VEj96HzWAYA84ChFJ7IH23k/G9LC0=;
        b=F2q/8vJwdpCE6AT83qX3zPMAn9qUVJQMKkJvZWdn/R6xi/4UuC66SjLd2WvE5pz2yM
         K3UFgG77aEN1z+BIYOe2We7Ch5m+1RmHcE1l559iDeRN5USnS128fkWP3kKLPJViWAW5
         j7G2LWED13tfgQgxi/diiKAU4vFCXoVb0Ofm9wUPmN0BOaK8BquqPDc41DD51rwRgf8z
         kE7z0QoupvlKW6SIdhRTKrSswE8moX+CNT7oBqU2MUsHTMjbpymp8nLOTX0np3OtvhkJ
         dHDWxKwnqd/bVpoFoyzv7hy5vURrEMwbIGkE8P57dlboiDipEJlINzS67AtjndavyasE
         Wlxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=sSt96N2F9rbh6/VEj96HzWAYA84ChFJ7IH23k/G9LC0=;
        b=FSVdy4lygamLUYwm+XbS7wXE5i4RtmcXBvbIFyY4GSv22ZsivF9EZmeKyWrfhTui4T
         QZvgUA4e/wfb+TlAHEVOmMVA4R79kV8cVXIbmjRfkMheSFi0bABg3gnkr/WBn/70Uck6
         WNqH/z7DS5Ytkwir7CMUjcvUgo8yN44pyqKfDJ9ojVBKvpfQVDMvkiLUs+3T/dwE7y18
         oxFMIjcj/v+dcuLsCcauJT5E/rLnEeU3cJoOaJ+4A7RAM7TW1pTmRfe6JusEM7notqm/
         nf5ozw5eueTWFpufOUCc/GP9jrKzUSntTw2YAdCfDiqjiG6GmX+fSC6Vt4j+eHvZnD6n
         /HJQ==
X-Gm-Message-State: AJIora8iHg2sfyf8tmB2WJvsPYqmjQOL+KaeN2TvMivWDyV3KNCnLeGZ
        Hvap1IKz8Aol6MJzm+ACqYCNQlYAFnLhcw==
X-Google-Smtp-Source: AGRyM1v3nhyiml/ddpUvD7iPWOtmkEty1qplKFzx+VNOOv6XcvEm7si5pO3GI1pa5Ph0oVhySPRpKUzJUUM9/Q==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:1c04:b0:1f2:96f8:7db with SMTP id
 oc4-20020a17090b1c0400b001f296f807dbmr9088379pjb.88.1658768833305; Mon, 25
 Jul 2022 10:07:13 -0700 (PDT)
Date:   Mon, 25 Jul 2022 10:07:11 -0700
In-Reply-To: <patch-v3-03.26-eee6ca28c6f-20220721T191249Z-avarab@gmail.com>
Message-Id: <kl6l5yjlt934.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
 <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com> <patch-v3-03.26-eee6ca28c6f-20220721T191249Z-avarab@gmail.com>
Subject: Re: [PATCH v3 03/26] submodule--helper: pass a "const struct
 module_clone_data" to clone_submodule()
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

> Add "const" to the "struct module_clone_data" that we pass to
> clone_submodule(), which makes the ownership clear, and stops us from
> clobbering the "clone_data->path".
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/submodule--helper.c | 38 +++++++++++++++++++------------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 29641690c8c..7d5ee6a6261 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1650,20 +1650,22 @@ static char *clone_submodule_sm_gitdir(const char=
 *name)
>  	return sm_gitdir;
>  }
> =20
> -static int clone_submodule(struct module_clone_data *clone_data)
> +static int clone_submodule(const struct module_clone_data *clone_data,
> +			   struct string_list *reference)
>  {
>  	char *p;
>  	char *sm_gitdir =3D clone_submodule_sm_gitdir(clone_data->name);
>  	char *sm_alternate =3D NULL, *error_strategy =3D NULL;
>  	struct child_process cp =3D CHILD_PROCESS_INIT;
> +	const char *clone_data_path;
> =20
>  	if (!is_absolute_path(clone_data->path)) {
>  		struct strbuf sb =3D STRBUF_INIT;
> =20
>  		strbuf_addf(&sb, "%s/%s", get_git_work_tree(), clone_data->path);
> -		clone_data->path =3D strbuf_detach(&sb, NULL);
> +		clone_data_path =3D strbuf_detach(&sb, NULL);
>  	} else {
> -		clone_data->path =3D xstrdup(clone_data->path);
> +		clone_data_path =3D xstrdup(clone_data_path);
>  	}
> =20
>  	if (validate_submodule_git_dir(sm_gitdir, clone_data->name) < 0)

Hm, the leak in the preimage comes from the fact that we assign back to
clone_data->path, which is a "const char *" that initially comes from
argv. So we didn't free() it even though it always pointing to
free()-able memory past this point.

So now that we're introducing and assigning to a new variable,
clone_data_path, wouldn't it be simpler to just make it "char *" and
free it (instead of adding a separate "char *to_free" in the next
patch)?
