Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF62273D77
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 18:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758048384; cv=none; b=FGiSTb/r+qyFvkHRMxqboBYH227NF9+cnvOsfcRM2+NeQbqkAMomt3Gf6Rj/Xw5uEvyUTT1OJ7cenVCkTUZa5RKsr1HkKt8QK/O3f9o2cENwHl+4G7S68vn3XGN/auqtrg+/l8l+eN4qA2t5U0t9j+ZaQG3dCssL9JC6qTNDxl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758048384; c=relaxed/simple;
	bh=e3X6VcLvP0sbKZ/JulSbNf6VZC4VoiQ1MLi5tS8XNa4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=TFesUFzRHt1tfjgzZNApE/FRSgsdae3mvN+xJU0VQ18Veg6Pc33ecRnwzOvWMw5RGqkSGM3uqYONu8tYAwVFlsazJsHMEy+bzuheK50Kbe3dQQGpsiAOSQIKWYB9HO7WayM1YBsCDs5Ggqdn2QC0NynJdUAfyvLaj4F8w7v3fEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=wQEFobKI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oKM3qcNY; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="wQEFobKI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oKM3qcNY"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5F5AB14000D1;
	Tue, 16 Sep 2025 14:46:21 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Tue, 16 Sep 2025 14:46:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758048381;
	 x=1758134781; bh=ZJ8qrG1aN5p2bvp4aeDSqhffEhCqWrkd2jum9K0EeIE=; b=
	wQEFobKIF5HJbrTluNjoQ+1hIGb1pjfiwzeBOA32qNifA7SLJBCLzVCmdN3aitc1
	qqbpyKNLAl9YNGvChqieRmbXJzf1Idzvk9YXdMn8bDQJMH6jW8mym2zFqSeWpkSV
	a605DD8iPCUNUeuHcYLj45QUl6Gl+zxF4phjXJkuAq0IFoGWR2ruTh4FQ2lvnF2Z
	/DEElhRxpzg2NrhNgZ07K9enKQf751clspUT0hC9tzIry6BIePR4psue7yZSpZjj
	M4pcwCQDheJ9e7mLcBi9ZDY3dPNz4voAc45gz4vuT0krS5r8i+NV+xh3XLaswh4h
	JsVPKEXPReVBCTA4sDMonQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758048381; x=
	1758134781; bh=ZJ8qrG1aN5p2bvp4aeDSqhffEhCqWrkd2jum9K0EeIE=; b=o
	KM3qcNYSfANFAJUoXRhj+M18QR8+cEX0LOFpzIqxabZEw3EAGZ5X0Z6yrzz21gK/
	eTIGtjOhrOtjjRAsxW6Mk1tA2TGMkblFMXCcFMIyXO9JPvcSfbTfpOlcN0VEwxmW
	mGBncgSPrvAq20BBtNvMa6ofWfwkntX4DHgvf7sghLqTBJVSsDLfPfdHQi5P+sqV
	KI0+X5FQzilivgRE6Vc2gwjZp37/JkStAU4qql58Z2VxsmEOri288RX+o82DoNRC
	JexaawS7+d5VUwVzIRe4KJYD/WVvJxE/r2F6BrMYGNG48wTRQDZR9bYFjM8ibirU
	bLOW2hsuIGPzS5mkiYebg==
X-ME-Sender: <xms:fbDJaAejiElS8bQkVSjA0jx3vcf5splGX_umXsG3006qHjrQFWJ_Pw>
    <xme:fbDJaCPQD7YTw807e6TMYbQXVQ-a-tkLrUylCT6WZw3UjjhrZTqCx9tpmv6Qpwfj1
    Xq41WnkmSLHhJXtqd4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegudeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfluhhlihgr
    ucfgvhgrnhhsfdcuoehjuhhlihgrsehjvhhnshdrtggrqeenucggtffrrghtthgvrhhnpe
    fgveekudeviedvveeuhefhvdetgefgffdufeeguddtkeegtdeltdevhfdtuddttdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjuhhlihgrse
    hjvhhnshdrtggrpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtg
    homhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:fbDJaD-3aJKkf_JMZRYFh0cYs2_xFSG2TJYlMHFzzgtFYg51J6eHLA>
    <xmx:fbDJaM1cYjAp3KnYtftbrOnd3nwjvUG92jzTj3Mh5v7jmZXv6EgbrQ>
    <xmx:fbDJaAALOlAqTKZGCBji6D0-EuV1Rt0Z3pQS4S759-50imYcevS8Rg>
    <xmx:fbDJaAf30citQQN4l8IgjNbNI26Msm0tU_EjkfyHqLIoA_0otDQmWQ>
    <xmx:fbDJaDP-PcapQX5idarT2ucluhaJLSh6QbWziEUKRZuno0-Cj9I3bb12>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1642678026F; Tue, 16 Sep 2025 14:46:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A2KDzlJCb01s
Date: Tue, 16 Sep 2025 14:46:00 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Message-Id: <3f9f511f-7f9c-4179-85e1-87d76b748db3@app.fastmail.com>
In-Reply-To: <xmqq7bxzcgsj.fsf@gitster.g>
References: <pull.1964.git.1756240823.gitgitgadget@gmail.com>
 <pull.1964.v2.git.1757703309.gitgitgadget@gmail.com>
 <270edd2b00e63ef396ae69a9a7e9113a54f0df82.1757703309.git.gitgitgadget@gmail.com>
 <xmqqjz23l7ci.fsf@gitster.g>
 <70034c35-8f08-4ee0-9017-7faf6f55ae14@app.fastmail.com>
 <xmqq7bxzcgsj.fsf@gitster.g>
Subject: Re: [PATCH v2 1/4] doc: git-push: clarify intro
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

>> Will try this:
>>
>>     Updates one or more branches, tags, or other references in a remote
>>     repository from your local repository, and sends all necessary data in
>>     those branches or tags that isn't already on the remote.
>>
>> The goal there is to make sure the reader knows that git push may need to
>> send a significant amount of data, depending on what's in the new commits
>> you're pushing.
>
> Yes.  I do not partculary see the point of deliberately trying to be
> vague by saying "data" (in "all necessary data") instead of "tags,
> commits, trees, and blobs (collectively known as objects), but I
> agree with the stated goal here.

What we're trying to prevent here is readers getting distracted by trying to
learn concepts which are not necessary to understand how `git push` works.
For example, one user commented:

> I had to look up what the term "object" meant...

It's not necessary to know what an "object" is to understand how to use `git
push` (though if you have an example of why it is necessary, I would love
to hear it!) If it's not necessary to understand the command, readers should
not feel like they have to look it up to understand its documentation.

I think "..., and sends all necessary commits or other objects that aren't
already on the remote." might work if we want to add more detail, since it
gives users a hint that maybe they can ignore the  "or other objects"  part if
they're not sure what an "object" is.
