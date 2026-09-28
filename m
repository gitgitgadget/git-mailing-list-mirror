Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF92C45FFA3
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 20:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790629134; cv=none; b=priT3RTwrAe5LlC6EPIaSEEJ4Rda/NTz7cI0/ohqvG/+XQs1SOn77t0Z3VPizJEPWp0BReJHuMwUKSGDEcXOFglO+Vy6jA5JMYvVl/VxHdjFyOLu2QbNRB2Q/tNtJbSxxvqWR9YIPcXIBb1xaoqqlSr+v79hQaLLzeBCnnsasNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790629134; c=relaxed/simple;
	bh=XZLucst4ROZIIEkzHhicZ0IWuRqfxhHKEv9c4L6JFKM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=t6rp2T1W0T6sIictwKXQHZjIFexiC3hQ51eqMWlu9xuFX7OuBy7ifB7iGCE+EDfv09Tj18Fa5CpfuHQhU2gR5ppor4a8889W/hdBQsP8Kr+TI5/K/l8yLmw17I+NxSVwPiJIpdiqNEHJkjasfybY+98jrB8LXq3VKilQOq64hg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=aV87A7V9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CtMD0Gwl; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="aV87A7V9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CtMD0Gwl"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 232BC7A0134;
	Mon, 28 Sep 2026 16:58:52 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Mon, 28 Sep 2026 16:58:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790629131;
	 x=1790715531; bh=FOnwYU4sobFH4DueFHHI8ipfQQLuCxA3Zng8PD3XJn4=; b=
	aV87A7V9wGo1vKYVZlpC2dRy8UyLbANZ1H4BOkAx0I+4mf7r214YP/Pf7/9odI5M
	jgqqIzTx/9E/N6wZ7MT4lHU2BFJWLlZPTUfU3Udmu27MYwgv5ZIQyysZJkgAHnVV
	F16+zCx1z1CERzjICjoGQAZ/2vxUsCFf202pPRDjGlOC2XKvE9KhpYn/Sb//3k5w
	IVDrQh6BqCTjVOQefnfVsTLHj/mvSkDiN6vQd+a9ipBDPtixlC8/e1cNmIWv3yVW
	fMH8SARgEiJqwcVVbKT0bWEtnHIwhKBeEI+Rbcz6yJbHxxNaExGHjxd2fSzNGOhl
	/GLxtH688LkvxFLAFqa11A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790629131; x=
	1790715531; bh=FOnwYU4sobFH4DueFHHI8ipfQQLuCxA3Zng8PD3XJn4=; b=C
	tMD0Gwl6sLjUh9azd3qJRrlsMtMr7UFka67gKEES8F0Il2sFbcryEea7z/oDcVVh
	ViGhiWwnsGkluF/zdRvxnYSp34GsuCrWBoCHu2Vm5WjIQHBw41wyG6vpqPv1sPpV
	Y48ER2U7eKrl3IgtBWBJx096bqRQN4G6rfZYSumNTxHApe39O3wIDhp2n2SNHu7g
	7G/4lrSqebAjHPOM9jIUvc3lnJ5b4DEHlYrCtI+73GdY5pWEYxvBkcsycylGZ5Ja
	JOdVGjvKO4CnRbgOrtgn8LvVQAnz/4MNNvC3LGyzqytWkIHtgtv+N8muvZsBpVFC
	hjL5xDIAoE7JPngBxX2rg==
X-ME-Sender: <xms:C9W6asi5HSz1MxnQslk1pVMx3M5gI-u7xYXX6JARag1M1K1-BqUBrQ>
    <xme:C9W6av2dgA3dXIi-ITsQROxok3uSpmE_t5PiMBGwkGbhyfAzClRJIOSp_n1vHQsfC
    -Wr5M8eah7Hx_uwNL98dx6so9th3UrdTVXd5bGicTaINnKxGUSg7Pk>
X-ME-Proxy-Cause: dmFkZTEaFF4UvFgtoT4o5kwY9cRrvpwQX1ZKZPkV+TAJ2O9lSabDOn9jBl+ze3iAniQCpZ
    IlJfOYuCmkKbdDOCBZ8VII2kbzSb1yLPHCiyLZg55KOYSw7zcqAp8L4tFjtH11zK47nbo2
    dlM0ygIwLRPqI897mO0JfJjCOs+of1xMBZkFAJPzMyjRYLMoJMSBda7BjzialSOWKJ6nx3
    Y0ciX0E55LeSIYlYjVa+eLBScHLGvMGIjtpj6cSlYTNaaA7BW7KxBj29LGewfKm3NCvzeN
    NpbDYBdRE7jwGZo0Lw/sdHFQCpnsb1HXypIqqyNYeV+vbaa8BEdFWUTIsfd+s9zJ941SjZ
    jJNLQwA75Ar9h/npddkjDTbIRYDssdGq5svMlury+TriTNYtWLncwY4tAuLeyJeWonSMsT
    //Xq/D7FDKP/ZSmkstAy8iorP0AWIQzwcCxbZMaGICfUOClwqFG0xCFHBX4ptvbI8XmqHd
    BhAHx1EOd7aW+gD2R8yIl/BsWKV4yIPVU/yoWMgYi8ZEs4l+BCgrBDsVM5M/9UjJzbnuiV
    5Tf4s0mdzWOerYq2SpySolXYYtPoUNGZjFkYndTm/RZzlnqrj4OqByXPchPz7GqgNtcpQP
    hgRcRGkrKZdXM005Df0AHgLxOgtirCxi3qhtYbl5gcnWBxODhh+Plg6W5PnQ
X-ME-Proxy: <xmx:C9W6avJG6bxRolje9a0TjK_2aCjtUkKqGKT-LC5SPiszi77qj3hXVw>
    <xmx:C9W6ag-vSCEM_sl2lTUtTAm2VdFqx7AVQIms6yAq3vcF77bjDBFlaQ>
    <xmx:C9W6aiI5T4q3-F9tBjS3QUaqOdqdGEPrihjSCFLuJ6W_86zdODLOSA>
    <xmx:C9W6alkt_oapwcTEnMp80MFnzjzBQCw_gxkRy9QXgDr1I3ibXh8kcw>
    <xmx:C9W6aqvjBpyFNL9hUV01FdHyH1UMMLPZNHtLd1-kXrhMJ2Q2_V-V6v-U>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A8FCE780070; Mon, 28 Sep 2026 16:58:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AJ3yMKGvzUL-
Date: Mon, 28 Sep 2026 16:58:31 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "Patrick Steinhardt" <ps@pks.im>
Message-Id: <cc1af300-d296-49c8-98ae-8b30ef11ada3@app.fastmail.com>
In-Reply-To: <xmqqpky1uu6t.fsf@gitster.g>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
 <03a6b43b5803e6bd9ebba1a49c34cb42202a7f44.1790261062.git.gitgitgadget@gmail.com>
 <xmqqpky1uu6t.fsf@gitster.g>
Subject: Re: [PATCH 5/7] [doc] git-cherry-pick: link to new merge conflicts guide
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


> The new document may explain how to resolve conflicts, but are the
> details removed from here that are specific to the 'cherry-pick'
> operation also covered there?

I'll update this series to make fewer changes to this page as you
suggest to make the diff smaller.

> For example, during a difficult cherry-pick, it is often handy to be
> able to run 'git show CHERRY_PICK_HEAD', but now users are not told
> about the pseudo-ref, which seems like a real loss.

I'll put this back for now, but I removed it because I couldn't
understand why CHERRY_PICK_HEAD might be useful, and some of my user research
showed that almost nobody uses `CHERRY_PICK_HEAD`. I always appreciate people
telling me why these things are actually useful though, and even if very few
people use something, maybe more people would use it if it was clear why it's
useful :)

My best guess (based on what you said) is that `CHERRY_PICK_HEAD` is
only useful if you're cherry-picking multiple commits at the same time.
Is the following an accurate explanation?:

> If the conflict happened when cherry picking multiple commits, you can run
> `git show CHERRY_PICK_HEAD` to see the commit that Git failed to apply.



> The fact that cleanly auto-resolved contents for paths are recorded
> in the index may be shared with all other merge-like operations,
> and it need not be part of the "how to resolve a conflicted
> merge-like operation" recipe, but users need to be assured that this
> is what happens somewhere in the documentation set.  The list
> removed here served that purpose for this specific command, but it
> is now gone.

That makes sense to me. One major benefit of making a
centralized page is that each man page explains different aspects
of the merge conflict process, and we can make sure that anyone
who needs to solve a merge conflict is aware of all the aspects. 
I'll think about how to explain that.
