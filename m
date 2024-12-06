Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8D23D6B
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 08:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733474602; cv=none; b=Z3Vr0NyZf87T/7clwI03qxoT/RoVMcfp7ibIgA5qORXzU9M6tHxvIXv9lYIg2sFI+ocD7nDVlW6Rsqpx2MNAOfmOOljdCmt50p2d1e6gSee7ClPqIFely3vW2lRLoPQ/qRgnCsKaPEiAY+QzxGoMguM3eUaKJcPY4VvHObGDdfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733474602; c=relaxed/simple;
	bh=SB75755t37mibW19sIGQVTCbZYcHBRomI41N6yujv/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iz6fOyuUwBMCX7eHwNsX34akM1b9VRNRE7IhSybsron5t+flQRegLbpQVCVgygrPUEQFnhcAflsKjKtEMIIX98pdbKuAq4LOxWuDpX9yCTc8bspBkCGrL6qtEF1Epyf9Mu8HbXiZcdn1RLzNrzO/8XtGY6ztKbLVHmF4HxL3P/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=atlassian.com; spf=pass smtp.mailfrom=atlassian.com; dkim=pass (2048-bit key) header.d=atlassian.com header.i=@atlassian.com header.b=VtpEdcuX; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=atlassian.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atlassian.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atlassian.com header.i=@atlassian.com header.b="VtpEdcuX"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e396e33d47dso1697487276.0
        for <git@vger.kernel.org>; Fri, 06 Dec 2024 00:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google; t=1733474599; x=1734079399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SB75755t37mibW19sIGQVTCbZYcHBRomI41N6yujv/Y=;
        b=VtpEdcuXXVDCFeZeDlgQfk1SBRq5bfE2OQxI8d5z1VeafcFB/ySlMpD9TBHH1eqnah
         phyUn36NyLO5/yW57szX1Xx2BMezcvSceTnFmGk3DoU9TPFOiZuXWnjeWbVrFHKkfvCP
         fwXhM/xaYfNt9xSCTkWyPUjP2ls64AWhuWGHtZawgfKvfKO4RzCXFhdPIMiwJ9Vtgh37
         JMvVslfkH0I43ji6mGgQTzoRwB6BuZei7QQ71D0SxvFpJYo5oN88NgYuWfESUE+0PAUr
         8gD7eTxBcZGW8b7+3ZtF0UAHWvghUzIVtknjJnFOPG2b51sHYBgzUdQITxE8HJaoT8Fa
         XaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733474599; x=1734079399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SB75755t37mibW19sIGQVTCbZYcHBRomI41N6yujv/Y=;
        b=Kpg5dBUf72zhRkyh54ujQGQKUD8GxX22XswB9ypVTUA3U0HhPemOdQmQvBVBbqsXfh
         kwUJRkDdoi84OAw/Y/LDYVuKgzhXvnMdj6PmNUdeBqEbi/MyTuUv4eGrJJvDQI/mMQiS
         AgR5VCz/se0i/PqdPnnhupRE/pbKz9JbA5nQ68MX1aLhQpdpCkPerctyax0KS6HXtDyA
         WOAemv+k+4Vr0LdLdoBkbnc7g0P24Z8dtUFeU0IGMPeiuN6oI2eLFJoGoOW22WKoLnx3
         9x8CpB2OpI4404gDK1bIDCJOta3dEu0SWBerHjI4HSMU04JjjFahyl2xW5lCExpsnx1h
         Dlug==
X-Gm-Message-State: AOJu0YwGSi2VBPwHDLiw5B0XLY4zYSTx1p3P2bjdJhZWd15+8qOIt8iC
	zkV3GcJed3p4AxXSrboqdpHL21U9IMU7uUbbr46kvO3y41nM/RTWsM0aNwU/mGHRQ4YD1T2CUpk
	pPNSiU9BpSwzhdaj1NjxHO0tGFp5hlKAde8ah
X-Gm-Gg: ASbGncsiNjhSkA4dtPqKqSn+aC7lmhjkPucTx0Np6P+0xN5qcFQP3i4oxKGtrYWTnac
	e75tK7LJRmRH8dTtBmC5tQcNV1Q8Q
X-Google-Smtp-Source: AGHT+IFrO1RbXR1BECV5ppNLFYJI18uvMRvVfneR5G90YyCyM59TCgRh3cR3B627QSE8TFJLf7Wyfi62IUrXbkZNXAY=
X-Received: by 2002:a05:6902:70a:b0:e39:811:f2b4 with SMTP id
 3f1490d57ef6-e3a0b07dd5emr1843283276.1.1733474599157; Fri, 06 Dec 2024
 00:43:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACfnds=++C75pg8ojn5sJzjKzLcgnyPxgR2c6pOPCRmf2rDKvQ@mail.gmail.com>
 <CACfnds=J=Q+viagTEoiQ3edUxU8GSY_s7=biGUGY4NKbQpsTvw@mail.gmail.com>
In-Reply-To: <CACfnds=J=Q+viagTEoiQ3edUxU8GSY_s7=biGUGY4NKbQpsTvw@mail.gmail.com>
From: Shubham Kanodia <skanodia@atlassian.com>
Date: Fri, 6 Dec 2024 14:13:08 +0530
Message-ID: <CAARMkVGYOKb0H3pmUdcDWTs2p3hZZMX0dsdU1rT=Hg5a6M7Z6g@mail.gmail.com>
Subject: Re: git add -p is slow for sparse checkout
To: Manoraj K <mkenchugonde@atlassian.com>
Cc: git@vger.kernel.org, Victor Chan <vchan@atlassian.com>, 
	Shrey Somaiya <ssomaiya@atlassian.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 9:53=E2=80=AFAM Manoraj K <mkenchugonde@atlassian.co=
m> wrote:
>
> ++ CC
>
> On Fri, Dec 6, 2024 at 9:16=E2=80=AFAM Manoraj K <mkenchugonde@atlassian.=
com> wrote:
> >
> > Hi team,
> >
> > I am currently on a sparse checkout repository, and it looks like the
> > `git add=E2=80=94p` command is much slower than in a full checkout repo=
sitory.
> >
> > When run, the `git add=E2=80=94p` command expands to the full index and=
 takes
> > more time to start showing the patch.
> >
> > Also, we have git trace2 enabled, and the timings of the subcommands
> > gave us an indication that the `git apply=E2=80=94-cached` subcommand i=
s
> > taking way too long, with an average P50 of 3000ms against 300ms in
> > the full checkout repository. The other notable spikes are in `git
> > diff-files --color` (180ms vs 80ms) and `git diff-files --no-color`
> > (180ms vs 80ms).
> >
> > I am really interested in understanding why `git add -p` expands to a
> > full index, which I believe is the issue with start-up regression.
> > Also, would be great to understand the difference in performance of
> > the subcommands.

I started tracing execution of `git add -p`, it seems that `git add
-p` seems to require a
full index whereas a regular `git add` does not, because `git add -p`
ends up calling
 `do_read_index` in `read_cache.c`.


`do_read_index` seems to then call `prepare_repo_settings` that resets
the value of
`istate->repo.settings.command_requires_full_index` to `1`, even though
`istate->repo.settings.command_requires_full_index` passed to
`do_read_index` was
initially `0` for `git add -p`.

```
int do_read_index(struct index_state *istate, const char *path, int must_ex=
ist)
{
....
/*
* If the command explicitly requires a full index, force it
* to be full. Otherwise, correct the sparsity based on repository
* settings and other properties of the index (if necessary).
*/
prepare_repo_settings(istate->repo);
```

The comment here seems confusing to me =E2=80=94 it seems like the intent h=
ere
was to preserve
sparseness when as possible, but `prepare_repo_settings` seemsto do a
blanket reset =E2=80=94

```
void prepare_repo_settings(struct repository *r)
{
....
/*
* This setting guards all index reads to require a full index
* over a sparse index. After suitable guards are placed in the
* codebase around uses of the index, this setting will be
* removed.
*/
r->settings.command_requires_full_index =3D 1;
```

Retaining the original setting seems to fix the problem and makes `git
add -p` fast,
however I don't know if there's a reason why it wasn't already done this wa=
y.

```
read-cache.c | 5 +++++
1 file changed, 5 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index 01d0b3ad22..92f7561a88 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2339,7 +2339,12 @@ int do_read_index(struct index_state *istate,
const char *path, int must_exist)
* to be full. Otherwise, correct the sparsity based on repository
* settings and other properties of the index (if necessary).
*/
+ int previous_full_index_setting =3D
+ istate->repo->settings.command_requires_full_index;
+
prepare_repo_settings(istate->repo);
+ istate->repo->settings.command_requires_full_index =3D
previous_full_index_setting;
+
if (istate->repo->settings.command_requires_full_index)
ensure_full_index(istate);
else
```
