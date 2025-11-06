Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6453C38
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 03:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762398492; cv=none; b=TuOMCDPvGyD8bxVl7TMYMaGLjZ47IsKcZ6h7Vm6Pq3ey4DLiRiVx5djwY95B5NJNKCwFY87+zZNw+ofr6xeyVrieLbZZK/qdnnHP1AUHPPraUmVulYgUbyCIb+8rvgyTLjGYDNNcBpT16OC6TpY1gebStmUOoFdRA+Cz8LQmSeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762398492; c=relaxed/simple;
	bh=Gx8ufcJosKQVU4TAcY2zskLchP6wUTAu7w6isd36wVE=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=ROf6JtHD+HOQPLERNOg4etJ57o406PhjFy9XvyeKhtl1AIyPrIv2kO5KLF6/3hpPZnfmxqTtLyAQ3iReLv4ynf50WXyv7GitjZ/A2OwEZKMuswXSFlLlw1SzlFP4yaP2e/B1IlkjkdiFGERkshkpjXCSH8QqKY1Plmlccdifhf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WyUwKbRN; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyUwKbRN"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-63f976ef4bdso553662d50.1
        for <git@vger.kernel.org>; Wed, 05 Nov 2025 19:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762398489; x=1763003289; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xBLqGzFjM+z4IC1fWXx5DGMsDzniZoDyJo1VikmRaCw=;
        b=WyUwKbRN9VrdtcgfIBDDtwWZz/z+cwUid1R3Ja242bkov0+91cbFb5zRpWZpiWnDmo
         yWaTFkYg022WqyDG7dIY387cUxQ04ajcU6bVqXBFvAyRUQoXvjSuC3AkkhtKSt7XhGzf
         CoJ/2E4cVBVVWgcLlgaOYll4JG4AYpWQfzcGpvc3nolgysqofygCnIQncRlDYlNEcYqW
         SR5wolRA0FEQCAUjsAvFndV8t4bnxcThabJgs1XATarsxvt/DL+91xXyov2JBprny6k5
         BvuGybHH7UdhOb48OLyGbzm5+glUvDmobE61yhoUliWxXTWPOV0V5H61VvXQ/gaUvqD1
         JQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762398489; x=1763003289;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xBLqGzFjM+z4IC1fWXx5DGMsDzniZoDyJo1VikmRaCw=;
        b=LAXa5J3pANDbnPxBpnqyR8VFw++DqAQl8fue0k98iJ+zk+/CtKHit9QWuSAadDbQC5
         pvp6Yi45IAjsXojfGa5FVgAicvzl/FRDH4vXUr7H51oxH5ZQxKoos2sAvzeT5TW9tKiI
         VZdrJxRVWU07vs07ea4MII68tGqP7/9QXyLA5jHv/9HSy3VTKRabfI18Xb2pIJGuz3zd
         Za9dLK78c+WAzm1YKdM1o804RWqiJpmjWmeSZrJusgvGuHe6dQGFkFHtDVC3J09HQUGj
         6zkgPfWTfZ8x7238XQsPxxZMHK0HiN1x6v3Zvuiy3EnJPMfghctkiwI27hAskhvEo1lk
         Z6cQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFqPvYoUGFHWisH+oG9y5Ae3yRmDpXAQfLY3ezIYJkJg7phJVTzP7L5f6Mg6av03tGLdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC6GvQkbbmJ2vOUeGiX2xqE9f8cNg8mmXl3tfEB9TWI0Jgn2RC
	QiKeCXUhZFPksZgMT6URat05RmdnKPqxma+xYCKUxhk02Locw9UMhc7H7ehWYQfuPLk=
X-Gm-Gg: ASbGncsrtRq6sOsstmkilVO3tBZJK2peezQWSHXFfJOIesPOjKw31rj1PflN1OyNh/y
	FGJ+YU8lZBmV+NMVVm2KFY+3vPi4b2WILctzJFhsJI+nFprD2ib4ffuEJJsdq2hAvPhwrSab/Yz
	eYerQBbfEjJ1fWIIa/LtQwKqYxRFUSv/+fdsh4QBWSG8ZkYT6C/klCWP2+MAQJK0lnjyPe+dhgd
	7luA9Tp9kJR6yNnaPGy4Dt63rIHcCFMe3Sh/HgX2ZmTBOLGdy7F5pxusCgZsjBSgjFIHG40iaHl
	wCzG5pLbWMEO6m0pb/w5dpoZVkgkXFKwwmZZHDk76CKnjJ9AixSOBIRor1BRshQCCE6DQS3dOl6
	xBGsXVcKRVdVcsX5+bcLzATrtzCyDbmJF1w7RGiidpkHzC3Dq9pg00AdIrPHMlb2bi0kj6kYKTb
	ekomixgoZYkFh/F6/ZNwVjMmekJKbmOoQxUCaC5OE4wmlRJJyzuUV5yCHO0spH0vAOhggD
X-Google-Smtp-Source: AGHT+IFMQ8ij404jGHPlvXHFDM89d6cioL4OrbTjNXjpF42xpvLcFxIXDtylSZOie6NClH2BiD3Usw==
X-Received: by 2002:a05:690e:4295:20b0:63f:a856:5f84 with SMTP id 956f58d0204a3-63fd34ccc0cmr3935391d50.18.1762398489442;
        Wed, 05 Nov 2025 19:08:09 -0800 (PST)
Received: from smtpclient.apple (99-144-70-174.lightspeed.chrlnc.sbcglobal.net. [99.144.70.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787b101fb94sm4580427b3.0.2025.11.05.19.08.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 19:08:08 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v5] doc: add an explanation of Git's data model
Date: Wed, 5 Nov 2025 22:07:57 -0500
Message-Id: <875BAB6E-724A-4AB3-85D7-8750667949E5@gmail.com>
References: <7217ae44-5ad5-468c-b76b-c485247fb2f4@app.fastmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
 Julia Evans <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Patrick Steinhardt <ps@pks.im>
In-Reply-To: <7217ae44-5ad5-468c-b76b-c485247fb2f4@app.fastmail.com>
To: Julia Evans <julia@jvns.ca>
X-Mailer: iPhone Mail (21F90)


> Le 5 nov. 2025 =C3=A0 11:27, Julia Evans <julia@jvns.ca> a =C3=A9crit :
>=20
> =EF=BB=BF
>=20
> On Tue, Nov 4, 2025, at 10:21 PM, Ben Knoble wrote:
>>>> Le 4 nov. 2025 =C3=A0 19:02, Julia Evans <julia@jvns.ca> a =C3=A9crit :=

>>>=20
>>> =EF=BB=BF
>>>=20
>>>> On Tue, Nov 4, 2025, at 6:45 PM, Junio C Hamano wrote:
>>>> "Julia Evans" <julia@jvns.ca> writes:
>>>>> I do not see the point of implying that the commit ID is not "special"=
, or that
>>>>> it's only one of many ways to find a commit because to me it seems ver=
y special,
>>>>> since there is no way I know of to retrieve a commit that doesn't ulti=
mately
>>>>> end up using the commit ID at some point. (though that ID might not be=
 encoded
>>>>> in hexadecimal)
>>>> That is not what I am trying to say.  The hexadecimal name is the
>>>> most neutral way to refer to a commit object, and in that sense it
>>>> is special.  It is the way ref subsystem uses to record the name of
>>>> objects, and that makes it special enough.
>>>> But that does not mean that the name _is_ the object.  The
>>>> hexadecimal name is a way you use to name the object, but is not the
>>>> object itself, and the special-ness of that name does not change it.
>>>=20
>>> Okay. I still do not understand at all why this is so important to you
>>> (for the reasons I mentioned before) but I'll see if there's anything I c=
an do.
>>=20
>> Perhaps one way to look at is, what diagram would I draw given
>> different textual explanations?
>>=20
>> The diagram we _want_ folks to draw (?) is the one where a branch
>> points at a commit [a circle, perhaps], which points to a tree
>> [triangle] and recursively blobs [squares], like I=E2=80=99ve seen Stolee=
 draw
>> for GitHub blogs.
>>=20
>> We might also want folks to label the arrows with names, or not.
>>=20
>> One way to interpret the =E2=80=9Cbranch refers to a commit ID=E2=80=9D m=
ight be to
>> draw a diagram where the branch points to an ID label, and to find the
>> circle you have to separately consult a different part of the diagram.
>=20
> Yes, the most common type of Git diagram I see is something like this:
> https://git-scm.com/book/en/v2/images/head-to-master.png
> which only includes references, commits, and HEAD.
>=20
> That's the diagram I have in mind when writing this text, and I think it's=

> a useful and accurate diagram to keep in mind, and it's one that you see
> very often when using Git tools, including in `git log --graph`. (it's not=

> a _complete_ diagram of every type of object, but diagrams do not need to b=
e
> complete to be accurate)
>=20
> I personally would not use a graph diagram to explain how commits relate t=
o
> trees and blobs (normally I use `git cat-file -p` instead, like I did in t=
his
> `gitdatamodel` document. You can see this comic for a "visual" example of h=
ow
> I've approached discussing trees and blobs in the past with `git cat-file -=
p`
> https://wizardzines.com/comics/explore-a-commit/).

Fair enough. Here=E2=80=99s a post I =E2=80=9Cstole=E2=80=9D ;) the shapes f=
rom, for posterity:

https://github.blog/open-source/git/commits-are-snapshots-not-diffs=20

My larger point was: since these are the diagrams I=E2=80=99m imagining we w=
ant to convey to a reader, perhaps ID can be omitted for brevity? IOW, the r=
elationship between objects is the thing to highlight.

OTOH, when exploring the data, especially at the plumbing level it seems we h=
ave to do the =E2=80=9Cpointer-chasing=E2=80=9D ourselves (see cat-file).

So idk.=20=
