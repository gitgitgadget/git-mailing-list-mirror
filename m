Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3745733A9FF
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 18:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781722434; cv=none; b=txH6vc/JpoqZiJdIsp8/ih85AbG/S2GBNDu/DWAwxebNT8TUvF65RcwH5PxPwHryyv3/YLo04od56m61s4LtU+1FRkM2KiRCKgAakqI70PeJ12vy3u1U2G89n0ZHxQGtu/wm/kCqzIPVUfFRQZkLVJb8GdJU3ymRaAN4HjMEEfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781722434; c=relaxed/simple;
	bh=JjRFfTrqJkw6Ug6DibpmFUJB1gt/zJFsQJ1IDwUPC7s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fwV6nf4g19YrmIARFmgzu8mn5Y1ZvkucpWd776sC7n480JFiP2RkNjC+uctVMPqVFLmarFDBMpzxbEum7SFDFTs9gwe3ffVgTSrJU2seuMiFYay1j7CHYAUWuBCdrU09pRckyd/6GWKuzZiHPH2CBc9ACGlCUZF9GZLsKn3ugiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oRmf9s9E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TTBdWEm0; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oRmf9s9E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TTBdWEm0"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 3D5001D00107;
	Wed, 17 Jun 2026 14:53:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 17 Jun 2026 14:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781722431; x=1781808831; bh=Asvdnll0JR
	nhPeEktJb2tsyAREuS+eWGwYtCxkYsbro=; b=oRmf9s9EboGIGU2u2JDZif2OOI
	1RFZNLqsfsyr7BripeJ3rdR6O9G1dQx5iJ4IUP0adnWKmpm+DnjETk9LGYBX2kg2
	zT6/4j4XQuq/ACrARY1eZ0FR8MVI1Bma6PV5d9X0aeETjQMdpxsXtedYF/JUOJnt
	5Y7cZioXfuBHiMguRL2hi6xszYy9NJvoFl07uaPWOBGsqCF3sqcZ0kBP6Y/vGDNX
	H52v9gL0bxrTIA0Eyhc3qSqgjB+BjbrRBh682tGpjgOUZokG4DmxdYSzwKkls8ms
	/n9J3Ei04Y2/vx0MTGLkDqF39UWOC3vXdPEgMi0dmTLSWaXK0B9bkBrkSngg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781722431; x=1781808831; bh=Asvdnll0JRnhPeEktJb2tsyAREuS+eWGwYt
	CxkYsbro=; b=TTBdWEm0G02ePzca9iPnWoIEv5vsbRYrhM8/C+fVzwrpdiW/Vzt
	a8KcH58f4xj+0+d6XkNfzfXys30ye632qrpUJdD5GvSmKOQSuSy95DmT5lBGA2aW
	ch6g9vt3jCUGe0dvyzARej/Q1aS2eHP6+7LPGmPg0DIaQ1WSUMAJm13iNMv9SSX6
	+FCgUsWEOx8R9biCkbiLqC828JjC1NUfOhXAxJw94RZ9jVxIWUsroAxWynK+E0QE
	BoOOFP/svCMyxtmYCKDicoSzYpiRqHikBXKP1TVroya1i5zNSjMnUE5NpDV9nPIz
	Ktj/BdHNnGBqWgmk/9sBLnBhS/VtUvKtPMg==
X-ME-Sender: <xms:Pu0yauc0IPJVBBWBaYnk-9QelZRrhgvoep9v85dQr6UMttZj27PyKw>
    <xme:Pu0yavH2XjnqeKN6_p0r0SQl25-aQ9n42G6WQjRCqWdx4kYEw4acFWtr9UgtBp-uW
    6ydgDMyP_c39orA1YH7c-w3C_bDm2Lw0lX-LcM1UHLCw2epO6HPiQ>
X-ME-Received: <xmr:Pu0yan09igbULM_8V56VN70bZJpNy4MO4li4azgssjfPvwTMywKBCAN_P3Gl0CHR1BXyYSaNJenyBst1fAL3sq8m7iif0Vs9vgmM>
X-ME-Proxy-Cause: dmFkZTG4j/YW9gydrxk9murKPt5vajuzeRByC1NZjjkeurbBwsVowcojsCx8z/LIRBbnyK
    tX6GegSGLUZKOP9XApC447x0OEavL6Adhxs448N0aqVFnSm/duC/Gok8MtRu8MjZDeo77m
    uRL+17zS3Gi+RmB+b3VQXYSlt/9yf5NzVBNWTKZ3B3bhve9ijY9a9z6mDQjH7stN6X2knn
    1z5NBPfdhGpclA9fESvFa21fq7JGFdGnCrmhPZKdXYnznlBJThLA2nrr4p3zSdOXuseLVX
    /hVn+i4uoLH0X1sIvUyPXT8TFQHJgiAIOb96QuPUNovsA411J+7PMQSkNNjtPOvuoKsMW4
    LLkYW5Jk2DwAgqQf8RsmDw+DryP7BVWYPXoF8ufSR9SE3W1YvhhNsyE0u+I7qtMdXFvv8O
    jA74+Ja5PM6r8MP5zQ1J0uVviUXapKROOW3ARpPVndlffXGp/Q92azaqmMa/RXI7k51VLE
    fK/2jAoz4Tt+P56UKrV0cbZTAHKrGEqi6JFQkpR5Z2QPaGu3RDyEmeoy2Ui8hJ9rX/yXH/
    eK9pbo1N13MVuvXhVfWMqtjzzZqQe+9R+U2gMUcQoanwuU+5ZpQD5ptGvDGssd/5G9FEXF
    752NVnnnFgB5svYmSwJbM3Yjz3MJwT591M4saFrlItVQtx4/qn+b/vlH/I1Q
X-ME-Proxy: <xmx:Pu0yanmm95Z4kBKvJ-mIh2zyAUT-SRdXwLOSxRd6u0jH_Frsmv96Qg>
    <xmx:Pu0yan9UpGFN1xFOo9-6nnKRcTqQXHXasPRl-S1zweXHNbfALvwQhQ>
    <xmx:Pu0yaspt8kG3q3On2TpVbKajgFGBilq7PZLjQhFNAVMdnFqR8awMXg>
    <xmx:Pu0yagmDTZvbdQKk0AsUS1MGd1voMpDnsOv6vgKFIf5lRlrailLRig>
    <xmx:P-0yauEvhiWsM3kW6XY5ee3YSnoOR6YgQIfi4lDKRi9w7lMniyfb_NK5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 14:53:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Jeff King <peff@peff.net>,  Derrick Stolee via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 0/3] config: allow disabling config includes
In-Reply-To: <539713c4-b291-42e6-8541-a16a454518f5@gmail.com> (Derrick
	Stolee's message of "Thu, 11 Jun 2026 09:08:45 -0400")
References: <pull.2139.git.1780927027.gitgitgadget@gmail.com>
	<20260608225149.GB340696@coredump.intra.peff.net>
	<4d7834c0-d8ab-4dcd-8a7f-ed62c30cbe43@gmail.com>
	<20260611083943.GJ2191159@coredump.intra.peff.net>
	<539713c4-b291-42e6-8541-a16a454518f5@gmail.com>
Date: Wed, 17 Jun 2026 11:53:49 -0700
Message-ID: <xmqqzf0tuhfm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> On 6/11/2026 4:39 AM, Jeff King wrote:
>> On Tue, Jun 09, 2026 at 08:59:22AM -0400, Derrick Stolee wrote:
>
>> I'm not sure I entirely understand the problematic case, though. The
>> user points to in-repo config (which we already tell people is a bad
>> idea), and then that config breaks for some reason? Because the include
>> is relative and git is run from another directory?
>
>>> Or: are we venturing into territory where we don't even want to create a
>>> new foot-gun? If there were another way to solve the situation that I'm
>>> facing without these risks, then I'd be open to it. Any ideas?
>> 
>> Yeah, the more I think on it, the more it seems like a foot-gun. Like I
>> said, I'm not sure I entirely understand the use-case. If you could
>> flesh out an example, that might help.
> The case I'm struggling with is that our build system has sandboxing
> restrictions to make sure the build is deterministic based on a certain
> number of inputs. A tool we don't control is calling Git commands and
> these users with included config are getting errors because the build
> is looking at files in the repo that are not registered as build inputs.
>
> Files within $SRCROOT/.git/ are ignored as "internal to Git" but when
> the users update their config to include other files, this error occurs.
>
> I'd much rather that this tool doesn't call Git at all, but I'm unable
> to make that change to a third-party tool. But this environment variable
> would make it possible to disable this behavior. And I'd also rather
> that these users don't use includes in this way, but they are using a
> checked-in file to share aliases and other quality-of-life things when
> a human uses Git, not "critical" settings.
>
> This series is my attempt to see if we can find a solution that enables
> this behavior, but maybe we've found enough concerns with the idea that
> we can push back on the users to say "stop doing that."

It seems that the thread went dark after this message.  Should I
take silence as an agreement, and mark the topic as retracted?

Thanks for an interesting discussion.
