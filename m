Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A545217C7C6
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 10:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730715458; cv=none; b=KMSCdsKGgRmeYO21klBkBO6mnUpHf3G6FQz8fcgh2g30hayGLhf2x3skD3Ki/aP7x+j9MmAJ11bJeEqKPmUIEorFvyrY3sTh3RnhU36jxg0BCXdbtuRpUXQsC5sWELHD8NliASjwBnpYe64N4CGZKxoTXp4YYxFSQ0hLQ/yp7o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730715458; c=relaxed/simple;
	bh=z2k1govXxGADnsuWO4JIFa4V/5xDVq0vQL7gppyvbcE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fKGV/jHADjsrapFU/F1DqNpN43iWzCPdTlnTWJk1Tm8IVNOVXc1uzyecL4asnFmCAATFrUo1O2/yOjcLvyDYvxKD+6Cz1J+g11wZqcJGl8qlMCZz8vcao5J4szXzWNm+qX9C1fXNwKBsB01sf31zG1kD0d1nID3+GSo49yp3CEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ljSM6HSb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E7e8I3pp; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ljSM6HSb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E7e8I3pp"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id A436111400B3;
	Mon,  4 Nov 2024 05:17:33 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 04 Nov 2024 05:17:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730715453; x=1730801853; bh=UNKk0gFEQy
	/iDL/HQkhgZnaHEzvXU2CLPlHHIdkYpeo=; b=ljSM6HSbj5aOJinoTqBoE+vTvq
	hhrX18W0uIBJZ6JZxz5RJi9vwtHL7czSI12Pb2cEj/ZuiaWcNTmTs07Ce0hpPIy6
	GlKFqG3weQOzOvsIv5hyauK5sLdXK8OQbsHSdJFLtfjjjrdnCJP0llk4scCXVDlS
	EyaLlpZB1f5muz90VX8rsm6vU6Ls69f+00l2VrkXjmvjuw8UvEYJtnWVBhW0lqhR
	YE8HGRMMAw9Al5NpDa+kmrHBcHLpxvuWZRtxN1cLpyGTLwQvRUlop7cWFJpXn9Kx
	9iVsYkT8upSVQNQZtP5hyOBA9v1gfY08J+ShCZoG+4oUmqhekMI2OgtnfF3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730715453; x=1730801853; bh=UNKk0gFEQy/iDL/HQkhgZnaHEzvXU2CLPlH
	HIdkYpeo=; b=E7e8I3ppmWcmHS4XSjX19rh0H0FeaUUy52UHSjPUNjC8AYQwz2o
	1jDqa3utPbpPMDbmO+Ita273wGCyX9EWs7iLFH8iedKcpfoyAq9nz8zqkpz01s2H
	jeRO4GR/dtm/gBezhHAsK/CIxrtPqOImZSf+/kAKxl+Fyhj92veAWh7So+fcpt4J
	k/kgdXxYce0kVtFCggF+tAch7IsMGh8cpt+FumpAepnvsHr/6DEbbj0vZrksiIUF
	9s9mJABY5KD2wvuPYFMJFzSIpIii//KYQ2vZuDLqYrf9EIFd15enEKfF39hWi+JY
	imV3knJw1PNe3o/Kou7iFzIke3Hp6gjZaZw==
X-ME-Sender: <xms:PZ8oZ8hyXUvtUVL9fGMABwgdV3gZJFYUUkn4rHQwzF6kmaVLhHpyaw>
    <xme:PZ8oZ1CrP5Tz2XCe9-SR5G0k8CP7dHRfTGisSA88bGk9bRK0QQ99567r589Konw7U
    FjD_P_Uq--uXaHCIQ>
X-ME-Received: <xmr:PZ8oZ0EpJpi3BxUOTYenMlltjAbG9J-fk_Cfmh_TtOvVoJeo1xvcVJTuuE_WI1f54Tqgvm_IixIfEtYdyMlNbPJlF5kWNjTzZWkq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeliedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeei
    vddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhhsthgvmhgrih
    hlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:PZ8oZ9RiH7z41QIFoO4hX1waedgZwH0EX9vf4DL90DQAieHacsesqQ>
    <xmx:PZ8oZ5xQ23v2PYCXqc5upMqWNpsiTDP8pDA-rH043TS1HMrl0MgLng>
    <xmx:PZ8oZ74WhN9zgVY04cD1BN6Ocj9yxI0mCw3QmTxV-eOWzkjWVnQa3Q>
    <xmx:PZ8oZ2z0cQWhcLkdAT9rLiVQLWS6TtohRB1ZMZyn1kBonGIW-SWn9w>
    <xmx:PZ8oZ7skDTfu7Xin315xdyrC8dWmhXeFQUMzFSibgaX5meLk4037OzqB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Nov 2024 05:17:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Devste Devste <devstemail@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org
Subject: Re: 2.43+ git checkout --theirs on stash error - no alternative?
In-Reply-To: <CANM0SV3vNBwoNw08AevHE-3cOjUTG4AGVJdpwfKCr=CX5DSW8w@mail.gmail.com>
	(Devste Devste's message of "Mon, 4 Nov 2024 11:09:40 +0100")
References: <CANM0SV0KKd+WN4MQ1_8fEvFyD4tYY3qAUsUh9Njcy1xo1hNSBw@mail.gmail.com>
	<CANM0SV0Muk8KT6Mv=14ui07c6OzaNDDQwg2bUVRb8JyJWTyHnQ@mail.gmail.com>
	<Zx7O3VsZX2B9d9qN@nand.local>
	<CANM0SV3vNBwoNw08AevHE-3cOjUTG4AGVJdpwfKCr=CX5DSW8w@mail.gmail.com>
Date: Mon, 04 Nov 2024 02:17:31 -0800
Message-ID: <xmqqmsifwbes.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Devste Devste <devstemail@gmail.com> writes:

> On Mon, 28 Oct 2024 at 00:38, Taylor Blau <me@ttaylorr.com> wrote:
>>
>> On Sun, Oct 27, 2024 at 11:31:05PM +0100, Devste Devste wrote:
>> > Turns out the previous behavior can be achieved with
>> > git restore --source='stash@{0}' -- "some-file.txt"
>>
>> Hmm. What you wrote above here makes sense, but I agree with the
>> original change from Junio (CC'd) that using `--theirs` does not make
>> sense when the source is a tree-ish and not the index directly.
>>
>> This is different, though, since here you are just trying to check out
>> the contents of some-file.txt at stash@{0}, without `--theirs`. What did
>> you mean in the previous example, and why was `--theirs` necessary in
>> the call there?

> "--theirs" was necessary since I want the file exactly as it is in the
> stash - any conflicts from applying the file from stash should be
> automatically resolved using the hunk from the stash

But "--theirs" is to take their version unconditionally, isn't it?
There is no "if conflicted take theirs", or "take theirs only in
conflicted parts, but otherwise take a natural merge result".  At
least, I do not recall writing the code to behave that way.

So I am not sure if you are getting what you _think_ you are gettin
by passing "--theirs".

