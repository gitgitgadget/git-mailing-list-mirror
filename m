Received: from web23.osl1.nordkapp.net (web23.osl1.nordkapp.net [185.114.57.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35643C099
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 19:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.114.57.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713296675; cv=none; b=FLgUgW42N31ibyt6bAdLOTJHOe2GtFzBp/o3MTAZoBKLSTJfN2znSe9ZNaF6gGAR2S9EQ9JUkFWKpHXJ7m/zm7BNVjRRn/t+I4XdV2UtoH9ansZaKVhUs9OoScZsmfRUo8eT/RecHuQ2W2PMQQjKnBS9+13VwE7nl90swFfzBMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713296675; c=relaxed/simple;
	bh=g5+S/z9pa1Ek9EUv7cyBh/H58Oi/24VBTFP1b5b7Eig=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=p/OmKYMPlZ5g7rA4hEb+WPjp13iF2HMy0itFKgy1NgcDdsJkfbZuiRE+Eyw8cwLui09axq59q0hEXXpwQf6/BuGu+gwdKvreufdFXrXq+gCwEsjA8FT8U/qnbq34FAq/+gSeqFEjZaSYewHpJXEHxfF0Ac5xMn6u+2vuZzBw6pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=softwolves.pp.se; spf=pass smtp.mailfrom=softwolves.pp.se; dkim=pass (2048-bit key) header.d=softwolves.pp.se header.i=@softwolves.pp.se header.b=iHNrD61f; arc=none smtp.client-ip=185.114.57.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=softwolves.pp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=softwolves.pp.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=softwolves.pp.se header.i=@softwolves.pp.se header.b="iHNrD61f"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=softwolves.pp.se; s=x; h=Content-Type:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GKhJp8j/TlW0sJzR5UwUASNyUEHCZVie18oPfCR1C78=; b=iHNrD61fDgXrRJ7qwU1gV5zGhk
	mWjQr8cMKAEe5Oo2kh2s84/R6HceqUUCJRsKP8EuWHWTju9d8U4lL7vtY8SvhmuoQX9ZHNIa5wwj3
	socP0cUz3KQLeWiA8eWGYZ4bVSU50VuwtJFnG5OdI7U7jTqr7Qx5pbMJbMpNRfph8ZtRYDjTCbPPI
	b7fbZ9P5wj43y/D40BlUw6iy4OSHGgXpKErNap4glEPDZhnErQ5XXnKbwGWjQQY+Lf5uaVBNd2vkv
	J2EFRUBtOeMbfytQC7J9h5StyxTrbVg13unmszNfuYWe2PYa3QjUXKQsgq+bxuBaisWKRHRpr1rqq
	6XhNM8Mw==;
Received: from mail01.osl1.nordkapp.net ([185.114.57.50]:37128 helo=mail.nordhost.no)
	by web23.osl1.nordkapp.net with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <peter@softwolves.pp.se>)
	id 1rwoj7-0000000DCQe-3Wat;
	Tue, 16 Apr 2024 21:44:21 +0200
Date: Tue, 16 Apr 2024 20:44:21 +0100 (CET)
From: Peter Krefting <peter@softwolves.pp.se>
To: Eric Sunshine <sunshine@sunshineco.com>, 
    Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>, 
    Michael Osipov <michael.osipov@innomotics.com>
Subject: Re: [PATCH v3] bisect: report the found commit with "show"
In-Reply-To: <20240416051358.GB1745631@coredump.intra.peff.net>
Message-ID: <70e5d02e-7728-260b-40c3-a19cf68d9b0e@softwolves.pp.se>
References: <965ae345-fd58-c46c-5a7a-de181e901f21@softwolves.pp.se> <CAPig+cQu15HzZkeT3+oG3U7iFax5_GYUB=uqwuJxshw-PD=VHQ@mail.gmail.com> <xmqq7cgyl3pr.fsf@gitster.g> <CAPig+cSY3vp6V=4SWmxyCi+7QY74eGnzPM6bu5LU5j00n8-j5g@mail.gmail.com>
 <20240416051358.GB1745631@coredump.intra.peff.net>
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Organization: /universe/earth/europe/norway/oslo
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Relay-Host: 185.114.57.50
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus

Eric sunshine:

> Style nit: On this project, multi-line comments are formatted like this:

Indeed. Fixed this in v4.

Junio C Hamano:

>>> Signed-off-By: Peter Krefting <peter@softwolves.pp.se>
>>> ---
> Curious how you trimmed the trailers from the submitted patch ;-)

Yeah. I had some extra information in my local commit footer, to make 
sure I remember add the correct Cc in the outgoing mail. I didn't 
intend to remove the Reported-by trailer (and in v4 I see that I 
forgot to trim it at all; so much for posting stuff late in the 
evening, especially just after pushing a localization update).

> What is more problematic is that the message is sent with
>
> 	Content-Type: text/plain; format=flowed; charset=US-ASCII
>
> and the contents of the message is in that flawed format, possibly 
> corrupting whitespaces in irrecoverable ways.

Right. I need to remember to disable that when posting patches. I 
haven't come around to trying to get the Git built-in tools for sending 
patches, as the last patch I submitted this way was in 2009, two mail 
hosts ago. It oughtn't have been corrupted by that as it was just an 
import of the git format-patch output file, and...

> Peter, if the resulting commit I push out later today botches some 
> whitespaces due to this issue, please complain.

...it comes out just fine (as a v3.5 patch, as my v4 also changed the 
command-line options, which we should not).

Eric Sunshine:

> Sorry if that caused any confusion. I wasn't trying to make some 
> sort of implicit suggestion to the patch author (such as "don't use 
> Cc: trailers").

It was not you, it was me trimming the posted patch a little bit too 
much.

-- 
\\// Peter - http://www.softwolves.pp.se/
