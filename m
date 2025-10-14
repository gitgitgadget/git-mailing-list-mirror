Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696622DAFD2
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 08:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760431758; cv=none; b=htrXyLYyZEnkxxFoMcrtAxsRLksIScf/uTxb9roFT6FlLe9t+v8rAtcmDVfRFqn39Q5gnZ63AjOMCdrTUlk3gfAB79t782b/SKDZvtfkn/AgDrceXTxhBJzQ4QUc86GP2C2IRtzOg6Si++wfhg4Cbw6SKjzoBh1ryteZJlXONZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760431758; c=relaxed/simple;
	bh=Q4g6T3p75V8hcOsslCUNKr9F3KXy+G1plgoBwgl5CHs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M/YjMkmr2zI9AKpwyfL7tWuCOPqsCi0reV3ZBhBG0hielSPuFZqy2y2o9T9GuNUUOlEw3/to5SoN6xXFAfuS5IQkMnOMLgSG5APbYKHSFNfANn2Ss6OL4/+T83JaHAuGEjZPtVzOIeqOu3YJYHdBYDw1fbiuiewmL0uy3rAzJOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QepPJZyL; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QepPJZyL"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-54aa4b86b09so2010139e0c.0
        for <git@vger.kernel.org>; Tue, 14 Oct 2025 01:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760431755; x=1761036555; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ignOfHlZBnIpdrbM80ZQ0racxFfwk7sEvyUQa53KzOw=;
        b=QepPJZyLrmyOIay2OvJhYaHd1RnuMCVxjzr/FlP719MCizDpvrvaqMjxeh4XFn2cHW
         fVPhwP5bgKQPDLi1vBYPD1gg0IY1S/k9Bpcqy/+UC9Qa5CWEWWci3oce+6lyel3XOwpT
         ZNmMhdmipLaiP69qzpawLAzWBeIRkxzzC1e23Po6tt5hp2M2ifHKn10upu1Gpf3tn2ZC
         gz3U1h8k7TB34MZczTyZeqSFCLcxNH5VS1cSFZaQJVzQyMeKEHlfHSkoP/Qt3vOqZAti
         6L4DGVl9neThtN7VT3bC3A6gAXtE5RRKq0zOtU5AjxRTja1snwcYzsJDg6xilT7BIKPA
         cT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760431755; x=1761036555;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ignOfHlZBnIpdrbM80ZQ0racxFfwk7sEvyUQa53KzOw=;
        b=RU0rict6DEpAO8wZ7E/O4TG4VlLeTM40f5XrgCbZ31jMYYQSKNrtEmehTqJ6E003bE
         TaC1enXcov/QiWfp4d1sK5j5A+hG94Lgrr+7UzYSiSkTaD+8rVuY6SmhJTaztAFQ7X1h
         JpwLa61+dTelCFe9gY5fcXQwUXgy54CzWRhozaHHB4eIjHh/N6NJbCknHfV49gAfWnLk
         QywuO10x+pPQOmlKdmUoPPpeinhx1cbkCzgfVFLWEcdvfibUlUjGqblEuDOGyRs8bVlQ
         cMIV0FjwfpeyCN3mlhf2iE6e9Rrild+qFJHMfpg+zIImCQD7yGNswkJ1lTtsMxl1RS5p
         C20Q==
X-Forwarded-Encrypted: i=1; AJvYcCUA6CwQGwM/R9revk7fpwCZOBksx+WzrEYvTcDNc453LhaRVsCZv3CJQhPR29EIvdTiknw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3fNdotOxvvb26CH+h3fU9Q4E0uedy8xltS3iG9Yx+xGnKiigv
	zBWZ20aoJu8NikH8/TvEV0Y6CrYzT4FF2b3b7hHO2qTWp9YMMC/O/6WAAd1kfBkjnPGZMTiIZMh
	PjAO68dR2cK6zbZh+T447MEa44DFXefY=
X-Gm-Gg: ASbGncs5izOrca9xTgyR3t7zW+ko6dOwHknviYzlR5h6eYhcLtoKWEmSe+IoWE7Cc4C
	k48IJLvZwnqrNOc5mNyoyqoBzfl2tHHWGTxOzxHtubUhepBD0je3EAjoq6j8O07I1iORe83LDX3
	97YHW2VQCVnKHdyV/ScZa/pGiEThErxM8WLtfoTe24hTp8ALvPMEU6+GFhzQ+BwtSxe8gdS4bMj
	BWryF/zp3//mBU0ChlG+aZGcMao9OpIUrOtpRh2GdUmsj3gfI0ywHrTy08lxlm2sd3qbx0=
X-Google-Smtp-Source: AGHT+IEtiXyc5qB5NmqOGK4X1MLBkqTgvGb8mRdZE+Vq4btCRWDL41FL0p9G1lM0/bwZ6Q1Cg22X6S0fu7hnlDYpkfU=
X-Received: by 2002:a05:6122:3119:b0:544:8830:8e15 with SMTP id
 71dfb90a1353d-554b8c92870mr7708019e0c.12.1760431755232; Tue, 14 Oct 2025
 01:49:15 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Oct 2025 04:49:14 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Oct 2025 04:49:14 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20251001-b4-pks-history-builtin-v4-1-8e61ddb86317@pks.im>
References: <20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im> <20251001-b4-pks-history-builtin-v4-1-8e61ddb86317@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 14 Oct 2025 04:49:14 -0400
X-Gm-Features: AS18NWD3EF8mry2lwX60bUozmmwZYtCEj-tBkZVTI4btz1KUKIS1-NeGOMcHcbc
Message-ID: <CAOLa=ZTUDOYb1KVUEZY4KFyoaP-PdXjBvUto0vxOtYanEjoOFA@mail.gmail.com>
Subject: Re: [PATCH v4 01/12] wt-status: provide function to expose status for trees
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Sergey Organov <sorganov@gmail.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Elijah Newren <newren@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000006c3deb06411a7576"

--0000000000006c3deb06411a7576
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The "wt-status" subsystem is responsible for printing status information
> around the current state of the working tree. This most importantly
> includes information around whether the working tree or the index have
> any changes.
>
> We're about to introduce a new command though where the changes in

Nit: s/though//

> neither of them are actually relevant to us. Instead, what we want is to
> format the changes between two different trees. While it is a little bit
> of a stretch to add this as functionality to _working tree_ status, it
> doesn't make any sense to open-code this functionality, either.
>
> Implement a new function `wt_status_collect_changes_trees()` that diffs
> two trees and formats the status accordingly. This function is not yet
> used, but will be in a subsequent commit.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  wt-status.c | 24 ++++++++++++++++++++++++
>  wt-status.h |  3 +++
>  2 files changed, 27 insertions(+)
>
> diff --git a/wt-status.c b/wt-status.c
> index 8ffe6d3988..b66edbfca6 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -612,6 +612,30 @@ static void wt_status_collect_updated_cb(struct diff_queue_struct *q,
>  	}
>  }
>
> +void wt_status_collect_changes_trees(struct wt_status *s,
> +				     const struct object_id *old_treeish,
> +				     const struct object_id *new_treeish)
> +{

So, my understanding here is that we want to diff two trees
`old_treeish` and `new_treeish` and then finally store the status change
in `wt_status`

> +	struct diff_options opts = { 0 };
> +
> +	repo_diff_setup(s->repo, &opts);
> +	opts.output_format = DIFF_FORMAT_CALLBACK;
> +	opts.format_callback = wt_status_collect_updated_cb;
> +	opts.format_callback_data = s;
> +	opts.detect_rename = s->detect_rename >= 0 ? s->detect_rename : opts.detect_rename;
> +	opts.rename_limit = s->rename_limit >= 0 ? s->rename_limit : opts.rename_limit;
> +	opts.rename_score = s->rename_score >= 0 ? s->rename_score : opts.rename_score;

Curious, why do we need a '>= 0' check here?

> +	opts.flags.recursive = 1;
> +	diff_setup_done(&opts);
> +
>

So first we setup the diff options, with the right callbacks so that the
relevant information is added to the `wt_status`.

> +	diff_tree_oid(old_treeish, new_treeish, "", &opts);
> +	diffcore_std(&opts);
> +	diff_flush(&opts);

This is the part which calls the callback function with the relevant
information and callback data.

> +	wt_status_get_state(s->repo, &s->state, 0);
> +

Based on the list of diff data in `s->change`, we add the status print
information. Okay makes sense.

> +	diff_free(&opts);
> +}
> +
>  static void wt_status_collect_changes_worktree(struct wt_status *s)
>  {
>  	struct rev_info rev;
> diff --git a/wt-status.h b/wt-status.h
> index e40a27214a..924d7a5fa9 100644
> --- a/wt-status.h
> +++ b/wt-status.h
> @@ -153,6 +153,9 @@ void wt_status_add_cut_line(struct wt_status *s);
>  void wt_status_prepare(struct repository *r, struct wt_status *s);
>  void wt_status_print(struct wt_status *s);
>  void wt_status_collect(struct wt_status *s);
> +void wt_status_collect_changes_trees(struct wt_status *s,
> +				     const struct object_id *old_treeish,
> +				     const struct object_id *new_treeish);
>  /*
>   * Frees the buffers allocated by wt_status_collect.
>   */
>
> --
> 2.51.0.700.g236ee7b076.dirty

So this function will be used in an upcoming patch, looks good.

--0000000000006c3deb06411a7576
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 940f9cd3be6c2b4a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qdURvZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOU1WREFDUXhTMEFJbVRzWmtNMlMvVU95Vm4wOHlneApVdVJGaW5peEpk
a2RLVzRCY2VENys2dEpBZ2xVblZvTDNhRU9yMHVONUh0cVBPQ0RCYmZBN2hjTmdSOHNmU2RSCi9J
Z1orcjR1S084NjdiM0wyWlJpS0tYNHJVVGJiUVNZMVlDSzdvOW1NeVRheUQ1aWF2OVI1TWY2MGpw
aHhPWTUKQ1ErZjVVYU94ZWRTaDdhazVKd0pyTG1XS3g3Q0N0c0pid1RHVTlGWWZUMjJ1M0hmRFl0
Mm1zcUw0dnN1OUVkNQpLRVF0ZCtkTU1LS2EweWJiaTR0aFRHZFEzQThLaXhJcFY0a2ZOajJZZlYr
Qyt0T3JtR0FhU2ZlakpuR1krZUwzCjh3TWRRRER0R1lVbXpyZ0NZaXI3VVlYU3RXY1JrSzR1ZG44
a1k3clBpbzNNMnlmak1zbDUvUE5WSFcrVzgveUsKMzE3a01BTzIvb1d2c1dIYVdydGlxZU1laWlG
VVFFTFRFbCtKVEoxZ1h1YnJZd3dMaFFtOHZTbzUrOUZkZUNrUQpWeXdvN09nN3hRRHJMLzlmUkhq
NjZ5MDFZYjI0dlBnQnUzUTlKRkJMazVLMTJ2TlFDeVZSOFJtTzMrRHdiR3BZCmkzU1RQdm9PRnBX
QmxVdzJZMnBjemEyMmtPM3pCT1NOb21rNXNPQT0KPUNQVEMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006c3deb06411a7576--
