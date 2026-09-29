Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380F02DA76C
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 17:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790703132; cv=none; b=WRSFrcu7T+/j+b+eqh8vvnXhcLNMOvZA6IjAeVQsRTqzwd+DCiqKbZ2yZ7S/jJdhUlx0bA/tZFkKNuRmTZlA7pKyYfB6WPzn1deSrJLdHO+dyeH0ctgQXnmvzY+OqOIOVDTNi3mfQN6kYfLt+PbsFO0HzsmUSeZnQQ4FIo+2ip4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790703132; c=relaxed/simple;
	bh=g4T+CdGOxtAroK2aG7yjbxTV7tUSrD+/T6yF0gU9guU=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=SDUDBoedZn6o50/BgjESvoPEIx/8sKF8fNcn9f2XY2zJH6mX0iSmqlv0ZUDGnPqz78K9UQ6xaSTsmu5j9w+cyQd4eOTxI0q1fzp/yI3OunPovd5jbf6I5aB99TOYOdztFYd3Taa5JONzS11kGs5SkjE9gAFsJR90qsVJdBgIuX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkkUFeqr; arc=none smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkkUFeqr"
Received: by mail-qk2-f42.google.com with SMTP id af79cd13be357-93bef17c191so391382085a.2
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 10:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790703130; x=1791307930; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tq2XV6L6KyElZUB/LKT3r1FSPlA5GtdOB7midTqoxj0=;
        b=CkkUFeqrTU0qGPcLfWXA/rBzeSwXtUYMCiOwZpNTfUkTXkpusElOUaJ19hUiK8c6sB
         7vWaTvLfEm6tJ3264rqr/qxUXlPIPoI/m+wbOYMGs2UlOXwtlSG488BTx36QpA5uPUVQ
         qNa7i/QHnaIlpTkbp+z4rKJjQT+jXKDaPWwiOTfPrilAaFDJQFhCYWMRvSWev+0q4fTs
         C0QCgSZO/RrW+pe+CAq7TKnaLC/tDhCzfo9crkessIXsSAnE6mQSx58/SRCdNQP0xwZn
         K1R2lZLy1ZMG5vt75epz0+UfPK2qHhy8bKZYIx24BJlt+a7YRlhKbJHV6ljMvEmhrk4U
         tZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790703130; x=1791307930;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tq2XV6L6KyElZUB/LKT3r1FSPlA5GtdOB7midTqoxj0=;
        b=TtLzLhToh33WjjWkTgoF420me45jls/OgGOhXKbYVRKevGYZJfTTomQVAvATL/+0nF
         2Ze45Q40PEJcnnhCUyZIcwpEmOuL1csUbNfQTMdkr+7Nv1K/Gg0ljWl98Dx5h4DWHwdC
         oIoQ3rttUhGG9nLiTKWJajnzJpT8L9GxcNR0+nmeGc/8Fpgodk/GqxIZFQBe60uYNoDV
         kFTsoWrQ7bsBj6Nw+kRxbZYta3HqHR2K4S49Z8XgpMvBLpmeHYmQ191yx4g77ET60U4S
         beclmcPxIQjLuYMT/FaJjlCfWfuU6VeLgAoIPMGP6X+JKY+B1AXn0V2XiocMPTPtGqvZ
         bwMg==
X-Gm-Message-State: AFuF++mjugG4J+O1joMh7m7ktOKFrBkyYkFXVgJl7w+zQlD7zE85/AvN
	QrmFDlByJsNWxAhi8dP2ToGEk5EDcnIs0lmkH5ckUk69CBtRop6wfNx2vB7VxEnh
X-Gm-Gg: AYBFou3B3T/ogYF6pJhQAI73fiU4kDLl87A3rsqMgwS4WVU35ZZDVpFT51xhhsgauCw
	O/kS4QkKF5/Nu1BzQoAdw+YintZ0oZ02GcWobT5yBy5aIOJA0UVXl3IpeDNz7aHDxySLft4TxNk
	0idVhtvm1eOybEwtgwPRV9YztkaRvxxkrlnjwNuD05cHNJzkMC9B9H3xRSKBSXxww5Em5a9Yp7n
	g0jq0W3K/qLNgIm77wO2jtAYFQg60wqioyIqDmXtYy8jDs5TSvU4xOypzJsyLs6WdHzHC8kIf+q
	ZUtcYICm/erSSWlAP9yKmfhEOE09cD29bTC8CT4UKnKQGjUvrI1D1HCRTUgFXTcK/4R+e0sE80R
	zPXyzIB+a6pABwBvhXlG85QkYGySkQtzlwAAliFQPltm+ldiefiyudeCUyhqIecyW01OgIkynPJ
	6SmqrvDCVWqeJsz/cxRacWIQqlqz+d89RaYDF3Mwoym39RPb/YJqCh1R3wtzmnW4KjfxoBTCrXp
	ofGsMMMY+rbbmizfuWEm1TzfqV153uOapjcq6nrCrloddfnkW8tY+anSO9A8DJegI7BinyaO2Pu
	HkRVdttMc7DxP/F3QIM+TYNycW3uUAHLs9tPRQC/VhMYGPrpFyYeYb8qXBaHXe5zE0J1FI3rgmX
	R01imzA==
X-Received: by 2002:a05:620a:284c:b0:93c:5c7d:2229 with SMTP id af79cd13be357-93c9fc2dc32mr34988985a.54.1790703129936;
        Tue, 29 Sep 2026 10:32:09 -0700 (PDT)
Received: from smtpclient.apple (158-94-182-130.mclarenap.oninferno.net. [158.94.182.130])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c9f57ccd4sm20240885a.46.2026.09.29.10.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 10:32:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 0/5] stash: clean up index-mode test merge
Date: Tue, 29 Sep 2026 13:31:57 -0400
Message-Id: <F407EDB6-80C5-45AA-B8DE-CCD61DB663F7@gmail.com>
References: <d5ac59be-0688-4d60-871a-2ccebc91c58b@gmail.com>
Cc: git@vger.kernel.org, Eli Barzilay <eli@barzilay.org>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
In-Reply-To: <d5ac59be-0688-4d60-871a-2ccebc91c58b@gmail.com>
To: phillip.wood@dunelm.org.uk
X-Mailer: iPhone Mail (23D8133)


> Le 29 sept. 2026 =C3=A0 11:48, Phillip Wood <phillip.wood123@gmail.com> a =C3=
=A9crit :
>=20
> =EF=BB=BFHi Ben
>=20
>> On 29/09/2026 13:18, D. Ben Knoble wrote:
>> Changes in v4:
>> =E2=80=A2 Drop merge verbosity changes altogether. I was going to
>>   save-and-restore, but when looking at the index-merge test case (more
>>   below) closer, I noticed that "git apply --cached" reports conflicts
>>   on stderr. That is, "git stash apply --index" would report conflicts,
>>   and silencing the merge takes that away. So instead let's leave the
>>   configured verbosity alone.
>> =E2=80=A2 Only copy resulting index merge tree OID when successful
>> =E2=80=A2 Fix interaction with t5520 (new patch 4/5)
>> =E2=80=A2 Squash test from 3/5 into 5/5, since it requires actually mergi=
ng
>>   trees. I've elected to keep it a separate test for now (contrary to
>>   Phillip's suggestion) since it's written and working. Adapting
>>   existing tests requires quite a bit more digging into implicit context
>>   assumptions ;)
>=20
> I've left a comment on the new patch 4, but everything else in the range-d=
iff looks ready to me.
>=20
> Thanks
>=20
> Phillip

Thanks Phillip. Pending other positive acks, I=E2=80=99m not sure if I shoul=
d reroll with Thomas=E2=80=99s new patch, reroll dropping it now there=E2=80=
=99s a seen topic for it, or just wait ;)

I=E2=80=99ll probably wait a bit and see how the dust settles, but:

Junio if you want to see a reroll hit the list using the new synthetic base t=
o make things nicer for you, I can do so. In particular, I think the last ch=
eck I made when I saw your mail about the synthetic base had the prior round=
.=
