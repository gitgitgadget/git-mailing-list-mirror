Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ACD363C53
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 18:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788459404; cv=none; b=dOAjYukS85NdRB4cGKSsGbGOEYcAEMEV4Gz7/xHYg+9axk/Oh+iUksaAi3WE6WQLz8xGLCRvwVnHckvjqGDmE5tgN2OnrbTLSmO17ZPxiKdq2X3FJrwT0zbdfDpXB3+37sFP0d5ndrV8EO4TUmUrE0ggbVvE7fCYcNu6b3BuLSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788459404; c=relaxed/simple;
	bh=KHmJioPj/xSKsBz+lwPrkNZT6gqIHatrdwb2Ax301VY=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=Xix5+yKpKOjZxPbWAMi+HmTx10OdpMMk7HfvkceJoMTIbDMAALe+MOLMXricooeqtxI1V8B18aPfUc/NQ7Q0kovYyT9y1GUf11OefiyI16GwikLk83EBddRUMetLADCvgIbmN74MQF6P2Mvlk0YE5nWTEMvKSGZgCFkdqTUwUk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIDZ5muc; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIDZ5muc"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-66bd7857841so152350d50.3
        for <git@vger.kernel.org>; Thu, 03 Sep 2026 11:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788459402; x=1789064202; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tb6FTlD8wK8cE1txj+9Hxwk3MWXeSQxd1Fek8pZOpGk=;
        b=CIDZ5mucnrqQYipK6S+3bVFFZrWEXh/4YohrOWh7vEeyCqnfnaqwPHUPbykJ8+9cIC
         cNf35v3lqkX+o5TKIgWRsejHWafO11juGcgMdh2MQunqcuUgn79j2feIExcohC+zGSNJ
         ArlafeK2C6S/YIyjnKt0a/zMQb6DjzARQWj0/AJxmF+IfC6tuQfZlY8UbbJ1lFhNdMIU
         2grgM9nyysSuhVYQjxbavh7VlsfJN+t3sLl33JqlKFBMMTl/1zVLTb2XBR5JZGUp5OTZ
         z4poT/nQMPEJDf0irPIjbA73xc5t7gBS8u8cxKozYx0i+aJ5Y7ZFbc5I7uWiWQ/M8nTK
         lt2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788459402; x=1789064202;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tb6FTlD8wK8cE1txj+9Hxwk3MWXeSQxd1Fek8pZOpGk=;
        b=a1DuvU/tdNK++PkhEA3+Igb/AkaKtXduNCa5YpMpqqQDpZejMkWGIuUgE7EB6+jLxq
         ChNA8L6DWOqNdgsQ3Ldt+nOZcBQH56HxVGs3HpTXtoVHEJCRTUPDETQ7wuyIHJ3PE5s7
         2LQGmpzo29pcafKZl8gY4mFncxo0VXu38sTI+XPHXsyuYnO++j5QZ3nxteJO72T8fIL0
         0+RoS057j0WWKFvWawdvik6hA79oM61e2zn5vXMQzeTqopr0ZPJd3EQG71icAyfuHfaW
         3ile7x52+Pou/W2XDuqB16rtBDEY57wsPWxHNh7uDZ2gAEnfsQhUYuntEWnXamb7veeZ
         qwKg==
X-Forwarded-Encrypted: i=1; AKwUvBx8Wb+ThJAEm2k6Nn8sp6LAJ4Wt274iAGoSkfwuv42ns7ODMhpcxqQCfEeiBRaxellEU44=@vger.kernel.org
X-Gm-Message-State: AFuF++lhuRp/YvRkp6bCEdDnP1UTv3nVuJkrUU/8Uyh1iCaZ2jWHraDN
	ltwXcxxjS/MLN/HLwupGfw6onMH8GMaJm6InRK9qyfygTLZ3w2aC7fYH
X-Gm-Gg: AYBFou0zULoTvM+c2AF35ljQphvFmoFe/zLgYpVIKuyS7w98J9wFLBp6FdXrropKf0T
	W6vts+SjrNPlQgJcBso7+9hFa9tZaMEiq/OwmFgYcsyUfonIUgxqlaVUgqbQU2Ysce8hYacTFhZ
	+1v1Ef3VL29Ry5mNlYORIAG4T7lZ3+rgXZ1J3Ac+sxodhHIOfBZTwn+n55wupiXdvp1OCjEnx72
	68odqwaWBQtC7hxEW6yBlGmVN+Pqj803Olbii7zzeM/HTf6Prqd5z1LGz/YUW+bxsTk1F/AGB1g
	W08VJiLF0WwDWrKw30vCsZhIMCXOA7QAN7sjThltBpCdfllf3EG2J8p/ANZE3Z16ZK5mq09+TfB
	9Mx90mXJkq8atWcC+KJNTeht2M8aTGT2eM3v0XE2YPdbBsxHXqX+yEw6v27Z/qhv/V5col/e45M
	NYZk1CBtbT+QbY0+27ltXWWp03nNT5H9Hy5ZeqiBrKCgxwHcrGxqh25VHvHe1Lk+7ozBAKBaz3Y
	16x4CNbGFiZ4HanAU3nBWbyJ4OYbXmbjogGGOvZdJDLd3hGqZV09MHvRe6phrrWJuzvKNZgFvL6
	u5AqWTf6ULGd0j0bdSohsmKWJ0oU9QmIMrJiww==
X-Received: by 2002:a05:690e:1c2:b0:66f:afdc:b49b with SMTP id 956f58d0204a3-66fb57643fdmr200126d50.0.1788459402188;
        Thu, 03 Sep 2026 11:16:42 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9092:700:dd08:3986:f73c:a217])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb4939b30sm477237d50.15.2026.09.03.11.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 11:16:41 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v6 3/3] core: convert build-time USE_NSEC into runtime core.useNanosec
Date: Thu, 3 Sep 2026 14:16:31 -0400
Message-Id: <D0BA1B32-1CAD-4328-A612-75A648413017@gmail.com>
References: <xmqqbjaefhwo.fsf@gitster.g>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
 Patrick Steinhardt <ps@pks.im>, Todd Zullinger <tmz@pobox.com>,
 Olamide Caleb Bello <belkid98@gmail.com>, Yuchen Tian <cat@malon.dev>
In-Reply-To: <xmqqbjaefhwo.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (23D8133)


> Le 3 sept. 2026 =C3=A0 11:56, Junio C Hamano <gitster@pobox.com> a =C3=A9c=
rit :
>=20
> =EF=BB=BFBen Knoble <ben.knoble@gmail.com> writes:
>=20
>>> I still am worried that something that sits this deep in the
>>> callchain can easily BUG() when working on a repository that is not
>>> the_repository due to the use of repo_config_values(), and we might
>>> be better off adopting safe default when istate->repo is different
>>> from the_repository, but other than that, I think the series is in
>>> great shape.
>>>=20
>>> Thanks.
>=20
>> Yea. See previous messages re: convincing the test apparatus to
>> set this globally. If I could run it that way at least locally, it
>> would go a little ways towards scaring those BUGs out into the
>> light.
>=20
> I am not worried too much about the current code.  I am more worried
> about how much this will hinder future development of new features,
> e.g., diff or status recursively going into submodules without
> spawning subprocesses, which is done for grep already.

Sure. Some kind of safe default could alleviate that.
But seeing recent work in these areas convinces me that
we should use this as impetus to lift the restriction, and
I worry that papering over it will remove that impetus.
Still, if a later series needs such a band-aid, I suppose it
can add the safe fallback. And that=E2=80=99s where testing would
be nice for automatic feedback on new such interactions.

> Testing and
> seeing 'git grep --recurse-submodule' not hitting a BUG() does not
> assure us all that much, as I do not think it needs to deal with
> racily clean entries any specially.

A prior reply of mine to Patrick specifically mentioned diff=20
with submodules, I believe. But I agree that positive evidence=20
is probably better than negative evidence.

All-in-all, I=E2=80=99m not inclined to change the shape of this series
at the present point in this discussion, but if you (or others)
feel strongly about this =C2=AB safe default =C2=BB being a requirement,
I will find some time eventually.=
