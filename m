Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28C330F7FF
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 05:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791178348; cv=none; b=Muwa3OR9GW2i0kcOY5garo1nJqHT6c8FYaPtEOxzWK/Bf2LpaeWhE0+YxsnANvolD6bxGHMuLDneg7DQd4l27+ufCkLqD1mmGM0ds2E6AxBUHxLytkwi0naWbwugQvQpDX698La61inpQDYaMfiIaqMg28+1U4zrREJQEcL0eIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791178348; c=relaxed/simple;
	bh=9NUwJoMnueV+ZZXeEj8Zql6epBMJjLzcub5aF7qRfHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hX3ClVzj+nyKlaUIDOgDIThgaNEaqWnTBeJ4sJeqdf5mX/rE5vxaoeO8WX5P0OoMVxoO21KHugyiQ9VQvhXVfm6QoqPqYNC9z/TJy7M4MtuKHabCxKt6CJDPGcmdnOjow6IfHDhmVbskWDGSH6b72V87xo+YnhFVUGtMrZ8C6/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nadtJAQr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=htlV0bLO; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nadtJAQr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="htlV0bLO"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 82948EC03AF
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 01:32:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 05 Oct 2026 01:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791178345; x=1791264745; bh=gMr+KItwbc
	RqjQ1ADAjriK8qtPxTL0FevJ6nJ99XyhE=; b=nadtJAQrlTHK4yDNz4qF/zH/Er
	2h2Uu2QpZRh7LXI10AnlF0JoRczVYnHGnZyEkv8EtN7XS4XbCJK1uTDcNoHm1XmF
	6JNAblAQpmRpatpIJcnPTN+6FMUrpWsxIJNlVbCIUxw/FPkVG0uPoxAJOTwydvHt
	nWGBNE10vEWV6h+2+Q+12GZj5jp3HdZ4Rmmqc+g0N6YpKKc1k8cYPgghO1aLe7we
	Ro2VzXLqpehSjbSKk7fBcvrDUE75OZW0dYsgpJhaQd15IsOyzOQba5jXkt2y9Iys
	4Mdu8IoAjlROaddEGe1jZDyYj8HXFCpiEAa8CrVDxmZe7snrmo2ujExD4Lbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791178345; x=1791264745; bh=gMr+KItwbcRqjQ1ADAjriK8qtPxTL0FevJ6
	nJ99XyhE=; b=htlV0bLO3B4D2JIGF+OcYrAXgwXdbWs0FVt/zMi72cmIPUS93Od
	oCBj5KLkwDZ3WY+yJCuqfUA7vVCU+y6o5CHcVry4UcQ3rO3yIr56gUPuWqz/9Ddr
	lqgr8XsXZ6sBWiLU2Obx4BOHkQVGDlWMuEKU2AhLq0TFw0w25xXPD/KU37dGnLO8
	0qzjff8loEtVGUW6U9noozZqb3YcK5sASEWQETM55gcGUDzlM3LX45fy7j3e8tCw
	/A3JgBA72IQxLBQzGBSWOIXnI8+jeIVnqtOpTxXk8vfqOxyeGnCPKc0gLS/krvJn
	1xhrivkyQpwWjEQpoWtWVHJjjp4a+XctoxA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791178345; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:FARsctrqG3VBn0w9wiKLyyljM0QFjmWi7M/gEQL7dxrmQGm
	jfPplHqew2gLpnZZmgodeUckHoJx0cgFMZXq6wk6UwWv/ZOLwBhkZgYtREg8Fxzh
	7k2avMulqzb+DSdGcCKlbEqFqNPi20eiAf9B4xxeYD7Tu1cZXB0VXIfm4oQmKmab
	Xy9bqd8o7f3sbe+BYFwbmv0LOwDAqeCWuIaDC4+W3LGKShIFjTI14Vbl3YqyKd1/
	ueCzymwVVmD5j6GOcShd8DvI7oBWsD4MkOYlr5B8njQIKCIHlG9Wb+KW2AgFArAo
	kAKG1LqMSqz6Q8vTCgXfKJArKv3U6ega+oTiGfg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:2CC+EaYkyD2uzrMJYRsNakdE+THQzVDJRgo7JfqesA8=:9NUwJoMnueV+ZZXeEj8Zql6epBMJjLzcub5aF7qRfHE=;
X-ME-Sender: <xms:aTbDaugNKlANtBoFLJhFoCKlADJNsZx6fE3rkFFXYBvQD-LaSvEFSQ>
    <xme:aTbDamAcdU_kqmieD_3l9t6_WWHCF0PZQGYrx_WIATLTr0bQXllwpNo7IJWkiMLCO
    Sedi7YIEGluCpJr7H2KDl1RakpcplphsReUeP9h9FcuyyjTR5RR9II>
X-ME-Received: <xmr:aTbDarFixeJVB4dMl70ulzC0-oBgJgpjFhtGm0uhsWVEr2YPyoNFj7vC2ETDf5KdS3QxL18>
X-ME-Proxy-Cause: dmFkZTFnlg6z/hEcm2gXeAUgxHUNZHvQ+qJrqwI01KpD2L+apOqpT8Ur+EJSBBJEaKoH3w
    AMw9qN2fswj78uvZaFkLzi6H3o9brURwIBvy5sFQB9p0D7lKOmazuSNuIK8em/paxQ5BmN
    x9BxpZ2hE8zxQPJ0iP4VAg/dbES/V7AsueckSuqriP8ohaqbBa7heuP52q5NeKkDHaAHDD
    Szjld80r/o5bI+l5DkXQNycxrS/Z0/Wjl51pq0RWqL0YtvQe3NJHTfeIxIHujiiODehrTM
    zY4WYhFQTLw1iFCT1yzUoTw91+XEl200F4S9pFl25wNPPLfoMNzIVnpxIF+R+/NXUrGQJE
    IDZ/PJJhdWBtUlsIImMsnlV1L/KyqAge9hhF/3W0DWBvHEgo9X9/mC4lfym3fupYU/tqos
    tSaQCATMFXPzskCZrNduCXzPJqKu5ugVGnDqe0VYWW2KsykiUdOMIIaK5tLSITZISeGzdz
    c9r48jzmyt42/hQs/ptzqFNe4RZ0irbmoQiHuLJNQq2hq7syrFwUvaWoAa4RKFIq3/4bxX
    6Vl1DFmLconTw0zplosq45tugnwq2Jw1B8R6QOq54Gi0R9jIYv70KRyPFEO3gWREi1PZd5
    4HirJicQdylv0rJ+qC06raaRQY7HB//9HIv9CvdmHelNPrUzB0M/I2nAfA0A
X-ME-Proxy: <xmx:aTbDamIZAjf8r4nxaf0zXxic8Mp-NJqUlrq19Yi9imc5VGC6E-jrhA>
    <xmx:aTbDankQTF6-_ZDprcUhtYph_Pt8FPCRmH6l_wTCp6RZufTV_fh7Jg>
    <xmx:aTbDamQHUukV9SLXKr-XROD1AicFsUpK52psjbs2EVsksYwJrM2P9A>
    <xmx:aTbDahIRrBo7djCfwqqjR2khkMQdJqK7m5HzazsI9VgWCDZ-bHlsfw>
    <xmx:aTbDajJ1ANgvenqREKCgrN_B7Xf_2fIQDri6YAKnIqK8Zmov1Fr5kikh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Oct 2026 01:32:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 499fe2bf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Oct 2026 05:32:21 +0000 (UTC)
Date: Mon, 5 Oct 2026 07:32:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Guillaume Chauvel <guillaume.chauvel@gmail.com>,
	Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 2/2] packfile: fix corruption due to stale delta base
 cache entries
Message-ID: <asM2YoImN8bHLHj8@pks.im>
References: <20261002-pks-packfile-stale-delta-base-cache-v1-0-7592a3e31ae0@pks.im>
 <20261002-pks-packfile-stale-delta-base-cache-v1-2-7592a3e31ae0@pks.im>
 <20261002222335.GC833115@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002222335.GC833115@coredump.intra.peff.net>

On Fri, Oct 02, 2026 at 06:23:35PM -0400, Jeff King wrote:
> On Fri, Oct 02, 2026 at 09:34:07AM +0200, Patrick Steinhardt wrote:
> 
> > Note that the added test reliably reproduces the above bug on my machine
> > that uses NixOS at c59305bab206 (cosmic-applets: add missing runtime
> > dependency (#566040), 2026-10-01) with glibc 2.44-25. But as we rely on
> > specific allocation behaviour of glibc it is very likely that the test
> > will not work on other platforms.
> 
> At its core this is a user-after-free bug, isn't it? If so, I think it
> would be fine to say that ASan will reliably find it (and we don't even
> really need to demonstrate the complex case where the packed_git has the
> same address; all bets are off once we access the freed pointer).

It doesn't though. The key of the cache is the address of the freed
object, but the value is a still-live object:

	struct delta_base_cache_key {
		struct packed_git *p;
		off_t base_offset;
	};
	
	struct delta_base_cache_entry {
		struct hashmap_entry ent;
		struct delta_base_cache_key key;
		struct list_head lru;
		void *data;
		size_t size;
		enum object_type type;
	};

We only use the value of `p`, but never dereference it. In fact, when
I enable ASan I cannot reproduce the bug at all anymore because it will
hand out unique addresses.

Patrick
