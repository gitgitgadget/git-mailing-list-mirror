Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA02436BFC
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 12:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783512299; cv=none; b=Cw/LjoVJeIC8BowZavl47sQoJDaCpH5zG2hKf1hS5XqEYblG/XQ9xFNu6TSsrkbNIa4fi4s51JvBoBS2DUKMY/4qQXe2iOXx8HKuVXb+KNix4kf/2YgY8cvY8BlqzfrQ0tq6xAPW6n4zWE+ywD/vHE/SvORcMa2qNtlau4sx7BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783512299; c=relaxed/simple;
	bh=DulsshbJLjYMf+sqRNfZZXYJevgpUyMZXiligSZPoLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRA6jf1lzPL0D1lZe3C5o2l0E3WHXCMLeGW8tHXdomhsWIJl07HA1ESZ02YA84EXjWQyUoHrp6r7FSSmScHdnfprGEBAhS1n/7yJWYHkyH1vMukgE3xHePrrRU1o44UUWOv6S1qOs3tnav0mLeFwvozxmqJpRHoZzBwY4Bgo0bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=G4KXWGal; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a4+NykLn; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G4KXWGal";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a4+NykLn"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 37B771D000F7;
	Wed,  8 Jul 2026 08:04:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 08 Jul 2026 08:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783512296;
	 x=1783598696; bh=BGwvGlAxF8SL94wafk23lmQIX220zbbkowWN5zANoaM=; b=
	G4KXWGalOZ13Es+sYeI12VbuwAevAkpPmgkt2lIFZ1EHbEWmz+3Wau52AsF1IVOf
	L7ECvEtKs0tkVEdT8Tr2eJyaqwFuIBUim8LbyDZ87RwVpcWRVxG2Y4G7roF3iA2P
	jg2puM3Eqs2d/MFbq1xsL8nQhrzgLyp4IZNgfJ3KLS+DLkC0LxhZPOhpvX43DxCH
	0RBqFtyCq/ZNOtWtNRoRoZqf2OiZzSXYFUUfgPJ/o8x7NbUR5+hcGcmi6KWbW3Nu
	IvYYKFkg9HjYQ0VZe1Xpkfj63K65Ze5I27uz7e6wHsQ69qhO9i08tc7v/yJxwRec
	rBKIWkmymEIF4AVmP/L0bA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783512296; x=
	1783598696; bh=BGwvGlAxF8SL94wafk23lmQIX220zbbkowWN5zANoaM=; b=a
	4+NykLn/7w3d3rLBb3Un+p8iaC4KKDrycPR7+VcvoA9G03XTv6mwsmeDlus58liq
	dCGZ+j9/yXkNjMzrAxV0To/ajQm0EP3j6ZWQlYfhtySnegLF75zcAUpWgHEJPStu
	kgeQ0JABVYdx8P9eKEh0Fd7cbJay9l1AxeIqgdZmkKe/7IxqiUiMynNX8w/xuoaY
	eGKAN9tSpGHfGHkGvM7oeZ3KL74A+NsWfwy9cnqGZTxyM9uq5C5Fcm/3d4QtYZMB
	x8MCJf3g9FIyK8cv4xTJ1qew1nv4fXPxIn5BCnqKvpU6oDwxO2gvx3/HjavIdM+Z
	5Wjz1fTr9AECzn/dkKHpw==
X-ME-Sender: <xms:5zxOamTBbFRDdx5hHbESjKJJ_r784CGIPVx0hqACXQ5nhfhO5yaHBw>
    <xme:5zxOavdwr59fx8E9RfV8jmt0h3SkY8qMa9jWM5wK1ES-A9G46WTmVdKlvgfbT5_Jf
    Qx9ZET1UiePbiI4tkdSkpmrcVJTAEDTSenJb2Sb_QElf2ahQWQ-Qw>
X-ME-Received: <xmr:5zxOatpdqDtjcsESJigPzA-L2BKYzaBAGe2JVILriC6cPunJpUKMDZKMa7g-UJtxI4V8GMueknGsd1O4g0KAIbglTtXRmkGPsOAuqQan>
X-ME-Proxy-Cause: dmFkZTEyxJwFmecR/bukEYZ7kicfTJzSg536p5BB+FWL3EOD9qaM9a2QmuNTe2JexRnOI5
    cdlyw/nMkURM8ZUo9QyTW4vgaSZOc1vWjJmw20kCrjwBsrstDOZgPt+sY/ICI494hSxHGn
    rV8869cof3XV74oPyS1ikvOC6mb7fIwNj/33O6Pc0NNIikSuwoa78GLS/KkaOi8FkAYbSQ
    D0t20Vtp/++4pIvzcT2Bv8Q6KDmptuCHRBHmGanwanqtmTtEsGDYMd2GAratCcSmEaLKeQ
    pmPAY77Je+/LHcnB+8JZIxWmWloV3x9rDnVy6ZLViBOveHZTK34PYT/xHzySiIIQ/DfHrb
    xBBCnbpQzQW+EpjiZguJ2prs1pdgmV+TpyyBTMbWMElKGqntOZu6lRp8bB7YzQt2Eur9gd
    DElkMhRA5XWAUooZLL+TwT1zMABd563JeYrbGg3kb4UDlHLq3HrV8a4M2cvyeec1plDePy
    woqjYxrjf4ZyLLQCZmK/S4nzZ4AJVcb/qYuvhfEr3wE3In4FjNPJ6e5GP8/4tSHk8BNM5f
    DzX0Ik9IuZ7CA3EMiizNcsdxpFPfajhu+7J2WYyanp7gwbDtVLgBLty1hdi3p209BUuny+
    i5Xfa9Myv65SfG02D6nwAV9Acl6kb6qkNauiien3owcEfDbMNqGrbTEsSasQ
X-ME-Proxy: <xmx:5zxOao9B5x9uHa-rc8Og_Tw_4LgQLBIMfQu_dRzSXmTIBTUBOaOs8g>
    <xmx:5zxOahczpzKYL_lNjeVpzycc0K4PrxZopmqIA2qCHJNJkW_qAl2d_Q>
    <xmx:5zxOaqKJe2PCm4OL7cfpXq3Zr9YVPcxDu6fB1cFiKHwr_sBK5hU-uA>
    <xmx:5zxOapicocRVXf-ioHghE9En72d_5dlPI4JzSKLX8V3KQkyr6fyr0A>
    <xmx:6DxOavVaHqslrdlwvSH0QtaiHZEtcOqevQ68BVWt1Oayo-Bi4Ag9NjyS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 08:04:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 008e7543 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 Jul 2026 12:04:52 +0000 (UTC)
Date: Wed, 8 Jul 2026 14:04:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Dominique Martinet <asmadeus@codewreck.org>,
	Pablo Sabater <pabloosabaterr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH RFC 2/2] builtin/history: print feedback after successful
 reword
Message-ID: <ak484Ywk97k-8ULs@pks.im>
References: <CAN5EUNQNj86Q+hi6PouOZNWo1T4QTQ6sE5Hs9USZXWpkTedTcw@mail.gmail.com>
 <9C91B027-C24A-4D7B-A3BC-5CF3B04D990C@gmail.com>
 <akyKDtuHTHZGEpFx@codewreck.org>
 <CALnO6CAjZfK3hPWn1vOxgw=4=cjRYEHabYJmJrpVVDU8yyQn_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CAjZfK3hPWn1vOxgw=4=cjRYEHabYJmJrpVVDU8yyQn_g@mail.gmail.com>

On Tue, Jul 07, 2026 at 12:10:12PM -0400, D. Ben Knoble wrote:
> On Tue, Jul 7, 2026 at 1:09 AM Dominique Martinet
> <asmadeus@codewreck.org> wrote:
[snip]
> > So I agree with Pablo's suggestion: printing old/new short hash on
> > success would help visualy confirming something worked.
> 
> I think we have the machinery for this (see --update-refs=print for
> git-replay, for example), but I'm surprised to learn that we don't
> accept --update-refs=print for history.
> 
> In any case, I second the "we should emit something"—I wonder what, though.
> 
> - In the case of rewritten refs, we might like to emit the list of
> rewrites, a bit like a fetch or push will do: "+ $old...$new $ref
> (forced update)" or something
> - For new objects that aren't pointed to… maybe silence is a better
> indicator that "we didn't do what you intended"? Or we could just
> print the new commit objects "$new [unreferenced object]" or something

That's exactly my issue, as well. I'm slightly in favor of not writing
anything, but if we're able to figure out how exactly to represent
results to users in a nice and consistent way then I'm very happy to
change my opinion.

But that definitely needs to account not only for the case where the
current HEAD gets rewritten, but it needs to account for any reference
(including detached HEAD) that may be updated along the way.

> > ... But it might be worth to ensure that the commit has any ref we can
> > handle (if --update-refs is set then the commit we edit is ancestor to
> > some branch, if not set then it must be an ancestor of HEAD)
> >
> > What do you think?
> 
> I don't think it's worth restricting the operation (I can imagine a
> use case where someone creates an unpointed-to object and later makes
> the ref, even if that's a bit weird), but
> 
> - we could have a "strict" mode that ensured inputs are pointed to
> - we could warn when only unreferenced objects are rewritten
> 
> ? I see git-history as very "porcelain"/user-focused, so I think it's
> feasible to add output niceties (and optionally a quiet mode to
> suppress the messages).

Yeah, I don't see any issue with having such a "strict" mode, either.
But I definitely don't want to enforce "arbitrary" restrictions that
require the user to work around them. It's intentional that you can
rewrite history of commits that aren't even reachable from HEAD.

It might be sensible to even make the strict mode the default, where you
need to pass a switch to rewrite commits that are not reachable from
HEAD. But if so, we need to have a switch that disables this mode.

Patrick
