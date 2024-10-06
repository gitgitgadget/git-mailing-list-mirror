Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ABC155A47
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 15:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728227750; cv=none; b=VgLTUEa4M8WjMTBWlsViM2u30fPDtKZ3PYJMaLh47XIaWqGKvyVtgyVLokBl7n53f7a5MJvJPJKgf6iBK+q9l7oPr37Td71WIAJMugOBY8OQEOw4nMqdl9ZCIbdDMnbwHuWZKM5kiurkuMS/Yfs9cSf98B7pVZaknim6lwYAaGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728227750; c=relaxed/simple;
	bh=zTCbipRyrVMg/ZjcjVj0eeu6I2PR3FSgeF+2CpGbpoY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LfeITMu4IwHvCslFE5j5LHRmqF1Eaz1ptMHAuIG++2JM6AB1v/TMe9Pj3b6rXtEjAWnC0cSaH5gDUpMaGBb4Go37PyLy9lM7LrGjwnjKZBevfhblLBUPmK+Ic1bTXhzaTlDXL+yX7Pj3dS/EHlrXTjElvevrRvwOdHksugUtWYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=dDjlsipl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K/+k51uX; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="dDjlsipl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K/+k51uX"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id BB00413801BB;
	Sun,  6 Oct 2024 11:15:47 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sun, 06 Oct 2024 11:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728227747;
	 x=1728314147; bh=y8zTNMI/+/k7F8saW9H5Z9U+v9OT80sJ1WRAUZleNoc=; b=
	dDjlsipl1ETuRPhZ7NtR0SPnlAmFmbmOdHSBQ1qJgvuAevi7sNclrQ0HispRTvsi
	0oTUQoSX6NLB5U3DDk+ypvj/AVvrgIggMaCUbjMT45yRBTkO6R/7XTdI11gE8mjQ
	JwpOY48ELsBAYn0Gzfi7SZsOfH167/9cPXLshp7hjLuk3IhfVEB6LEyV0ZQtCpyG
	kYx6CZgEqeqW5sEIJSnkQQFUEZdeY9LkDwJ4m6Glhj+2V+mlB3jVg+fSS73s62VZ
	gOij1r6Ht8J+pmYZWxXd8tS2P4rGTGWWABavCazpPlFTOnyHOXqZc55aDirCfxeX
	r2wsfycvTo/vFYic4hRheQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728227747; x=
	1728314147; bh=y8zTNMI/+/k7F8saW9H5Z9U+v9OT80sJ1WRAUZleNoc=; b=K
	/+k51uXMdJh3bQIk51A1PfWzFjzKMYmZcaNLq2FYiMQ+PFxKzW1IgFJF5bXtJQwX
	WNvR9inYxLA5t5dmqfZLRuL6Xj3jfR1hhMRWIJSOOws1s0cwO1q0VaUEe/jQGrju
	ppwfnvrV5mSig1XadKXiezgHU0RzWoVyFQvcaQLJ9m0P54XZ+SBb9z/oVPKF8Exc
	a3eML0PqwEUwr18kqlkMGXzok6IFixIStM/TFocONBYpvSKaIpu/EgoKY8bWEOdo
	nGQiJJLwOuNThJwVlWqUoZ4kCHhXdPgl6pDRDYgQesYaQdnITjIg2NXBRZfiUa0+
	tw7wKx1QBa9XvECKBBSmA==
X-ME-Sender: <xms:o6kCZ3d0D8uvSJEB1m4INHK1KQFxgBJNiMAGUG4a5cC0771BYTt4QNo>
    <xme:o6kCZ9Oc4S_beV7vCYS4A0IWI3ZPiEY2SN2NNp-XJty5bU2mD53a8MmeCTIIl3sbi
    9OZVRmhTEBLbGO6kg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvjedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnhephedugfevgfefgfffvdfhffdvveevgeehhedutedvgfeuffejveejudegve
    efvdefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprh
    gtphhtthhopegtugifhhhithgvfeesphhmrdhmvgdprhgtphhtthhopehsuhhnshhhihhn
    vgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:o6kCZwiw2ZlUeuHhxoYFUSOPeAzT8gaGMmz_x9hfr2hJgORc1NpviQ>
    <xmx:o6kCZ4-PGpJT9dvR_wZqRe7IQfNF_THcmTuq4UMyxQWrWfpu6XBdEQ>
    <xmx:o6kCZzteYagG-jzZXbpRXuiOd3mcqBqTm4ty3arLLuoW6jFpHtLTJg>
    <xmx:o6kCZ3G9aLUePIR2rwEycyaQASv3oSDieKq8YUXP5slDn_JVN_WCkg>
    <xmx:o6kCZzIAJ-ZqjvAqvgpXnjU5-YRYhkgu0AG1CKztc1klU_yflPPuZvbS>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 79060780068; Sun,  6 Oct 2024 11:15:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 06 Oct 2024 17:13:25 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: shejialuo <shejialuo@gmail.com>, "Caleb White" <cdwhite3@pm.me>
Cc: git@vger.kernel.org, "Eric Sunshine" <sunshine@sunshineco.com>
Message-Id: <b5bf4d46-1357-4584-b5b0-012db4626cc3@app.fastmail.com>
In-Reply-To: <ZwKoNg-HYGaohvCd@ArchLinux>
References: <20241006060017.171788-1-cdwhite3@pm.me>
 <20241006060017.171788-2-cdwhite3@pm.me> <ZwKoNg-HYGaohvCd@ArchLinux>
Subject: Re: [PATCH v2 1/4] worktree: refactor infer_backlink() to use *strbuf
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024, at 17:09, shejialuo wrote:
> On Sun, Oct 06, 2024 at 06:00:57AM +0000, Caleb White wrote:
>> This refactors the `infer_backlink` function to return an integer
>> result and use a pre-allocated `strbuf` for the inferred backlink
>> path, replacing the previous `char*` return type.
>>
>> This lays the groundwork for the next patch, which needs the
>> resultant backlink as a `strbuf`. There was no need to go from
>> `strbuf -> char* -> strbuf` again. This change also aligns the
>> function's signature with other `strbuf`-based functions.
>>
>
> I think we should first say why we need to add the change in the commit
> message which means we should express our motivation in the first. It's
> wired to say "I have done something" and then talk about the motivation
> why we do this.
>
>> Signed-off-by: Caleb White <cdwhite3@pm.me>
>> ---
>>  worktree.c | 26 ++++++++++++++------------
>>  1 file changed, 14 insertions(+), 12 deletions(-)
>>
>> diff --git a/worktree.c b/worktree.c
>> index 0f032cc..c6d2ede 100644
>> --- a/worktree.c
>> +++ b/worktree.c
>> @@ -642,10 +642,9 @@ static int is_main_worktree_path(const char *pat=
h)
>>   * be able to infer the gitdir by manually reading /path/to/worktree=
/.git,
>>   * extracting the <id>, and checking if <repo>/worktrees/<id> exists.
>>   */
>> -static char *infer_backlink(const char *gitfile)
>> +static int infer_backlink(st
>> ruct strbuf *inferred, const char *gitfile)
>
> This line is so strange. Why it generates a newline here?

The patches got corrupted by something.  See the emails from Eric
Sunshine.

This resubmit didn=E2=80=99t fix the issue.

https://lore.kernel.org/git/CAPig+cTB-sA-g4cdhfEjWwY1mnbWJ41e=3DbOCNwp=3D=
Y8JKvpmpRg@mail.gmail.com/

--=20
Kristoffer Haugsbakk
