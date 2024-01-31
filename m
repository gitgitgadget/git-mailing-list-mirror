Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A65B12DDB1
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 17:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706723736; cv=none; b=aRrt4TDP75GlObWHGm6ODo+ryiY8BsqkHYQP5THV73ID2iovdrDy2D+SMek0/JRcQoMJf0T+DQguMn06jVe1jg/y8LO8jR8pkoSq6ava5Lw0g6Dy9P/y8WQEf5PbK2cpMdDkVNLzqiF3aaFFnxGvL+1DdcRRiMktPCLvSoF7XSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706723736; c=relaxed/simple;
	bh=LtitJ2oV3tjKbXOvJ+HOz5/EWWbSStoSbOXosrV/34w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=umB+OxU/SNZkjBIou8Oun8BXAhL25r9k5yPy/Nk54wmqrecy6qJsleyGViVgm3Haw7zeZ7M0hq6fbq9w44RDPPOzcNN//8fCL67XT//P+4MA/KQL6URsBWhucd/JLcAnjexBJT40P35/CTPVORjSpMnfl72q2aeEp48fv/zfQZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc226bad48cso4867171276.3
        for <git@vger.kernel.org>; Wed, 31 Jan 2024 09:55:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706723733; x=1707328533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rI0IRj8QxK9eTU2NzZ88WohkTl0OYNV1tT15oSYhqgA=;
        b=bXawtPn5y8RkHAGzAKJn9WxKNJM4RJuWho6MIgoSN38X5VroTzYkTizEX/3svi9Iwm
         Ncz9uSnRQgPHSSzxqTTvuUVyTDkyn89ChGnqmJxZQ6uAtwz5ZnQS9gFonZ8MmYbnulZD
         tPYk63VTo9r7SpMzXwy8Sy/aQkWQzQZugvSsJFHzOlT0SJ6Vf0y8RkL6SfWq/TOrhNzx
         pzLo6sMbOa9gY9jjC4lNGjOI2KqOLIM+x6HmNTv/6prjTEUOXxlv5guFpkSXEd9bnOUt
         QAMF1FX1hLn2wKi3GEsG5CfxpQ3NN82ctGzLQIJuE/KH3pjcL23+AaLXrdeuyWg/7+Nf
         Ws6g==
X-Gm-Message-State: AOJu0YxXnkxkjbpzTZItdQuOSNN3ohO7Ab+2PnxHA5d7DltuBY4W2LTe
	Q5DACwDJeM7OWdTrtF3bpIBfytG3Wkh5NmWs1G9oetKGMZkjTRyDQG7o2bd/Gdr+yNKZSYaeyoV
	oalFITdAQVpHoLE0ic5cZJuhE6ZaqmWTT
X-Google-Smtp-Source: AGHT+IFSL07DiN+kavI6KJtPjnSSKb2bQal97xFeRmrkQ+eX4Q1u3dU0sv94bn4+msP8of0qiZohb8ZwMzbrcb99gPs=
X-Received: by 2002:a25:ada1:0:b0:dc2:2846:59dc with SMTP id
 z33-20020a25ada1000000b00dc2284659dcmr2359307ybi.36.1706723733306; Wed, 31
 Jan 2024 09:55:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1706687982.git.ps@pks.im> <00aeaeee63dc1371d3338b72f779c6f165bd14f7.1706687982.git.ps@pks.im>
In-Reply-To: <00aeaeee63dc1371d3338b72f779c6f165bd14f7.1706687982.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 31 Jan 2024 12:55:22 -0500
Message-ID: <CAPig+cTZcxiZUPgjqEzMNG72X4fwnNT_DwjTj5cQh5zEpiN2Hw@mail.gmail.com>
Subject: Re: [PATCH 7/9] reftable/merged: refactor seeking of records
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 3:02=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> The code to seek reftable records in the merged table code is quite hard
> to read and does not conform to our coding style in multiple ways:
>
>   - We have multiple exit paths where we release resources even though
>     that is not really necessary

s/$/./

>   - We use a scoped error variable `e` which is hard to reason about.
>     This variable is not required at all.
>
>   - We allocate memory in the variable declarations, which is easy to
>     miss.
>
> Refactor the function so that it becomes more maintainable in the
> future.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
