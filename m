Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C0635C1B6
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 16:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776443949; cv=none; b=Q3Deki+N7Wf+JV/KnrdbWlcNJ7K1XtSXOffbeyhQDgf1eCWNw2mqiWM1IhJ1xHc1d6M/903Eq4iaPwnzCueGh/SvcR/q/k56cvhsOrXCmN5ypFTm8BNTjsLVtWCh8BO+EpJUEiTiCARUZSPj3FPRwoGZ2LoQn6kIGGdh9k9cnlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776443949; c=relaxed/simple;
	bh=xPeCdnfA4wtdGVl6CYTKBNciIsfkU6kMIzDDE3/3JMk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q6HIuRJjJbtxR/Arjd02cdZ+RQJ8ER5XKx/o2mdKhe84cZxYkb7wjHSmnotOhdv38tgjwIk9BDVbU5l43a2QW+T877MC1Was1HJlguu/bQRB1DyIPCrEwRxtsLU9Wt00DOjiLBqYo+ogbFCUbQPqyQRKvkVXKAELraz/gHVOMeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdBBG7Nu; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdBBG7Nu"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12c565dd3a7so1331229c88.1
        for <git@vger.kernel.org>; Fri, 17 Apr 2026 09:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776443941; x=1777048741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uctCA0Q/XHq2cDnAK0LyuSrVZmoPp38+g2V62PP450c=;
        b=FdBBG7Nu7kf3iV4YJyKpSZJ+Oq3i7oDRzveSKP4x5B/lsD8pW/C8LGkygLyYzrKIgf
         wnw7/HtcP8qCXmWTFVHC+x1Fy9uzHEBBsIPNJ6XSrNAooowDjw7ytGNsQgiJNDQWgMBc
         wAIN7AB8K0OR2DXJ20wyUKiO+Fs21eVMu81Gak0iNWBKPle012Mu8bWrZpRcCmnldIhl
         f4mxwMhrnEEH+zwSyEwaFOahE90Qk+pTiq66kcJuMNKH5tqhjjcDM8zdCG8E2v0ra9Or
         kzapBJEgrIQaHhBvjnzB38PPSwEC6Cc+zMZyERkVczYjsPjT/8cy7EF2nYgHTrmonBO0
         VCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776443941; x=1777048741;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uctCA0Q/XHq2cDnAK0LyuSrVZmoPp38+g2V62PP450c=;
        b=cyq6mYIVSOAZD/AYX94i946wkrl+2vo7fVfbV6dF+YdX/CmwQ7U7tKDfqxcZSkarPt
         3gF8WRDEASKkaDsp4WC562pLs2WBtj1q2EvGotu+moEiS5+JzWW8q5jwBWJVcnjUz+ik
         0WkeARj6A87/oqwwFWjTVhfR/9a/7zmDGErR5Uq+Drz5rzMZVUa/jtvkM06dONn6igvr
         5x87A2QfslnzR+5uUta0CU2fhNHdbmBu3uH6iPuqdVXc+0SkqpI6OyjU+U6T5NdipyhG
         D8ZTWFFCa8M4LJPH/sKtI9VmuYvnMwsCmN2AEYd8bMui0pWFYxT/wYF6tFssoFefCG3+
         UyhA==
X-Gm-Message-State: AOJu0YzItLGkDnX2oDL/O/ZlhJLU1enKVdL4FhwP8IwgVxaRFmMoeijB
	XCEeSs7AI7/UQ8GeWqeT+6yuoIC8MFSvgdlQHFUqC4GKJkEEbKHkksE6o8mqnA==
X-Gm-Gg: AeBDieuLBLwPpJ/+BJYQ11VjAIxcPxdewDuiyJ/y+MV2wQ2Rln734+91vrds0cuQKSb
	SX5JjBNVEkq1+H26ZmkYuspQd8QAbTwGv4J+t3soMZEv0iacNZyK9sJbI9D0J7EWUJixefvq6qz
	XTmOZ9fT95zq8D3EPCovlxTh7EcEBct4CO3kzRgqMHcn5jy8p6tHoMpBwU/q/vqqof+nmi0m+ky
	todjCovoFbuiJmsKWZD6rww/EZOBDhqrp9Xx551UWQp1SipvN3RF9GahvrMrMHUDHcIibwWipOM
	UbcG6wEnrKemrU14T8Aja2jgQKAHA9l7bOwZIazP+QcsYfIc2xFll73j7JaEI+QrYJUvva/WVp6
	XMLUCDx9A0pYhY5I4MSlemYGqI4/th3E6x72up4osUBLRnPK62KUQrmi6/2dHFbMMf0GGyCL6fN
	wQXfqCXhqOzKWPVDw=
X-Received: by 2002:a05:7022:6988:b0:119:e56b:c75b with SMTP id a92af1059eb24-12c73faf85cmr1856509c88.32.1776443941137;
        Fri, 17 Apr 2026 09:39:01 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::19df])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c74a20b9csm2786099c88.12.2026.04.17.09.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 09:39:00 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH tig] Fix compiler warning with latest gcc
In-Reply-To: <20260417161228.1578-1-marcel@holtmann.org>
References: <20260417161228.1578-1-marcel@holtmann.org>
Date: Fri, 17 Apr 2026 09:38:59 -0700
Message-ID: <87pl3xsfrw.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Marcel Holtmann <marcel@holtmann.org> writes:

>         CC  src/diff.o
> src/diff.c: In function =E2=80=98diff_common_add_diff_stat=E2=80=99:
> src/diff.c:191:22: warning: initialization discards =E2=80=98const=E2=80=
=99 qualifier from pointer target type [-Wdiscarded-qualifiers]
>   191 |         char *pipe =3D strchr(data, '|');
>       |                      ^~~~~~
> ---
>  src/diff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/diff.c b/src/diff.c
> index 6c670e4b4fb4..182ea349eb9c 100644
> --- a/src/diff.c
> +++ b/src/diff.c
> @@ -188,7 +188,7 @@ diff_common_add_diff_stat(struct view *view, const ch=
ar *text, size_t offset)
>  	const char *start =3D text + offset;
>  	const char *data =3D start + strspn(start, " ");
>  	size_t len =3D strlen(data);
> -	char *pipe =3D strchr(data, '|');
> +	const char *pipe =3D strchr(data, '|');
>=20=20
>  	/* Ensure that '|' is present and the file name part contains
>  	 * non-space characters. */

Minor nit about the commit message, but this is due to a glibc-2.43
change. It isn't related to GCC versions.

Collin
