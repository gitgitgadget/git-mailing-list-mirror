Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0D733123D
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 18:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791310005; cv=none; b=V/+xfgpPnb874Eze0iKXemKWJIgcQLEiPIoqYQhgZMx7V0qY+0FcrJO5a6AotHp5LMGXVwJfVbtvuaM3+dHtHaGLnsnqyNBhMJnQs3+W4EdMXaNq1mObEHgQU64PYYXnkdqZXldDhgpt1E8WnL6n5pCyEhcyHdev9ZJJh75EZj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791310005; c=relaxed/simple;
	bh=rf57foQy53aPPqI1gmMrpn/7qMsdhKNEE9j6KBgIgbc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hjg4f6d1s//GrItBnFXyrNgfw4iN5QIDcYqIuE/heSSld9bpqsPWbMJVmXnHY7Pe5GU1Laa2qEuzom3bwHLXwS9JO3nb5F9V94WymJLkBQx6WpIm9rRuY05FMCRU2e3u0lH+dOFCN7LaMtjO3Zs4rS7AEinlOoN64SMunzwFuN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=ZMZjK9Aq; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="ZMZjK9Aq"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6768ced47aeso1189731d50.1
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 11:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1791310003; x=1791914803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WyxC60HhIksLcHpNc6VholbmLS9cwnApBZ6FEmWYx/w=;
        b=ZMZjK9Aq+4dNMtcw9lgkqrBbQcRRoLGnmPZYFJBB4yhFerkH50BEJ9hFMEXXSvjur0
         FsAxcLTW7hxXUD1WP8XYDh3vt9Fo42+lF25CASz8/Mgsfr3+1j4tD24BHTHkMZ68tnSS
         sEY1TqDjk5m96mMXZUgw+OTMZTi4BISicZr/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791310003; x=1791914803;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WyxC60HhIksLcHpNc6VholbmLS9cwnApBZ6FEmWYx/w=;
        b=oESUTdjA3Zoada9KhWU7EBXBbcS2AmmeUONFdee0DsiyMrMeyuy1qZJcgHRwz+E6bN
         xm8AKPXWeHAzPVpMoWSL5fkJ95JNfGSNbyOGVkXTdFTfKgkTrrh0Hj3tEaK25HRQPwcB
         OLbYszR/zPomOCNPWti8DR2Xh9oDBRT+QhdWC8c1Eqi26YZI1xPPsQzrA9jG0hpDAKwD
         JuVEwjY4msLavhFvj3UUGyddv2K7hVE4LbEja79dSSMxvBRavrgPPdh7q8zKjT8fLwxF
         4wWTqJm/K64R+3B/Z11Mh1u5J6q1hqVUj/V6e0lwxAMILNzDV0za0dbi6pfwxbcPSh8j
         gUgQ==
X-Gm-Message-State: AFq9FYKFw1rsnt9KyO7cPR8DuaMU+G7/1D5tm4tZSu7Wbc+8ROcu2CEh
	af6oUHFmClWGCk7Y2Qa09/tpiMhnTnY8n6lKKjyELOViWIz+y2sm9wxt8HeLxgr4WoVxLPpjcEk
	Te+LZ81I=
X-Gm-Gg: AYBFou1hiRa+RVpUJ5U0ATaI8bwr1aS8j4MnTy2zX8kA7hGUOITpcg6O9YpTXyucP03
	p2CE74LO6jAZIkKd5sDgyBLv8BRRyqPfbrIDBY0/drw2zAXT1uWL8fDUR8DpqAgaL7ZrKVB4cWf
	02sv79SRepzVzHsT1RlURoFEGgX4VslJdIYlrGnT0Wx+k9fASKPoSh110ChqrQcVQH+xz5dkRnk
	qtu2i530js+QqYGPKUatIk6SnhctGRUf+KP259ietfwyTIjyhe/N5UF41X2+EUx5mwvm9T9HbcU
	CLy5+CvPYuqp2btGluU8xevy2gtu0nV2BCpUA38de8In1pLc1uxJqAwyKeoqIN2huUH3nlZf30j
	M23eVA1SC2VPUMALrcrzD1leh54FyVXinE/wCg66ohSAMOUajXPiWx6doeOusivik9UGdQ2qbMT
	fr6isKAfZ7A5bGStQFaanavvK0WA3uxacCv3+/p0Yqce9dO302i5REqKeL4KiuDXZMG6OxotjSW
	wVpdOWmVl06ywlaDs+p8QDhX7aoCe8gdhB81JCEy73i8g6M5kn7/u+DQ8xV3Mk3zMZbR25NzYUf
	K/d8h/uNx60=
X-Received: by 2002:a05:690e:813:10b0:677:ce4d:5b2b with SMTP id 956f58d0204a3-678fce3dac6mr986178d50.22.1791310002877;
        Tue, 06 Oct 2026 11:06:42 -0700 (PDT)
Received: from com-79390 (vpn-eastus-01.tradc-corp.com. [172.190.114.39])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917e0c06ec0sm118742876d6.37.2026.10.06.11.06.40
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 11:06:41 -0700 (PDT)
Date: Tue, 6 Oct 2026 11:06:38 -0700
From: Taylor Blau <ttaylorr@openai.com>
To: git@vger.kernel.org
Subject: [NOTES 07/07] Protocol v2 for pushes
Message-ID: <summit-2026.94e33e9ddf234334.07@ttaylorr.com>
References: <summit-2026.94e33e9ddf234334.00@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <summit-2026.94e33e9ddf234334.00@ttaylorr.com>

Topic: Protocol v2 for pushes
Notetaker: Emily

* brian: Some customers have millions of refs. Reftable has helped us
  push up to 100k at a time, which was a big increase. AI means more
  branches and refs, so the problem keeps getting worse. One customer
  was unhappy about an 896 MB ref advertisement. Protocol v2 for pushes
  would help. Much of the code already exists and needs wiring up.

* Peff: We were waiting for somebody with a use case they care about.
  Protocol v2 has a capability advertisement that leaves room for
  further extensions.

* Elijah: With fetch v2, it would be useful to request only a handful of
  heads rather than advertise all refs and tags.

* Jonathan Tan: We have prefix filtering for fetch v2. A client can
  request refs/heads/somename, and the server sends refs matching that
  prefix.

* Peff: The client needs a better refspec, and the user interface is
  hard. How do we specify the mainline? Even excluding HEAD can speed
  things up. This is an optimization; a push is correct as long as the
  objects are reachable.

* Peff: Could we use multiple passes, trying a smaller set and falling
  back to a larger one if some objects are still unreachable? Many
  advertised refs are not useful, such as abandoned development
  branches.

* [There was a related discussion about showing fewer refs in GitHub's
  UI.]

* Peff: Could a server-side configuration limit the advertisement and UI
  to a smaller set of refs, with the client ignoring the others?

* brian: It is useful to control what the client requests. During a
  push, we want to say that we care about only a handful of branches.

* Peff: That still sounds like a refspec problem; the default asks for
  too much.

* Jonathan Tan: This is push, though.

* Peff: The client could suggest useful branches more intelligently.
  Guessing the main branches is a heuristic, but upstream tracking
  branches might be useful.

* brian: A project setup script, perhaps linked from its documentation,
  could provide useful initial configuration.

* Jonathan Tan: Instead of a ref advertisement during push, it would be
  useful to negotiate. Restricting the advertised refs may cause the
  client to send everything if the optimization does not work. Relying
  on the remote to know what matters is error-prone. We would be happier
  with a few round trips: advertise capabilities, exchange haves and
  acknowledgments, negotiate the push, and send the pack.

* Elijah: During a repack, the server might give a false negative. This
  may be relevant to shallow clones.

* Peff: We could race and miss a common commit, then be unable to look
  further back because the client is shallow.

* Elijah: Geometric repacking may help because it is less likely to miss
  something. A push to the wrong place should fail quickly. Let us leave
  shallow clones to develop their own story.

* Peff: Successful negotiation could also make connectivity checks
  easier. We could cache information in receive-pack and pass it to
  check-connected.

* brian: Shallow clones can spend much more time trying to minimize the
  wire transfer. One push went from two seconds to 35 seconds because of
  that optimization. `objects-edge-aggressive` is relevant here.

* Jonathan Tan: We might get substantial savings from simply disabling
  ref advertisements with a configuration option.

* Peff: Even without a protocol change, the server could decide which
  refs are interesting and limit its advertisement. That might be easier
  than introducing v2 for pushes.

* Jonathan Tan: The client needs to tell the server that it wants to
  negotiate.

* Peff: It might not need to negotiate.

* Jonathan Tan: Would that not be bad?

* Peff: In practice the drawback may be small, though completely
  unrelated histories would be a bad case.

* Elijah: That can happen when appending a shallow commit.

* brian: I have seen that happen too.

* Peff: In that degenerate case, do these optimizations already have
  problems?

* Jonathan Tan: Negotiation does not have as much trouble because it
  starts at the tip the client is pushing.

* [General agreement that putting unrelated histories into one
  repository is best avoided.]

* Peff: Nobody objects to push v2. We have the hooks and the fetch-v2
  infrastructure. There may be an easier place to start, though.

* brian: Another benefit of push v2 is interoperability. Currently a
  client must push using the server's hash algorithm; it cannot
  negotiate a different one. Fetch can do some negotiation.

* Peff: If v2 makes interoperability easier, go for it.

* Emily: What is the failure mode?

* brian: Without it, the client must know the server's main hash
  algorithm and the mapping from object IDs in that algorithm to
  content.

* Martin Fick: I would like push v2 for automated replication, where a
  forge pushes to mirrors. Gerrit does this with thousands of targets.
  Ref advertisements are expensive when checking all of them. We need a
  way to know whether an advertisement differs from ours, so we can skip
  targets that are already up to date.

* Emily: Push negotiation?

* Martin Fick: The ref advertisement happens before negotiation.

* Peff: You want an answer in tens of bytes rather than thousands. A
  checksum could provide a small initial step.

* brian: With reftable, generation numbers make this easy.

* Martin Fick: That might work for this case, but assumes the
  repositories are in lockstep and covers fewer cases than a full
  protocol change.

* Peff: Would the rest of the push not fix it?

* Martin Fick: Parallelism makes that assumption harder.

* Peff: We discussed an ETag-style approach with reftable at GitHub
  years ago. It would be useful to see an implementation, and it could
  fit as an option in the existing protocol.

* Martin Fick: The server could also send a diff or a leaner pack.

* [Caching was also mentioned.]

* Patrick: Should we shrink the advertisement format?

* Peff: Perhaps compress it with zlib.

* Patrick: Let us explore options and benchmark them. We need v2 on the
  push side. We also proposed sending reftable directly.

* Martin Fick: A reftable could contain extra information.

* Patrick: A compressed format may be simpler.

* brian: We also do not want to send hidden refs.

* Patrick: I mean using the reftable format, rather than sending the
  whole reftable.
