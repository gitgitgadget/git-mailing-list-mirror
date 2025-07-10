Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8E82E36E0
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 03:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752116454; cv=none; b=gYElnFMt6hzRHfnjYpjK5Xu2R+11YfWoX/biVhbNRoIS2100ffWoSbJiVkqyET9uKh2lx3j46/ooD9yKrh7auMKoAZeCt31xfg+WXaMeNIi0TTF42yF7qzaUAgmMT+t7cAbJG2qg3l20DcGy+jPcQPLCYr3jXgMZf+yPvoL9S48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752116454; c=relaxed/simple;
	bh=+SE1dLf9/FaeHkidnnD7kUhJZlu/8+FyWWQy6XqovYo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=oIuInr5dJVzHw0ZUxEKZawb6EoJiGvfrt+2aIX9p93bw9SNQie3Uq9FbsAE1g/turA7cVvpOknQzGKLziwU1mEO+x2EK0u1Uo+6mo7Dh0ZPz9WcmOQn94f1uIAedorCXKido8W7TC7Ah+3HCGRF558MbOlUXD5i+HKpBidwOSK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1uOmJJE; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1uOmJJE"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7490acf57b9so425399b3a.2
        for <git@vger.kernel.org>; Wed, 09 Jul 2025 20:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752116452; x=1752721252; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFzxD5fxNTOJ98UcGrRbDOAyrknSId836ViYf9qoStw=;
        b=i1uOmJJEBm0qiRb+m8J6ssz76c9+gt1RG2beZsbEhwyILz87yQTsBM2cF1RMm9iOk0
         FOzVM9PwxOv4izLp6n5rD9bMh46I/2CkvyxCstzRnPNn4KRDOXSmMpK+/gDhERIh4CNg
         Nkxkk5Q3X9VLwNFalpNipA0+mwrCyyrIWzVheJnkr5yVusdh7VbBaiV+uBYBLHGbkGyr
         sehdyoxvEifsMRtV0F1z23ovm/i0Js58YcF9hz3F6ePUuZY4rXtL4gQpLgKsrnnlj3Yn
         kdkAVsk5OUXrcQVsqIiDWmcTUsqH91FM7xzp4HJ7ic62EWQM5FAH3avXfxHdrXslk5I2
         0oBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752116452; x=1752721252;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XFzxD5fxNTOJ98UcGrRbDOAyrknSId836ViYf9qoStw=;
        b=ekn3k23ItmDtJVwCe8hZEl9vhe/XCyC3cROWuFm3Aw6sN9QvIWdq5XV/rrU0P/q1o8
         KD8xwNjBddhmEAtiP+J+gm4RRUSKpuG4zZLZAwc7ElkIcXYwfOQDyXXQCIMp6fnPNa0k
         OLn/BwOcy8ERsv/tXccbgbpKNVtWK5gNwydTy4tz/dnAbx3vI5Vo3yFyEfGBr1XiobG0
         zPg4vLJVBtmyj8uCb7XUzpDx2EQoTQ6ZRpHUvT8fqvv68eBaLmgrEyawPTCnDnSeOGEB
         h3vL0OGpE0oufhLM39LZxVDIvhdK5mE1pn6Q3xBnlLWZCCFDgBxdzpcoAIOfRqWncUfs
         nPBw==
X-Gm-Message-State: AOJu0Yzl4sv0GzC8w9ZAix0jSPT3Bp7oAlYQrK7JOxQkoHYgiPRcUCxB
	NWDBP4MgYONIrWsMJRTMBzRUX2xMguDBs4wmpqAdCdedhPEDe0JR/B5c
X-Gm-Gg: ASbGncvMeonsRtpPJd/UM1w5vJTK9vmLDO+9WWpxC+/byKZLRsMuAhOwqwdH+renPw8
	ggky0TpBIz9iKDGVOrIzyJolpMWeq8U6mMNbzV3LVMA4f2IcuJXMu/nGvigxVTlz+ACR6a3j+l8
	JDdwC8Vxz1elHoEC4ne5Z6kl9I+b719SmWrpTp+jvXNrYHH2RABCCDIixBG+S6p8txayk7v9bCv
	gukdBFTKcWyP/wM9aep8m+0fOP67eTcq3rVdHWVN8FqksABO4KarX7BBSVlJ7Feji0UJASDERXF
	3ViWfYBpHRg9NKK0+cFXeScyNjgAr+/YoRYTpk+m1BHxWxsIredIHViX0QLxhXTr6cqHOkghTLK
	nuaWjDJ84Y7fUBalSDi/lZ/KAl1DZCkFCPV1vygLjb1Nz6TZCeFne2RgHYqj49Bs=
X-Google-Smtp-Source: AGHT+IHwf2Fj6XyhZ251QFoT6+0UKMAPDLsIE/Sm1MX17s/By+4gSxkah5GA+GCd8keY+WxRzNX8nQ==
X-Received: by 2002:a05:6a00:a8e:b0:736:4d05:2e2e with SMTP id d2e1a72fcca58-74eb5400abcmr2693936b3a.6.1752116452062;
        Wed, 09 Jul 2025 20:00:52 -0700 (PDT)
Received: from smtpclient.apple (awork062199.netvigator.com. [203.198.28.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd7384sm606175b3a.35.2025.07.09.20.00.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jul 2025 20:00:51 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v2] reflog: close leak of reflog expire entry
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <20250709-jk-fix-leak-reflog-expire-config-v2-1-f9af934be8c1@gmail.com>
Date: Thu, 10 Jul 2025 11:00:38 +0800
Cc: git@vger.kernel.org,
 Junio C Hamano <gitster@pobox.com>,
 Jeff King <peff@peff.net>,
 Jacob Keller <jacob.keller@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D34FE2DE-EE5B-43F3-A706-1AC133AA72F1@gmail.com>
References: <20250709-jk-fix-leak-reflog-expire-config-v2-1-f9af934be8c1@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Jacob Keller <jacob.e.keller@intel.com> wrote:
>=20
> From: Jacob Keller <jacob.keller@gmail.com>
>=20
> find_cfg_ent() allocates a struct reflog_expire_entry_option via
> FLEX_ALLOC_MEM and inserts it into a linked list in the
> reflog_expire_options structure. The entries in this list are never
> freed, resulting in a leak in cmd_reflog_expire and the gc reflog =
expire
> maintenance task:
>=20
> Direct leak of 39 byte(s) in 1 object(s) allocated from:
>    #0 0x7ff975ee6883 in calloc (/lib64/libasan.so.8+0xe6883)
>    #1 0x0000010edada in xcalloc ../wrapper.c:154
>    #2 0x000000df0898 in find_cfg_ent ../reflog.c:28
>    #3 0x000000df0898 in reflog_expire_config ../reflog.c:70
>    #4 0x00000095c451 in configset_iter ../config.c:2116
>    #5 0x0000006d29e7 in git_config ../config.h:724
>    #6 0x0000006d29e7 in cmd_reflog_expire ../builtin/reflog.c:205
>    #7 0x0000006d504c in cmd_reflog ../builtin/reflog.c:419
>    #8 0x0000007e4054 in run_builtin ../git.c:480
>    #9 0x0000007e4054 in handle_builtin ../git.c:746
>    #10 0x0000007e8a35 in run_argv ../git.c:813
>    #11 0x0000007e8a35 in cmd_main ../git.c:953
>    #12 0x000000441e8f in main ../common-main.c:9
>    #13 0x7ff9754115f4 in __libc_start_call_main =
(/lib64/libc.so.6+0x35f4)
>    #14 0x7ff9754116a7 in __libc_start_main@@GLIBC_2.34 =
(/lib64/libc.so.6+0x36a7)
>    #15 0x000000444184 in _start =
(/home/jekeller/libexec/git-core/git+0x444184)
>=20
> Close this leak by adding a reflog_clear_expire_config() function =
which
> iterates the linked list and frees its elements. Call it upon exit of
> cmd_reflog_expire() and in reflog_expiry_cleanup().
>=20
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
> Changes in v2:
> - Actually fix the leak properly. (Thanks Jeff for catching my brain =
fart!)
> - Link to v1: =
https://lore.kernel.org/r/20250709-jk-fix-leak-reflog-expire-config-v1-1-3=
4d5461cf8f5@gmail.com
> ---
> reflog.h         |  2 ++
> builtin/reflog.c |  3 +++
> reflog.c         | 15 +++++++++++++++
> 3 files changed, 20 insertions(+)
>=20
> diff --git a/reflog.h b/reflog.h
> index 63bb56280f4e..74b3f3c4f0ac 100644
> --- a/reflog.h
> +++ b/reflog.h
> @@ -34,6 +34,8 @@ struct reflog_expire_options {
> int reflog_expire_config(const char *var, const char *value,
> const struct config_context *ctx, void *cb);
>=20
> +void reflog_clear_expire_config(struct reflog_expire_options *opts);
> +
> /*
>  * Adapt the options so that they apply to the given refname. This =
applies any
>  * per-reference reflog expiry configuration that may exist to the =
options.
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index 3acaf3e32c27..d4da41aaea73 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -283,6 +283,9 @@ static int cmd_reflog_expire(int argc, const char =
**argv, const char *prefix,
>     &cb);
> free(ref);
> }
> +
> + reflog_clear_expire_config(&opts);
> +
> return status;
> }
>=20
> diff --git a/reflog.c b/reflog.c
> index 15d81ebea978..3ce1780924dd 100644
> --- a/reflog.c
> +++ b/reflog.c
> @@ -81,6 +81,20 @@ int reflog_expire_config(const char *var, const =
char *value,
> return 0;
> }
>=20
> +void reflog_clear_expire_config(struct reflog_expire_options *opts)
> +{
> + struct reflog_expire_entry_option *ent =3D opts->entries, *tmp;
> +
> + while (ent) {
> + tmp =3D ent;
> + ent =3D ent->next;
> + free(tmp);
> + }
> +
> + opts->entries =3D NULL;
> + opts->entries_tail =3D NULL;
> +}
> +

This looks correct.

> void reflog_expire_options_set_refname(struct reflog_expire_options =
*cb,
>       const char *ref)
> {
> @@ -490,6 +504,7 @@ void reflog_expiry_cleanup(void *cb_data)
> for (elem =3D cb->mark_list; elem; elem =3D elem->next)
> clear_commit_marks(elem->item, REACHABLE);
> free_commit_list(cb->mark_list);
> + reflog_clear_expire_config(&cb->opts);
> }
>=20
> int count_reflog_ent(struct object_id *ooid UNUSED,
>=20

In builtin/reflog.c, we have code like

---
	for (i =3D 0; i < argc; i++) {
		char *ref;
		struct expire_reflog_policy_cb cb =3D { .opts =3D opts =
};

		if (!repo_dwim_log(the_repository, argv[i], =
strlen(argv[i]), NULL, &ref)) {
			status |=3D error(_("reflog could not be found: =
'%s'"), argv[i]);
			continue;
		}
		reflog_expire_options_set_refname(&cb.opts, ref);
		status |=3D =
refs_reflog_expire(get_main_ref_store(the_repository),
					     ref, flags,
					     reflog_expiry_prepare,
					     should_prune_fn,
					     reflog_expiry_cleanup,
					     &cb);
		free(ref);
	}
+      reflog_clear_expire_config(&opts);
---

I think allowing reblog_expiry_cleanup() to free all opt->entries might
cause reblog_expire_options_set_refname() to behave incorrectly.=
