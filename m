Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AEE1F91D6
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759075068; cv=none; b=HqPC3kUzC8Ewz+O77PypXNDiNL5PEQ00iXYaujb1s9F9aOsaQIbj+2q2i65vAKDalU29cveBrt4xxuLa+KNLkkCbpsKKQgIy7JS7P+Y31ufW1WzeNM7PsIb4Bdgvd1gwn4BRZnlnMBkwwIuCFV9Pz1JfQFxvREVLLI6ThZgRp0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759075068; c=relaxed/simple;
	bh=SfayapPmVVCiY25J3I+olzwcOlR5BRpUHcnfbbvl7Hk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iBjp+ttOVlzS3TF4aEj6LIXAqD+oknOUXkG4VYQyN2uPN+Hqmc59BXQWcLBBOQvryCGgDkQ1GvnwPlneogZ5ZNn/xJEAcRVreps5P3sENNjlu8jkA1N5jzO3AdhIXy4g2alq/1K2DhoFj9i3E63N9MnOiwEWsnPylpHX/LqYtcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EcItjI4I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gk5Yxhci; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EcItjI4I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gk5Yxhci"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5C5117A00A0;
	Sun, 28 Sep 2025 11:57:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sun, 28 Sep 2025 11:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759075065; x=1759161465; bh=IgyBWVqvIw
	MbNOfil/m5Zz7Jvle0sjD3N5nA7lxo0jw=; b=EcItjI4IHnGMfZgLlrl7VAG/1Q
	NuzejA7wDO3hi8S16bGjsWue6kigD18Fcw8/Su/eA4ftcqcpfOpZRRpwKk4BNpgB
	FvWWb6hQlyDFmL29k0bWRQFKWElEanV3t3QT7AJmCogVyetDI3CSN7fIdknyYe0Y
	r3JYr3kVe8U8CW/o/kQv6hBWhfZnrT7WmuVSZT4xy1XVuiMqyWrNZPWVvL10JV38
	YscCv9QUeHt1nlnzS+6J+uYBR560LhTxer1S1Uq5nGBkYTi03q+UssWuB8RQXOwg
	aiQkcWuN9is1NC+REWeZFpQRmFgz8MlcpLCowH1SXsmsDn3YV2JKM/T321iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759075065; x=1759161465; bh=IgyBWVqvIwMbNOfil/m5Zz7Jvle0sjD3N5n
	A7lxo0jw=; b=Gk5YxhciiTxAjJU3q8fDpGDUTJgOugO1zHwCR6SYJJf8DFh+S74
	fEf5x4/sxfvFAcTUWyQ9rmSYD6fEYLSSbaoL1ACzQSFcISdBI5l0OGOT+wbVeGyK
	haPOoT0c4JoPAf5irZpe7QvAg0xxhrA+NIo8HsSzvrR8bV35hZzVs20HZLWVJlYq
	M7mmvTewljqeV3YvwtuTK9QsfGZreFOWqEIKnWfGp7AIq8W1e3v5wu4btQFixTdE
	/jXl5+rSsC9CdwnPng4DmzMNHHU3tMILzX7q/M19M7w/o7WKqx0zcYDVw3awAXLc
	a0pNe4X0hTpJ5ywFtyqFoK5ztZsZLAU6w2Q==
X-ME-Sender: <xms:-FrZaM8-HSshCBRLYZ_Ssd4ct3H85eCQYZq-dfmgQyf45w7v7eT7UQ>
    <xme:-FrZaLt45G3DGmUjpcnsjQ1S9gFXMiSHM4DfzCSkGCkNv4NgF7PCtXL55uGtbwB2Y
    eYEZwUujr9QOPVVtDhDvTZ40Yl06nJAEnKdpfwj0mzXG8q-aC2WNqU>
X-ME-Received: <xmr:-FrZaHB3DfMqP_KxuJUXspQKxdKsSWLiRfX9YmKejiTgyZChQ249IGDqDy8b6rVBAIoFKBZaos_7PqY_A3_g8kE__vTiUOxD7kag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejheehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehrrghpphgriiiiohesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjheithes
    khgusghgrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-FrZaLWIaqpoml6lOqbAxJZ9qiX0319RQfAydVS4qBGx7Dt5QeCnJg>
    <xmx:-FrZaNAITPBZ9XQPhcJGDRYPbV1O_5nxn7ERw1GFapGOl9itc0Zl6w>
    <xmx:-FrZaG_uoG7alNIDage9eB03dShfniW-YQGyKHwnURqScD8y_Us_Yw>
    <xmx:-FrZaMFS_EjespAbWTzBJvH19dA-rXE81VZnMOrhmXfVyHY4FS5Edg>
    <xmx:-VrZaI_7NCEnBZam6aQegUHGPVXfZn95Pg502PYYV_n9pn8-Sqy5v_wY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Sep 2025 11:57:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Rappazzo <rappazzo@gmail.com>
Cc: git@vger.kernel.org,  j6t@kdbg.org
Subject: Re: [PATCH v3 2/2] gitk: make Tags and Heads window geometry sticky
In-Reply-To: <20250928135435.59623-3-rappazzo@gmail.com> (Michael Rappazzo's
	message of "Sun, 28 Sep 2025 09:54:35 -0400")
References: <20250928135435.59623-1-rappazzo@gmail.com>
	<20250928135435.59623-3-rappazzo@gmail.com>
Date: Sun, 28 Sep 2025 08:57:43 -0700
Message-ID: <xmqqbjmu7eo8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael Rappazzo <rappazzo@gmail.com> writes:

> Currently, the Tags and Heads window always opens at a default position
> and size, requiring users to reposition it each time. This patch makes
> the window remember its geometry between sessions.

As the second patch in two-patch series, whose first step is a
revert we just saw, it is unclear what state of the code "Currently"
above refers to.  Has it been that way even before the revert (in
other words, even with the ancient Tcl/Tk 8.4.1 workaround), or have
we briefly regressed with the previous step to fix it correctly and
this is the right fix suitable for Tcl/Tk of the modern times?

> This change saves and restores the Tags and Heads window size and position
> relative to the main gitk window. The geometry is stored in the config file
> as `geometry(showrefs)` and persists between gitk sessions. The window
> position is stored relative to the main window, so it maintains the same
> spatial relationship when the main window is moved or when gitk is restarted
> on different monitors.
>
> Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
> ---
>  gitk | 39 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 37 insertions(+), 2 deletions(-)

Nice.  Very well written explanation that tells why this is a good
thing to do to those who do not even use gitk very often.

As a pair of patches to an area with an official submaintainer, I
won't touch them and instead expect them to be fed via a pull
request once the reviews are done on them, but it still is
appreciated to see patches sent here for reviews even when the
submaintainer is part of the team that authored them.

Thanks.
