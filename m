Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1082B9C4
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 17:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710870541; cv=none; b=dsXsfpTVRFiduNAKca0QovBIdxA/eiRO5zeWLn3Fr3aFL9P3Yo3wGB3dBsO9Kbx21kGJwKFNtOBDjHJgxyQ4ke60ttUaasRJWkvXTf7Umd/Rr/jrLX7m2j0FQf6Yw7Jo3fEquP21rOhArE1HiDM8NYlDpAuSnvquQur1fFl9TWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710870541; c=relaxed/simple;
	bh=JFLkIcjWgyblOCDwIgWJbbS8hBd6q0zrtDhXZggoVpM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=NE3V/CBNroUs4btthyd4Houawt1eiTzx/s0VQ39LREaum4vFFa3/rfePIfZKGMAuJsd2kgSSagncmKUypOkEWL/+H1lfmutNspSxACs4F+Ocw73FUpos1H0iMA8qR2yisX4ayd35kvEUn0x5+LKeqLZ0ed4bbJO1nwFPAfbJbxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=kAp7CZSf; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="kAp7CZSf"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710870531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kHloNi0DvPyUQ+xmJI1Iwe4oQyV3jkRc37dzcwLvKGQ=;
	b=kAp7CZSftmr7lrQg6511Y3pnmZuQhzSbH6TVDC5fspbrcSAsjpt2cRR+FXah62XzIddESY
	90v9AEY3cKX0+qPEZmtfzSepTPKFse2Q8M0PxvTMrmpCpMgna4ieaCCxYFgbk1oOCXJex6
	XPCWhxOWBNKteiToSCJA0XB+u2YM/T7XR89vU2lWAVKM//jEWBWQHJC4iMEs+6mr/3N1zO
	q6St1n/Ov5f7WPR2UpxBEVWHWwEphnIA3xuT7ByRWoatLEQxSNcGjkHoLsXmO+Y5NC4wH0
	1/7UtUc6hCgej+thcWwivccMDXAvogNxVrFpWdMffZrKmvPIeB/qKRA+Fcs4VA==
Date: Tue, 19 Mar 2024 18:48:51 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/5] New config option for git-grep to include untracked
 files
In-Reply-To: <xmqqcyrqqfrv.fsf@gitster.g>
References: <cover.1710781235.git.dsimic@manjaro.org>
 <xmqqwmpzt6jk.fsf@gitster.g> <c68a6d94bb02e5d9aa2f81bee022baa8@manjaro.org>
 <xmqqcyrqqfrv.fsf@gitster.g>
Message-ID: <d8475579f014a90b27efaf6207bc6fb0@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-19 18:43, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> However, I think that the usability of this new configuration option
>> outweighs the possible issues it could cause to some users.
> 
> "Screw others who share my preference and want to set this variable,
> but use third-party tools and scripts that will get broken with this
> change, because I do not use them" is what we try not to say around
> here.

Well, I didn't mean it that way, but I get your point.  Basically,
this series cannot be merged, so I'll extract the cleanup patches
from it, improve them according to the earlier discussions, and
submit them separately.

>> For example, I quite often find myself in need to specify
>> --untracked while running git-grep(1), to see what's found in the
>> code changes I haven't staged yet, so I find this new
>> configuration very useful.
> 
> The feature (not the command line option, but the behaviour that is
> triggered by it) surely may be useful.  Otherwise we wouldn't have
> added it.  As I already said, I often find myself doing "--cached".
> But that does not make it a good idea to invent a new configuration
> variable and set "grep.source=cached".

I see.
