Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4738562E
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 20:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710967905; cv=none; b=i/FeVg89yC7p9BO+LBdwShyNcHZM7Rp/cfnXho0/lT/4DdfTM7EkiQtyyF7pWIoDB648lGuhfYuv5d0KvbfgEawaJ6mGnq4x3dwqiaTy4vA7tvYdYHLXeY/73ivZGFvb5qI+VwFry5Bl4d637g6JF7T7DJTHqLSf75WGsdT8JE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710967905; c=relaxed/simple;
	bh=zKby8EXEUAbjkWwrs/tW4u+OfP6FmUiWOvBa0d/hjDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HrGe9ACuHUcHfQKuG5kxx/Bs6q8yLVFlT6DURhUSoPYnA6qiCyYsxm6ISpsxoguuf5FatwaNWGaxgsqTOuv+7hglf3EYtjQQdPWkagtpLiExXXxJghjALhDNfRr/tfKUZJenMqotdwQPASYKNUO7ljVJk/httXJTPYAaYphvT+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 18124 invoked by uid 109); 20 Mar 2024 20:51:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 20 Mar 2024 20:51:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22409 invoked by uid 111); 20 Mar 2024 20:51:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 20 Mar 2024 16:51:43 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 20 Mar 2024 16:51:41 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Chris Torek <chris.torek@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Ignacio Encinas <ignacio@iencinas.com>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 0/2] Add hostname condition to includeIf
Message-ID: <20240320205141.GB2966606@coredump.intra.peff.net>
References: <20240309181828.45496-1-ignacio@iencinas.com>
 <20240319183722.211300-1-ignacio@iencinas.com>
 <CAPig+cT4fpX7Kczu0+H5TZnmpVqqq0h8nBafj4UqDs7Xv2Nf4A@mail.gmail.com>
 <xmqqa5mulycz.fsf@gitster.g>
 <CAPig+cTFRAmzBGiJv2F-k1XWvGSbT8UeAG57T+XpB-1w66HRkQ@mail.gmail.com>
 <20240320001934.GA903718@coredump.intra.peff.net>
 <CAPig+cT9QxRZhZyZV=Txt1VfqzDZX=gDbXvFg1nO=rjeMFaBeQ@mail.gmail.com>
 <CAPig+cS_hCOnAuwRd_dY5h37-wgHCk2tjS7asm2Dm_p=s41X3Q@mail.gmail.com>
 <CAPx1GvcVZgsU+WHecLd8PWo_MN+wJj6wQ-G5nxYvWnOUOhfQng@mail.gmail.com>
 <CAPig+cQOAfRNrzyr8ABMxkNzbazD95AN4u=T=xgTUnMF0zHZpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cQOAfRNrzyr8ABMxkNzbazD95AN4u=T=xgTUnMF0zHZpQ@mail.gmail.com>

On Wed, Mar 20, 2024 at 12:37:22PM -0400, Eric Sunshine wrote:

> I have some vague feeling that this idea of using an environment
> variable as a condition may have been discussed before and possibly
> rejected due to potential security concerns, but I don't use
> `includeif` myself and haven't really followed past discussions, so I
> could be wrong about that. Peff would probably have better
> recollection.

I can't think of any security concerns; if you can control the
environment you can already set GIT_CONFIG_PARAMETERS to do whatever you
like.

In fact, I think I've suggested includeIf.env before. ;)

Ævar even wrote a patch, but I think we got bogged down in issues of
syntax:

  https://lore.kernel.org/git/patch-1.1-1fe6f60d2bf-20210924T005553Z-avarab@gmail.com/

-Peff
