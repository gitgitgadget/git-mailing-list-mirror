Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4D11DDC29
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 11:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729166209; cv=none; b=S84flNLlfAIHY4+o4rQ09mzVIYMkoFd7brOwukvK5xZdTH8ZTW8IjBc+JVOtKUgBysDjG/s1LtJG17djxuxfMkZthz9DhDah1ZKUuxBhG0XLjk21176QOCDfMgzx4Yz0RALTglT9F2w3E3U4b9WiuJJ6mZlEL1CkXZGWAjfA7AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729166209; c=relaxed/simple;
	bh=DgKB1ckokr+HBtgSyESA5348NSLl80l6Qoi9W7YZsOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B76lNJh6jfGE3ru9tvzaLxmC+upu4ztRVEFrzdhYQWIMxILqtZsPVBz34bVyPsDN3LWWEwaXRDm6RLQMHDyb7iH5rzUU+9Q9PxAmdhMty8JjD3mknnEAZmZsZAzQjHwkRib6qMpzZWDIRIuh9H5+wqAxfULqBv1tdrVQ/zJEeJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVktFreb; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVktFreb"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4a5c4d8ee99so290827137.1
        for <git@vger.kernel.org>; Thu, 17 Oct 2024 04:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729166205; x=1729771005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRt6d9ErrJFeARDjJ8b4PXMf3JNCd01UAr1IrlUiQHk=;
        b=UVktFrebLwon2JoKPJ7z4c/giIkzsRPic9qONepPvB1MGTz+G51WkCQaHm8RTzvKDj
         swb9/z7Y8zKFIO+Bow90jgBk8jzx/JAi6Ra2QW8GhQ3N47SdC8KhQZIuDGLXYeVIcOhi
         Si56caOcVzXNFwhnTUkUlrDvnGsRoeRj1NEY0f3VwdB3UKTlVs0D3LJAevUCMcXPtshv
         m4Ys4cUrM+CvT2QVCzjMXXjSlAjgmPpPyyLGCXCJ5mWZ+rXk6e4T9S7mcCtzCz1s1XGT
         5+XNvDhZ70xcIqu+1Ev47wMs/DtZkO+y20d5BpO6ysKbGjH+2wAPK6puxP25SGEsSdx/
         9wPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729166205; x=1729771005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRt6d9ErrJFeARDjJ8b4PXMf3JNCd01UAr1IrlUiQHk=;
        b=rvltbqHWzrvkhfyqa8koCPaIRdXvp8C5ZPnoyXFivK466eCYA9g7Cynq20iw8NuahR
         gPPFYkz3ohVxvCZTyY3r7FROBpL8969uDDzAQy4PR4PSZQdBRFD+nSHckwFS8ZZgnpAI
         EDTi/apStyz0AgQ6uUG40CA7PCj523pFtLU4TmAQ2o+bObKRRc8Ctu32kcwgoEFNrWZ8
         yUso0QY1GxfSz9ZbxKGWBktM70ZamfUGRtiBfZx17cv/hl+kACH9TIbwRQunXYULU12g
         2b3C4dHtf1DASrCr49JXsxGIFCWG4gSAsinYaNqZCNIdt/UPWF3Qo467JhSdnRYf7uiK
         w3VA==
X-Forwarded-Encrypted: i=1; AJvYcCXH2a1FBLFjZ5xxZK4E6hsxgKt6MOsE1405oWwtlsu09yPDciPncitp3G7HhkcHDwZhK2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVc1lXV+xGzGnj2H2weUjBlI1pf8UPyU4ElEM2+hO1zpOg2kGt
	6AzjNIe/0Cur+mww6n95+5H/XyKLVTJXcevVCZuFX32JHXw+QtQIDIIT6iT8AQis5Pr53DzvKs2
	nvYN5uv5evfNOVAChU0yBzc+x6SI=
X-Google-Smtp-Source: AGHT+IE61tjUUZoIieyHzTFhStbkxjItGRci1Sn7lm+XzZVHBvclikPAEOdx9AcKmweuVyiz1boNpfyVOf96O42iGKI=
X-Received: by 2002:a05:6102:d8c:b0:4a4:8a29:a8f8 with SMTP id
 ada2fe7eead31-4a48a29ae3amr13964909137.2.1729166204742; Thu, 17 Oct 2024
 04:56:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <c93bc2d81ffb33a2a61dda2878fa3b9987545e0b.1728774574.git.gitgitgadget@gmail.com>
 <CAPSxiM-V1qOB9QXUY3aDh+_nGdDHBWXJZ54U9p_XxKfHoODu7A@mail.gmail.com>
 <Zwz4B4osJnYJw6pd@pks.im> <2a937b6f-a3fb-4f2a-997b-5508f0e20e65@gmail.com>
 <Zw0kGLZ-mcYjb6Je@pks.im> <2160f8ea-5f00-49d9-8e02-d71d4d827d39@gmail.com>
 <CAPSxiM9ncwaZ3HF72wsRwmen7joWk3mjipsu78WxKEzLX607sw@mail.gmail.com>
 <CAPSxiM-aptyjesMX1H-P5QJjA-6CUonA01Bo84cq2_t==TqFgw@mail.gmail.com> <84dbe9f1-976d-45f8-a49a-d0f942906686@gmail.com>
In-Reply-To: <84dbe9f1-976d-45f8-a49a-d0f942906686@gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Thu, 17 Oct 2024 11:56:33 +0000
Message-ID: <CAPSxiM-Yw2H65+EHoDckU2N2hr+UrXRu5Y2JjXc+TEwEUKJT0Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] parse: replace atoi() with strtoul_ui() and strtol_i()
To: phillip.wood@dunelm.org.uk
Cc: Patrick Steinhardt <ps@pks.im>, Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 6:36=E2=80=AFPM <phillip.wood123@gmail.com> wrote:
>
> On 14/10/2024 17:26, Usman Akinyemi wrote:
> > On Mon, Oct 14, 2024 at 4:13=E2=80=AFPM Usman Akinyemi
> >> On Mon, Oct 14, 2024 at 2:55=E2=80=AFPM Phillip Wood <phillip.wood123@=
gmail.com> wrote:
> >> I got this from a leftoverbit which the main issue was reported as
> >> bug. https://public-inbox.org/git/CAC4O8c-nuOTS=3Da0sVp1603KaM2bZjs+yN=
ZzdAaa5CGTNGFE7hQ@mail.gmail.com/
> >> For the test, I should have the test as another patch right ?
>
> In general you should add tests in the same commit as the code changes
> that they test. In this instance I think you want to split this patch
> into three, one patch for git-daemon, one for imap-send and one for the
> merge marker config changes. Each patch should have a commit message
> explaining the changes and whether they change the behavior of the code
> (for example rejecting non-numbers) and add some tests. Note that I
> don't think it is possible to test the imap-send changes but the other
> two should be easy enough. The tests should be added to one of the
> existing test files that are testing the code being changed.
Hello,
I am currently facing some issues while trying to write the test for
daemon.c, I need some help on it.
The start_git_daemon function inside lib-git-daemon.sh is made to
allow --init-timeout, --max-connections and
timeout as well as other arguments. The start_git_daemon function in
lib-git-daemon.sh is used at t5570-git-daemon.sh.
Basically this is my changes
                if (skip_prefix(arg, "--timeout=3D", &v)) {
-                       timeout =3D atoi(v);
+                       if (strtoul_ui(v, 10, &timeout))
+                               die("invalid timeout '%s', expecting a
non-negative integer", v);
                        continue;
                }
                if (skip_prefix(arg, "--init-timeout=3D", &v)) {
-                       init_timeout =3D atoi(v);
+                       if (strtoul_ui(v, 10, &init_timeout))
+                               die("invalid init-timeout '%s',
expecting a non-negative integer", v);
                        continue;
                }
                if (skip_prefix(arg, "--max-connections=3D", &v)) {
-                       max_connections =3D atoi(v);
+                       if (strtol_i(v, 10, &max_connections))
+                               die("invalid '--max-connections' '%s',
expecting an integer", v);
                        if (max_connections < 0)
-                               max_connections =3D 0;            /* unlimi=
ted */
+                               max_connections =3D 0;  /* unlimited */
                        continue;
                }
What happened is that the start_git_daemon will already fail and will
prevent the
t5570-git-daemon.sh from starting if there is any wrong starting
condition such as the new
changes I added. I am finding it hard to come up with an approach to
test the new change.


Thank you.
>
> >> Thanks.
> > Also, do I need to add the reference which mentions the leftoverbit in
> > the commit message?
>
> I'm not sure that's necessary so long as you explain the reason for the
> changes in the commit message.
>
>
> Best Wishes
>
> Phillip
>
>
