Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE2D1BD01D
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 21:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729631919; cv=none; b=qHSqkT/iGsNDobpZkhVYJli1eNxfyulcunImxN0dUt/CWeNQW0h3tFLkgwI1TCkizxFP7TSeJ//f8g4Q8sjIwAjPyMB+bDZffvAxKerIFar8EpWdAuYjGXp3as7+qv5h+w1zPazABwS7GSU3QkkddaJlIcY0UbqIuJ/cn989no8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729631919; c=relaxed/simple;
	bh=c2SNF5O9BjcQz1Av23eSXJBhH4U8/aImHxWHLd+hwpo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=S2QS1/MKEnmVpFgODIQXZFIvK0J9EYFE6FbzXhNITqqM+EGmPkqSGkztAwA7OAS/oQU9MMr/gUwnLoOiUqefT0NyyEcKtjxNfY6A+UINm1IwsRrWf6LsuvaZXyHeaoKx70cXuFkGqvj3gjntIL06lUwalhIvGWWLfq/Mm74lvns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Q5a9uh0Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I+2qHYkr; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Q5a9uh0Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I+2qHYkr"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 19D5913800F0;
	Tue, 22 Oct 2024 17:18:36 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Tue, 22 Oct 2024 17:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729631916;
	 x=1729718316; bh=BAxbYBHnxjMGqja7tEN90iJDacnF76HhrlzPtNhygYI=; b=
	Q5a9uh0YY6Xv1Blpd/cYRmysNpQf7jLo/cy3tCLq6NTacbnweCfb9D78P7RzETKc
	HPSzi0Thg3fEsTpASVghhmDeMCOynmYbVbxC4t1UoVk0n3A4jDNYDwA0+pitOCKI
	OGavRMfI0gKrRh2dS+lwBwF6c1jnfoGgvQXe7fTcwjab6nvgcwv5YbEPeYYgDvW6
	9AKfzSGtoIFLFWxIc3njs8iQzObcywYJyHim76IT3XSR4/ZnzyvUMg2Yxcmpwcki
	Y3aUfxgRl7M0ZqCVPS/uBWsjT4H89X2KW7wLJQENiXVJMZQcRcUjLRGPhldWkaXP
	xpNzh2Ftsrs0HB3QWevWVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729631916; x=
	1729718316; bh=BAxbYBHnxjMGqja7tEN90iJDacnF76HhrlzPtNhygYI=; b=I
	+2qHYkrvfsAfBreaD2GJgBjtdnxMh0Umsju4dDyQvcswT7sNhLjyR43LBH+LKAp8
	HUFwJ/iEeVKyqXqsER7fExKf4+MHtgVm4SoZTDvzxhSiEbK+K4s+ekdfPjE8Atah
	oINjKUACjeIS2lnGCXXciuKuk2+KIMKKhdeGISW84Klfp+uCuF8GEMlW8i0AJZpk
	xpC7PeWn6M26JP4GrbbnB30RzJT71KhcUtpqF0vbP9RJUQA2OK8OzCTBFgPkftM5
	b85MSAbn30Ew6dFRIBqz4WZlPEvttH3NVI1LlaPNKjE4yTJV1TE5fmoLU7VlKLil
	EjFqLJVkuffi0e5Ov4ZvA==
X-ME-Sender: <xms:qxYYZ2R__NdpuHByPfY6hQ-Ti9Y4QleC7cpDcrAy9T6-JJpI2akJzdc>
    <xme:qxYYZ7wxHEG4Ec6EKn5iV7isL9R-mHycEkrW00Myfgbv2gGOuriskg67bYgyf4qEe
    KI1TZCClpGvaj7u-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeihedgudeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggff
    fhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghr
    ucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgfdtgedvvdejuddvteeigfeu
    tdejleetueeufeefleevhfevudduleeifeekjeefnecuffhomhgrihhnpehsthgrtghkoh
    hvvghrfhhlohifrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
    dprhgtphhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgtphhtthhopehmvges
    thhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:qxYYZz1tYOa08_xhG8HPGXQ2myW3W2OAjSjpf1C3oOYb7cu6v1L1ug>
    <xmx:qxYYZyC9UphUnSWmBey3x0vFoWxI5RZopWynH9m-DomTUfiOt6KjrA>
    <xmx:qxYYZ_gK6YZ_0nZVX6RbKPq3dDN6OxUQQae5LTm6EJF7sqejoo6M7A>
    <xmx:qxYYZ-oXm35vd-P2tUOzQ0Rzu3mfGXRlWCj2zz1l6n-PgAhVc6fyIw>
    <xmx:rBYYZ8vQUlZ19tZ0uUh3GD-gX309u5Qw5PBnYvDgYU1prFOQZgsv7bCo>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D65BA780068; Tue, 22 Oct 2024 17:18:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Oct 2024 23:18:15 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Taylor Blau" <me@ttaylorr.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org,
 =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>
Message-Id: <aae8b889-3611-4146-91f3-72d6f1768b3d@app.fastmail.com>
In-Reply-To: <ZxbIWEGS1UB3UIg+@nand.local>
References: <cover.1729451376.git.code@khaugsbakk.name>
 <f7d9aa89c953ca7d15b5047487b4347ef62e77a9.1729451376.git.code@khaugsbakk.name>
 <ZxbIWEGS1UB3UIg+@nand.local>
Subject: Re: [PATCH 2/4] Documentation/git-bundle.txt: mention full backup example
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024, at 23:32, Taylor Blau wrote:
> On Sun, Oct 20, 2024 at 09:15:00PM +0200,
> kristofferhaugsbakk@fastmail.com wrote:
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>
>> Tell the user how to make a full backup of the repository right at the
>> start of the doc.
>>
>> This is a requested use-case.[1]  But the doc is a bit unassuming
>> about it:
>>
>>   =E2=80=9C If you want to match `git clone --mirror`, which would in=
clude your
>>     refs such as `refs/remotes/*`, use `--all`.
>>
>> The user cannot be expected to formulate =E2=80=9CI want a full backu=
p=E2=80=9D as =E2=80=9CI
>> want to match `git clone --mirror`=E2=80=9D for a bundle file or some=
thing.
>>
>> =F0=9F=94=97 1: https://stackoverflow.com/a/5578292/1725151
>
> We do not typically use emoji characters in commit messages on the Git
> project. The convention here would be to write this as
>
>     [1]: https://stackoverflow.com/a/5578292/1725151

Ok.  Will fix.

>> +You can use `git bundle create <file> --all` to create a full backup=
 of
>> +your repository.
>> +
>
> Looks good, and could likely be combined with the previous paragraph
> instead of breaking and starting a new one.
>
> Now that you mention it here, does it make sense to drop the more subt=
le
> mention that you refer to in the patch message?

Both sound good.  I=E2=80=99ll see what it looks like when I sit down wi=
th it
again.

Thanks

--=20
  Kristoffer Haugsbakk
  kristofferhaugsbakk@fastmail.com

