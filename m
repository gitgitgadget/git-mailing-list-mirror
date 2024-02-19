Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894F555E4A
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 22:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708380286; cv=none; b=t4bzlQapedBgJNTmmPRQfgppVuhSB5VNKZAdcUQCRajeDc2fl2v0OJ7BBoUATwCV73yR6mJO5Kz1rAJbkriXmM/jv2gIKcEE7ccPffza/OgCjsS+5JhvjRPBdHtGG8UKObLbHEdxY3jHhFEyy+02XIZzlEN307axPzvz2ktT8jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708380286; c=relaxed/simple;
	bh=rQSJS0amdlR1Lvz/7gfTjFNJSez9G/tT+r3Fdkf8ikg=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ruFMeNUn+FytWXKmLcPf37r/OVYli1Qm99YZvbh1b7NNeHsfE4hSX6pv2XTu0RhuHL0yH0kIYiFqhw2g6kk2m3DiB7QcY2/WvTjl5dx88YpSeGy9E1BHlxZJdMZhyxW+qBtqo1y/pysF2d6YgOfArotN61DTT7GWhp8IDoifFJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=WSJRylEt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L8HgM8Ju; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="WSJRylEt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L8HgM8Ju"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 648AB3200A64;
	Mon, 19 Feb 2024 17:04:43 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Mon, 19 Feb 2024 17:04:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1708380282; x=1708466682; bh=V7Rq/tJqI1quEE6mSo4a+nr9r4ivHc90
	I49mJN+XhVI=; b=WSJRylEtaOuPugBf+Ihpiplw+kMJxNeA0ISnGal9rXZSh5x/
	lNburNbZUtVXx3Hv3NXQpXZNRLZZmZ3No7gqKBar1boP18K6Giws/xNLH8pbVNac
	LZnyY+7uVoParKY0TbeN1/oCP1cvgESCuBtqX4hRFIXWIqO3D2ZMAZz/Q4URYEHF
	+7Tk4PuhADhnigkhn56iFRKWg2uPgigZ4RdFkbA34t8ipxh6Wd1Oa/6c+EZ/Eb9B
	0ZxRhe2+eblHePGef2sizSgFeVWkm55XXyur/hlageREpm/PCAGNK3VwIrcrMs/n
	mmBqFKmUvbTXkYm+kofX+1l1Ag2t3DgjGEp8yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708380282; x=
	1708466682; bh=V7Rq/tJqI1quEE6mSo4a+nr9r4ivHc90I49mJN+XhVI=; b=L
	8HgM8JujNitHe22NmKePEBd6yHyoN6KxABGCq2X2WBLkuNClBf9hSBk/iKzQGeHs
	tVxg4fjHieewQr7g3keNnINCGDIPy+tlNAqqj0bPh/3BVT5PVFurf4xcJ80f97J2
	9+W7+CrsX+QfZOX8I8Xx4cLTkKU6iBhohprjRPiQ5taQAOli9pIBW8IYLnH+diXu
	vDLEQqI/O27heaszpRYAeXzsYcCHP598ZJ/mSvcw4V/mKxkd06ZsAEQK2jLg7LHc
	ZITfyc1Doh7DnS1poxF00Skk/idy780Pxz+lCjvekltf4HqglgwXvgFxBhHEN37f
	FHSnc1S37yAjEtBfYgHDA==
X-ME-Sender: <xms:etDTZYNfGyRKvIiUnVVpDkFNAzW2yaD0lMbBfCqogg8Xm4W6dMqDvds>
    <xme:etDTZe94Mea-3CcbTgwqUEymetOWex1gTMskJjParuG1CWtwX5xotlXJE1WJnMRbQ
    Ay1SSNBZYqh8LgxXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgdduheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvveehiedufeehffdvteeuveekhefh
    leeigfektdeifeduteeuheeufeetffefudenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:etDTZfSPayvtNBk7XWoPxHtbLu9vtez3QM6O23ZF30zweG0KMrkoxQ>
    <xmx:etDTZQvv9LFSrIZN_kdxyrhMjW9uu6Xo4by_Dcr6Nm8P37oQ4B4GIw>
    <xmx:etDTZQdudfhaeGOYm2ZwsOFbE_hpJNlb3rUjh0aVIgPy4EvXwHPFpQ>
    <xmx:etDTZcGw-I0cato-vrXczm9s8tO2VBQKszHZ5Lg7kJp_ZnPyGPxuSQ>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 9852F15A0093; Mon, 19 Feb 2024 17:04:42 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <423c4144-56dd-4897-9b81-badf67e22420@app.fastmail.com>
In-Reply-To: 
 <7dab12ab7b8af3e6a0778fc1a01dd1479990bcff.1708317938.git.gitgitgadget@gmail.com>
References: <pull.1677.git.git.1708317938.gitgitgadget@gmail.com>
 <7dab12ab7b8af3e6a0778fc1a01dd1479990bcff.1708317938.git.gitgitgadget@gmail.com>
Date: Mon, 19 Feb 2024 23:04:19 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Josh Soref" <gitgitgadget@gmail.com>
Cc: "Philip Peterson" <philip.c.peterson@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] apply: rewrite unit tests with structured cases
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024, at 05:45, Philip Peterson via GitGitGadget wrote:
> From: Philip Peterson <philip.c.peterson@gmail.com>
>
> The imperative format was a little hard to read, so I rewrote the test=
 cases
> in a declarative style by defining a common structure for each test ca=
se and
> its assertions.
>
> Signed-off-by: Philip Peterson <philip.c.peterson@gmail.com>

IMO in general you can just assert that X and Y in the commit message.

  =E2=80=9C The imperative format is hard to read. Rewrite the test case=
s =E2=80=A6

If your patch passes review and is merged then that=E2=80=99s the truth =
as
determined by you and the reviewers.

More subjective-sounding =E2=80=9CThis was hard to read=E2=80=9D and may=
be anecdotes
like =E2=80=9Cthis tripped me up when reading=E2=80=9D can go outside th=
e commit message
like the cover letter or the free-form space between the commit message
and the patch (after the three-hyphen/three-dash lines).

--=20
Kristoffer Haugsbakk
