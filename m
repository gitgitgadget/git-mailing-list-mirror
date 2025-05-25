Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41387263C
	for <git@vger.kernel.org>; Sun, 25 May 2025 19:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748200037; cv=none; b=nP2vP0qWLs7uPWineAzD3mVzlciGUrEQwsvAIZFQdoSSa8EmA+u6ZN5NGI3CPSXXRzw3NLbr088gphAAjC8eZX6siEBQmvHx9CeSgG5ME/PBYw/erM+UJD33EEO0O0PFSp4DY61CwODli8aqb0eH+dfi4nCsV17DBY03hEN6cLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748200037; c=relaxed/simple;
	bh=zusA7U5ki31Mcit08s7IZoCswPf4fQKYIihQX+PszRo=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=aQoeVf2opQF7xAst32Utf6755Zn+WuWrfV8YBxyT1F0KvJ3dNahXAycWh4c8wA3bTNERXjr8EmUl4+9d0JSF4/voiyjh36eqDiifbsT2ZCni+4+lMwG9PDTZ3/3pZNYWQza6keDY4qyHqwU9mC8F9iZGFgeR22DgBG+0U2LWD7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbaCzSi/; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbaCzSi/"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e7da171c504so459871276.0
        for <git@vger.kernel.org>; Sun, 25 May 2025 12:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748200035; x=1748804835; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MjNZsTd+i1YLfmG7+ZoMWpHAA9bZqNwqYui9nGbVOII=;
        b=dbaCzSi/UqpJOApXbAq8mPX/TN3ieS8D6rsAsKRHhBwQooVlgZWpEKqIjgQ0o9HkM/
         BBRuvY747MfwEVPFflsI0jwHNekHqYjmOVC+snQKMNlXKWNZACiRG10xDqwE8CHjosTD
         9TskqWTGG4R9KsGQo2YZu8AEtCQIWymnqff3rBUSy77NyePAdbHVe1Btzak6AsfU6mLX
         Zz962o/aUuH5m30pmhKw2zQmjik+vZZW7kX2atbrwDblUMcWn7lp3R6o3u6QlGIjCvKG
         4eMXIzFc0bz/RsIbBd2y7+kRD1kCmiae/hGYqOSENVuOsOSqyiSWdajRf7TdEqSv8T81
         kZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748200035; x=1748804835;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MjNZsTd+i1YLfmG7+ZoMWpHAA9bZqNwqYui9nGbVOII=;
        b=UuKnX/eXxvNFTLqojdzfuuYeniuX0NOKZSMV3+WvbrzllCuRQ/V3hovJok1IM++r5U
         00JiqiZiYOYOW+JhYXvfGE0o2+HPZIO4Mr2UzjCyj37p00ojLbMmoG8fKF+tg4Uew44s
         z+WdFl3JIfJa7Ju6lMmzHvelbNR+XcVvmTaDdhJT2fiv+esK4j9AJDAbph2pNbhDkafc
         4MHvjEB4exXs9A2E9b3a0YlS6Tv+1lgjgdp/MFo3uiAKxoXVBcboWpKfwa54O9dup8Ci
         0q6K58EBqB4WITRqcOBoJgh64peoS5zHEA2wKtkUgyI6fpQ5uCs47MgJWouPpe1JpOs8
         vebA==
X-Forwarded-Encrypted: i=1; AJvYcCUnUPSA8+U4n4uvIegoS0hq8iZFSJELhVxFtiRnHXMr8/Lqmc3nvPlbANW/sdwz8T7c0UA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF7ImK9/aEny6+uAwVF6uYiQS1PMMGaJKkvTBX71SRgHYfUIsb
	+aMdovxmI5Ww7svuH3xybBnHNo5+6EOM827Vv7+8VMVuHyV2odS6NkIC
X-Gm-Gg: ASbGncuuARof16x437JiyDVEJ2DIhP6UAFyy22KaeoDxcsBbfiyPWOMWjV6xrjLun4d
	VPxyKz92UVbj64fsUlxcvMASpuwqGmc2hBcOXo3Yq1G934TEL2soMiKzE3x6vuHRvHVWTBMsPF4
	6uQq6Vu7cT+//qwnQuOAZ3x1eYMxtfbkhCN6rm/5D636/XP3ewHDR7Z108StmrF1lAM7MEMHzqK
	UHdcZmoPASDKGY+QnGpNmHqmgD4qQKLuYmadmUPxNMOplio/rhFMpwar8OGpDBDp2iVTYx30QwL
	DNcJy6qCyoH889QdzuPLKVynAgIMgFKAypveWhRAcQWBkcm1deo8+K3zkos9vB505Zdwyqjr
X-Google-Smtp-Source: AGHT+IFhajyFErVUEKFA/tpmbqval5N3SYxTFrcDWgYbGfQlswobtilwN/nz27IdjPoPeUPQWz4jZQ==
X-Received: by 2002:a05:6902:4a87:b0:e7b:9236:c99b with SMTP id 3f1490d57ef6-e7d91a1cf64mr6979408276.47.1748200034775;
        Sun, 25 May 2025 12:07:14 -0700 (PDT)
Received: from smtpclient.apple ([106.194.99.5])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e7b6ac877b2sm6535980276.16.2025.05.25.12.07.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 May 2025 12:07:14 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Aditya Garg <adityagarg1208@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 1/2] send-email: fix bug resulting in increased message number if a message is edited
Date: Mon, 26 May 2025 00:37:01 +0530
Message-Id: <CDD9EC9A-3703-4826-B7D2-45237A2A4031@gmail.com>
References: <32479CC9-3C03-4F3F-A57B-88A3D43305CA@gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>, sandals@crustytoothpaste.net,
 julian@swagemakers.org, Zi Yao <ziyao@disroot.org>,
 Jeff King <peff@peff.net>, Jacob Keller <jacob.e.keller@intel.com>,
 Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 Aditya Garg <gargaditya08@live.com>
In-Reply-To: <32479CC9-3C03-4F3F-A57B-88A3D43305CA@gmail.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: iPad Mail (22F76)



> On 26 May 2025, at 12:35=E2=80=AFAM, Aditya Garg <adityagarg1208@gmail.com=
> wrote:
>=20
> =EF=BB=BF
>=20
>> On 26/05/25 12:19 am, Kristoffer Haugsbakk wrote:
>> Hi
>>=20
>>> send-email: fix bug resulting in increased message number if a message i=
s edited
>>=20
>> I don=E2=80=99t understand what the bug is from the title.  =E2=80=9CMess=
age number=E2=80=9D
>> sounds harmless.  It breaks the threading?  The summary/subject could
>> say that instead.  Fix threading bug.
>>=20
>>> On Sun, May 25, 2025, at 19:12, Aditya Garg wrote:
>>> In case a message is edited before it is sent, its message number gets
>>> increased by 1, and so does its order in the message id.
>>=20
>> It feels like this part about increasing by one and if-editing gets
>> repeated at least two times in this paragraph.
>>=20
>>> The cause of this bug was that when a person attempts to edit the
>>> message, the whole sub process_file gets terminated, and the user is
>>> asked to edit the message.
>>=20
>> Here=E2=80=99s the repetition.
>>=20
>> Also I am not familiar with the code.  Just testing it I get this `6` her=
e:
>>=20
>>   Message-ID: <20250525181003.40129-6-kristofferhaugsbakk@fastmail.com>
>>=20
>> Which was incremented every time I did an edit with:
>>=20
>>   send-email --suppress-cc=3Dall --to=3D<me> \
>>       --confirm=3Dalways one two
>>=20
>> But that turned out to be benign in my simple case since the next email
>> used the correct In-Reply-To.
>>=20
>> So at this point (reading the paragraph) I don=E2=80=99t know what the bu=
g is.
>>=20
>>> After necessary edits are done, the whole sub process_file is executed a=
gain.
>>> The way sub process_file is designed, every time is runs, it increases t=
he
>>> $message_num variable by 1. The reason for this was that the function ra=
n
>>> again everytime a next message was sent in a thread, and thus we need to=

>>> increase the message number for that message. In case a user edits the m=
essage,
>>> there is no check for the same and the new message gets treated as a sub=
sequent
>>> message of a thread, therefore increasing its message number by one.
>>=20
>> This feels like repetition again.  You say that a variable is
>> incremented because the message is edited.
>>=20
>>> This breaks the shallow thread logic which relies on $message_num
>>> being 1 for the first message, and it gets changed in case the user
>>> edits the first message.
>>=20
>> If I=E2=80=99m right in my assumption that this number is the `4` here:
>>=20
>>   Message-ID: <20250525182426.41076-4-kristofferhaugsbakk@fastmail.com>
>>=20
>> This was the first proposed email I got with =E2=80=9Cshallow thread=E2=80=
=9D (all in
>> reply to first):
>>=20
>>   git send-email --suppress-cc=3Dall --to=3D<me> \
>>       --thread --no-chain-reply-to --confirm=3Dalways one two three
>>=20
>> Then I edit all the messages.  They still all manage to refer to the
>> first message id in the thread.
>>=20
>> I still don=E2=80=99t understand what the bug is.
>=20
> Steps to reproduce:
>=20
> 1. Run `git send-email --to=3Dsomeone@example.com HEAD~3 --in-reply-to=3Ds=
ome_message_id`

You didn't specify --in-reply-to in your command
>=20
> 2. Edit the first patch (pressing e and enter) when send-email asks for co=
nfirmation.
> (You may have to set confirm =3D always)
>=20
> 3. Do the edits. The message id of the first patch should have 2 instead o=
f 1. If yes,
> send all the messages and watch the threads break.

You also didn't edit the first patch, and rather edited some other one?=
