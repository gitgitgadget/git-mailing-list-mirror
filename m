Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8232417E2
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 23:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738883840; cv=none; b=WDAo85aLVouhKbEL3kzbO3OaQp3oTkO60Pu0DpFQDZxQ6UqoyIG7fw4wGRYLvf8b/1BHTMTnbXalWpEGSSgwB2TAalq9aKDgwjBk8fiEkmHsCoSbHPkpzQJCTLf3D1udXRpjc6RNya0UIu5nTn5pjS7HBCevyKiFkw2ucvkVymE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738883840; c=relaxed/simple;
	bh=iY7fOeq8NcheBoM6RPQdCO8zojDvVJOVHfEihhOpU24=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PvRWof7AHQtxk2emslCBZNhU9VetgsaFY1xFHnAohMgRwAc2GrTwP5Kur8vuzvsUQWyvrNz/Zoeirfvc6ZFtg9CeEvy1YLvcpke5hFZGYjFS75udxe3vu7QJJy3eyjtuxQiUm8qrPgojLLM2JNdpTMo5DUZpjSy4uP45AZaFinM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=u8hklwgC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=smjsH8BQ; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="u8hklwgC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="smjsH8BQ"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id B1E6D1140114;
	Thu,  6 Feb 2025 18:17:15 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 06 Feb 2025 18:17:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738883835; x=1738970235; bh=2y4WlrhVw1
	ctQr2IvQzE9HTnSmMjuLlDhx2FykvukXI=; b=u8hklwgCU7OJzYgFokcn1kIPot
	qHTJpcasK2q43JeU2ylar8CDJcNFa8hGB3pLRza9K1Hs7EmFUUcCcREfMcvEKnGe
	FW9OAUbpWf4x6zeJR4uV0Nx9gpgyJFzNk/bzdaWDgu/cMtCOp+iGZKg+y0J62R6X
	7+jAck62mfJiogrvbEhJxcYDAMERTmorHQIlqj6jpF2NvfdA46GoSDDSbEvxQKmh
	tazlPRM+bD2q3uVhuGDshfnrxMTcxthlm/cjShPX2HkxADnY4XxTYWy+EZphhrQz
	QUuXL72JwCkgQ37NKBfkFCDh4WWSB39HUeKKwrEA4JI9R0c3jx8/GA10WoFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738883835; x=1738970235; bh=2y4WlrhVw1ctQr2IvQzE9HTnSmMjuLlDhx2
	FykvukXI=; b=smjsH8BQQv9XSPs3QWHj/wCU+awUHtnv4HL4OkmaY9nl/RcEicG
	087BTnHQWltE7xsG4eSFL2viXyKEj+5gTBBJ5ujtGlFV+WKq0u85gu3a23m3LWxo
	ad4UDzkwy2DbYBJTamW1TIXoz6hDmgRcD1NlTR9HE2TC9S7HskL8pZY+QuJ+uv5A
	JTCERVQ4HQ5Hl2N3qiadU/6kdnPRzz11fMyUmdF7I4VUBIyj/2MABjjz8uFIBmWk
	27HYVgcOu/pzYhMU46nUc+H59qc6BmGJFs6PRB7l3doxImSuBvwdG+WjZpDwNnZJ
	XffZ6x+t48wQRvGCxNeS7El9zLpA/eJECCw==
X-ME-Sender: <xms:-0KlZ6Dc4JLpBtQ4oi5x4YE7ao0PcCag24gwCk-l01c5KBs7h7gGmw>
    <xme:-0KlZ0jMa_t1hdMf_qEKTTik62sipdkr0hIaUFZ_UJ4tHwaxmkYEty4QPT2R9xMqP
    J1_AivOfJnIY7XbNw>
X-ME-Received: <xmr:-0KlZ9kCL6AneUXPW5Dz5QOphQbW8up12O4MqImtkz_Wiqk7Zq8x3ryFf5lXxWh6H13uL_mBBpDwD1Uv4CEArx16MTyvTTte0q2b>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfef
    iedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggrlhhsse
    gtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehkmhhsohhmrghn
    ihesrghluhhmnhhirdhntghsuhdrvgguuhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-0KlZ4yYgoMi4Ndpcbpr7f6IruRMYjuKJR9WDUGU4nb0FHpS0-A45g>
    <xmx:-0KlZ_R__JgiyuMYC_m58pWhJwV69e38adGip_73wEtfygoXRsT7pQ>
    <xmx:-0KlZzZPTgwVJBlpSrpVq2MgXaGqkOOM1xlyG0Y2qF5WNXxNVAUz2w>
    <xmx:-0KlZ4TP5-TQA2VqSzQn8bh5L3zXWB43Yawme7VfAFVsXJfTNpRqlw>
    <xmx:-0KlZ9NKysp_7cBhnqaTEqSNt-QGHTDXRk-z9LVVZ_Dq5UpXVSOtM7Ck>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Feb 2025 18:17:14 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Kapil Somani <kmsomani@alumni.ncsu.edu>,  git@vger.kernel.org
Subject: Re: `git p4` broken on machines which do not have python on path
In-Reply-To: <Z6U1GoGVA7IiPg3A@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 6 Feb 2025 22:18:02 +0000")
References: <CANF_+=4dG7bVF5n+s4ezHR=HneeMgvYNhsOjsz7e7bFapG2f2w@mail.gmail.com>
	<Z6QUeaoH_tV2ncwn@tapette.crustytoothpaste.net>
	<CANF_+=7hM7QqLNE3d4=UO-8erYoeQwYG5SrsDTXtgqZq3AKJwg@mail.gmail.com>
	<Z6U1GoGVA7IiPg3A@tapette.crustytoothpaste.net>
Date: Thu, 06 Feb 2025 15:17:13 -0800
Message-ID: <xmqqmseyhddy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2025-02-06 at 02:12:02, Kapil Somani wrote:
>> Thanks for quick response Brian
>> 
>> Yes, our team compiles git for use within our organization.
>> I'll reach out to them and see if they can provide path during build.
>> 
>> Meanwhile, I was able to update copy of the git (compiled by my team) to
>> use python3 on shebang line.
>> It appears that the git-p4 is compatible with Python3. Is git team planning
>> to update it near future?
>
> It's my understanding that it's designed to work with both Python 2 and
> 3.  It's unlikely that the shebang will be updated until it's no longer

Correct.  The CI has jobs to try git-p4 with both python2 and python3
since Mar 2020.

> guaranteed to work with Python 2, since `python` is more generic than
> `python3`.  When that is, I don't know, since I don't use Perforce and
> don't maintain git-p4, which has a separate maintainer.

I am not sure what story about shebang is discussed here.

If the complaint is "your script says '/usr/bin/env python', but my
users don't have 'python' on their $PATH", I think that is barking
up a wrong tree.  As a general principle, we try not to rely on
"env".

Just like other scripts, we munge git-p4.py script to replace the
shebang line to use the path to the python binary specified by the
builder into resulting git-p4 "executable" file that is installed.

We do this (not specifically for git-p4 but as a general principle)
because we do not want to get affected by random customized versions
of stuff end-users install on their $PATH that overrides the ones
from the system that builders determined to be used by Git.

Is the complaint that "on my system there are /usr/bin/python2 and
/usr/bin/python3 but no vanilla /usr/bin/python installed"?  

So it is your responsibility to tell the build procedure that you
want to use "/usr/bin/python3", as the build procedure defaults to
"/usr/bin/python" when you do not specify any.
