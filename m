Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2007115491
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 18:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709661818; cv=none; b=UP7vDfk0GESlLiuGZV8dhLJVCOQAseQwtRDzs+XcmEispFZFnwT1G2AKSvKYZRZvRcM/FptefvtpqR1yCAecpzqRqqynrvt03GPAU36RPP80DRjAelO+q+ATcONnez0rNnKA1iarLgYU4WGMqFgbuDYevwExo02WbzfDfbEvlgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709661818; c=relaxed/simple;
	bh=TnIUqWndiei6jr/HeV8zYnR2YOOu7U9qBnqFpdg7TJo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PgNl4kb9vBRiZieJlIv+1ZgrEYF6kInWLgM9C8cMhpsQFpO01jgqONIC3pcMpgW7OI+UGQBaH87bk6S8dbm4IZLAkXwEnwF3mPx7fH35IiveqgE6Lc9KbeWtkHeiSaiX6y/KNCuiAIge+9xq72VG/Ol5TF1o/mC7GpUqGwOrbLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rmVR8yFF; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rmVR8yFF"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ADBC11DA4EB;
	Tue,  5 Mar 2024 13:03:35 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=TnIUqWndiei6jr/HeV8zYnR2YOOu7U9qBnqFpd
	g7TJo=; b=rmVR8yFFqWSOmQl1Nl5xThvl6G22Oqq3lBUEBHV3Iil3y4xvZRC++r
	OeLEH+kUEmD/uJilnGB+3tEzTJrOAFZ/aSoH76fjFQwsD/ABE3n1Bi5Gs1VvN68n
	HBeNO8W4+1uaXmieC0dJpIaxxpwih1KlIDRxj8kio68DfBt6KC5iU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A38DA1DA4EA;
	Tue,  5 Mar 2024 13:03:35 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D2A391DA4E9;
	Tue,  5 Mar 2024 13:03:34 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>,  Emily
 Shaffer <nasamuffin@google.com>,  Josh Steadmon <steadmon@google.com>,
  "Randall S. Becker" <rsbecker@nexbridge.com>,  Christian Couder
 <christian.couder@gmail.com>,  Kristoffer Haugsbakk
 <code@khaugsbakk.name>,  Linus Arver <linusa@google.com>
Subject: Re: [PATCH v6 0/9] Enrich Trailer API
In-Reply-To: <pull.1632.v6.git.1709252086.gitgitgadget@gmail.com> (Linus Arver
	via GitGitGadget's message of "Fri, 01 Mar 2024 00:14:37 +0000")
References: <pull.1632.v5.git.1708124950.gitgitgadget@gmail.com>
	<pull.1632.v6.git.1709252086.gitgitgadget@gmail.com>
Date: Tue, 05 Mar 2024 10:03:33 -0800
Message-ID: <xmqq5xy036a2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AF2006C6-DB1A-11EE-9E67-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This patch series is the first 9 patches of a larger cleanup/bugfix series
> (henceforth "larger series") I've been working on. The main goal of this
> series is to begin the process of "libifying" the trailer API. By "API" I
> mean the interface exposed in trailer.h. The larger series brings a number
> of additional cleanups (exposing and fixing some bugs along the way), and
> builds on top of this series.
>
> When the larger series is merged, we will be in a good state to additionally
> pursue the following goals:
>
>  1. "API reuse inside Git": make the API expressive enough to eliminate any
>     need by other parts of Git to use the interpret-trailers builtin as a
>     subprocess (instead they could just use the API directly);
>  2. "API stability": add unit tests to codify the expected behavior of API
>     functions; and
>  3. "API documentation": create developer-focused documentation to explain
>     how to use the API effectively, noting any API limitations or
>     anti-patterns.
>
> In the future after libification is "complete", users external to Git will
> be able to use the same trailer processing API used by the
> interpret-trailers builtin. For example, a web server may want to parse
> trailers the same way that Git would parse them, without having to call
> interpret-trailers as a subprocess. This use case was the original
> motivation behind my work in this area.
>
> With the libification-focused goals out of the way, let's turn to this patch
> series in more detail.
>
> In summary this series breaks up "process_trailers()" into smaller pieces,
> exposing many of the parts relevant to trailer-related processing in
> trailer.h. This will force us to eventually introduce unit tests for these
> API functions, but that is a good thing for API stability. We also perform
> some preparatory refactors in order to help us unify the trailer formatting
> machinery toward the end of this series.
>
>
> Notable changes in v6
> =====================
>
>  * Mainly wording changes to commit messages. Thanks to Christian for the
>    suggestions.

It's been nearly a week since this was posted.  Any more comments,
or is everybody happy with this iteration?  Otherwise I am tempted
to mark the topic for 'next' soon.

Thanks.
