Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D6E391822
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 09:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782294395; cv=none; b=i1Zx3XKGrm4qTRnSI6ZTyX2L82v0a/vWLN0Bdwt6FnGc1wOq5w1XWClQfrTPwO8cQ8CHWcZDEYDox9p9W45vJGkEj10SWp1JDlEK4dIi3SP+PkJ2oN3MxRMB/KUVhsVHioXsCxJd1HvPxnPzkUqohWGoQwBf+hG8V/HTioH5w7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782294395; c=relaxed/simple;
	bh=uQaarmNtypC6TJARxlR7u3HIUTqXu7XXjTY1GrWTbTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PsXqpFBS5qOkuOHhWTrGJNVrvnsZg6kUsYBKfARkTeAWEJdWfmN5fQ9r+AYlZf+JrkvoEegG9OIxQPHXcpttCWNsyKphE8J/7YV3qWB76LOh1uFRzDPSbclvLCMWNeRJDGh6w5Wb5hUUA2pSgFCnMCiVz+8QzG7LuqsAb6losR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Kgx5t3OL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NhEohdM2; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Kgx5t3OL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NhEohdM2"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 0B4281D0016F;
	Wed, 24 Jun 2026 05:46:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 24 Jun 2026 05:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782294393; x=1782380793; bh=9e23IWkXSQ
	fV6ZiDwuTMxD2X775wFKGgReJR6OLy55E=; b=Kgx5t3OLya3cvxED2jYbAr8t42
	Vrr4tfRWpoSmMNIblpTDFdUMHgIwlI74comd0h9vHqYo6c+UXuG8Dtfg1N9BGbmZ
	5JAOhL/72S/VwVxiAttpi+C3bzxBdk6MtLC7pK2+Lq/grJd4GefbIG015jTaV9sG
	SUFzALoLK7GE0EkFn/t9s9Gqpc0au7jGK4Bo/tAAzwYkHJL20O3ZSTiFNnuUVl9A
	jWvcPv6I9Hz5tfcmcXWMEIr6SdZqaSSs2ZkeLRYg2ONsXtVMk5BeOC32BawFF1Rn
	Qpx0GT7G0rCJp2EXVFUSnykzQZuuBU135iXTBztddWfLRlzORTKLvGqymEjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782294393; x=1782380793; bh=9e23IWkXSQfV6ZiDwuTMxD2X775wFKGgReJ
	R6OLy55E=; b=NhEohdM26Hz9us40g3hr+op4h6cT6Mnfhd8lAUsYm0SQjylyp0f
	oL7J40ARcePjYUkpmHvz7ji0kyHYLmqq22SQrT6mMHzheTIsAJ/du5UUyDMdWqB0
	pltNc0nAvm8STE1SaTw29Mm7QEAKJcy2NJs01XVejwWr5eiplJ52ItJXCxSP75nj
	I0W5AAwPudB05k9tMk45grPyRt8qiCbg8T9WVXZQlUX38J5U+CHMPjdRMlCthI8c
	lZYra0F7mfgGD9Nt2G318ycdWWeqoQC2Hif2YSMUXI7LlBA6n8q2RhyJXfS9i+P9
	NH85hlxxUq1hCmh7iPBSw1+hqij6QDZ6puw==
X-ME-Sender: <xms:eac7agDsgOLky-KNkiOYbSn79c9dOUzJDboXqv5eBf5UT-3mjw0Mfw>
    <xme:eac7aogbgK1fRLxOxM1O7wi6fGxOsOXs3pL9U6WG9tg1kyUxSLg6bVaC048QoXngN
    YgQggeSdpMBBxlBfQl4jE5jbvISIQfgV8o67viLCgwWbHeivCkT-A>
X-ME-Received: <xmr:eac7ahPf8H3IyIxPcQa2Eh_WkoIRkQ7__3vzneXo5312dMmK3k0sXpajZLvIsdnHLpFMfSIWPR47XXfUpR1SUOM0-DewDGivrukQAD6O>
X-ME-Proxy-Cause: dmFkZTFJ1BJiRcgqg6w0Xn/gQp5SHV/8LjqDOEPYlNgDiFaX7SgCGwC2MRv804kvf1UpYC
    co0D4v3I8t00ekj2rE6ddzs26OkU3JEdAxgpHUMc8GjNvRgfTMzfP/DPqdSA1WZPBB+Yv+
    HUi88oBhDfSM25rOobctmzby1wTw4yRL8ldkfylkNSHloKCt0dni2POVfN5ljjpPpWQX1Z
    Ta9pB7ngF+au842ke3aZZt42lkQcFMG4IldJ653VQLwxD5RLFuWDeEDBehYQhEtBfaIkYA
    OrIg1J+ChVH44+sfRQ3UTunrHwMjUrh9vivfPTX8CMhUKniTopZttHOsMzyCGYeN3b2DkX
    y2jCVNWgfkROra3jQTK5SPwu0MGikHhPPSPJ44ewgyLfhzPkTcgfyZsOVk2aoMCpRofChm
    keTSOj9sDDp+eORQf+77kbINYC/saC0cwyi5uHh66eFVH1Bvq6LIeZyNc+AHNIXER/lBA/
    K2ZKHjix31H97HGvxELAvS5QiQUE3tk8DtSXXc5Q8l2lfWQOwbGgu/V2PsIcUoZbmzmhk2
    HRaRqwVwTfVl2YnC/WD/ElQ8B6+yT54wZ8C93CPZsw61byt9sESBkDAe7THmzbI0jg0qb1
    vXUhRPrtYcHLZ52nKxJ7uv0Axgd8CsLLgxIrIRSFgx5/Wh0LXrrtvRX0zefw
X-ME-Proxy: <xmx:eac7ah5WWE9jCzfU50lChisWVPEtGTSrvPysPocfxlSyPx6gkaIjbg>
    <xmx:eac7an0cancMk4q2aXvO-Ak74j0lKXzHKom2sIuPo2sElrN2_DemuQ>
    <xmx:eac7aqZamnSwwSaBW4tiGjktSo9YP3RpWLLfxYyIFaHXUNIdVDhmeQ>
    <xmx:eac7anBvxrPn2yIPe_skusyCxLruK5TF68Jo9brnOhKj-Y8MZV4mOQ>
    <xmx:eac7aieD25Zzhf7gVAe85sPlgzWeH0bm7UzTTW6QtZa9yLazeXqHpJ1H>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 05:46:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d3442fdd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jun 2026 09:46:30 +0000 (UTC)
Date: Wed, 24 Jun 2026 11:46:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: oxsignal <awo@kakao.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 11/11] reftable/table: fix OOB read on truncated table
Message-ID: <ajuncy95aopgDt-b@pks.im>
References: <20260624181426.NJDNpVd1RE-qJjBVh5jtQg@awo.kakao.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624181426.NJDNpVd1RE-qJjBVh5jtQg@awo.kakao.com>

On Wed, Jun 24, 2026 at 06:14:26PM +0900, oxsignal wrote:
> Hi Patrick,
> 
> Thanks for the patch series, for adding the dedicated reftable fuzzer, and for
> the credit.
> 
> I reviewed the cover letter and the reftable hardening patches. Patch 05/11
> matches the OOB write case I reported:
> the new minimum block-size validation before handling the log block prevents
> the bogus inflated-size underflow from reaching the inflate/copy path.
> 
> The rest of the series also looks like a good cleanup of the corrupted reftable
> parser surface, especially the restart-count/restart-offset and truncated-table
> checks.
> If I find any remaining malformed-table case that is not covered by this
> series, I will follow up with the reproducer.
> 
> Thanks again for handling this so quickly.

Perfect, thanks for the report and reading through the patches!

Patrick
