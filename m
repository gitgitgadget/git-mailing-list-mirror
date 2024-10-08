Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A21136982
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 18:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728412682; cv=none; b=njY26JRSaWlpOLAfKGNO0TmdMF/BVoXDfsmFtgGSU3Jh6AlOBUKOjCLBUt5E3wM9siDucsXp3yzUZ0Bsfbac5dmYk1dl9BBClwWy859buXUdHIMXJ3SdiULOb9t8VfL64BTR+Co5Njp0nxWPfe+Cpb9/5VAoleCuLuA7r3tAlk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728412682; c=relaxed/simple;
	bh=zjINzvrw96aW4Qv6DtJ7BcdrVnenTvVjVDgt6xeQR5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=kqozTDbpZRPOHeVq3oMn6WebGirBdbO+9leAKTiEHORwuYq4agSxA4x34XtjrEZRkL5SBJFp9qHg7KrG4CGYxZ79AurY2RQDEOsygIubsmx+V/xMRYUK/R/PBimqxWPKToYZTlYfd52j0q3zsA4IRFgw1kTs6NbttQvCpN1Eayw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJhFvnu+; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJhFvnu+"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fabe5c8c26so54262791fa.2
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 11:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728412679; x=1729017479; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjINzvrw96aW4Qv6DtJ7BcdrVnenTvVjVDgt6xeQR5Y=;
        b=GJhFvnu+W2D2rjPZUnXU4b5MhYBpqKJ32IXd5CunEkjxrQU8+zO/cad3W3xQkCHM15
         atHVIAUXw9Oz8D33FA9zJv9VxaGfF5T5ahzBWiqd3rHs+zfi5CNgrXjlc6YGolWVAvIM
         R1tiRVeKDl/UAwr12U4Rkx/Xe1dkUHrJJZLB2dtWuHfeeuij1xKDnNEKFiJ29yVEkP6P
         AnX5tTtuRiH3m9DF5bRTy0TP/RM7b+NL0Pihs+DWaotN8hDU3ubfkDlQjtOgd4R4qLmV
         +MANAOVrtvDb6u3rELlBPUuDvp6ahIzW8t9ntlXkELAHYmhYO/grWPdbLZGcr+VbNvQo
         Hwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728412679; x=1729017479;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zjINzvrw96aW4Qv6DtJ7BcdrVnenTvVjVDgt6xeQR5Y=;
        b=lcwkA/5GnsJeH7YUrYARJwJtbPC8ZBFHC+dAVZC6sKJ5nQuWo4VDKrxqNHCImWjvPN
         d2gsxHlUXdykbgcrZ5qzM4k3/vco9nGSoK4EZNNgKfO6LdxyI3F4LbrOqgK8M4CIqNZj
         +Q5UdepU0aLV1HwwfDdB1I+w4xLP6sB+Q5W2w8cz5fT254HB+BdpgLTFhiNgSeyCrnj+
         WAO4chuz8UYdRjZ5BzOyobda0tDfLUByrAbWpE6occ0kUJ8ppWpJMRnr+3gR9YUSBA+K
         YXIG6SOcOIcQ5ABN8AmWFEfQIfxniNT1HO4/ncFH/joDjvWnE/jnSx3EH+kP06J/FsTT
         XdNQ==
X-Gm-Message-State: AOJu0YwJgmb4K1+QHyJV4aaGZVvpnzB3b2zbKbuySsUiBNCmfvd0SoVQ
	/CdgQwoyKsALBGi1T+t5JDR99p0tfLkkZbmJM4lex9+y7PugBdskgTevOFuXFoCEFUy/FbVI4GZ
	fOm6hMNEfAbzyoE0Z5cvwlrIC6Z0HUN0=
X-Google-Smtp-Source: AGHT+IGgAHTfxru7ak2W40Nxwxv3Q1TXgyiLeK1iSPtfWZqG0kwSVswZt11/HI3SxorNHQonnP4uFNUMJiBBGxfUyiY=
X-Received: by 2002:a2e:d1a:0:b0:2fa:d059:af2 with SMTP id 38308e7fff4ca-2fb187d282emr131781fa.39.1728412678772;
 Tue, 08 Oct 2024 11:37:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABa71ByU_9g_6OgJ9PsoQ99oyMspucTBqO-RkB_2W4smTr2RNw@mail.gmail.com>
In-Reply-To: <CABa71ByU_9g_6OgJ9PsoQ99oyMspucTBqO-RkB_2W4smTr2RNw@mail.gmail.com>
From: Spencer Fretwell <spencer.fretwell@gmail.com>
Date: Tue, 8 Oct 2024 12:37:47 -0600
Message-ID: <CABa71BwtEWS79CZwPOa_Nrh1iMrXRo+hyxNBc5F8GsQiwjdapw@mail.gmail.com>
Subject: Re: Verbose Commit Ignore Line Fails via CRLF Line Endings
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On second glance it might involve having a file being committed that
has CRLF endings in it.
Committing files with LF only does not produce issue.

I suspect git either needs to add support for a magic ignore line
ending with a CRLF,
or has to sanitize verbose output when that output has CRLF (less ideal)

Bug originally seen as early as
[2018](https://superuser.com/questions/1367811/sometimes-git-includes-the-d=
iff-to-commit-message-when-using-verbose)

On Tue, Oct 8, 2024 at 12:30=E2=80=AFPM Spencer Fretwell
<spencer.fretwell@gmail.com> wrote:
>
> gc -v produces CRLF file which does not ignore verbose description.
>
> OSX + git-annex (pre-commit hook disabled just in case)
> using subl -w (sublime text 4) as editor, which indicated the change
> in line endings
> - committing as Unix fixes the issue (workaround, tedious)
> - leaving as Windows is the issue
>
> see attached bugreport
