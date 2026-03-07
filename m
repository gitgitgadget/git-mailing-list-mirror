Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.61.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0FF3290B7
	for <git@vger.kernel.org>; Sat,  7 Mar 2026 21:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.61.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772918904; cv=none; b=mUJKf65ECXI9IvXEv+LyvAagYZQos4p+29fK+dxwJ7wi3gU95bqfEs74Inn8x0+5icI4BOHbQAMCxxDv8YHtHb4EtHkQzVxyaj+w/Vjfob4dfX2mVAVnQPod8kD/nrRdrlDK0e16IOezRe/B+CwxG7EThcqpeu/KP4MzDXD8WFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772918904; c=relaxed/simple;
	bh=GLvQl+EkWOwEZZmNM2ZlX7gP0PkIMyfwrCe6grPMYBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=Uea9Qkwc3GL0coraJTgRFv2Q84wDZaWG8KQcyzaTABjptrjECeTK4KsuMFDw+ocnieRUcSZOhH4jo8NyUQQCHDDU+fmsgbCaAZHFJzQkP5aThMrnHqNdO0maoYldGOe0lMiq6M6aWUgYkQTcbLaqVhWCEM/qmsgiMnWgwjeKY/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rd10.de; spf=pass smtp.mailfrom=rd10.de; dkim=pass (2048-bit key) header.d=rd10.de header.i=@rd10.de header.b=NuZqcLQ3; arc=none smtp.client-ip=188.68.61.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rd10.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rd10.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rd10.de header.i=@rd10.de header.b="NuZqcLQ3"
Received: from mors-relay-8403.netcup.net (localhost [127.0.0.1])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4fSxG41LLjz86qk;
	Sat,  7 Mar 2026 22:28:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rd10.de; s=key2;
	t=1772918892; bh=GLvQl+EkWOwEZZmNM2ZlX7gP0PkIMyfwrCe6grPMYBM=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=NuZqcLQ3f6x2W8jF7l98FMGTeqgN2OFAJH14F5Dlob1udc3G9mphWiYDJDKpnxOpH
	 +kQ9/9FXZSQZVXV4h6KFHpSM0Wa5Z302/jsO8x0AOMr/T0GGZ9+bcISkt5DWHh6BVu
	 tXFxYYx6MeGD54EEs4WAog0iWX8GMXb1NZzrkH13mAoklmGlo9obAKAt5gNzjs1mDB
	 E6zHG4V40u4yRuHlSFrjEG28XLNqCdqeuIGsbrZ2aeZfA2Y2AS8UEK+KnUCzu28zIM
	 bYTdcOI3MeNUQVLa10BjqIVRc0yzKjGl9XGGydnGjrVxKypNwgUPEVZfMGjZcQCLGD
	 iEDNI76utse3Q==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4fSxG40g2Qz86qK;
	Sat,  7 Mar 2026 22:28:12 +0100 (CET)
Received: from mx2eb1.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4fSxG34st1z8sgT;
	Sat,  7 Mar 2026 22:28:11 +0100 (CET)
Received: from [IPV6:2a02:3102:8e00:2a0:34a6:9fd8:dbc8:23b1] (dynamic-2a02-3102-8e00-02a0-34a6-9fd8-dbc8-23b1.310.pool.telefonica.de [IPv6:2a02:3102:8e00:2a0:34a6:9fd8:dbc8:23b1])
	by mx2eb1.netcup.net (Postfix) with ESMTPSA id 248981001C1;
	Sat,  7 Mar 2026 22:28:11 +0100 (CET)
Authentication-Results: mx2eb1;
        spf=pass (sender IP is 2a02:3102:8e00:2a0:34a6:9fd8:dbc8:23b1) smtp.mailfrom=rdiez-2006@rd10.de smtp.helo=[IPV6:2a02:3102:8e00:2a0:34a6:9fd8:dbc8:23b1]
Received-SPF: pass (mx2eb1: connection is authenticated)
Message-ID: <1d6a8eec-20b3-4d6e-83f1-d18b7a3c0145@rd10.de>
Date: Sat, 7 Mar 2026 22:28:10 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: git-fetch takes forever on a slow network link. Can parallel mode
 help?
To: "brian m. carlson" <sandals@crustytoothpaste.net>
References: <5c7c975e-2541-47e1-b789-fee1fdb77d2a@rd10.de>
 <aas--JZ-CCWN-o7O@fruit.crustytoothpaste.net>
From: "R. Diez" <rdiez-2006@rd10.de>
Content-Language: en-GB
Cc: git@vger.kernel.org
In-Reply-To: <aas--JZ-CCWN-o7O@fruit.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: 
 <177291889131.1948229.10869311190857129225@mx2eb1.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 248981001C1
X-NC-CID: b0KRs7yIJWyHWaOPvq3uzZLhFkislrEPrRWYr9oT

Hallo Brian:

First of all, thanks for your quick feedback.


> Since this is presumably a bare repository,

Yes, the remote repository is bare.


> [...]
> This performance could be improved with `git pack-refs`

After looking around, it turns out that the documentation of "git gc" says that "packing refs" is one of the things it already does.

I'll check when it was the last time I did a "git gc" on the remote bare repository, when I'm there again.


> or by converting to the reftable backend, which will open fewer files.

The documentation states: "reftable for the reftable format. This format is experimental and its internals are subject to change.". I am not ready to risk it yet on my precious Git repository. 8-)


> [...]
> You can also see how long various operations take by using
> `GIT_TRACE2=1`, which will give some detailed timing information that
> will help you see what the expensive parts are.

That didn't help much. Most of the time (23.7 from 24 seconds) is spent in a single child process:
child_start[0] 'git-upload-pack '\''/home/rdiez/MountPoints/blah/blah'\'''

The log talks about "upload pack", but I gather this is actually a download operation. It wouldn't be the first confusing item in Git. Or have I got it wrong?

I added "export GIT_TRACE_PACKET=true", and then I got a more useful breakdown:

This takes around 13 seconds:

   pkt-line.c:85           packet:  upload-pack< 0000

I don't know what 0000 means. All other similar "upload-pack" lines have a hash there.

About 2 seconds are spent here:

  pkt-line.c:85           packet:  upload-pack> [some hash]  HEAD symref-target:refs/heads/master
  pkt-line.c:85           packet:  upload-pack> [some hash]  refs/heads/master

7 seconds are spent with "upload-pack" and "fetch" operations, mainly for single "refs/tags". I'll check whether that improves after the next "git gc" on the server.


>> However, the git-fetch documentation does not clearly state whether the parallel mode only helps if you have multiple remotes and/or multiple submodules. In my case, I just have a single repository with a single origin and no submodules.
> 
> Parallel mode does not help with a single remote.  All the data for a single remote comes in one job.

Is this due to a simple implementation in Git? Could Git download such "refs/tags" files in parallel?

Best regards,
   rdiez
