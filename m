Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF41F3B186
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 21:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762205470; cv=none; b=sQPcb44+aO/jkiCtlM97aU5bt2jmlN8skEiuHZInvWXZS/hCa7OyIrRi3KXCiz4udWhMDaFcboz5RWibsU+79n4UR4UIde66IvYjAbzTehqGT4LN5SB9qSi2YUvGVPTGh/J2XRGeIcu+xj0KAjmD/w3DOU77+qVJNzOOAfXjZxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762205470; c=relaxed/simple;
	bh=L4m0WnKbaMVkc9QQ7dyFaZF2pm6vGXEKm2Xq6iZ9tEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ldih5kHCrpzbX19OAdi/LKeDB45iLsggw7n1cf4D+AkWxTFOoartQO5+AkUIsOEqdpPGbI0gacOHQ+mII1AYukEYEaROod9xOYIF7xBzfuZKOHe6DkNzzzPSjFWQxPoQ7FwNoITsRW7CwaXNVphOjQZ6YuCMlQRcqtKp+NP3lH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=XTusgvGn; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="XTusgvGn"
Received: (qmail 423247 invoked by uid 109); 3 Nov 2025 21:31:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=L4m0WnKbaMVkc9QQ7dyFaZF2pm6vGXEKm2Xq6iZ9tEk=; b=XTusgvGnOx3G7sbJJZB1t1MOLNd0uDKGtQBQzchyx3ucljE8F8xgk3KtBzgnGFBRbk/pN1/7u0ZyHRK0SkeViMCZirsSCCooNu/67Y9i/ve3WLiZ78g7G0CDu6R9oHsCfsbC97w7YZPWTvyYZ89zjrDgUPCjotnj3qvfeFgmvV9Y2Olt90ec3H0GWRxc9D7pYUcY1jmW3AH4GbRWHqD1vgzn9QcAdlLBOeWq1YOGWDmDpox5aZi/f6CYlbZU3qjDTIQ/F9qKW0kZXOcEgt8avyK7KDTHiNszzdjQ/2gXj+uGc/EoEJrHg8mipXnGopXxg6Kfe9NBQo+MCNyuqlj+Qg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Nov 2025 21:31:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 662739 invoked by uid 111); 3 Nov 2025 21:31:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Nov 2025 16:31:00 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 3 Nov 2025 16:30:59 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2025, #12; Thu, 30)
Message-ID: <20251103213059.GA2528366@coredump.intra.peff.net>
References: <xmqqpla43wcp.fsf@gitster.g>
 <aQRaRuBtt_r7SamL@pks.im>
 <xmqqo6pjt2wn.fsf@gitster.g>
 <xmqqh5vbt0sf.fsf@gitster.g>
 <xmqq7bw6ubaw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7bw6ubaw.fsf@gitster.g>

On Mon, Nov 03, 2025 at 12:10:47PM -0800, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Bisect points at 054f5f45 (ref-filter: parse objects on demand,
> > 2025-10-23), which is unfortunate, as that is the motivating step of
> > the whole topic.
> 
> Here is a fairly simple reproduction.  It appears that this does not
> require the refs to be packed (i.e., "t7004-tag.sh -i -v" fails
> after saying "*** Loose ***" here, without moving to the packed
> test).

I think the issue is that nobody ever resets data->maybe_object. So it
is left cached with the very first object that gets looked up.

Something like this seems to fix it, but there may be a better place to
do the reset.

diff --git a/ref-filter.c b/ref-filter.c
index 7cfcd5c355..4c174f7ecc 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2124,6 +2124,8 @@ static int grab_values(struct atom_value *val, int deref, struct expand_data *da
 	void *buf = data->content;
 	int ret;
 
+	data->maybe_object = NULL;
+
 	switch (data->type) {
 	case OBJ_TAG:
 		ret = grab_tag_values(val, deref, data, refname, err, eaten);

-Peff
