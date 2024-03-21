Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9919B12B171
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 19:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711050645; cv=none; b=q1GTVbdyUdT/AZNTARSkHrszVavE42MGRgEz5vwnepYyky8KirV8J62iAvHqESj/QT79W6PFzkfdXEIn7WS43ziX2rYK4/cGBKXP36I5ji/DLcfpt9MgTEEUkyg8yL8Z4Id6tSTozkIQgzSwEyM1peslD91ReXXvdUNww39i6+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711050645; c=relaxed/simple;
	bh=djbcDkFawuZg5isXH9aSbpgkYw06wEEJ8sPOtX2lNRk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nWHF9+VaCoavyFh2fnNpNEVrb8IwWzc3jp/K0U00trJBbVjtepk63gW/VYvAMHAp6B1/PHUZBxNBrHYrCpnEOXobLBnEpq/DnkfPgp/1/Vv68EMjRd8jXsP8Q5yl67tn8jB90MhJvS6f8s7cDtJrrm7cOicNtrX/qRuD3kS85qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Y/SwyrAK; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y/SwyrAK"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4B2241F13E5;
	Thu, 21 Mar 2024 15:50:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=djbcDkFawuZg5isXH9aSbpgkYw06wEEJ8sPOtX
	2lNRk=; b=Y/SwyrAKUzpIsvKzbg/fLjFuN3eXPJOYHud7eGt+buNhK0qMF9WY83
	LPHy95eUgLf3lKvcsLJ6aKsZjQ+0MlxdgyvUWTovroZKDhXwSSIPsPRVbY+xfUWF
	e3WlMzCxtyDEIBXcgbUsoRtrOPomRXJtWBGBNEI4huZPEPK6q9bBU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 426D61F13E4;
	Thu, 21 Mar 2024 15:50:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A159D1F13E3;
	Thu, 21 Mar 2024 15:50:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH 00/24] pack-bitmap: pseudo-merge reachability bitmaps
In-Reply-To: <cover.1710972293.git.me@ttaylorr.com> (Taylor Blau's message of
	"Wed, 20 Mar 2024 18:04:57 -0400")
References: <cover.1710972293.git.me@ttaylorr.com>
Date: Thu, 21 Mar 2024 12:50:40 -0700
Message-ID: <xmqqzfur74a7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4C675BF2-E7BC-11EE-8252-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> This series implements a new idea in the pack-bitmap machinery called
> "pseudo-merge reachability bitmaps".

When you work on your next series, please describe the feature in a
different order.  Giving name, and then mechanism (from coarse to
detailed), and then finally what it is good for, is a sure way to
discourage people from reading the long description.  What is the
problem, what insight led to a new solution to the problem, and what
the mechansim looks like, is probably an order to keep the reader
engaged better.

