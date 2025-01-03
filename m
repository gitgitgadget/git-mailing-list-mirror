Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFEABE4F
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 18:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735928526; cv=none; b=fsdXJTj15+HvunoJbH/URiuDP4nSDjx3ypXUex8IrE4PI0bQ7HrSFgHYO8AMkiokkkuDGMhph8sCCCflqHZB0fc4zgXDvuvds4ZF+i9lCu9+9ycuX7LwAJi+QYANxqbBmFhfd5rrO4tj774CJO2aJFpkIKmsYn8w2Bpd08Gk1Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735928526; c=relaxed/simple;
	bh=jPr8LRfvRvfDkHft9Q9y35uQmc1o6CMa8ShONHW40ig=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=QwBzpdEk2OS3wFLz0I8uO7omUqFzMetDW20INGmJMbQPxwIaU0Qg86OKKQlfowUleDfob9CjUBwn0Q+tZ+8W1ag8+YBLcRxNJDJoPsOYYSKq9PMq8vCCnCA4l1tjq2DOwTFcU0sfbZXJvqzfi2mTbEr8sU9vJ2IDsjk7EnC8YHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 503ILtZY815302
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 3 Jan 2025 18:21:55 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Ankit agarwal'" <agarwal.ankit51@gmail.com>, <git@vger.kernel.org>
References: <CADQbHxG_dop-Lti7N9Uh02YeRuFt9apXTXWRVQb47kHOSCmKgw@mail.gmail.com>
In-Reply-To: <CADQbHxG_dop-Lti7N9Uh02YeRuFt9apXTXWRVQb47kHOSCmKgw@mail.gmail.com>
Subject: RE: Help with Git Subtree Push
Date: Fri, 3 Jan 2025 13:21:50 -0500
Organization: Nexbridge Inc.
Message-ID: <059601db5e0c$5efbcb60$1cf36220$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFDoaQycAZfPAvPHg/vtiUzOIJmgrQ01CRw
Content-Language: en-ca
X-Antivirus: Norton (VPS 250103-4, 1/3/2025), Outbound message
X-Antivirus-Status: Clean

On January 3, 2025 12:28 PM, Ankit Agarwal wrote:
>We are currently facing an issue with the use of git subtree in our =
project. Below is the structure of our main repository:
>Main Repository =20
>-src =20
> =E2=94=9C=E2=94=80=E2=94=80 java
>  =E2=94=9C=E2=94=80=E2=94=80 test =20
>-commons (git subtree linked to external repository: =
mailto:git@github.com:MSILDigital/MSIL-EDS-Transformation.git) =20
>-README.MD =20
>
>When attempting to perform a git subtree push from the main repository =
using the following command:
>git subtree push --prefix=3Dcommons =
mailto:git@github.com:MSILDigital/MSIL-EDS-Transformation.git =
feature-branch =20
>
>It fails to create the feature-branch in the external repository: =
mailto:git@github.com:MSILDigital/MSIL-EDS-Transformation.git.
>To debug, we executed the command with --debug enabled:
>git subtree push --prefix=3Dcommons =
mailto:git@github.com:MSILDigital/MSIL-EDS-Transformation.git =
feature-branch --debug =20
>
>Here are the relevant logs:
>command: {push}
>quiet: {}
>dir: {commons}
>opts: mailto:{git@github.com:MSILDigital/MSIL-EDS-Transformation.git =
feature-branch}
>git push using:  =
mailto:git@github.com:MSILDigital/MSIL-EDS-Transformation.git =
feature-branch
>Splitting commons...
>Using cachedir: =
/Users/anagarwa/Desktop/Code/msil/arena/.git/subtree-cache/97237
>Looking for prior splits...
>  Main is: '78dfdb9f6dcc729a5f99a03b8ba061b28f4db97b'
>    Prior: 78dfdb9f6dcc729a5f99a03b8ba061b28f4db97b -> =
067b015de01bd0aa8d1694b1c9c7b3b9e836e06f
>  Main is: ''
>    Squash: 7aca20022503ddc3374be82ee39089da07094a5b from =
6ce1ce18cb63e5992ff4a29e9e17e92a1af1afa2
>  Main is: 'c5352df744e1eebca0eb03ae62ca8c52cd501fe0'
>    Prior: c5352df744e1eebca0eb03ae62ca8c52cd501fe0 -> =
f152501eeaacbcc982bf5cce28c0f3d7b843d780
>progress: 1/     199 (0) [0]
>Processing commit: 1b0c28da208f38245ba61dcfe1fbb7d0c0f0bb78
>  parents: c3f464ce8a03eb1034782b649bd1786589d2a95c
>    incorrect order: c3f464ce8a03eb1034782b649bd1786589d2a95c
>progress: 1/     199 (1) [1]
>
>The complete debug output is attached for your reference.
>Interestingly, this command works as expected for some team members.
>Could you please guide us on what might be causing this behavior and =
how we can resolve it to successfully execute the git subtree push?
>Looking forward to your insights.

AFAIK, git subtree is not part of standard git installations or in the =
base git code.
It is a contribution. I would suggest contacting the contributor, =
apenwarr@gmail.com
For assistance. At least in the CC.

You might want to consider moving to submodules in a recent git for what =
you are
attempting.

--Randall

