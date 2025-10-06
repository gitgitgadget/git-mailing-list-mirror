Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15271DF254
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 19:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759778287; cv=none; b=ahXFyyT02gb5N/ebyGWdUtlKj6NRQK+4U/jpSClvN5o7WsGM4saOYYivMaY424mJtNKRQzonBiepMu/8uFqyuTXNCMB437vXbrRr5NhMBNsdkTKYC6zi2bQYNgLcMgfI6IoZ0LLtv7hhW+a6K2D6nKj/QbqeeMeAHQKxxKGulSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759778287; c=relaxed/simple;
	bh=cXIco8r3Rqpwo5tjWiJtvVJIvgqfY+MwQzXyvRBHrnA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWzDbhJLCcKdwyUVlmjy4Sl0fPgx30qWpc700VHNT2/v2j/Mz0oWFu5Vi5WJthxrV7nY8hj5u/cPqsl7wVmtYwhAHYyRLA8WhZbeFV/+z22iIfUgYDt1PGUodhDt2jZ1vCzERq8udzT+8sOpojadFgw4NLO4qlqsUCussQcKVx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=VYMYihFH; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="VYMYihFH"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-92aee734485so231900039f.1
        for <git@vger.kernel.org>; Mon, 06 Oct 2025 12:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759778285; x=1760383085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fbLvOahRh7H/MvxkyZXfAa94ATaDF0afxhwKerMGu8Y=;
        b=VYMYihFHzyGKnb9q+yQ2zpVdb6X39uuxHsWEyEuuhTLCyrssbnUZTEwIeFTWelWaoz
         SXPWKpXFwSSec9dl0W2/Y1x3vjOPq8cwZdRg2/jQaRxk6jwE9DdUmcv8qZr7hDvXYDYc
         PWofbc0UFz9UaL1SjB65hl4ZihQgO2sLGMx7cTiye/aYFRBhNJ9DMhv9ILhSYP1y228s
         7FzmXX7AuC0YNHUm7iK9WOBv7BSGvCpTeHqekUf+96V4HIzFGfZqIdDpx2k3qXPAK1O4
         VZ7k7zYZny9mHAuoqGzK05zr9uKF9D23DqHU+HIPxDvg8jZS7jpLnhhew+2sAJ63tBza
         r39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759778285; x=1760383085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbLvOahRh7H/MvxkyZXfAa94ATaDF0afxhwKerMGu8Y=;
        b=hKitot/16/NOIK4zrCE9Wxfw5/ELGiXmw746Paj7AKLPDQ7ZyilycOsXNbmVTUlj3I
         2fZMKH6kvPEhU5UNiasiXJlLsSBlzRfmJXFN3xV23GeqEha7Wno7Tr8DHMWd5eYSolL/
         Vhu+917ZIorvlC3k8egPxUIVRMNicR/0n5d5NIqLstIcS9a+iqcys5zCY7YwT0p+R6i7
         g2NCccLS5b54vvPhUlDbvHNlbDTy+okC7SOhFPomhZyLmNmPI/BOmwh11s5qzKn803dX
         1hBLlTNthojoE109nJAy0+PuC6305yPjMMzQX1WQw7qDmQjXTD/LqVz/GC6rj5V4XDQA
         KFJg==
X-Gm-Message-State: AOJu0Yzg6ZQtmuy05CYD4OKbsRIWz9dUkxKjZWjGgeLtGyiLuzDPRvVH
	pqLIkdzlCJtwuLTcuKyP11sNa5rV7lMwt8LllQtSUz5QSoAOw4LwKKU1JnqgNTjAZMXp2AqmCPO
	qkgCtTpMnyw==
X-Gm-Gg: ASbGnct5n1x6PFh8zfkuqYe2qCnPBM5pPYu3df/h3pKADnWzScpNbzKfxGDFvRfKs6v
	dsvqhNgES6NmFOlLOZ5YSYNJVj/vXlR65wiwnyWulgrgJtc5ewHeyvg3hjIX6RTIpdLwEnEfQQK
	rHDijukGQq3RWAZ2Z+nL1/Lxgk09YIyFdzFLK+bJ/8nNNkEhcsYzRwn7343uiqJvf0ez0kZDWYW
	WENjhpT1hrNeC7gaOmf+xvXHnoC9m4rxeqzpQ7j4dC2PEiuyZQrLZI0AIgYq5gjibNFbzEG8B5d
	W8NYbLJFZe5shRI9gVtf6xYYJ5csm9DwB/qEJf+FYWmiI9RURdxOBJv/RuCcLMM/fbFDITnPCjk
	q6Rnp2vlaICCnIM1j4WpFgCvbTO+gKdephz2v6DU3HPwpKLSliBvflZw5ySfm+gSP6tMSQoV4HW
	tA2HZttvxaeaopYimOe1+DOPdB4EE5s75Gmb2t2s7IqTu2EU3irg==
X-Google-Smtp-Source: AGHT+IGusxS5i7EA08MkC3tnjTP/0oUa2l0sGCTKRaKZYSITFPzGRYoobIQ1G/aViJGQDITBUuCfVg==
X-Received: by 2002:a05:6602:6d06:b0:93b:b891:d6e1 with SMTP id ca18e2360f4ac-93bb891fff8mr761189739f.5.1759778284306;
        Mon, 06 Oct 2025 12:18:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id ca18e2360f4ac-93a7e3a5cd5sm502375439f.11.2025.10.06.12.18.03
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 12:18:03 -0700 (PDT)
Date: Mon, 6 Oct 2025 15:18:02 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: [NOTES 01/11] SHA-256 and interoperability work
Message-ID: <aOQV6iM49QDhcC+C@nand.local>
References: <aOQVeVYY6zadPjln@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aOQVeVYY6zadPjln@nand.local>

Topic: SHA256 and interoperability work
Leader: brian
10:15am-10:45am PT

* lot of work to do
* brian is working on it
* it's progressing, not sure if we can get everything done by 3.0
* how to deal with submodules
	 * you can produce a split history
	 * accept, document, ?
	 * we need to have mapping on server or client
	 * if someone pushed one commit in sha1 and a different in 256, we can end up
		 with divergent histories that could produce security issues
	 * some private repos for open-core type submodules make this difficult with
		 submodules
	 * could have the server query, client derive mapping
	 * server could also be malicious
* if you're converting, how does that work in gpg signatures?
	 * we have a way to map both signatures
	 * if you're in compatibility mode, it will produce signatures for both
	 * what about for older histories, how can it be verified if it's only valid
		 for sha1?
			* it can be verified but can't be resigned
	 * for converting, can that work?
			* converting will retain the sha1 signature
* what is the simplest user journey?
	 * I have a clone of a repo in sha1, am I expected to run a conversion locally
		 and then I can talk to GH in 256 protocol?
			* you will create a new repo with 256 with sha1 compatibility and clone
				into that, which will convert it into both algo
			* download the data again?
				 * clone it to another directory locally
				 * it will preserve the sha1 repo and create the compatibility layer
			* let's say the local one has a submodule, clone locally including the
				submodule?
				 * yes, the conversion script will convert the submodule as well and
					 you'll have both ids
			* if I do a fetch, which do I need
				 * you need a mapping if you're talking to a server with the other algo
			* the mapping is only needed for the server if it wants to be forward
				facing?
			* with mapping, its only commits or all objects
				 * all objects
			* if someone trusts github, they can just consume it's mapping?
				 * the server and client will do their own mapping
* what happens if nobody has the submodule anymore? commit from 10 years ago but
	nobody has that submodule anymore, how do you make a 256 tree out of that
	 * pick one at random it doesnt matter
			* but you can't match everyone else
	 * we've chosen to use divergent history in this case
	 * Same issue exists with LFS objects
* if you have the old submodules,
* recursive/cyclic submodules?
	 * it's something we need to handle, don't have a great plan but it could be
		 done
	 * plan is to maybe have some pool
			* you have to convert the submodule up until that point, then convert them
				piecewise
* have you thought about mix/match where one uses sha1 and the other uses 256
	 * we can't distinguish the size of the object id vs filename
* right now you're doing the work, are you thinking of allowing another hash
	algo without having these issues again?
	 * the way the design works now is that we have two algos - main and
		 compatibility, but designed to accept multiple algos. if we switch to 3512
		 at some point for example, we could add another compat algo - it's some
		 work but the approach doesn't assume much about the specific algorithm
* steiny thought it could be useful to add a third algo not for security but
	speed
	 * gh has the insecure non crypto varients
	 * problem is always client support
	 * corporate controlled repo often also has control of the clients - so maybe
		 less of a security issue but depends
* can you put a sha1 link inside a 256 tree
	 * maybe an extra bit in the mode, some other interesting horrible thoughts
	 * would it make submodule problems go away if you could just carry the other
		 forever until the downstream decides to switch
	 * solves the submodule problem but not LFS problem?
			* LFS might be easier, you don't need to have the object to convert yours
			* assuming you have the object still
	 * brian not 100% against it
			* if I could do a 256 repo with a 256 submodule, you could parse it back,
				but if you do that, it's a different size and not usable by older
				versions of git
	 * if we were clever, sha1 trees hold sh1, 256 holds 256 and only when you
		 have a sha1 tree inside a 256 that we would use some new format
			* the problem is you still end up with stuff that doesn't work with older
				versions
			* degrades gracefully like a mode bit, worse case is that it checks out
				weird filenames?
			* write it out, take it to the list
	 * we discussed upgrading the tree object format, but it's so tight
