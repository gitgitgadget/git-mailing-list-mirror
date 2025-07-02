Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031CE2E498F
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751480912; cv=none; b=uU08eJ35gj0tqOA4NW4s382Xmf1GXcEyuyED5SaEcCoWSgoEgq6WvuN1pYXr/uVZtQVK3g/C8hYrykzPZbsdocQwysEazkTJSr8wQgkLJv9iYEuUhb2DuyUNfqmZZ26sTfZeMPdlEt8U3oJf0KCcWuTHP+i74lbymJe4/dd9ixk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751480912; c=relaxed/simple;
	bh=OYw2kyea88BRsRs8JnEjjYTrQhohaNGDMK8aRCMsR38=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XfOQv0mV248FGrKqIN9y4gIiTHC9BUa76rzZ3Evk/B4ZLw9U4JoJOfVE3fo1embiiRrU6ja298RYFfO6Udz8Xt6p4ZlDjhwXD9QFT/Xm5THFGX7p8+SovtC0yMKIYvNgN+4CSrGFbqJ+sW2XbVvuoHiwXHibogcveiJj34Rmuig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnFcir6Q; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnFcir6Q"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-74ad4533ac5so205406b3a.0
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 11:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751480910; x=1752085710; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EKk5CElDSW3EbK18u3dpLeJuBtQek/gcZINsuzFHsSQ=;
        b=cnFcir6QnmSqXn7tg96ptlFXrnlDT+IFTk7tBCreCrJ3jI9soRigrYa5R2VGr4HQW/
         GPm1KTmg1BaO7LeWElW6WrogMlL5nVymYmvEPJv6DfSFfPO1AGkjsoyp4FUcGKMnMUle
         ywX+Z6ysI8ecbEiAyUHtiOGE41Kqle+nG/AjnA1A4LiVdrdssq/6aIwuA80f8i9S0Asi
         PSALII7QLC8sJaR2jTQCfVL3XbJqHOaargj54zdt6tqyFq4PanLvSzbtBTrnVOcsDC6z
         jXxqaCvM1nyuQLR9znw6pBfK8Wj8oKPb2gDViCnExW1mQi218GeEQWTnD46R5DRRLTEu
         qZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751480910; x=1752085710;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EKk5CElDSW3EbK18u3dpLeJuBtQek/gcZINsuzFHsSQ=;
        b=MsLzFADz9ec/BkIeL60MEUt9dR7OZSabj/ifqwkILl+vaTyriHlAistKkk6b8gvYIs
         TZVOlwR/VjKrWnDjy7WVj8yCExCOwvsei+eOKMQxVILqJlzy1coEIpsGmWxteDzk+S5J
         v/OryOL05hPbpOKAdaWpiNwkWJSKDsyBz3pbM5P/CSom8Io5UlRbbWi9TL3a3d0LKqyU
         fO4gc5HyAwg02x0CpCnRlH71D6Mn7ZwMCWu7qiOAKPA8TTGkw3Or9Ckf4Dq04R6zSZcP
         BLi1gQRaEcgoHeU1RFeP87fm9orgkhECekYV1ABGRxUHqfTa8sXMUqeiWpYZj6QyKufD
         rdwg==
X-Forwarded-Encrypted: i=1; AJvYcCVRlo6BC144ddjq7Rz5uVxJ7g3k2RaXPOVcRhRarBx1PlXT83dYcSlL8r1BAqeoc/De6eo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm7EYZmIbBHZ13q0CCkPG5wgzG66/jGDBsCi22IgQbKj3lZR/A
	6le6CypC21e05da4TMMMNwdDnbsnFDmAPoNJtUBK4US52db3me7ehh3N
X-Gm-Gg: ASbGncvcaUjXpkCxiODEremYJhqMtvLaNBqKDmSxtD58plFwaamrrtOUGHDMUzrgztI
	QgzP6BtZH3duPDe0OWrOMdfDudZ33+nSr08zyHA9MV5Ibi3xepS3mmtCxqUZVn4UkgKlArmqeit
	iHGfeOZut4ddxl25IJ879bynR8IWNcY7esyLaM+m4VD6psb9KVlbusSElvkikwTFhnX5nhO8oXu
	ou2IcKtDJ4Gvpz7Ao6LVfrm4e3pOjffMBDR77nnA2O0VfycwWNrZi+h9pes9AT2prpFLN6oirvA
	h3Z5lAGEAX/r42nx4j/X34+LUdAlBLLuxmn3+93Ef+Psfz09aU29OfFYWqF5S3p/Hhv7xETQNxy
	D1CZokmdRuMCZfRgHgqNcDfK8ysw=
X-Google-Smtp-Source: AGHT+IFM9/UdGrA2/uXY0cf40lUIfd/yecFNLMEVLd8CTc14DxJANJEc58gNh6FUYzPsKTjJjkf6JA==
X-Received: by 2002:a05:6a21:998b:b0:222:d9e:c5f6 with SMTP id adf61e73a8af0-22411a28a87mr814424637.2.1751480910165;
        Wed, 02 Jul 2025 11:28:30 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b34e300763csm13625721a12.4.2025.07.02.11.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 11:28:29 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Leon Michalak via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Christian Couder <christian.couder@gmail.com>,
  Leon Michalak <leonmichalak6@gmail.com>
Subject: Re: [PATCH v3 4/4] add-patch: add diff.context command line overrides
In-Reply-To: <2ee8df78-1c8b-42e6-bf93-a5aa42c20af3@gmail.com> (Phillip Wood's
	message of "Wed, 2 Jul 2025 15:07:15 +0100")
References: <pull.1915.v2.git.1746884789.gitgitgadget@gmail.com>
	<pull.1915.v3.git.1751128486.gitgitgadget@gmail.com>
	<b68c58b667c29c66433b4634ad44ee9ec5257e80.1751128487.git.gitgitgadget@gmail.com>
	<xmqqplel17s3.fsf@gitster.g>
	<7686a5e0-23c3-4e3a-b5ea-3b8c80ba54fa@gmail.com>
	<xmqqa55nlxdw.fsf@gitster.g>
	<2ee8df78-1c8b-42e6-bf93-a5aa42c20af3@gmail.com>
Date: Wed, 02 Jul 2025 11:28:29 -0700
Message-ID: <xmqqtt3ucur6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 01/07/2025 16:54, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>> 
>>>>    * add OPT_DIFF_*() macros to parse-options API, as its utility is
>>>>      very narrow, and forces those who are learning parse-options API
>>>>      to learn one more thing.
>>>
>>> It means that we have consistent help for all the commands with these
>>> options which I think is valuable. We have a number of other macros
>>> that define options that are shared between commands and I think that
>>> works quite well.
>> I understand that principe.  What I was wondering was if there are
>> enough places to use these particular ones to make it worthwhile to
>> enlarge the set of OPT_* macros.
>
> There are six users of each of these macros so I think it is
> worthwhile. That's two more users than there are for
> OPT_RERERE_AUTOUPDATE() and twice as many users as OPT_CONTAINS().

OK.  Thanks.
