Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94988175A5
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 09:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761902096; cv=none; b=Jh+v7mUl5Q8KizKOopZjAgUWtnOlUvcMx9efaVMW20MW0Fl2gRkcofB4RYmT1o93jIZjBO09FvfnfFkBo7r1HqOwobQPnUIXGsigBE3QCp14hWa5BwpzxuwJVTU6nkqcVj9grgnyDNUE/xmdrKxC8Da83YcNN3WGwH6jSdM+OzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761902096; c=relaxed/simple;
	bh=alNU0eLqGfrNnOMlH0b0yphZGWnHjesqXDl16c1X7fM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=k581tR0bfhvup0eag3F/gkHVFEJ9hcKqHWP2jB7gal3nq6Og07UKgdB514AUwqnjufdGFvItcQX8yPzRZseZE18aEvUA8M1E2JsMd4OpuKRAd4l7MyPmsxG4MC9wK15fnTPzORIikpAWZLXL0AFF856+CR3rAO9AhH1xbmSsy7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=DO89dYzw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EFK1G6wy; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="DO89dYzw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EFK1G6wy"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id BCC23EC0223;
	Fri, 31 Oct 2025 05:14:53 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Fri, 31 Oct 2025 05:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761902093;
	 x=1761988493; bh=s7tSr6cEpJ7d+dynCPEgwdVYLuoIwB/yDzdJKat8c50=; b=
	DO89dYzwArU72KwItsHmK1kSuSI57FvC5cMy7SFJScI+LOuppP4/dDoSMsv8tPPP
	Xw3vGMRAWj4SCSdTGeMBU5+plKPLkz/EZvPuaMw2si+JXzfl/zXwYl0VFh0uVFld
	2Y3RHZoLxvgGqJjZFVYR7PS3hfvMHpnZgxACwv0ZsTmovpUH0PGB43HARuMFhoiP
	MK4YJdykcF6IXZa9hDYtoRd0ML7pz3hiechwR8QoczfyrbjMJe9PwpzC8VGS7joK
	p465VIk9+tBsR+NO0mA/Sqyl+Nw+BGPc3GqfaAAqcbsq8nWzypZ1X8rY3q9n3cV0
	6FGC/mZ4bLH0PcneOGxsqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761902093; x=
	1761988493; bh=s7tSr6cEpJ7d+dynCPEgwdVYLuoIwB/yDzdJKat8c50=; b=E
	FK1G6wySHjnuVbCniRK7M1LmBE52TDEs6yU7X6/IIY5MSE5RtZriiLKuNU2FWDVV
	T602RENGbY09QAm25R/K+ux8JNA7gCWGajQv136jIIj3MFpo6u0MJbOMGJzG16KX
	4NiZAbuwAgSlg6z2J0CkbuC6B1Z+Ib/cyyiM+HYBy5ErV8m5zWqija2IAOl2ZRRb
	gNmzRp227OOLcuB3JQ4BIbKbiM/A5PtWyQS1kK+mGT0Ghbr1LDFYKMreFSZWcamW
	HSYbV6Pw4oI5i6eK4EimZybxPhsypeWgZTvk247g/2n6zzl4GJ1WBEzw0ze6/UZJ
	e3ljJQ5wjyfnv/qFw40Mg==
X-ME-Sender: <xms:DX4EaR4FgLQByOhPhakiC97WJSWJLsX1M1bgRbFi05F6KfvsZ8eksUc>
    <xme:DX4EaZv1UXbf1-IhqsIUCUhqKkj-wLKFCKmCtvXFNWU2S-iXyIuDklYlgBUT17jHy
    -3qyMXC29EV8pppDrdxJSTRhfTugvQmB1cjMSSOz56v90EcPHRM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeluddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehrrdhstghhuhhurhhmrghnshesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:DX4EacnvbWElEyYOXMHolQWV7ZPyD6ruqAdqEYmOWFO2WnpGzif4jw>
    <xmx:DX4EaZz3Y8S-uN41xvkh8ihoX0-yjtqJ_oQ4Qn0eXNvKE168mTsnFg>
    <xmx:DX4EaSMTneQUj0nTZOA4KPTWeyCZsILwkgI_L01Qy80gY6rO0AWzLQ>
    <xmx:DX4EaVSD7hHQwKcTCSxNY19aslHgXlki-Hw3xNedvMjAKgFr7ESHhg>
    <xmx:DX4EaaelnRYWURAEtH0BKQyIbtb0WhOznUXXsXXb5pdRKxjR7BAX7_cL>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8131D1EA0062; Fri, 31 Oct 2025 05:14:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A-58HFYM_TrJ
Date: Fri, 31 Oct 2025 10:13:54 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Remke Schuurmans" <r.schuurmans@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <1cea229b-f4dd-4799-ab55-d688d14a2741@app.fastmail.com>
In-Reply-To: <c2551c49-bcb4-4518-97d3-063941d591e8@gmail.com>
References: 
 <CALnivwfp+WTN3VKY1LQ+04OX0nwPSfKx4zyZDsCDeXg8ubEPqg@mail.gmail.com>
 <57ab19e2-9cc0-45bf-a3fe-c268c540a672@app.fastmail.com>
 <c2551c49-bcb4-4518-97d3-063941d591e8@gmail.com>
Subject: Re: git whatchanged
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Oct 31, 2025, at 10:02, Remke Schuurmans wrote:
> Thank you for taking time to answer my mail.
> I had this command still as an alias :))
>
> I'm old scool :)

You cannot alias builtin Git commands on the version you are running
(which must be Git 2.51.0 given the output you got).

But you can alias builtin commands that are deprecated on Git 2.51.1 and
2.51.2:

    git config set --global alias.whatchanged 'log --raw --no-merges'
