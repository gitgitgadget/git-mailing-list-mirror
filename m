Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A8E298CB2
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 16:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781799540; cv=none; b=YqOTOb13XIU7XdGXIWdkA0uxNagiHF7uO7iBrVEJE2+pfSGvPl/h3V08l4Y+xv50u3IClHd/8qEtNkLjsU1GhhdaiXob6pz4Dlx05mx+SDD3r1rB3IUJZthziJ43jdkLAiRFVHa6xo7f7kVtozWshv3Of/68jPu3kZb/N6SVm28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781799540; c=relaxed/simple;
	bh=1IMehE0sgKge1PQBQkMIubK9o4BwLvCW8UHEith4ptU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m5SNulEAkPHn06lZPf3Z4MDVoR4UFX2rd1Sy+mczoL6+bHEYgyiDr5tKA01LQxITXMh/Ph6bmhKy6Evtgap6DNcDH82YUlySptuUGbvTkpz4zXnhwImgrKYdIH6RC5b0NlPWnj1k0V8rnOKBknXnb5YNcWEcL4yMAIDzmdnXDE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nbcK/iI3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lAaW997R; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nbcK/iI3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lAaW997R"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 11D94EC01B5;
	Thu, 18 Jun 2026 12:18:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 18 Jun 2026 12:18:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781799538; x=1781885938; bh=colgx/9G8o
	2bIqN/Oak3yYUnGa29ETSV/G7bD2bUBYo=; b=nbcK/iI3Zd0K6MUBddbBvV77nL
	gKqlokPRM0XB9rBohbSHrCsWhxTh81nesWsPqsMjn66uWauNlv9WVe6ge1TLpjPf
	INk/Im4sg7q6lRsA5sGvqjo7Sq1uPbFbwePBbbxNl9c6fc54+q7jrQsoYsWJVCqC
	MMT0GkYue9PpBYhoTQT9fcea7/dKGpinvKBPCWxQ3rsV5QBMN43RxScqyZYKj90J
	yVtQULbpX3yFhTSxOHZJ4bYgZIGjCf3ulrYLzFi8VYIZ2HD99OszEBntUVknjhhb
	14of6+1aKXfW8K3Vtz/xpixJHlAS6GgO6qRg6wvGy4s76U06ZUlb29mDF1GQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781799538; x=1781885938; bh=colgx/9G8o2bIqN/Oak3yYUnGa29ETSV/G7
	bD2bUBYo=; b=lAaW997RUc36FaSfIFvtLUA+nq1G/1/Pc9wDiTEudYKnox7TEV0
	BYhkhjvp1ibeVRaEpch6KR+ZMlTDfH+b3OCIro5bciOYHpKgiHuwvEQKXQNUasGf
	Fenht4R5hP7SIYPt4PMECeL4VmNKv50RMGrZuQHMKTvh7MiwOZlXZDBkK9fZHSGO
	3418Jz4bxZYnGO4sXbIiqhqqIB/QZX+u3QMfBumZIUQXaPaCScx87dVIk19thBd8
	b0oXcxm3QaFxx0sJk+eqIncwCWjejaUExp7+keKPwPrygIB5GuFWSaKeeC0ZzfGI
	dAYYZvpDl6zFFDSnpq0yX7RRgnpBoOBXd0A==
X-ME-Sender: <xms:cRo0au2zdJPlhPIbhtAootn00OqdKO_FNurW77qUknZHW18COIz_3g>
    <xme:cRo0aoFKAmqRughjtGkeoem_cVD2nruQFBD66GVm6JUp50Ke3418pYxrPXAUx3MpQ
    5vKaO_aBoC2admETareujONBBI1U8CBblIXkPvvrBfb638v7y92vg>
X-ME-Received: <xmr:cRo0ar6svyw2SFqqdt3SLsIW3-5czrQl9x7VFts0S8DemqvDU0SnUpMhAlNq9kag8uTDQ1iQZQ22PU4S1cnsvhY5QEE3ujG-HmRT>
X-ME-Proxy-Cause: dmFkZTEJ8N6TerGmyHTwdaoGK+BY6x7nRSa+9ZUxDrCt4j4gHNpA58iyNmfzv3HBGDgxJq
    rt8Xm20T72aclA5zn5dM9BAQOv8brGhEaA/QDLHOnVJU78CIbTKA6lU409AKCvfbzQ2M6H
    nM/KHrOQ6inVCjWc8uK5hmKpDcney8e2rUh48Ldsaxd7ZZULgR2Jku9OUNXcYsHxj+kGY9
    irCrp5IP+ouuZsCZNF9u5mRxQ6KCU45tzPGDbnB9vTz8lqowI8vAuqbfDytBiruTYm28Zz
    DjAtgsUmoPxmML2Ae9GYi4HMQbiRohSB4eiy6Uo5VEa9Ar3CvrpH3d0lzbEc+nI158pWG1
    eA8X9nbxZylumHJ43mfJfOgy9s+T5TGwfbHcZlsusRykJOL3aAL72DHefH15m0B3dK1hfE
    +otOpGwmyQEU3kiD1ZfFojps6rFJNvUxhDSS3S8E1LKg3BY/8nQq16KeiyhGoqImEE2qSa
    x6UjknbDJCy9Kel5xEI7QhfM6IjMFn3+Z1JSKFC9uSXfG6yVHSd1G+2uUk6OMZsh9GEtJL
    21mf6ZSPNvNKEOqyHmCpa9bgdVxZqBAfzvfmTDf+5kcLagPozuz8F2AkYvzlXXRlml34SV
    3FbtDh1sAH/byXW+xKbXBYkQ6NwI0iMTypX8cn8PxcU01d9Tp5A2xxXzmcwQ
X-ME-Proxy: <xmx:cRo0autOFx_qq_pdY9IJWnRzKLC1gMxXwwJOWw6JiZZvr3bYBdInAA>
    <xmx:cRo0as7xuGWkOB08qcGUrI_kK0QWtVIYxbhfvzUOvPQCO-HIpzG5IA>
    <xmx:cRo0apVWfFWdP13WE4CYzDqGUZrJX4Q9LSWy8ko8N0bL5EGcZJ5oaQ>
    <xmx:cRo0au_OAavQrEfaPra_kWEDRZ1XnkyHWwIuIxIbDcmxdpG62BVS-A>
    <xmx:cho0ageqNGExQUIE2BIWScObwj2ZOBgEf049KqqkByn9sKxEwDckzAib>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 12:18:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Todd Zullinger <tmz@pobox.com>
Cc: Matthew John Cheetham <mjcheetham@outlook.com>,  "git@vger.kernel.org"
 <git@vger.kernel.org>
Subject: Re: t5563-simple-http-auth failures with v2.55.0-rc0
In-Reply-To: <20260618144953.l6Ng-dvv@teonanacatl.net> (Todd Zullinger's
	message of "Thu, 18 Jun 2026 10:49:53 -0400")
References: <20260611210456.XYfhytSL@teonanacatl.net>
	<VI0PR03MB1163416D5C66FAB25AECAAE21C0182@VI0PR03MB11634.eurprd03.prod.outlook.com>
	<20260612180203.s2qSgDUs@teonanacatl.net>
	<20260618144953.l6Ng-dvv@teonanacatl.net>
Date: Thu, 18 Jun 2026 09:18:56 -0700
Message-ID: <xmqq8q8bstxr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Todd Zullinger <tmz@pobox.com> writes:

> I saw Fedora picked up curl-8.21.0-rc3 this morning and
> confirmed it resolves the git test failures.  Someone else
> has already commented on the upstream curl issue to note
> that.

Thanks.
