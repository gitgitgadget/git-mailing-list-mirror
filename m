Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7684D1EDA0F
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 19:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740425202; cv=none; b=QDMb8xnqzO7bLghNt9fTEhCxKux1Tl7+SgkyuvqNlUpJtoYozanydwN65Jy+08B2rywi2cfH4i35JOSPPteVGgKu/PmAhZqFKJfEVgbaUs8BUISVEXJR2MzQE5LyR//6QzPNM2SV8JnCg6TxSJpHGr9scVQGOY+ov+We31jO9Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740425202; c=relaxed/simple;
	bh=MZvnNxMdVqONt/O3sbS9juAkhbMmSDdWIxgP+1jqtZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M1KaIGcqgZ3TnPGaFjMgQ9EAbpjAZhNfeZnvOMvfzT2SphK4AW8qdk48pGM0qg5YqaP+VioZoTpkLI4o+mSj/1g4gujdBMOO7yZGfyHLtHvU2muRUh9t87FCOv7JJeWqqxp5UyUPTgU2VgggQ8opLRLZfHqVZwlNXTHQJ7c+ZKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRQtZ9Uo; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRQtZ9Uo"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3d2f5a932f5so1506735ab.1
        for <git@vger.kernel.org>; Mon, 24 Feb 2025 11:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740425199; x=1741029999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TH79Dagfd1FXNtKt4jmKoAwdy+4eSPpeys6GtJFhDU=;
        b=nRQtZ9UoBHOkaSwGazRRieeMIphyRXaSf/YwfXZRA3kvaiJYQLd3BVOhKX4DfOeGYh
         IQLlB5OXy/BgXni2vZSTpBF9N5J/ZzRCgjitvDos/vUhsYDxjuLYQaPlh1SQCm8dq6vL
         DZOJ1JRkeJXxaYkzkWhJYnqltlGM9ViX17rH3lAv8HNaL9dgysE9J6nzoRMcVmq1/ctI
         Tg/ZN0xwHCEwKe5vDIPIAG+OHBV3hYUxGHfRTpuhQ6n1ImwD/16H5JPciaBvWaa+HcI2
         Ml/WRI8M1eZ+QYTwFqUAwUlstu7aPof+BZ5yU7BcZ8oRw3vq4i4CIcbJ5fIIsBJeRXzs
         UyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740425199; x=1741029999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6TH79Dagfd1FXNtKt4jmKoAwdy+4eSPpeys6GtJFhDU=;
        b=kA6ThScHttTEZAtdyOnhcQ9iv0mnHJjEzTOkre42IvE8wLZor5g1fjiJmwTJMZenXF
         CSbNykuEEAZcU4EXd6R1d/HaTrt7ZXCK/VTgluV7Oezly9E5h5r/A44tp4dosTQEvdzu
         jp0eLky7L6OhJcvXiAODN3c7IFLi9XFxzVczgW9C0a04YAr15I7UGn0lDMoPCe4Qh1xX
         fuO35BRHTnjDg81L1wis6EpWuP95kkZifK8lQcxdPs+3SwcOP09FOibRAjqDwmByGn7w
         dwS6FFRIWfNv4hy771AOFaKBiBBuHK9t17hp9IKjW6Z9ag+f/ROcmSHjQEnJEwDM8VVY
         pikA==
X-Gm-Message-State: AOJu0YzqUX1NIG5Ef/VS+pk9w09rQPGaNgKE/nQkkGymnZXPIJtP/SRW
	TfknvB/OIVkaz7Qx0R9pyJw4uoYkuWyapQEa6ahotvHYzApxo1EXzmlN0xUk9zci85tybpAsdVA
	UE8RipbgJ6gKXYSsBk0G/YveDtkk=
X-Gm-Gg: ASbGncsFbu9NZqtatINnZQ1BZ/J+hAklBx+EqOMWQRSLe/WdNheGM+QxPiXiikTRs0B
	OcpRExMLO7Hgt+1gk1wA0NJWGKMmRSJyKZOqFun8AfrzN/97cXApbsmOTzuzQ+L7dvjZoHhfowQ
	gHf4q+hozXxMgQI8FhOUDCma9qqXOZttogEHpzCdQ=
X-Google-Smtp-Source: AGHT+IFh54oFB6Ga27QTnBBzLodxZaPABlXFrDgPL3cVUAZyCkamSC4YmFwDCiCXZwv2DHFqgi2NE87M0j8+YCPTkPI=
X-Received: by 2002:a05:6e02:17c8:b0:3cf:ae67:4115 with SMTP id
 e9e14a558f8ab-3d2cae6c5e6mr146461175ab.8.1740425199279; Mon, 24 Feb 2025
 11:26:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20210430232537.1131641-1-lukeshu@lukeshu.com> <20250224142744.279643-1-christian.couder@gmail.com>
 <20250224142744.279643-5-christian.couder@gmail.com>
In-Reply-To: <20250224142744.279643-5-christian.couder@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 24 Feb 2025 11:26:28 -0800
X-Gm-Features: AWEUYZkhlkM0kwDxl1cILImFatGoYQrYm6bSgRwaVXUNgI2OdWcI9YxyEqTlEFk
Message-ID: <CABPp-BFG=g_tCz5HjjsLXNc41aYiGvLi_8oq3d5o9cBLKmd1og@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] git-fast-export.txt: clarify why 'verbatim' may
 not be a good idea
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Luke Shumaker <lukeshu@lukeshu.com>, Jeff King <peff@peff.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Taylor Blau <me@ttaylorr.com>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>, Eric Sunshine <sunshine@sunshineco.com>, 
	Luke Shumaker <lukeshu@datawire.io>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 6:28=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> From: Luke Shumaker <lukeshu@datawire.io>
>
> Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/git-fast-export.adoc | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-fast-export.adoc b/Documentation/git-fast-=
export.adoc
> index ab9a315fa9..1b19f17b78 100644
> --- a/Documentation/git-fast-export.adoc
> +++ b/Documentation/git-fast-export.adoc
> @@ -29,15 +29,19 @@ OPTIONS
>
>  --signed-tags=3D(verbatim|warn-verbatim|warn-strip|strip|abort)::
>         Specify how to handle signed tags.  Since any transformation
> -       after the export can change the tag names (which can also happen
> -       when excluding revisions) the signatures will not match.
> +       after the export (or during the export, such as excluding
> +       revisions) can change the hashes being signed, the signatures
> +       may become invalid.
>  +
>  When asking to 'abort' (which is the default), this program will die
>  when encountering a signed tag.  With 'strip', the tags will silently
>  be made unsigned, with 'warn-strip' they will be made unsigned but a
>  warning will be displayed, with 'verbatim', they will be silently
>  exported and with 'warn-verbatim' (or 'warn', a deprecated synonym),
> -they will be exported, but you will see a warning.
> +they will be exported, but you will see a warning.  'verbatim' and
> +'warn-verbatim' should only be used if you know that no
> +transformation affecting tags will be performed, or if you do not

perhaps it'd be worth clarifying this slightly to

"...transformation affecting tags or any commit in their history will
be performed..."

Although, I'm not sure if that's strong enough either.  Even if users
don't transform the fast-export output, the fast-export output will
have already possibly undergone transformations and fast-import might
send it through more.  For example, if someone had a permission
recorded as 644 or 100640 it'd be canonicalized to 100644.  If they
had a duplicate tree entry or an improperly sorted tree in their
history, that would be corrected by fast-export + fast-import.  If
they had extended headers other than a commit signature, those would
be dropped.  So, maybe it needs to be something more like

"..transformation affecting tags or any commit in their history will
be performed by you or by fast-export or fast-import, or if you do
not....


> +care that the resulting tag will have an invalid signature.
>
>  --tag-of-filtered-object=3D(abort|drop|rewrite)::
>         Specify how to handle tags whose tagged object is filtered out.
> --
> 2.48.1.401.g48e0d4203c
