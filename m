Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7FE84A36
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 22:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727908539; cv=none; b=ZZROSmhWT42cDuGUqTeZCDKiVOBcf50azIcG4znuSNh8Ros/G+Z6O7IzsyhEVXIKJFZPSVwhU4aFH7mvjjEeR3l3CUyfZ43c4qu3rssuV0jjN8Mu+3gA7DXbth6a/faY2HaT4kNmleZMnCxb6mcjhShOYDX5xfaLvuzlJM50xHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727908539; c=relaxed/simple;
	bh=W12aCsD27QPyhxTUXWnxG3cJi4yQaWBrsl69K6ivBL4=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=qkbTST80pWap1XNZaH5XgliXVWHBVWgL4VIB80KTqrPYeGY5U9RqMyk3t7R/FWBgbQm1CSVFkX2cs1TnEIUSWzEmITmpHz9M2aeIstjQzLsY3isXIfR4qQG9yRD+Twg/wKz00YTTbJvRTaOlb9wd+6z8KDBZbwFWBhAMk19yKF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Laq3WVxM; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Laq3WVxM"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-20afe0063e0so2248735ad.3
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 15:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727908537; x=1728513337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0pNm92IxY1x5sv4hqW0pGN1esXjBuhfgSEuagsjVRMc=;
        b=Laq3WVxM+UYA7vGA96vAC88IeVJAb/zR+2Lmr8u7c1Zo/3BAYvjiRqO0aDeVBHxGfa
         iY1/8QFR+CRAQ+t1DMYzWxQo0NZKOZef0ScQR0Fhh/6ZqtnCM867psMNnpEeaP5yXCLL
         kv5hJVDxnc89n/uwDEsJrSI2R83D0HZNeTnO/3CDj37LPcKT+9ThJp4wdP5XkAqsKMyq
         8OEJOrE4eKdam5R7t67dqTWrg1XoZjgP4ftb6JqbXoMtgG6EWCVUUs5Garu8N5ORH0xI
         +lITlsvqLgnug1zDGB7dkWVzAZyTJJOkDOsHAUT/QJhT/EMRbolDokK7FO4rO6jCkKbE
         O6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727908537; x=1728513337;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0pNm92IxY1x5sv4hqW0pGN1esXjBuhfgSEuagsjVRMc=;
        b=T8g4s0/64/3eavK/wRezekV6dWmi8vdJVer5WbteioWFlgs7rAS/aR/6ISCKavqfuJ
         GduWEosZA9OVc365N95ZIoKDV7ddQEQ5ntG/NidqEKVURfzANmT7G53hwzfBLAIOI856
         Mdu2Es29KWQ2petQumtjCpFZxibftoHp1CD4KwxX4ubgoRZL8ONUuGTWckqVpODObxl2
         rrd/wn2LQz+PQGv9KUcM1byPHI1cxg3yYekeDGVq7xkBMv4jEIvqwW/xvxeR1nE1UYw9
         5l1y5YC86Fqh1kydkcQ1GEAcqY1zHTllw8Jp3IhIXI3rECE74Nv9C68gaIfofQe+8hs2
         czSA==
X-Forwarded-Encrypted: i=1; AJvYcCVUTXJkUiNfAo29u/NA9DV1IRvopXBmPMk74191UI6YNSsPlJ/Sv0fML7Oav4oF/Hnwm+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB69P29oax7UzdfyUxQDJTlSSFr16/4HdMr4UoWFrt4XpoV7lx
	t6RmL3yFQ8ikJcXtCz3F/91m4EFgy2lU0GATs66nIwfFrYmpBglmNwZ0Sdzyc6VEP9UOeOpKNIe
	XP5Z3jWvyroOhNg==
X-Google-Smtp-Source: AGHT+IHwBiQGJE/EfO3INGV0RgW0uhRloyBmIZ1ioRkiuBU7IhUo9T3rEb83F6cFYxk9n5PFOPhNbmEBt9fSON4=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:903:191:b0:20b:94a3:19e6 with SMTP
 id d9443c01a7336-20bc598e96cmr610745ad.2.1727908536186; Wed, 02 Oct 2024
 15:35:36 -0700 (PDT)
Date: Wed,  2 Oct 2024 22:35:21 +0000
In-Reply-To: <CAG1j3zHJVrpK5JZtUXFwkZgWY1-CxqET+ygpaMqo5aM-KeWaxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20241002223533.1408491-1-calvinwan@google.com>
Subject: Re: [External] Re: [PATCH 2/2] fetch-pack.c: do not declare local
 commits as "have" in partial repos
From: Calvin Wan <calvinwan@google.com>
To: "=?UTF-8?q?=E9=9F=A9=E4=BB=B0?=" <hanyang.tony@bytedance.com>
Cc: Calvin Wan <calvinwan@google.com>, Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	jonathantanmy@google.com, sokcevic@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=E9=9F=A9=E4=BB=B0 <hanyang.tony@bytedance.com> writes:
> On Sun, Sep 22, 2024 at 2:53=E2=80=AFPM Junio C Hamano <gitster@pobox.com=
> wrote:
>=20
> > I was hoping to see that the issue can be fixed on the "gc" side,
> > regardless of how the objects enter our repository, but perhaps I am
> > missing something.  Isn't it just the matter of collecting C1, C3
> > but not C2?  Or to put it another way, if we first create a list of
> > objects to be packed (regardless of whether they are in promisor
> > packs), and then remove the objects that are in promisor packs from
> > the list, and pack the objects still remaining in the list?
>=20
> I tried to fix the issue on the "gc" side following JTan's suggestion,
> by packing local objects referenced by promisor objects into promisor
> packs. But it turns out the cost for "for each promisor object,
> parse them and try to decide the objects they reference is in local repo"
> is too great. In a test blob:none partial clone repo, the gc would take m=
ore
> than one hour in the 2019 MacBook, despite the repo only
> having 17071073 objects. Normally it would take about 30 minutes.

I found that running `time git submodule foreach git <create promisor
pack set>` on Android takes 25 minutes on my machine. Granted this is
single threaded but it's still quite an expensive operation to be doing
on every recursive fetch. If this operation is so expensive, then unless
we can figure out some method that doesn't involve creating a set of
promisor pack objects, solving this during fetch is infeasible.
