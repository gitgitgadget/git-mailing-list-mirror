Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A2119F424
	for <git@vger.kernel.org>; Mon, 16 Jun 2025 11:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750074180; cv=none; b=hMnREBHuElYixa2g7l4zqU1JfTK/1LHeU1/QCkJ+zoAQoH1eMh2fbMbbd92lXf0HPNRArhoofchitLM6xKDz+f8hICwVpaGxTX/6ssg41DTn3Lnbp5QY4jr2H6gaFcFvuo8hB1xHW5uSs0xHOU4scMSTGzFftyhdXvRJ9/qCpV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750074180; c=relaxed/simple;
	bh=2avkfPSKcfVn53hD7EAVMNbQE9Yfh3eSAIZA9BPOzho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=FMEwmh+Iydo83No/2z0FFKGErvHkA5ZTVQqxBlaGv88yXPc3dTOoc/hpW51gd/9XetXFD0Oev2QGLKOK1TH4JpxNFtds5oBst4wlU33Sjd98KkzQQeP8CE0v4GhwqSxMpcu6znHIQ3ZdXCOrzMZVpiXkxA1aF450buJUOz2TLGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1NvpSJs; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1NvpSJs"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-711756ae8c9so17746047b3.3
        for <git@vger.kernel.org>; Mon, 16 Jun 2025 04:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750074177; x=1750678977; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUshDofu7mta+ko6J3ruWxpQB3OoiZm8b3V6OkmFrbM=;
        b=k1NvpSJsIu+zsjJ7qzEWWrxqeasEKB3SRXYq8Iio9/EGBvGUTXGR/YokTa97/HS+wp
         WrVtypf4AMbTeotexnSWg9RmxGJklhjrTOdkksLjdrkguTBBeah8ASYUj0IPYXTVO4Ii
         WMKQlb1vGsPMQLnZRAnX12H7pgoGLHJUX2+j/WVMcSqRp1u3oec7LtsO3nqCepbZTw5m
         7LNzzKdYT46qe7Hl+YrcC75RzueQwQh7YXLkhccCogZb4RyGIWHGliILIlyk45A2K+rJ
         nLomsfM4+oJISgShhV/mtbzxRSLUsKJOPe5geUimaaNXcnjAkbdVoWnWmBbW75jckCDf
         sRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750074177; x=1750678977;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FUshDofu7mta+ko6J3ruWxpQB3OoiZm8b3V6OkmFrbM=;
        b=GKVvfb26xc0lYqw4/HIrQlkVhyAGO82H2VUVtTThOtVzpkw0jo6Lph5LX/nIrTlBA5
         VcnxUIZ2gMpbvefrVoJpbrUIKaK+xS8BGR1wPcWansjGUyZh0R7wJuUlzWVP8/jePzCb
         Pw8tlhSEyP1lhuWVu5n+IBCPnI/CoY0TxGxuHmV7PZdaoI1EuohOuQ4Tm2rAijTfOLrc
         nhHabpWbPz8p2+QHwnB4qxj+C+GFeZ/auplsorKO39d3iDktS0gTAWnKkzFG7TfGCqmt
         q/JshsiE5Q4Jt6cuRtQbFpNzTEgG/cJ9oBmS2yEX8pplvLAntucB0AXUIBdEqxNiaDeA
         vwCw==
X-Forwarded-Encrypted: i=1; AJvYcCUjJkKeujfwFzz1qbMyeKHVwp6aYhTCDi+6ZMYkghsgPs3/SoLn936cQvchNXmJlTqA2bE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9qhkRDilHQuVI6yQtf47EajIqkSW1yn3xejfMrjVXH3N41KUI
	mYqbNL2mBwFR+AjW6tLzGNww+BhJial/r2T/qitBITviMSaQy7NLivcXRgK51xWdW9p7dyCOGLx
	zz0YXikkggOIZ3wfuWrv8qsYTHwrNztWDfrQSXsA=
X-Gm-Gg: ASbGncvke3ObOwFSBUJMc4UORAx5vZ5Kjqf5TNwmOXihTlJosDaAvhrEVL89VuIHVXL
	7BxutsJUyS4UJe4sb3T7knwZU36h29RnKK7FGw2mHPyVxr6PoRTLWffs26PbVetqJRKKLyCZRvr
	73DTkBUZnLa9Jk2e/7FRpGVicT5uvK5g5wBI7mFWGOmAI=
X-Google-Smtp-Source: AGHT+IG/MIV5cUJZWw5rphNtXWsQsCMYJXkLP67tXF0NFG5EJ+QO/p3HoemJmjli/RM99X9NcLwZf6cr59XQ2CDlksQ=
X-Received: by 2002:a05:690c:7242:b0:6fb:b1dd:a00d with SMTP id
 00721157ae682-71175457744mr127507007b3.30.1750074177382; Mon, 16 Jun 2025
 04:42:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKn8H7qa_b==1LqPkJ-dmH0UNNp4Z4xbewN+LgcL6-bBPM1boQ@mail.gmail.com>
 <aE9ag8TY7i4Qi1Pr@fruit.crustytoothpaste.net>
In-Reply-To: <aE9ag8TY7i4Qi1Pr@fruit.crustytoothpaste.net>
From: Juri <juraj.sojak@gmail.com>
Date: Mon, 16 Jun 2025 13:42:46 +0200
X-Gm-Features: AX0GCFtxY1A1ngYEvwkBbAteIeQhdQqT9YrrDcMILACQEir3OvnGDwOCYP9Mhyg
Message-ID: <CAKn8H7rLmdNUrukS8P-c4UMKuk==rGQtHXFCm++Zn9o+T941=w@mail.gmail.com>
Subject: Re: Git gui webclient info
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Juri <juraj.sojak@gmail.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Yeah, I would like to know about a version of Git GUI that runs in the
browser and is able to modify a repository stored on the server where
the web version is hosted.
I found Gitlab and Gogs on the internet, but I'm not sure if it's what I ne=
ed.

Thank You
Juraj

po 16. 6. 2025 o 1:43 brian m. carlson <sandals@crustytoothpaste.net>
nap=C3=ADsal(a):
>
> On 2025-06-15 at 21:41:50, Juri wrote:
> > Hello,
>
> Hi,
>
> > Will you have a webclient version?
>
> I'm not sure exactly sure what you're asking.  Is it that you want a
> version of Git GUI that runs in the browser and allows you to access a
> repository?  If so, were you expecting that it would modify a repository
> on the server where the web version is hosted, or a repository stored
> only temporarily in the browser?
>
> If it's something else, please do explain a bit more about what you're
> looking for because there might in fact be a tool to do what you want.
> It's just hard to make a recommendation right now without more
> information.
> --
> brian m. carlson (they/them)
> Toronto, Ontario, CA
