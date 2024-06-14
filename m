Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C161F157A47
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 15:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718379834; cv=none; b=L6mkXvNuGQgJAofYefd7RrMFEJ8pL/mo/7R5tsokMhQ8BXN1FhTGaj1sKCbvMHjpb2RpjDuVU5si7I5lXF+gpwltHv6Lv0WkDFelUoaB9uT7dG4XandhgstRAAMAvfa2/pGC8XeWYogkK/YOycjLqSC3SK5x58OUNWyru543m7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718379834; c=relaxed/simple;
	bh=XrFXiM3j/LdsuLqI4teMR+i07Yavz4fLRxllFdv5yNA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=WssWNetyJyXek201y8ODaUTTHXhcNbcNTlA8HiPHe2QiaYXHc+cavndEaH7p3h+iRix1V8qUuWA9L5s2H5tZwT1eAsjasfdFcgk/Vp6BemVden5QSLfKB6Vpw89eYjMRHfzT1euDW78UBe+Wz/GMklKjzPQDLCxJb4M6MOFc6kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/DhF3Nv; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/DhF3Nv"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52bc1261e8fso2726949e87.0
        for <git@vger.kernel.org>; Fri, 14 Jun 2024 08:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718379831; x=1718984631; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzxh89KHQFXi4nCdaVN0KoPQw06YJ149fPASbeMwn6Y=;
        b=V/DhF3NvoKENCliGMitAhK+jXwiNoCAXKk/RpD+eYGAPqP8/qwb4pEQzvg7sCS7V7S
         g9bOgRGmTd86shsHg0Eh66WtCKT3V7+TABwu/QwX04yMY3PDKBvzmhnuQ7AzHdNTVSf9
         dFgXWKXLj5/0lF37hP04/l4hGY1rRVN3mKfySJCKKkNuNSxRkJcViGdPIpvJOvnILl35
         GtSXapELOTAjRF42vqnActCIOQyFKNMMACZPPvjV1+e6w/k9gO9LOWXAMOwhc6rq50EE
         runkFPG9S1O7lPFozFE0JNqAOfO0rPsNI9RT00MTNuJeb3Fg0040B7M4gmHJ97vXXoBC
         SqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718379831; x=1718984631;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzxh89KHQFXi4nCdaVN0KoPQw06YJ149fPASbeMwn6Y=;
        b=hAVdxxcZ5tHKEsZYAEDpLWqjKcinjy8JV33mDurOC2htr4DbC4d+21kthcC9TYAcxI
         rzHhUFqyZt9fWPf7aYVBEDszVnyM8eCbHkQJVuzO6ItWY/c2QT8uhPW3KI9DALjkuubr
         V+njLsx3c9cnNkExD9ehH0r6LZ4Tl+sHItmw9dMErf9oNoLYm50olSNWWk5vqE+rW6wI
         mffaSZOQJFuUARNeC3PL1EU/VEXN96C724GzFUziDN+2TMON2LbyCcusJ3QsqWFWMfbq
         HTdrwhAJmTcuJ36PmnfE/vttqD1U8iuLsxtsW+LSgblD+7wN8b6cRWPE9C7oo9sSES9K
         YlzA==
X-Gm-Message-State: AOJu0YzxKvDD5zy5fyILVxB1CuE/H6UNmhgoDHOygkXE3yH8bTLKUZCR
	N4kkv3B+7lAiBailfwdM5Ae2T89ZDEQ/iENMbU/t3Tz4PZ/uPzDH/0TyaTktr6Q=
X-Google-Smtp-Source: AGHT+IGa8frK5t9e0GTvia0D2uKSi3x7nH6PtjK31SNtao5rb8MphjhMjiqBnusu3YgVJ9fRXYG+1A==
X-Received: by 2002:a19:f706:0:b0:52b:c071:f034 with SMTP id 2adb3069b0e04-52ca6e9d8f6mr2338129e87.60.1718379830483;
        Fri, 14 Jun 2024 08:43:50 -0700 (PDT)
Received: from smtpclient.apple ([2a01:e0a:565:11e0:e531:f1c9:c5b7:7516])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4228531a702sm62505115e9.1.2024.06.14.08.43.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2024 08:43:50 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: Non-blob .gitmodules and .gitattributes
From: Alexey Pelykh <alexey.pelykh@gmail.com>
In-Reply-To: <xmqqbk43ilk3.fsf@gitster.g>
Date: Fri, 14 Jun 2024 17:43:39 +0200
Cc: git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8E37AD78-C480-4838-9F69-3E7FC209A9FC@gmail.com>
References: <4F3AD9A8-DA3E-43E2-BF9A-9D7458EED7EA@gmail.com>
 <xmqqbk43ilk3.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3774.600.62)

Dear Junio,

Thanks for providing more insight!

The error I'm seeing due to ".gitattributes" folder being present in the =
diff via the ".gitattributes/shared.gitattributes" file is the =
following:

error in tree f8db7c96f9daf3ea8486804a3f717a807fc1a1d8: =
gitattributesBlob: non-blob found at .gitattributes

I'm seeing this on both "git push" and "git fsck". Steps to reproduce:
$ mkdir test
$ cd test
$ git init
$ mkdir -p subdir/.gitattributes
$ touch subdir/.gitattributes/some-file
$ git add touch subdir/.gitattributes/some-file
$ git commit -m "test"

$ git fsck
Checking object directories: 100% (256/256), done.
error in tree 3666f1677ba5c7ec7e69544510a0d8b99a71774a: =
gitattributesBlob: non-blob found at .gitattributes

git-push will give the same, at least when pushing to GitHub.

Kind regards,
Alexey

> On 14 Jun 2024, at 17:35, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Alexey Pelykh <alexey.pelykh@gmail.com> writes:
>=20
>> I've stumbled upon a check that ensures that .gitmodules and
>> .gitattributes must be blobs,
>=20
> Alexey, thanks for a report.
>=20
> For those who want to take a look, unfortunately Alexey does not
> show any error message or describe the end-user visible effect that
> the "check" caused, so there is a bit too little to go on.
>=20
>> yet while I get why they should not
>> be e.g. a symlink, what's the downside of permitting (and ignoring
>> for the actual purpose) e.g. .gitattributes folder?
>=20
> My knee-jerk reaction is that we probably can safely loosen by
> ignoring non-blob .gitWHATEVER files, but security-minded folks may
> be able to come up with some plausible attack scenarios if we did
> so.
>=20
> Comments from those who have worked on transfer time and runtime
> checks on these are highly appreciated.
>=20
> Having said that, the checks for .gitmodules and .gitattributes in
> fsck.c first collect objects that tree entries with these names
> point at into oidsets (this all happens in fsck.c:fsck_tree()), but
> the actual check for these found objects are done only when they are
> blobs.  Only when we encounter a blob object, these oidsets are
> looked at in fsck.c:fsck_blob(), and if it is .gitmodules its
> contents inspected (and may result in a warning or an error).  So
> the "checks" Alexey reports may not be in the runtime or transfer
> time checks done in fsck but something else.  I dunno.
>=20
> Thanks.
>=20

