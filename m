Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26998190462
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 21:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743803953; cv=none; b=gfyiJ54kzCcoJ43VvrU4N5KpaJxgf2P8dhx7aSB+tQQXVKY8p0I/6PWdqMDWm1Rus6tbpKq7IAiphXxe2IKG6n2CmaiCjevY0VZNH2F8P/ykTNl0233Q3hPrOrMYWPw+uGREhDYuKbw1hFJsXagt1YMqofEYoEp/q2sxKBDQGv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743803953; c=relaxed/simple;
	bh=yueH/Vhix5tXVHW7Oja6kFBoxHlIymD3Ahrfcecf5XU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=nYNAVY8miasx2N4mrt2lO33OIcjEIBKzBUFpFOHy83B8+mypE5laK6Mw3Qj6Z4QuazutjWPuB9LMNidlK1GJK103tQEs5PaRe/P14ayQC1pJ1ZBHJGxsfW8cjH45DUv7x9CAndRU1l+GaAOr/Dtlek0FU1rsfk+uhc+wQmURb8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDVA86wk; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDVA86wk"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2243803b776so36476855ad.0
        for <git@vger.kernel.org>; Fri, 04 Apr 2025 14:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743803951; x=1744408751; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IM74kvN2pDf4F5rnrXT+X+CwSy+zcTXfQrlT3MhgH4=;
        b=SDVA86wk4CAJBXSj7CeyyfQq+8GivaGji7wISkS+2F1w0ZeHAEf3bKUs0Zo2X7eqoQ
         HzMLRG8dhd93oxuqqqIRX0jxEzExVtxbWwd/KAmHlkma64uhfn0cUJzd02Rq2PW6PFSQ
         AgaJHW0+Epa6bfluXGzCy46Xvj2xTbZaxdbRZ/HMQuI9RqvM4Tmzp8gHLJMQYsnvEDvm
         vPM20/orhPcOkoO6RQZ2l4QXIJXRpqpK/liXQkOKCLxIVj0JNeyvtWVi3pP4fe6mPXf+
         dOSFj07UBrCIalKOIYLfZm1i4XdzcdlB4DiiG+DOkTkUqSmiITHNeTtDg26T6Jmm6zFI
         GvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743803951; x=1744408751;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9IM74kvN2pDf4F5rnrXT+X+CwSy+zcTXfQrlT3MhgH4=;
        b=Jrhjx5fCQle9MU1macsPHb2a8EwF79aCNol1mEBxCXtYMD9dtLp50rfunlSIrYvlpB
         z/D6CljHAu5jYf+JwMMcag/MJDVbVhq2m/GrBVoX7xbEbnUQL9gEmb90YTBj9+0x6SZW
         pyIkKo/nFiQUj74XeIv73rEbQvZIaScz7hBcA4C3r5N/LLtkt6rE8spLWi/uDvG40Uyp
         BVA+Fy+mNDn26xUIOPylhY4lDHuwBtsCNSu1e1AwwfWnOAVt4Z1BifasD9MRqmbtzfPE
         MzF7p6IaWMwiURrb8NM0nc6BnpIP2RCoJP94cy70jv+nncL6+vhEgXA8GZqp3w0pHUUC
         tTVw==
X-Gm-Message-State: AOJu0YyflMCVZ8j+DsX56dXL4HUwcGHMq6vrwa/dZFZKRyYXdp9rk/Oo
	oDbX5GmRWXAHluD9DOAH1ru8nDOLqixJ/xUX22elpY7+dMqWVuG40agN1A==
X-Gm-Gg: ASbGncuuYfwHd1wd60Yo2iwGUUbGM+BgwRu9hKwWcPPZEL/oCbQNR9YtHNyR0O9nWYs
	iHdJB6fjO8vsP9ev+nMAHtvBGI8dOlxzQN4z4gZS0s0Dz/1PM7IHnwO0T8dZ26kolkl/T88ah8N
	NlI5NIJjy7EkwWux/NeNx1jBzvIs31sDxOCgkNjd725y/dW7slV0NkmDyskdy0JRHCu86HV+g+P
	AZ4DVlL6xSIRKKA/mgjjmmQ7XCvY2kG4pWAT6vvptRl3EI6AUqwPtHq/5+s6dFQatquFhj92wZg
	YnVUTy6kB6NnyF72hz7qqSvQudzf7EIuq8Xa5bYztrW5xZ2UR1bF+hqTd2bXiJImaBFg
X-Google-Smtp-Source: AGHT+IETFee9UkgWC4tA69Sgp5K4cXXqCDyjd142AIbDXtEECCUBOCv0bIsu8DLibm3rk4JHrAxsKw==
X-Received: by 2002:a17:902:ce84:b0:223:397f:46be with SMTP id d9443c01a7336-22a955881b8mr11552375ad.47.1743803951155;
        Fri, 04 Apr 2025 14:59:11 -0700 (PDT)
Received: from smtpclient.apple ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297866e173sm37452565ad.192.2025.04.04.14.59.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Apr 2025 14:59:10 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: problem w/recursive, submodules?
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <PH0PR20MB6183CD9646B42F0DD552166792A92@PH0PR20MB6183.namprd20.prod.outlook.com>
Date: Fri, 4 Apr 2025 18:58:57 -0300
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E5FA108F-0694-4614-8899-4913E40FDA4E@gmail.com>
References: <PH0PR20MB6183E53678E814C2B473BE8B92AE2@PH0PR20MB6183.namprd20.prod.outlook.com>
 <9274ED7A-0267-43E3-9AE1-DC0BBEC81E69@gmail.com>
 <PH0PR20MB6183CD9646B42F0DD552166792A92@PH0PR20MB6183.namprd20.prod.outlook.com>
To: "Torpey, Bill" <Bill.Torpey@broadridge.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)


> Shouldn't the recursive clone pick up the HEAD of the submodule =
branch?

No, because a submodule is a specific reference to a commit of another
repository.

> If it sounds like we don't quite understand what git is doing here, =
that's a fair statement ;-)

No problem :-D, in fact, the idea of submodules is quite simple: there's
this .gitmodules files where the submodule metadata is stored, and =
there's
an entry mapping the name of the submodule to its commit inside each
commit of the parent repository.

As a public example we have the Git source code, which has a submodule.
You can clone it with:

git clone https://github.com/git/git.git

I'm working with the current master of that repository, which today is
at the commit 5b97a56. As I said before, this repository has a
submodule called sha1collisiondetection. Supposing that you're inside
the Git repository, if you run:

git rev-parse 5b97a56:sha1collisiondetection

you'll get this hash: 855827c. This is the hash commit of the
submodule at the commit 5b97a56 of the parent repository. Note that I
checked this without touching the submodule itself, as this information
is stored in the parent repository.

You can do that for any commit. For example, if you run for 23e37f8:

git rev-parse 23e37f8:sha1collisiondetection

you'll see that 23e37f8 references another submodule commit. You
can even see the log of submodule reference changes:

git log -- sha1collisiondetection

> but it sounds like git internally stores the commit hash instead?

Yes!

> - We've found that the problem is avoided if we execute the following =
command *after* doing the recursive > clone.  Not sure why this is =
necessary -- shouldn't the recursive clone handle that on its own?
>=20
> git submodule update --remote --recursive

Sorry for answering you this out of the order, but it makes
more sense to answer here.

This command will checkout the submodule to the latest commit of
the branch that is in the branch field of the .gitmodules (in
your case, `staging`, or in my case of the Git source code,
`master`).

Going back to my example, let's first initialize the submodule,
which I didn't before:

git submodule update --init --recursive

Then, run your command:

git submodule update --remote --recursive

This will bring the latest commits of the branch `master` of
the submodule. Now, if you run:

git status

you'll see that the submodule has changed. This is because it is
in a commit that is not the one referenced by the HEAD of the
parent repository. Just like a file that was changed and not
committed. And again, just like a file, if you want the
repository to point to that commit from now on you'll need to:

git add sha1collisiondetection
git commit -m "Update the submodule"

> - It sounds like you're suggesting that we need to go into the =
submodule and manually checkout a specific commit?

Yes, or you can use git submodule update like you were doing,
both work. But keep in mind that it will leave that in a
unstaged state. If you want to keep it, you'll need to commit
that submodule reference change.

In conclusion, think of submodules as dependencies with fixed
versions, where each version change needs to be commited in
the parent repository.

> Thanks again for your help!

You're welcome! I hope that it helps you!

