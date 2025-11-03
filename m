Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BFC1EA84
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 19:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762199635; cv=none; b=IW0Zg82w0zgc9B5vBobotN2y0n2sbLXAs3fWrN4ur4ANTXG42o2bAmrtTHhth37IG99RL8sNTxg6/5dE1s3blRggsQWnN5eqs4kGZaM+nLt4HidtDHVmeBXeqGX+EgMIaxS1LRXlf92AB0/q1BxG2JkGgCRrVxl9MooXHMfhoGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762199635; c=relaxed/simple;
	bh=fmRYH3dbMWPyLEU9pk2c2HXYoKkcpVnPeNUO7v2vnIY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=k3/41zF8gQzBT/f249cs8Zs7Ogg4V/Otm1MfO7qtyAVbej+Wjw1cPnesD0Sbvgp0KrpMUbflBa6DiPILW8hodkWxN3JYEUynTHZOf/kb3wjVn/gHUttZw3qV2O/tObiix5TT+bGkijMOF+7BuvpCiyarQulAJg3mOYXJfiBKWOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=144NhbgD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ghvx/NXg; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="144NhbgD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ghvx/NXg"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id CF6F21D0038D;
	Mon,  3 Nov 2025 14:53:52 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Mon, 03 Nov 2025 14:53:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1762199632;
	 x=1762286032; bh=JHq0rffOYmpw94trMsE6KVOMtcStriXr3jHAUGwGrds=; b=
	144NhbgDQwZjtasyBcs3oF1um6gUnnz9ZIGmWpFPiFmxipINwhQET7AYEMoQjbG7
	kkpNSqTQRpErxcpZtL/GaERXkUaneiQAMaGMbIe/InChreW3I6AOb93g9Q/KW+JX
	wD7LFsYOOj5BfQ4qTEVCeuBynMshaI/0DexNT+QrE0MUh56ZXiJo7fNp69bsm5u2
	Azsl4iDziuIOk4ILByktW8y7NiPGX7crfwaaeUHjS9ttpBWwxKTi8hlrP8hTdXzK
	Kn+NrK8VenVl2tX7D4MZdOA5uvfet4UzDcWdA/AX9XznWtkSITBQqZDMfOx91lOV
	v+5QEDoTrKH4V5tkdf6S+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762199632; x=
	1762286032; bh=JHq0rffOYmpw94trMsE6KVOMtcStriXr3jHAUGwGrds=; b=G
	hvx/NXgv0kY1L84KSlzHse9BT3oSEX1eDzvXpbFGCSiP8KZX2ea8U/pRZnmeOKOg
	1DfbHGumnuXyHVs5FX9UCkdpKeZhxxtJxculOKNHL1mwGVFlxerxdnNt2aILKJZi
	eWNoolZng1O/JJDj9k4Vf4nA7sph4wQiRyBYZouFHvtE41SMZOSaF8rKC+XY9j2A
	uxzLbhskXGSTSLqcsoOMpNhUXt3na+yQydDcuuagok9S1aAXt9sk5lDYivbYKdkb
	nput5C1uXE+RlZFozsh82H+GzMne7XcPfQzXO5PyQRkwHn/rGbffRnngkuPqm0yO
	hSQuFqnbbSzpbFYCiDxzA==
X-ME-Sender: <xms:UAgJaXpd-uH-kTS00RIHsQgUmRo4v2hdRVd_bNSk2aEsnwUl3bM2Jw>
    <xme:UAgJacc8nPsbXabsEEGBnYoyfK73yJcHrn2HHgMo2qQ_zozw6_laXJ3cXNp1OE03I
    Ww6wXvStyhLBlYESOlDGAgUQ6jTmEEY_-Ap0_W2mTe7cx3I8wv8pQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeeltddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedflfhulhhi
    rgcugfhvrghnshdfuceojhhulhhirgesjhhvnhhsrdgtrgeqnecuggftrfgrthhtvghrnh
    epgfevkeduveeivdevueehhfdvteeggfffudefgedutdekgedtledtvefhtddutddtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhulhhirg
    esjhhvnhhsrdgtrgdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepph
    hssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:UAgJaf8mN4p_cvHB0uCREiHS_ajXSDTt9sMN2d2N7SfsVABU_hThxg>
    <xmx:UAgJaY1xrrCEfvJhONXmRVG3P4SBAyh8_pMyVwsmRAV7qKuvdeYKzA>
    <xmx:UAgJacBgQ-znnhcwDbNMBD1eVKyIAcJyNIkXzawrBYp48nbwFrlYQw>
    <xmx:UAgJacf51SiGmqSt6TkSg-T-b-Km3sbVFds6SS1y6tpitIB7JM2kgw>
    <xmx:UAgJafOdzV7lxaqiafPgNkEVJacCHBDwn4NDS8_jEWp5xtjuxI-fUazL>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5043D780076; Mon,  3 Nov 2025 14:53:52 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AGkC0gJjnH2B
Date: Mon, 03 Nov 2025 14:52:37 -0500
From: "Julia Evans" <julia@jvns.ca>
To: "Patrick Steinhardt" <ps@pks.im>, "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <9ec9a2ec-d141-4c0b-8fd7-bfcd6a3f8249@app.fastmail.com>
In-Reply-To: <aQhcZwv0PdwNc6RW@pks.im>
References: <pull.1981.v4.git.1761593537924.gitgitgadget@gmail.com>
 <pull.1981.v5.git.1761856336360.gitgitgadget@gmail.com>
 <aQhcZwv0PdwNc6RW@pks.im>
Subject: Re: [PATCH v5] doc: add an explanation of Git's data model
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, Nov 3, 2025, at 2:40 AM, Patrick Steinhardt wrote:
> On Thu, Oct 30, 2025 at 08:32:16PM +0000, Julia Evans via GitGitGadget wrote:
>> diff --git a/Documentation/gitdatamodel.adoc b/Documentation/gitdatamodel.adoc
>> new file mode 100644
>> index 0000000000..1cefbb4833
>> --- /dev/null
>> +++ b/Documentation/gitdatamodel.adoc
> [snip]
>> +2. Its *parent commit ID(s)*. The first commit in a repository has 0 parents,
>> +  regular commits have 1 parent, merge commits have 2 or more parents
>> +3. An *author* and the time the commit was authored
>> +4. A *committer* and the time the commit was committed.
>> +5. A *commit message*
>
> Nit: The punctuation is a bit inconsistent here, as some list items have
> a trailing dot while others don't.

Thanks, will fix.

>> +[[references]]
>> +REFERENCES
>> +----------
>> +
>> +References are a way to give a name to a commit.
>> +It's easier to remember "the changes I'm working on are on the `turtle`
>> +branch" than "the changes are in commit bb69721404348e".
>> +Git often uses "ref" as shorthand for "reference".
>> +
>> +References can either refer to:
>> +
>> +1. An object ID, usually a <<commit,commit>> ID
>> +2. Another reference. This is called a "symbolic reference".
>
> Same here.
>
> Other than these two nits and Junio's comments I think this is in a good
> enough shape. Thanks for working on this!
>
> Patrick
