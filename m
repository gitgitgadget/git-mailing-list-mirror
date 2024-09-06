Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0054B154C19
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 08:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725611779; cv=none; b=gBzAQtISXQ5XFKYb1OKskZJg+HENb5O4XI6Z+dtdm07Q5aJsRhl/2/bVnNDyzkk9iNH6pOlsuslPuj1A0ZrKQuj5Z4wDkXnm/T9Mmz3jQcBNtFlW0ls599nECowgsD+A2DZi12trpnbSVO3VlWMEmjKZxcO8x7EoqhvgbBz3bmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725611779; c=relaxed/simple;
	bh=oHSoKFFyJ4WjmyMn8V9TggZe4PGmf+k1BNpmo9PAowo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msDlrQHYl7Z6PrjeTFpvFOBs09E7CBR2mN1HmJOB57d+H4q6+bwnwsEPvtvCAWxnTn9s3KtwVVqajKU+jkizreUvLrpXI0EwAbuXoutZs8ulYMrv0pKM+cUWMWQPrf1b4khtXT2T/+As4vNX3bFTgrcg1amqk6GHqURuoCOEZ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sdhq3riQ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sdhq3riQ"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2d86f713557so1233871a91.2
        for <git@vger.kernel.org>; Fri, 06 Sep 2024 01:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725611777; x=1726216577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8SFn/iTKj+WPZQ+T8LprsIApWmxaP8PmzhyoE9JDAns=;
        b=Sdhq3riQzBohCmYz3Y/753cwbGiUkcmx+fx9ZjY6UGctfZOh8tfyIUUqcvhDNRlEao
         1hsGHrSUN028xIB6dvWLNTl8t9MeeiMLGE/K5BSv2TvM57JwH6An1MDHJH5noajnSfJo
         F6vt3V3NoAC613b94BFugkYezLG+ZCxj/P1T3tawDxK65JVMaOnvfop8u4ho7k/hs1PN
         2dmaPTCjv6HgXU6hkch4t9FEGbh9A6sAAFxAqALKFfqMGGA8MKMQ7zKBaUdnQisvR3P3
         YF3kDWuhBDgu7ZuWHm3Wsyay6Db1n6EWS/Mmi9SYaFbdWlrct9K50ncnjgRMPQ2lY41h
         LA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725611777; x=1726216577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8SFn/iTKj+WPZQ+T8LprsIApWmxaP8PmzhyoE9JDAns=;
        b=XCAIhFrV7y+rgwF0S9rgvh5/aC5GAEQwlawNKLkyWa8N9An+/IWtE9VYQVM3yZILzt
         vv8SgfcDcpmXoGnrKKPb4jehFrKuwxp54c2HgamWXjMt/lY9N5HVd2c4VyO9h+7gYiHV
         Jv8GbqT5CYmh6+DZn2tqea+VEhySHK2CTzBB0YKU42asHxI+6Kzs4SmIWdRECdF0K2dS
         ZW+AO5sExjYyLh+5bcCaDgaRnmPe3I5YQ1ixF5YTcmR7JupJ/rDNXz6OerAf+JUAbrho
         MZ03ISSVde6sr9NFw4AuAIm/oL3xAmI8kdp96hNbG1EIDJWxJqsKo/s1ojBAq958Pu5I
         6fHQ==
X-Gm-Message-State: AOJu0YxoqSYxV9EcZs5TelywO7CUeUvsNXh53K8S+LoqnQJnGA6MseR6
	PQ+Zckan3gjJZvYP/+ffnpQ/4u1rlK/Et453HXPR3zc9+sMRGX8DVXVne9coIU9FF7v4s/D65ZP
	FMw10O6lgJRFDyHhTgU3h1VefS6bq2GHtLLQ=
X-Google-Smtp-Source: AGHT+IFtQWtPaZ2lI7nC2aREokFxUP/EgkA3m9/hId5D0nWOhqZxM7h4Myo2PO0T/5c5fh+qrOytNvW+V/57hQjIxpU=
X-Received: by 2002:a17:90a:c702:b0:2cb:50fa:b01e with SMTP id
 98e67ed59e1d1-2dad512cb05mr1961045a91.41.1725611777006; Fri, 06 Sep 2024
 01:36:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADLV-7K-D8ydFfeojv7EuhxBqKWsVYLofXJji+Y5rUTA8JEQ7w@mail.gmail.com>
 <cbc0019a-682a-4cec-8a06-24b12060a692@kdbg.org> <CADLV-7K7uumH+ikT6B2H39XR-eX21xBzUSNbeyVv2wM2q1e=QQ@mail.gmail.com>
 <39f85eac-c6af-444a-a514-ad7172748350@kdbg.org>
In-Reply-To: <39f85eac-c6af-444a-a514-ad7172748350@kdbg.org>
From: KwonHyun Kim <kwonhyun.kim@gmail.com>
Date: Fri, 6 Sep 2024 17:36:05 +0900
Message-ID: <CADLV-7+YxrXX4iOA6dHMtv3gGxyy9FBbzCDQ2SkjejkyGe2iKQ@mail.gmail.com>
Subject: Re: How do git recognize conflicts?
To: Johannes Sixt <j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

  Sure, I am replying to all,

  Anyhow, modify-delete conflict seems to be a legitimate conflict to me...

  How come it is an exception to line-by-line conflicts(conflict only
when the same line is modified by both)?

  In one version some lines are modified and in the other version all
are deleted

  -- KwH Kim


2024=EB=85=84 9=EC=9B=94 6=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 4:03, Jo=
hannes Sixt <j6t@kdbg.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Please use "Reply to all" on this mailing list and please do not top-post=
.
>
> Am 06.09.24 um 07:09 schrieb KwonHyun Kim:
> >   Thank you for the answer,
> >
> >   Is there any other exceptions from line-by-line change?
> >
> >   Can I ask you of any reference?
>
> Another "exception" would be a modify-delete conflict, i.e., where one
> side modifies the file and the other deletes it.
>
> Apart from that, you would have to dig into the source code.
>
> -- Hannes
>
> >
> > -- KwH Kim
> >
> > 2024=EB=85=84 9=EC=9B=94 6=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 1:39=
, Johannes Sixt <j6t@kdbg.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> >>
> >> Am 05.09.24 um 16:10 schrieb KwonHyun Kim:
> >>>  Hi, there.
> >>>
> >>>  At first, I thought it's determined by line.
> >>>
> >>>  But as I experimented, it does not look so.
> >>>
> >>>  Here's what I experimented
> >>>
> >>>  merge-base =3D=3D=3D=3D
> >>>
> >>>  hi all
> >>>
> >>>  branch BrA =3D=3D=3D
> >>>
> >>>  hi everyone
> >>>
> >>>  branch BrB =3D=3D=3D
> >>>
> >>>  hi all
> >>>  good to see you
> >>>
> >>>  when I merge BrB from BrA, I get conflicts.
> >>>
> >>>  but the first line is only changed in BrA,
> >>>  and BrB added a line so there is no reason to have a conflict...
> >>>  that's what i think
> >>
> >> If the changes in the two branches are in adjacent lines, then that is
> >> considered a conflict as well.
> >>
> >> -- Hannes
> >>
>
