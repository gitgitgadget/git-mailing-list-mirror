Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB5C18D65F
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 06:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723701709; cv=none; b=tMYF+4az+VW5UOX6SqDCqNrwhy/B7kO8tpQnkUqomNTrCa1CrOB8JeHGz/fVH8SN7W3BQLAbKrQaBq+dTMkHolMRRzLBqfww7297yVmrA77LrMPhz5rpqYtCaAbi4+/pC2n6GfD4OeVAyCETgHYQRdTxkaNYP13k/JKroUNNAlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723701709; c=relaxed/simple;
	bh=JJx/tD+4etBnufNNMzTczagTt0r/475O0hLEyghPzkM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=ZjruaiJ23hUGBfJSAkn69PwjdocjS02PTwX4+SciX7XB7nNqewIURbITnzn2GaMk2PsUYhmL+e3AaztH9riWfULIJ32xQxwX5pqamP4V8x2aUPTbdP/4Y+w9r/XDfzDDqPwT9I6ayBf9H27QlIpj09Oxy5aQ5PbK7mGUSWoTdow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=gPP4VLN2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FNcpjOUe; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="gPP4VLN2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FNcpjOUe"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 582451151BF8;
	Thu, 15 Aug 2024 02:01:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 15 Aug 2024 02:01:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1723701706;
	 x=1723788106; bh=5AoFxZIamW96LEQhWUS0r/UFC5tBsAiLTcUgVGwzZEc=; b=
	gPP4VLN2kk4aJHOcM49Fmsh8iOqnmWYaMGdgVJvJ0OM6wOYoqdHRKnelO3rou9rL
	iAbM2RVS3/qqtHnEu607ETcO2Wqvuol43xq8JN786+KgFPyI5z0du5x0ZO2GSoqr
	yxSpeopkWwiZNWZUnliH+8RunpAa/sZcfhruNKme8YYw7D55i6RR3uxrHCxv+1et
	XGu5Hl6eXw/T9AIrbxSOPyGuzduaQfIIyxUpmiW6Yuai/iKlufNqPlic2sYU7xaC
	kn1uDctrGEh/KWz+f1hz45Ur1yRcFW5j6FAX/PAYwC26eJ1ZIRwKyQSFLRYZftDY
	FV9GDGJh5d7jFphaZz4dYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723701706; x=
	1723788106; bh=5AoFxZIamW96LEQhWUS0r/UFC5tBsAiLTcUgVGwzZEc=; b=F
	NcpjOUe/fW0uYh4cMIB+Uu3ZT6QXjN+zrJw4iHyZw+F06vVmqmm774MUdvLt/Ddu
	cleBh7gAYEnMePsVtPfofseQG+7edpsmC8ooz+Tb8rBxVVo5XpHhoe1csUSrkeBp
	GcVgMeOmGq05cGczZBmTr/jYmsIEVdBrGJruIPbA+cLxvZn15KVkuzb4s6jDLfOC
	hoDLwQzMPV6FtvCs+gbsukcLKTVaYVgH+pLAD+BcIFtF1P3Fa+LCuB9Ml+HZYwn7
	Yg6BjzNWWhOMMdmKkgQ0orU70LsW1gGbktyh5Vq4kW2uQUIF9SJ3zATsTRvn4Smo
	jW7hXKGA7tejngd0cvj6w==
X-ME-Sender: <xms:ypm9Zo9x2ukH657fzAGPP1ytyhKA_5DRlAGkzExpdNFG3SybYUTTBQ>
    <xme:ypm9Zgvw0s1HsXYyLZDZQsa7YcvykrTZAm6SWh0joses4JkATDqkVS_1kC7InKT9H
    8afKCTZXSLe42MiHQ>
X-ME-Received: <xmr:ypm9ZuBu_vFaUW5Cfvwi-tMlNrCm5OyO15ifioskCDKN_Cn_B7Z8GVxjwKvW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddthedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpegggfgtfffkuffhvffofhgjsehtqhertdertdej
    necuhfhrohhmpedflfgrmhgvshcunfhiuhdfuceojhgrmhgvshesjhgrmhgvshhlihhurd
    hioheqnecuggftrfgrthhtvghrnhephfetueehudeltedtjeekudelueeihfevheeugfeh
    hedvieektedtvdevgeeileetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdpnhgspghrtghpthht
    ohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ypm9ZofhVVzD-yuuVGE7GCjgdHynWwR96PVFh3gMdtVNZWj-DpU4Fw>
    <xmx:ypm9ZtMU6K8k4gLp7tIaHWiwpWk9wfiLHZdOMQ-Bsi6v_4cQxeIWBQ>
    <xmx:ypm9ZikM8RUyVfcvtAziNWifXicmg2LLPm1A6xofbfo5yE5Dzx2Skw>
    <xmx:ypm9ZvuU-B78geXOgUZFPzal80Kv9jsGlLGuAT4uWYKlx8lPXPUsBg>
    <xmx:ypm9ZmbJI56iMW4yjcV7xilsowAo5LkYoCAzcOqEYCeT2V9-fKrmSJW->
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 02:01:45 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Aug 2024 16:01:43 +1000
Message-Id: <D3G99ASPVAJC.BIWK2TH6EIQA@jamesliu.io>
Subject: Re: [PATCH 4/7] builtin/gc: stop processing log file on signal
From: "James Liu" <james@jamesliu.io>
To: "Patrick Steinhardt" <ps@pks.im>, <git@vger.kernel.org>
X-Mailer: aerc 0.18.0
References: <cover.1723533091.git.ps@pks.im>
 <812c61c9b66d7608e41c6c1d00a6e22e995cef06.1723533091.git.ps@pks.im>
In-Reply-To: <812c61c9b66d7608e41c6c1d00a6e22e995cef06.1723533091.git.ps@pks.im>

On Tue Aug 13, 2024 at 5:17 PM AEST, Patrick Steinhardt wrote:
> The consequence is that "gc.log" will not be committed, and thus
> subsequent calls to `git gc --auto` won't bail out because of this.
> Arguably though, it is better to retry garbage collection rather than
> having the process run into a potentially-corrupted state.

Ahh I see, because `report_last_gc_error()` won't have anything to read.
I agree it's an appropriate tradeoff given that garbage collection is
not on the critical path, and it's not likely that GC will be
interrupted on every attempt.

> @@ -807,7 +800,6 @@ int cmd_gc(int argc, const char **argv, const char *p=
refix)
>  					  git_path("gc.log"),
>  					  LOCK_DIE_ON_ERROR);
>  		dup2(get_lock_file_fd(&log_lock), 2);
> -		sigchain_push_common(process_log_file_on_signal);
>  		atexit(process_log_file_at_exit);
>  	}
> =20

