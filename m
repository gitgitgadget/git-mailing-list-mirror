Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433E240A954
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 17:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784567008; cv=none; b=a3vENIdyCTioiG018acFc02cvE7B4pfX/5cRc+YtKpkQ6b+M0zbNW/KtXyupJsty8qe7JXry31KO1a63gcOY8Gl6647EWqRRkG80yMWZ08VcwV5QyNInM5rHB8doWCxB7BuGVr2lOJjjLrTBzNGYKg15obRbFRB/x3bN58zNAUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784567008; c=relaxed/simple;
	bh=5rl00gCAtAi9MexMWc1las7p+v0BFVNky09twoC4EMw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eSyz8Tq3VPC84zre+4F5g///x70PatoPOojJ2dgZuleKjM/O8r0jFehsO9mXORjF8KXeiiiWs66gHnd5zJhzzsC8Iv3GIao/wzB9SMAmTLMK+1ysxgYUd09wGRphiYgxM+x1b8YmbSHUpboW6FjV3dnis4yrg131WAgfrP+lAX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ihMaosPa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DXDGBLS0; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ihMaosPa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DXDGBLS0"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 7117AEC01E7;
	Mon, 20 Jul 2026 13:03:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 20 Jul 2026 13:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784567005; x=1784653405; bh=f70nbBDNu2
	vLOLAr2jJCSvt+SOwlZHs/Hs0bXlGItqA=; b=ihMaosPacv0MPd+W0nixI82T6E
	jVPwOjSRaMTqznHfG47InxHdH8vjcrHvVnkRjpw7I5jQ3p9sUwsPDt4BEO5oC/EU
	dwu2yWkT69ekSf/WYczbAUVJg1IAK/WPbn/l3A1/aQgtzwTqqCpSfe5wbFHW58cl
	k5EYJ38YALo9zd7OHxnT5ZtCPQv66ov4M56LfgdSnWYDC3nQBbjg3MAXgTxztcxJ
	oqmFzUleJJBQHEEe6SXWNluWFvvJJEdOMTu4lk8R0WW6VqC/LfqtrqtQ/ijY3MxH
	U+uUIGsYJCLbWVjkamWksabtUO62YNuUa1inyIVwl3b6TSIthGAGEhdRO34A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784567005; x=1784653405; bh=f70nbBDNu2vLOLAr2jJCSvt+SOwlZHs/Hs0
	bXlGItqA=; b=DXDGBLS021v2a0YY4H6dQO91Pf56c+aA0FyojXfT107oeiAw89I
	Q2ZDnolxuztT3kYh7024+98YXqGvOLEGc5AGHZ0R6vSYRNhID5esB1Ugfzb5NBPC
	5S6J4hDPlS+DGJnsqdH8W3AZoSi97VOtcj0LnmDOS4fja+yhecosg7euRiz5+yni
	48UXmPU/SUmKIHcCl3fY7JZ8dkqvbQiC2txFNKoGfL26XksjX5XHBSy6bmfUs/cI
	S1ysuQEEHWx9l31o+vgSaaRQ+SEh3j5h9RJ8ESUCOSo1TtoLMCu7OdfW3oOccBop
	FTggpTtN4jdtXqc+Bh8EJij/2safMKxZHtg==
X-ME-Sender: <xms:3VReaiDVYXK2MLwLyqCwwFnohb2YDKUZGK4ygEYGNwgqDkwA2zYpGQ>
    <xme:3VReaj92dITdD6DX8DEGuxy-zCvJdw__qEhvjFqsWn-6ZWuPmKKRdl2814e7_zrBe
    ZBC63XA1_ZNHeLR8B7o3zAj3YmFDTKcTl1aUMzdJ_kzduQ8rXXH>
X-ME-Received: <xmr:3VReai_7ZOC2YlxnV7-Af2Auxnagt--vdvw4zltgU9w4M60QSak2HWQw7cNUGv6yqF7AN0QgmQ2n0QzkpueDahCj2qJqagTZ8w>
X-ME-Proxy-Cause: dmFkZTE8HrB1JicdXgsZmkq/6RRSxOv50LvCRXoqBgHczWg04G+1/x8kaYJlfyIl2oSGdd
    1v9aIj+72atRB3iCLRqGcIJylWaqLVwONWQ5uvnW+2hD6I/r9etWNW+MVgLPL76fh4vFTp
    5t3dxjwG0nn9qzwf+ZwOjoEOfYMfZwC5Xj+Wvf1OgoNMntERxxv8ovPkX7BBfYhpAPgSon
    3D3exExBjl0qnBZkspHm1Af++REiL2VYhx8nu2IX4bDVpTSv5CTT1c09z4lk3WA7FIqgxn
    gT91QXho4LQPDI4gh0iZIjAKHIBmYkun/cY6Vfu/Sde6T3w+qkftUzUYfhwyf06qA5tEc+
    WpgiRKMR9b7psP4e/pkLCyA3iI/a4Zuu0brJWoBpncGzMX2FPYK/FerN3fLD3v22tpsew6
    6Av6GnewTMfk3f3H+G0Jar8hWACZntTs8hnZ6hLutYLfZgb2T6V5liARr7yTtCmJtL6k6N
    b2iVOpL0xyK0ar1M3biXnX1TtlA9JE/PPtulHKB8Ip/2ky0nL0LDAGGYc3ohQrqvlVOeiZ
    ZxKfmmyLrIlU6EyvOe7/pa5nx6pdxFQzXY9lqWgkQy3kY0iaSyizxBNFfuFlas6tJXj4Mm
    /SwFZU7TQg/UrLv1YkVnvYbQUUg9TNowaZhs8H/QvV9dZkiOCMFuFYTNig5A
X-ME-Proxy: <xmx:3VReaqewyX56FRTGE5eBAp-T3pgUZkTDxjGkNdhi_LeSSm1VZY_Tlw>
    <xmx:3VRearG860ab7Du5oqqIXijbM01reqTjZRqqxs3nWjlqkbv0fsxyCg>
    <xmx:3VReaofeo3nOgBSgaIsDdycJNgKfof9qDNnLdCAUo5VdNgSETtapig>
    <xmx:3VRealET-qgTMLRVDv0moh-C1R_ZMvx0JqJJDHefwCGyIPyomGjRfg>
    <xmx:3VReaiiXxBM_a13Shp6-eBOHUjKv3VIRD7OpX9lJg8BY2Xbb2bECdSZA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jul 2026 13:03:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 0/9] sequencer: do not record dropped commits as
 rewritten
In-Reply-To: <al4RYuWKqAr-IlFC@ugly.lan> (Oswald Buddenhagen's message of
	"Mon, 20 Jul 2026 14:15:30 +0200")
References: <cover.1782833268.git.phillip.wood@dunelm.org.uk>
	<cover.1784128921.git.phillip.wood@dunelm.org.uk>
	<xmqqecgyn5gk.fsf@gitster.g> <al4RYuWKqAr-IlFC@ugly.lan>
Date: Mon, 20 Jul 2026 10:03:23 -0700
Message-ID: <xmqqy0f5d25g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> On Sun, Jul 19, 2026 at 12:29:31PM -0700, Junio C Hamano wrote:
>>It looks like this is now ready to go?  Any further comments?
>>
> you can add whatever footer is appropriate for "i read it, it seems to 
> make sense, but i didn't double-check" for me.
>
> (same for phillip's new 2-patch series.)
>
> (it feels silly to "spam" the list with such low-value verdicts. i 
> really miss gerrit code review here, where i'd leave a +1 in passing.)

Actually, reducing the signal to a single bit, 'did I or did I not
see a +1 from them?', means Gerrit users see less 'spam' but must
make decisions based on too little signal.  I do not know whether
that is an advantage.

With your email, we can at least discern that your comment is much
closer to an 'Acked-by' than a 'Reviewed-by', and we can respect
that distinction when judging whether there is sufficient consensus
on the list to move the topic forward.

In any case, thank you for reading it over and letting us know that
you found nothing glaringly wrong.  That is indeed valuable
information.

Thanks.
