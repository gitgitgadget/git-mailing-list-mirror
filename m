Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054D83B3C10
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 06:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788156040; cv=none; b=Aj3LvNEpQbm4YLQU4+rnDXIKU7O7jBZVnnbGNJDYtSC4tTeOJHR3N9X07r9LeGOGLi7BRKHySYA6hzxgEyzFvtFzJJO2SRI3S4oyYiPjv671v0JLNagWwxQKz5/Wjdh6iV/hRjU7SloLepwGo4D8mQonhSfv05b+EnPijb+o26A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788156040; c=relaxed/simple;
	bh=4IJpZyslbDHsF+AOBe5UFKEkiUlgxNjqBoZnRXBWBGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8Vm7YdIoG7T7hA0pAPBuSyNQovLwtHU3quIu+9O79nyI1GhtnZE7kAYbuHwsS+lG9rqiZjtihMPAjDepg24XiW2UDgRguZ2vvusIICyWp4F1XmY9yPnzIZTOf1eXNWyQ2k1Q2LCb6ajNlEZWio6KijYZj0bHZNFiaFspK2YyJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Eeb4uRIH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BkRo8+e+; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Eeb4uRIH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BkRo8+e+"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 32C147A0138;
	Mon, 31 Aug 2026 02:00:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 31 Aug 2026 02:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788156038; x=1788242438; bh=YjT0oJ6KOd
	Px0020NW7VNWYaaFHy7uArQ2wCVkOetkg=; b=Eeb4uRIHB8/bRW03LYQhEDQyEQ
	f7Q8wyG8uFSRfEBabjSo+0Cjtuy6kWeTqIvoFXW5gzBDIbnaDUy0DJUvfHFgpaQP
	g2AnesLoBBB8edSw4e8qTT0rgeXnXz4s/F6AYicpXgr363IIWVyrf+UGRMuTEjH8
	h0nJmSOIJNOMmjOMWLa1bQnXb77N2CzolDcPWJbtK2PZARSOcuu4ZTtQBbIZfZx0
	fISuQmq9lQGi+1xiHcQbQbnSRWrHU9GYuwgexvOmmseGkN9W+2m5svZ4efpJKSk6
	LtPcRGYvN3TayfMt2gfq2ELCiVIUCyVyQ8Q9jUniqG5szGadso58mMRc8wzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788156038; x=1788242438; bh=YjT0oJ6KOdPx0020NW7VNWYaaFHy7uArQ2w
	CVkOetkg=; b=BkRo8+e+4/5oSE962f/oDANMR0xTFNKfEeRMgxY0e3jmJ/g1lU9
	ul2+vqQMjbo+ZWIXqV/8GAMhSu/4VGzzmxKzSQG9TC+8xnzzPaUzpiEfrpF9dU/l
	OYXfLeDoA2brScwI6NYi382cdCGP+DN40rorPufpV9kYq0s9/4l4Zi8WjnTfTssc
	6ieJYkDVcMih3L05bD7aIEFtKaQ9XCBciNLLHsVVc+adbqfgmqB3nga7nDQHGX0A
	YrOiYZYKYxF7HN3/fdTIA2xfPNHHXfhv2IHzzYJHjY6ac1k9ADw+pfB4sznBQ6dk
	4sZUvP1bZDEh6WT5lDsiiMKNFCoTFi96nww==
X-ME-Sender: <xms:hRiVakxr4Krr8SqqhdC3vNwxyXG69abeUMXFEJJMe7LonTMd0CSmPA>
    <xme:hRiVauSWlwylBLmnVUISicOn0Fler-TCmXoRKrUToS4Nqead_ZEOW43yMpwZaBrl3
    EsR9rVy6K6luR8vb69V9sfJqD2N7qZRBZPp5TV5Z8mP-Z3wPsM6Wg>
X-ME-Received: <xmr:hRiVaj8NlZRsF0jjzZsmrNf4vvyOd9_5WeakDYNgbqp5dJ2BqG6L7HvukC9rWeSV2uiKwA>
X-ME-Proxy-Cause: dmFkZTGRrc/w/LyLEw89uV9Ke3SE18xmG6iVlp9uMrMUKG9EAZ2dTprR/goEVcwWww0Ik3
    gfm9nhxM2s62kdcZ/4RQhfzNhH1xrd/zBzH+bYztHVou4a3z3q1JICSnoRb5BdpqB5Noyx
    W7zstf8dqNUYLSWljObupyy4bOUyBD2oScZowgwrYUAHqRfANmvUwfUzpA4QeH/opuZ9iF
    ir1JEUPapFQ9Fy9AltuUsrnGDwl9rBaHV59h5+OuMyfix7/wHYc6fOB/z30cECA6x89KCm
    ANULxC+IaSbngYJUCAh7uyNy0RJL/OFaWO8XOnlY4bo2beuiclvyW8B6NqXbnw0XVwFhgI
    0dlPHddNui5m1UW6pPyQ5oEaO/mj3kvXrjna77KcuhtBUc1f8DB0Y1TrEnHKGgnN3KCJ9P
    /q/48kl5/Z0fNVWU7MYWxmNfBkhsOV27F3zK3GmfZEfjgc1c/e7QMZh+vK3lcvzMFHuspT
    2VgvYrnFLXG1YcJ2g+h51UWx/Yd01EnOEEumnFLHd/vHE0TO9YYH8Kq1Qy5tRTiSKaOORu
    cOY8yswNuF0oSCpdZ9x8IjHj4uADOLcj3Z635EwI3zS4XtwZSBk8THD/2ub6DwqzjBamZw
    P6skimG+IMTYP2+DxgIy7ELB8AchRKARkxaYgPBGoJbNM4H2/lMKi/gfKxYQ
X-ME-Proxy: <xmx:hhiVatqGSy1U0te4HO8A0zhfM-4OSP8d0DWouFEhVbeSjO8tuZH8MA>
    <xmx:hhiVaonEDmtme4lJai-ryIFWTETQz6YEyKkxxuTPbEHFLTAa4V7d4A>
    <xmx:hhiVasKvwHNFBgDTrqAKdQ19eUM9fF47cLdxo1u9s2mFs9EJR8BjhA>
    <xmx:hhiValzUX4XP5t7Wnrv4yed5cK-OjqW5vpPTYMY3A3gWwULB2Ztmcw>
    <xmx:hhiVagg7QIlTnvgLogTg0nb9Ma2K-YU2nIR2Q2uTBOOdXlmbDfNKSDbG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 02:00:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a30be486 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 06:00:44 +0000 (UTC)
Date: Mon, 31 Aug 2026 08:00:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 04/10] builtin/fsck: don't check alternates with
 "--no-full"
Message-ID: <apUYgMoYbTWoe2W9@pks.im>
References: <20260825-pks-odb-source-fsck-v1-0-b756de0bf24f@pks.im>
 <20260825-pks-odb-source-fsck-v1-4-b756de0bf24f@pks.im>
 <CAOLa=ZThFKpbmifU-zScXqiT1QSQqCTppHWbgSqmpRft8K+0XQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZThFKpbmifU-zScXqiT1QSQqCTppHWbgSqmpRft8K+0XQ@mail.gmail.com>

On Thu, Aug 27, 2026 at 06:12:13AM -0400, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > According to git-fsck(1), the "--full" option behaves in the following
> > way:
> >
> >   Check not just objects in GIT_OBJECT_DIRECTORY ($GIT_DIR/objects), but
> >   also the ones found in alternate object pools listed in
> >   GIT_ALTERNATE_OBJECT_DIRECTORIES or $GIT_DIR/objects/info/alternates,
> >   and in packed Git archives found in $GIT_DIR/objects/pack and
> >   corresponding pack subdirectories in alternate object pools.
> >
> > So ultimately, it is supposed to control two things: (1) whether we only
> > check the main object directory, and (2) whether we check packfiles.
> >
> > In its current state though, the flag only controls whether we check
> > packfiles or not, and if so we verify packfiles of all attached sources.
> > But we also have checks for loose objects in git-fsck(1), and here we
> > unconditionally check them in all sources.
> >
> 
> To reiterate,
> 
> without '--full': Check local loose + alternate loose. No packed objects
> 
> with '--full': Check local loose + alternate loose. local packed +
> alternates packed.
> 
> And we want to only do local loose in the latter. Makes sense.

s/latter/former/, but other than this: yes.

Patrick
