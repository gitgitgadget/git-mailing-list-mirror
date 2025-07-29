Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE5C1990B7
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 21:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753823830; cv=none; b=aBDUWGBPVNYR67KyvhmrPvi0taFwVgmlMnXaiPO87cQ3nej1RctIaWZRX6zMEYhcUvmKVaHjgDmEr2UE+hF76ieDi1Ti2z8eftAITj3185IuUUB2wujuhu5lvJ5cr+a2CXfF67tRhijElwQb6DcUxMFjh6TDnjzPgIlEJTC5C/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753823830; c=relaxed/simple;
	bh=itL+VcsVrSOcKfzkTi1NmCwTgYrxxvqQCXQV2KxRnAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F1NIIVxa7OE4dqVlq5NeuJF79A8s/y1lfutXHUTHhOVxbvQbfWug3IUJKBKap6zpNc6ccbBlE3kaI7IZFlP/kIfXxzo6aA9HQ5X5EhbrZ+GoY1oydFPj2iH0sQj6TKO60oXfRZcr9a8kA2L4/xihzIDytrq6HcpMFLGV1BSXa8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CY1zmTKC; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CY1zmTKC"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-31e41cfa631so6324984a91.2
        for <git@vger.kernel.org>; Tue, 29 Jul 2025 14:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753823828; x=1754428628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfKnXT0ZodBYr+fuD2ZAubpqFFkDYtM0s6CWNauUowM=;
        b=CY1zmTKCjJJXX5v4spmWC8u/b2xuwmS/n0e7TfntQMV2AxF4Utb/1Y6fQOJZ0VGiGK
         CZnNyhqa177/CR78p0AKQJFY2YN4LiOhg3LUfmoL9oVv2pvFvSLWtpno7dHwqTyg9dX8
         nOH+B0dO6czYdk4pe+d7eE5EY0GOX1sWFKYuo5BiIPCGh9IThUcDuu0ctzEZ+oTHWX+M
         Fwdg9ZhDPEV8l0Dj681hjtWYUZvSm6XfOWhpCOXp1svcNXtZT6jvyeXhhtI7bd+aBVYS
         4y6dwYpIU8p/PvVlKfPkWQ5WSeRj5RhXCf6BXcpapdVeqrAyTpzGie6Ac2zCHadAlxQt
         hB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753823828; x=1754428628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RfKnXT0ZodBYr+fuD2ZAubpqFFkDYtM0s6CWNauUowM=;
        b=XtX4LxPsq3xRfafeJ5iohf6m1HkIjg+gC9FOp2rzbLiOaCHvUxzhEy8GyM6AZJ3UOt
         tb4sN0yMf2DWjDS8ePNot76Q0ol44ebRlllpfGxNORkbBdNNq6H2vCERQKmhHoFutho/
         4dvmkKB+lOrJSM9mgqmVvi8mTgwnL7sMKWuu44a88dBRJBDGFbDwtbXOQa3vbr9Tdsm5
         8lCcUNfQf57nWZ0pmVUbE7n3Y1lbMbI9uCKyrGAa1M68jhNHBYjt0cZq2MLdph0UqUdH
         ZB9BPZfBchml305NnPkY7mhEOpgNpzE7BfiE7wZs3JQGgy166Wkn8OZ3tVi/4fgU8d6+
         6YOA==
X-Gm-Message-State: AOJu0Yxh/0Va013ibXCV+/qmTShsNQarWzGF767J4EATQpVB32UG5Ec5
	5LJmH17YciNxedF0xrwHNTBFnzv6Es8SkQ4FjOt7m8Lsyogr0QYOXci+QjFnlo+HhFVFCf37MlV
	67gJc5cVXJBXofdky75XhgaHNb/CoJJA=
X-Gm-Gg: ASbGncs9B0lRK6n1rFKDbeiE2yU15N4wjCLRgsqAxu0U7Z3QsfntTDWYv4/gniY1xh2
	tiL/kSCW/UONW3lKnzbN+8rYmgvZcHQSoIZdb60rTrTu8mXy7sG7iFw7zG4ofuUx70Yp7jUN6HM
	YGYJbPkDLkq+RpFllLH8QllBjc7HiT7mUYyBUhts097rQ34RyLOBJoack0zOfZHiW+StweHNuhg
	1PxqgXl
X-Google-Smtp-Source: AGHT+IHIr6a1RlCG185LMADN3727Uu87JdUQIBbYBueQRacqc2JprbHkNjmtGGehPC+ARhO7kasuP9aNrDlHHPLhlFA=
X-Received: by 2002:a17:90a:d450:b0:31e:d2a8:5165 with SMTP id
 98e67ed59e1d1-31f5de7bc0cmr1122130a91.35.1753823828220; Tue, 29 Jul 2025
 14:17:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1753804956.git.ayu.chandekar@gmail.com> <c82620a1f54ea6760bff204fd2b5fe5c2df1896c.1753804956.git.ayu.chandekar@gmail.com>
 <23428022-ab13-4a3e-90ed-ff91ef93f051@gmail.com>
In-Reply-To: <23428022-ab13-4a3e-90ed-ff91ef93f051@gmail.com>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Wed, 30 Jul 2025 02:46:56 +0530
X-Gm-Features: Ac12FXwk3jWXUBitD7Zor9G19-aGmq0zFV05j6qA9AOWn4Y7X7N_smMxb9Sf1r4
Message-ID: <CAE7as+Y_S=J8D4xrV75w2KJCKzpHamYt4Ug_iGD068i3Kdq5JA@mail.gmail.com>
Subject: Re: [GSOC PATCH 1/2] environment: remove the global variable 'merge_log_config'
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, christian.couder@gmail.com, shyamthakkar001@gmail.com, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

On Wed, Jul 30, 2025 at 12:37=E2=80=AFAM Phillip Wood <phillip.wood123@gmai=
l.com> wrote:
>
> Hi Ayush
>
> On 29/07/2025 17:19, Ayush Chandekar wrote:
> >
> > @@ -26,14 +26,7 @@ static struct string_list suppress_dest_patterns =3D=
 STRING_LIST_INIT_DUP;
> >   int fmt_merge_msg_config(const char *key, const char *value,
> >                        const struct config_context *ctx, void *cb)
> >   {
> > -     if (!strcmp(key, "merge.log") || !strcmp(key, "merge.summary")) {
> > -             int is_bool;
> > -             merge_log_config =3D git_config_bool_or_int(key, value, c=
tx->kvi, &is_bool);
> > -             if (!is_bool && merge_log_config < 0)
> > -                     return error("%s: negative length %s", key, value=
);
> > -             if (is_bool && merge_log_config)
> > -                     merge_log_config =3D DEFAULT_MERGE_LOG_LEN;
> > -     } else if (!strcmp(key, "merge.branchdesc")) {
>
> In the old code if both "merge.log" and "merge.summary" are set in the
> config file the last one wins
>
> > +void adjust_shortlog_len(struct repository *r, int *shortlog_len)
> > +{
> > +     const char *keys[] =3D { "merge.log", "merge.summary", NULL};
> > +
> > +     if (*shortlog_len >=3D 0)
> > +             return;
> > +
> > +     for (const char **key =3D keys; *key; ++key) {
> > +             int is_bool, value;
> > +             if (!repo_config_get_bool_or_int(r, *key, &is_bool, &valu=
e)) {
> > +                     if (!is_bool && value < 0) {
> > +                             error("%s: negative length %d", *key, val=
ue);
> > +                             return;
> > +                     }
> > +                     *shortlog_len =3D (is_bool && value) ? DEFAULT_ME=
RGE_LOG_LEN : value;
> > +                     return;
>
> In the new code "merge.log" is always used in preference to
> "merge.summary" even if "merge.summary" appears later in the config
> file. When you have two keys setting the same variable I think the only
> way to preserve the last one wins behavior is to keep using a callback
> that updates the value as the config files are parsed.
>

Sorry for not mentioning this in the commit message.

I had looked at the documentation which says:

Documentation/git-fmt-merge-msg.adoc
merge.summary::
Synonym to `merge.log`; this is deprecated and will be removed in
the future.

So I thought that I should give precedence to "merge.log" as
"merge.summary" is deprecated.

> Thanks
>
> Phillip
>

Thanks
Ayush
