Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776B52A1A4
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 10:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738579566; cv=none; b=fmIQuzVFio48BQtBRxXcRRLNk17ZDOCJX+05gYzYkYsJxWMeJpeWoGP4w2r8juwLyFBIhxRnNJcZcWDgXJOL1HJY2NuYIoPIhVzQZPFon7UEX8YwmtFHROpjj9U8NUF238ZfQN9JZeUNMG1k4evZqdu4Mt91gw+gmyZ0SFgPWAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738579566; c=relaxed/simple;
	bh=WXRxfhozb1PkMBbCADD8jvTmiD3bOgz4wnFIli8O37o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p84IfPH3J7HTjb5iHvnoCmldrxqakBOwf3l/1fc659os7oLtbgpiw2upK0UGWjIBBDB8qL27NpWvynKOW3hpQic/r/Km2X3ZsEChdxH1VObgJsBjCePyQAJKpJyAJWL+Wf8tZl+5HvSyH6jNaGr/kZ4SVccqvOpD8Aq4h/s8EQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UoD11AOe; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoD11AOe"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d3f65844deso7822784a12.0
        for <git@vger.kernel.org>; Mon, 03 Feb 2025 02:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738579563; x=1739184363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXRxfhozb1PkMBbCADD8jvTmiD3bOgz4wnFIli8O37o=;
        b=UoD11AOe8LvebQmTrZP68uLNgSeOKN2Zm0fgycac3ZQntmtd6V4s+M8VvSHWb9J/K1
         AiMzFIQ86DLptcBy1Qhkrf+zBnoiC5H1qsypYQ7C2+1yJDEAgf4vB0PQRIeiK2D7VAqb
         YFq5hxvDk8N6T0exuNY+ORDQtMfosq44kPLxb7D0hqJ8e+I9pGfKw2R3/7rgdNr8hlln
         wfn5G4luIPmrOYsLmcSq61M+kjc4IOBRBJkQAF9nhBiRtmR7ri1/0LvxrDt+JAcmOfnF
         +5lwBJPkRUfkGvXjjDvDvOTAz+VxH+fiCZul/62EVuVhK13VGY2YkvWDfHEtIbty7ZQd
         REWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738579563; x=1739184363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXRxfhozb1PkMBbCADD8jvTmiD3bOgz4wnFIli8O37o=;
        b=oYBpGjuwdnD0Bp6SgCv5kymJBR6waTvvI2+T9SWfx6G+jEyuALfAURmNnI5uh+REmJ
         joZ63sN1MCnJy9tdOBZ5p/zssEKFDOphadldZkEvzOh6/K7328e0P3cpuubavMaBnHRa
         3KckwJrG50cwKejY1NhSr9Edj8cJS+Fxfwflk8hlch+7kBT/zBSLwWDHO+ZJyN3rb44T
         L9/O4ukSHDzXt3j8VYK/longl+Sd8T5r5kW+WAYhjOJiPIePC5yDq0Bo8cPeeKT9vOMi
         JfbCMBPqxoSmBFd7T4nuBkYbg8KKzQE9TyZB1I8z4bQlCqhC9otYL1T5uknEHNbogGuP
         MlbA==
X-Gm-Message-State: AOJu0YyjVKH2KZxzbg4dQOK+LkbrNP/0Tttfg0urjmAJEvxRfqwAWKNM
	pMVeCSku4Vwu8qbrOwDf3c/QXYijRvL0naZKGd7+qrZjONWbZitRg7p5hcDjFGBOhVtcj/9naKA
	e4cVEmMgzEb3jLcJSHpWcm4xu0CE=
X-Gm-Gg: ASbGnctLC2i4UMy1JLNHWLHkUFzBuMcmMiMPJXHII1OEXom0+T7JmMZDMpv+PGBYH8W
	Lzjtndd8MRBh5bqyRFFbPZn3qVbgxsmYQ30MziJzJ4SA32ZbZld2WjdAB6Zaiq9MCfqVWR6heqX
	8=
X-Google-Smtp-Source: AGHT+IE25WdC9aWpm/75mgovYSfmUc8BxPy+g9pmLaL6zlNxo+oY/nuGGaPUkuvcbs6gjbcox6PbJuPtMeote+rpILI=
X-Received: by 2002:a05:6402:520e:b0:5d3:e45d:ba91 with SMTP id
 4fb4d7f45d1cf-5dc5f008488mr22809689a12.32.1738579562412; Mon, 03 Feb 2025
 02:46:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110053417.2602109-2-jltobler@gmail.com> <20250201201658.11562-1-jltobler@gmail.com>
In-Reply-To: <20250201201658.11562-1-jltobler@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 3 Feb 2025 11:45:49 +0100
X-Gm-Features: AWEUYZlokrrKQCvJNT8DVAb9HbIJJSKbjfsIFdocCR7f_dWF422x9B4p5fli3Ro
Message-ID: <CAP8UFD0vbv7tRP1cac-q-Qqk7wxo57oP3VLqj7Gn_kHi41y=hQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] rev-list: print additional missing object information
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 1, 2025 at 9:20=E2=80=AFPM Justin Tobler <jltobler@gmail.com> w=
rote:
>
> Greetings,
>
> It is possible to configure git-rev-list(1) to print the OID of missing
> objects by setting the `--missing=3Dprint` option. While it is useful
> knowing about these objects, it would be nice to have even more context
> about the objects that are missing. Luckily, from an object containing
> the missing object, it is possible to infer additional information the
> missing object. For example, if the tree containing a missing blob still
> exists, the tree entry for the missing object should contain path and
> type information.
>
> This series aims to provide git-rev-list(1) with a new `print-info`
> missing action for the `--missing` option that, when set, behaves like
> the existing `print` action but also prints other potentially
> interesting information about the missing object.

I took a look and commented a bit on patches 1/4 and 2/4. Not sure my
comments are worth a reroll on their own. The other patches look good
to me.

Anyway I think you might want to address Phillip Wood's concerns too:

https://lore.kernel.org/git/76390e3b-e749-4d28-98a5-05db7c5fbcd3@gmail.com/

Thanks.
