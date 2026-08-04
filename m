Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E068B3EEAE5
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 14:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785853867; cv=none; b=WKViXduCdM3qi3TkaFNnIscHFPZKmGzYtoLQaJJVYCNF1nxgjk+ZV8rkjhj/Hz/pv63+XHxS+kM2HC+VTHenXFb5CmP5tZ0aUEQCciEpIZv4fBmEz2CRKhrYKdeOVV+eKGbGZdPt4vsk8XeNT8cjWmkjKw4jADreQUOMPAFLfhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785853867; c=relaxed/simple;
	bh=P+AU9JdkM5kSOOsLDxncpWn2hKBmCH1sI2O+9lC3ojo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3L3GUmU9zI6unSJKJ0D3PQN/aTGx/nbvam2KRs96OoQiCfp6Ssq5soVX9nNvwaQhXtVgH4Q+6zQW2kf6qTVdvE9R2pKuEGph5iMH9mj0GBLtVOL5IBZdNNljLPLyrfgDoQRYHpbZJUcNlH6XIiWnTsBN7moyXPnxzjfoqHF7iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PrVgBDkp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G185erZ6; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PrVgBDkp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G185erZ6"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 948971400112;
	Tue,  4 Aug 2026 10:30:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 04 Aug 2026 10:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785853852;
	 x=1785940252; bh=RetsLf6fqv/XFdbQEPCvI31seRBkIBfnTlntx0bBDgE=; b=
	PrVgBDkpt690URcJch6R3L8BytPsdTfb8QV/t9+tXIHpqe9DCa42wjLZXivYytQg
	6gpifcl4m2vdBGI1BFlOgs/T8FScnv1e2neKRi56S3azZH2MeHtvhIl14cQYoXLH
	5KKVhCKiE7Bwscf7zoVYOpOBFHCS/cThgqPyWB7VUXnzRTNYN4rxl3x0/c/pUU45
	JG/I+WF3/zD9eztuw5cHiB6VUU0FRasBEJU8O8tuS936AScuF6a6uGJBvQhl/yM/
	dRTOqM9Sp+CUAiFMrOAAAzp8SRqdvS0oD1kJN6edor1wOYXrDidmYzvEdL+s0mBL
	s/GQl+5G+rQufMyPqjtm3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785853852; x=
	1785940252; bh=RetsLf6fqv/XFdbQEPCvI31seRBkIBfnTlntx0bBDgE=; b=G
	185erZ6/mz1OgVcI6/6tyhIkP6SrNjgoU2ecF5S5y5CzD7CsEVzHWtJ97Zo8RCxB
	m4Jjkw5qwUrqaWojtGS/B08OH8chkpfww0pwrVALQVeA9q7S9bOGeUa+mfmLc6/C
	Yn0L9TLpC61RlRCsx7pCPFlkoJAo2hG7qfjyl5QuHniH+p0exsRxGjYRpxzQoN4Q
	93QLPAOT0VC3OF4o9myFb5eLqwBtLuBlrZCN/gUyNwLf1jkJ6g5i10m0vyDO5Fmj
	dcCnD7XfOHcSRydWxzVe0jwPzRfQNEXE5RPLzH/W5anapBHDdmlqLX9s7CpS/3Xw
	DiBkj85kVPXckgMDH6g7Q==
X-ME-Sender: <xms:nPdxaqekk27LOmuqPQ1GPPvup8SN2tSXkYWQY8ABCaU1qbk2oNpqUw>
    <xme:nPdxarPl7bmdgG4iCZGNZrgPpJQGNAN1D5txykXCdf7Q7y8S8rARE1tojyIyj3syd
    g8_eUegjM5sg5_E2O9N8-yuVrlby7AsLrUlqvkUtN6f4Hkcvc392RM>
X-ME-Received: <xmr:nPdxagitl08ozoh-5jMpIVuaKDYa_yvRAiYvcHSVy0gp8IlgHq0MQF6HQRV8ipxBbmFL9lWBO9B_XF4Dm93x6Qb5QUDq9Y18IU3NTzb7>
X-ME-Proxy-Cause: dmFkZTEQc1uwD566AmVWdDzuFTdfFeGYWfeLuUeNYXT4E2QDU8RYOramtEyCJHd0xWaghg
    /WddsyfDEg8quDdNYBFDqVqwJ9OPER+YBfYhIr7qPZg4UavXqvT/s5F59VD5jIC3bf0i5n
    Rlb6YhgWMTDMosZefJi50CDqndEhWF0vtKtHbu5+oeJxFCqsPgU1Yiz4mAlj5kdBX7H3Mh
    repFCJZgrfZtrcrtnfX7m+s0b+CSDyJ2t31Cn/MuCMfoEVlXSn9zIT1Zu1HpwGZlVHswJi
    F2wYqJBwNDwiAamyfibnkn8OeRbD/4J3BbVn/OMaCqYCTWNL9mnu4qMSOwZ6Ip5C/pDASA
    tNIoxGUzf3uhho6o0Ej3J+rEostxNg73m4nSXPMFxy4xGtHQI8Jwzqkp8rjVBRf7Y59mIW
    RgTl/qvJ1CycVPf0R9fxNWmSU1aOJbxi7d4heLmLj8qIsk+4QY+3L3f9H7Oq0lcd29uljO
    EIj3VivTnWKojej7tSfQNqcwbLZZ5HMC+ZqBScmLj17aRo1MIfxBi1yzdKdHTGtBnhFCM0
    BfBFziXPeU1gPN7Br1feOmNpf6dOQnothwYwxse8ICU4camqh8SXrJC7vzVnzT9CXxfJ1Q
    cZhoChL4wyqDYSrKgaJ8DxrKlElyQ+UVcUxB4OeCBPaOvRgDdvQFtbjEaxOQ
X-ME-Proxy: <xmx:nPdxam3qiXUZKopkiXxTEQzUDvv8KGB68P3wgDjf9_Ltq9GcNQJcZw>
    <xmx:nPdxaij0E0RbEW7urPAT6EX7LDfwZkUEonBf7qvnUDX71_6G2AHd4Q>
    <xmx:nPdxaucyUf04MUi_4gVqW2v8BSuycL-yOITcmcuPhjjZ9MzaYTDUjw>
    <xmx:nPdxatlJLZZsdjHAu4Zz5ElbPsXizC3828nzrbFUIdrqsvzW23iD2w>
    <xmx:nPdxakBtqlFVYNQx0htW43WmOyvHUNokWxG_dIewqaTx-kw0uZB1ehVh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 10:30:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 817c1250 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Aug 2026 14:30:47 +0000 (UTC)
Date: Tue, 4 Aug 2026 16:30:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 1/2] doc: refs: put ref migration warning under the
 command
Message-ID: <anH3k9PvWHMpWLT_@pks.im>
References: <CV_git_ref_migration_warning.b09@msgid.xyz>
 <ref_migration_warning.b0a@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ref_migration_warning.b0a@msgid.xyz>

On Fri, Jul 31, 2026 at 11:07:02AM +0200, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> 
> I have to scroll down at least three screens in man(1) from the
> `migrate` description in order to see the “known limitations” for
> it. This is important information since the text says that concurrent
> writes can lead to an inconsistent migrated state. Let’s move that text
> up to the command description and put it inside a Caution admonition.
> 
> This section made sense when it was added in 25a0023f (builtin/refs:
> new command to migrate ref storage formats, 2024-06-06); `migrate` was
> the only subcommand, and this section was visible from the command
> description. A one-page man page. But that is not the case anymore
> now that the command has nine subcommands to describe.

That feels quite sensible indeed.

> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>  Documentation/git-refs.adoc | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
> index ce278c59bfc..98828041c23 100644
> --- a/Documentation/git-refs.adoc
> +++ b/Documentation/git-refs.adoc
> @@ -35,6 +35,21 @@ COMMANDS
>  
>  `migrate`::
>  	Migrate ref store between different formats.
> ++
> +[CAUTION]
> +--

Hm, okay, first time I see this format. It feels like the rendered
version is indented once level too deep, but I guess that's more of a
problem with how asciidoc decides to process this. And it's a tiny nit
only that may not even be worth addressing.

Patrick
