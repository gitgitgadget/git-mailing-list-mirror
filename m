Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEF32550A4
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 07:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760687914; cv=none; b=qQIrxxxJ0swqs9T+lF2VNRgvA1mCxG5HQPS0pH8g5QVQ1hgenmpDOL4q17egum1r6q2F9rwN5WMNs1LOXm6h5TyM7viqeGBT3DdgHWKr3zgBz2Wd/hocIapqwlt9aLkpLceE1Pv+/dQe3xCKz5J5STIwDjtRQPdGzlVGA25gTnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760687914; c=relaxed/simple;
	bh=kpWz7JWSHYKeho/wkBwMT+PjkJCfM6j+kY8XHGMd+Mk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EFQlVmKZoMcdZQowhovtGBklgVIw3k3x9HyWfyH2QJFN6tZ4uDbvlM0+bWLJVI6glz2bbCi+E+tUabayxMJF7/qqf3Rb8fI4SfAifjUNEqNJgsLQQNSpBQ5+4mNSTBIw+zXxdRvgkTzoLRWAEaxeJ58bQv2k/7eEJiuJ0hDsucQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8ebvXW9; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8ebvXW9"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b472842981fso206079666b.1
        for <git@vger.kernel.org>; Fri, 17 Oct 2025 00:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760687911; x=1761292711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stezGxt6zQbIQuuO1Hxd5ni/6bbya0k+a83G7+Ebu8Q=;
        b=D8ebvXW9GiSeKckwgHns7+vyIZRkERAfDSMjZPfz8aOHdE6pM3tR1p/ICPpt+DwYs9
         8eFUaNNZID2HKMgUnd0s/4tJcAneLxQAPG+IOnskWq5cNLURoapyZUDYCAdA/23ry8uc
         0s9AJsasyqltVGQQGhuTi4QV9J/zF0+aMTBjoCEwb4csrgx3D2lYLiCKdGk9iajNKvMW
         6ju0vtT0YNRS9dwHY4rNC5UBnx4/AFybOO8cpNgjzDZeVeMp+4ToP0k1ErwfPdeOeODG
         umQX9XDA0jvJvzPsO0KpIkSff3qixJGktQT/3656eUOdaeDbCrNiFcpL9OuNbIylywhY
         hl3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760687911; x=1761292711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=stezGxt6zQbIQuuO1Hxd5ni/6bbya0k+a83G7+Ebu8Q=;
        b=ImUD3buZaWevKZRfgktZx6/oa6ghHOjfP17R6upDFaDkC+yIVDZps/GHVjRRDqTtWO
         nxh2BS2GQMuTOOYZE37tssPk2QRmj3lSiGBVm54bNdpfXsZ3k0bpDMLg9xCRwKmz3TqY
         NMOpM1OWYG70nkDjIsqRi3x3GsfcTeWf52HseAIiJekmTJZAqhHtwzUojrwHvcJrHr+T
         53Ev94xEoYrrg88o0scQlObBIOi1pmWhMa4AnqfEOt6rGhakxAFCtOHc2UXs9xR/skQT
         2HnJp+BZ6HxyFxN3ZawYIAXPLt8K8enZysKzy+Zbp84y2H/ACLyMzkiNQkQwbUvGMbGg
         J9fw==
X-Gm-Message-State: AOJu0Yzpdtlde9fhNjI1ycH4r/ApoC6bOnudx8JfX0ZsQTJbb3zVY0VT
	O9+Ck2dEgxGQcux6nHmuJN5ip/GHIeXg/lzwrDxU8xALVjSzZ1kJOppmvDPXxM6aDGgjXB4Rmuz
	9qYi1SuJY8gqFwdRqybbcoqnrkawgIFk=
X-Gm-Gg: ASbGncv5wLHCAcCkm9LEDzkOfs8AEVNJwAUeUaMY+2w9rL6STGk5VziraVyLpzHkOjG
	WDfqTQvQb/hMI8DJPYoW4R0t6kCE4S257Q8KCJaNo2Xwp1kTjoy9whhFLKzmcYdEhDOGGc16L1G
	HL+Lmg8sBMDp4sWKpX/smA0rwftk319+iKq9u2PLcIbuviJkVBMLFALXBz0uxpRejz6quhfYGA5
	E0XntouNDfXf3EkDEbLWo2D9rvLKhCNOY17NKcO+E06XhcSBpvRoc49axTD7CfoVdTG1Bw=
X-Google-Smtp-Source: AGHT+IFX+J5i/MIG3y9jh/wPfWkVOT7D3MQf7YECePd3pCDAVRt2UtqBifw+w8bfc6gQ+OmkKnMdSC4RVOcp9J2MFAs=
X-Received: by 2002:a17:907:fd8a:b0:b40:33ec:51ea with SMTP id
 a640c23a62f3a-b647195b5acmr256393166b.6.1760687910753; Fri, 17 Oct 2025
 00:58:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760571220.git.belkid98@gmail.com>
In-Reply-To: <cover.1760571220.git.belkid98@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 17 Oct 2025 09:58:18 +0200
X-Gm-Features: AS18NWBuiXlvcJyaShKG0e2glta3a52ofNszzl6DmXY1_Y_JKF0zN4E25VAY_1s
Message-ID: <CAP8UFD0Lzmt5ayQ3iSXtmJohDawmCEiu1r8Gq2mKTMy-1gX_fw@mail.gmail.com>
Subject: Re: [Outreachy PATCH v2 0/2] gpg-interface.c: use string_list_split()
 instead of strbuf_split_max()
To: Olamide Caleb Bello <belkid98@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, usmanakinyemi202@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 3:04=E2=80=AFAM Olamide Caleb Bello <belkid98@gmail=
.com> wrote:
>
> Commit 2efe707054 (wt-status: avoid strbuf_split*(), 2025-07-31) noticed
> that the array of strbufs that calls to strbuf_split*() provides are mere=
ly
> used to store the strings gotten from the split and no edit are
> done on these resulting strings making the strbuf_split*() unideal
> for this usecase, with the string_list_split*() being a more suitable opt=
ion.
>
> The patch series by Junio Hamano can be seen in the link below.
>
> https://public-inbox.org/git/20250731225433.4028872-1-gitster@pobox.com/

This description is probably good enough as-is, but here are some
comments that might help improve it if you want if you send a v3.

The way you explain things up to here, it might seem only one commit
in that series is about avoiding strbuf_split*(). But in fact the
commit you mention is the first one in that series which is named "do
not overuse strbuf_split*()" and contains 11 patches.

So I think it would be a bit better if, instead of speaking about that
commit first, this cover letter started with a link to that patch
series and explained the purpose of the whole series. You may then
mention one or more commits in the series as examples of commits where
strbuf_split*() is replaced with string_list_split*() though if you
want.

> This series continues on this path by replacing instances of
> strbuf_split_max() with string_list_split() where the string from the
> split is merely returned as char * and no edits are done on them.

Yeah, some commits in the series do that, but not all.

> Changes since v1
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  - Added commit reference and link to patch series for previous work
>  done on the subject

In a cover letter we are interested in the changes in the patch series
since the previous version, not the changes in the cover letter. This
is because the cover letter itself is not merged (except perhaps its
first few sentences that might be reused in the merge commit, but this
is more advanced, so don't take this into account for now) when a
patch series is merged. So a cover letter is more about giving context
to reviewers and inviting them to review the patch series.

So here it would be nice if there were things like:

  - a summary of the changes in the patch series since v1,
  - a range diff between v1 and v2,
  - a link to a CI platform where the v2 has been pushed and the CI
tests have been performed.

This would help make reviewer confident that the series is in a much
better shape compared to v1 and reviewers' comments on v1 have been
taken into account.

Thanks.
