Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1B01519AC
	for <git@vger.kernel.org>; Sat,  2 Aug 2025 19:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754164604; cv=none; b=Vm2lO9DDnXsyT0yuiJ04FAHj2ps1gxt8/GfjtBHYwv/JbZWnOJP3pVIW/3/6pElX9lUT2zagi0ltdGXsLFuLDDpuQDa0gsa06Sd81zZdz2IMYB4f3GnSklwmKikVYnMyaVR+CZbFiYBZFdZ0ySCcO1z/Jp84rEyM3FmNSICxDyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754164604; c=relaxed/simple;
	bh=zels5FlXciVjmxt8AJ5exS+oP7MM21V1qUvhPW4GtLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mBqRCY/Lo+7TPtaHkt2BzLeuRypDq/xLyy+968Sn/XeU6B//Ejdu6KPe1k4gMgTw9My8s9wspK3LocEStJcc7ujXSAKc5DBKqbfmOIXTbVOdb+v/DDvMwtMYceaMYVgkfe/xBTp/crbtLpGt9Q4qVYcGWEIO40QgQpR6720q/rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jk8o7iLR; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jk8o7iLR"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-af0dc229478so301968866b.1
        for <git@vger.kernel.org>; Sat, 02 Aug 2025 12:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754164601; x=1754769401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6B6/PvVa2fKJL8wvcAwhOIMa09eU2VnN0hwAcw0R8Rg=;
        b=jk8o7iLRhEjaou2zQ+6Zh2eDM5scdzBvT7x5gyTtfN4J1dExR0bpDXDvFy9/SXpIO5
         0G7AriyMCCdkJTKxe5YcDodJuB83iJK8PclxY2FYXKHBzwASY/HxEXyJRrelCdCquUZJ
         9F7BM86w5kkmDHRQAu0p2cR/mlD9J5sc4SrYEnoX1LIW0ikT4UJDkHagf4Z7PGcbRtka
         FrP7LTj9RxKJ7buL0rQnvQSGwNWTGoW4JIHvV1ex2dDPN50MppxtB3jO0fP3Xe5JJsYd
         qcq9iHVQivBbOR3BNMmZE0grVcAW7xUGoU1tUjsuFK8QOctQMFq6ti5sccq8aaza25QI
         oqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754164601; x=1754769401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6B6/PvVa2fKJL8wvcAwhOIMa09eU2VnN0hwAcw0R8Rg=;
        b=JF9jvQh80zO9ZjgioMggP84GtUcd9XcljisVrJ4S7t62EuA9U1vXBX2eT38ZIiw44d
         R/Xet6wYpJy8hiuxP4DqJzSK7cB+ag1i7RMrVBljTog3H1PWG5o77XwM1hij7Z1QtiIg
         9Veclp9qY66+/OJgmm9VfexBLP4XzW1+mlaiY4MinxLS9duYO4E044pYqGj1+FKKhQTR
         pURC7CKdpAdvoLq/RXpoyakkjvkgrtQam7+9lQmDMuTD/srlIrrBOz9yKI2V7H/Uh4sq
         sJOFDHNBvr8yuj4HQghQnMaxiNd/I8pu+jBDGPm/tGLTO1H2pOcS6709trK5QlykoeN8
         FfJA==
X-Gm-Message-State: AOJu0YxODXGmibEfjJdeICUfP5uDCdRTiPHh0IU/iqL6Kro/XwMhaTbj
	9OwLGcWxS5IqX1D0JPt0DnhWKx9TpRcLUnKvbOKN6B4OelE+OrgYkeYggkwvBr8t3S+LhurI6nq
	3cIzokqTCNNOyvkr7Tclng2wCZdgLa2M=
X-Gm-Gg: ASbGncuF3wVmdRS5yEAX6rD7j0tlsaJw0JV0F91wYHiQrZwzB0wvhG/DKSapWuV4+un
	diPpUcsglS0E7DwNJgBNDLzWE8Dg/r8DTQbEKVRMjE8z30UZLrZC2+ikl6XqetMPOmw8Ss4LPj+
	YSFryPxy4jA1t3AXSbuFe6ZmoqZL6/ESHlZFtycRogmywlRms9b9emZQW9CmofFpkaaB3BJKG9+
	2vxGHO0PqUluDhOzJDau7VAdNLEijSObkKld4apX6HCTYUvmVtd
X-Google-Smtp-Source: AGHT+IE3bPtWvmJ2t7uUubJN+H0PiJSyYnB+LubZ33LbPhJL05qkjEQ1Nkw5sLciLDeviupj9RrYYGtHD7mV7D0guv8=
X-Received: by 2002:a17:907:dac:b0:ae3:a799:8e84 with SMTP id
 a640c23a62f3a-af93ffbd4eemr394198766b.8.1754164600451; Sat, 02 Aug 2025
 12:56:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqcya63cqx.fsf@gitster.g> <20250721115519.140361-1-usmanakinyemi202@gmail.com>
 <20250721115519.140361-2-usmanakinyemi202@gmail.com> <CALnO6CCN0HUXJVYmvAJO3EoQQZzHVjE0P=g+AUc9c5Ti0Rcm2w@mail.gmail.com>
In-Reply-To: <CALnO6CCN0HUXJVYmvAJO3EoQQZzHVjE0P=g+AUc9c5Ti0Rcm2w@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 2 Aug 2025 15:56:29 -0400
X-Gm-Features: Ac12FXwG9ibS8jHE_xh9mXZXhihabKqP7Zf0Ii7QD1f_FgqHBpMwSokuIi5KeDY
Message-ID: <CALnO6CAPBsxg=-aXVUUJSKrPLWWPLGdEM=k5J=GVoh5fVTAhYQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] t/t1517: automate `git subcmd -h` tests outside a repository
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, chriscool@tuxfamily.org, 
	christian.couder@gmail.com, me@ttaylorr.com, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 26, 2025 at 10:34=E2=80=AFAM D. Ben Knoble <ben.knoble@gmail.co=
m> wrote:
>
> On Mon, Jul 21, 2025 at 7:55=E2=80=AFAM Usman Akinyemi
> <usmanakinyemi202@gmail.com> wrote:
> >
> > Replace manual `-h` tests with a loop over all subcommands using
> > `git --list-cmds=3Dmain`. This ensures consistent coverage of `-h`
> > behavior outside a repo and future-proofs the test by covering
> > new commands automatically.
> >
> > Known exceptions are skipped or marked as expected failures.
> >
> > Suggested-by: Patrick Steinhardt <ps@pks.im>
> > Helped-by: Junio C Hamano <gitster@pobox.com>
> > Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> > ---
> >  t/t1517-outside-repo.sh | 25 +++++++++++++++++++++++--
> >  1 file changed, 23 insertions(+), 2 deletions(-)
> >
> > diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
> > index 6824581317..9fcebb7d94 100755
> > --- a/t/t1517-outside-repo.sh
> > +++ b/t/t1517-outside-repo.sh
> > @@ -110,8 +110,29 @@ test_expect_success LIBCURL 'remote-http outside r=
epository' '
> >  test_expect_success 'update-server-info does not crash with -h' '
> >         test_expect_code 129 git update-server-info -h >usage &&
> >         test_grep "[Uu]sage: git update-server-info " usage &&
> > -       test_expect_code 129 nongit git update-server-info -h >usage &&
> > -       test_grep "[Uu]sage: git update-server-info " usage
> >  '
> >
> > +for cmd in $(git --list-cmds=3Dmain)
> > +do
> > +       cmd=3D${cmd%.*} # strip .sh, .perl, etc.
> > +       case "$cmd" in
> > +       archimport | cvsexportcommit | cvsimport | cvsserver | daemon |=
 \
> > +       difftool--helper | filter-branch | fsck-objects | get-tar-commi=
t-id | \
> > +       http-backend | http-fetch | http-push | init-db | instaweb.sh |=
 \
> > +       merge-octopus | merge-one-file | merge-resolve | mergetool | \
> > +       mktag | p4 | p4.py | pickaxe | quiltimport | remote-ftp | remot=
e-ftps | \
>
> Hm=E2=80=94if we strip the suffix with ${cmd%.*}, do we need a p4.py patt=
ern
> too? Actually, at first I wondered why we need to strip the suffix at
> all. My local Git produces only unsuffixed commands. But
> bin-wrappers/git produces both p4 and p4.py; request-pull and
> request-pull.sh; and several others. So I think stripping is probably
> right, just drop the .py pattern.

I think that using "instaweb.sh" instead of "instaweb" also causes
this to fail on Windows, like:

https://github.com/benknoble/git/actions/runs/16695826272/job/47259908953

--=20
D. Ben Knoble
