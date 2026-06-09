Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B318B3D88FA
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 07:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780990068; cv=none; b=N5kXyh2AwcQ6p8igIkpWFY1/XNMEM0zmpb7jY+DuTudkoLISn/pVYrk63Pbss9WWGr4iRn9TE6p9E/bxr8LHUWKFH4lIpAHY3cX59UkE4kXFDZzaOcHpOgbt+TaJXtGVgt/9D9H8L+Qn0hfmzbSWxfmrzUfbq2yVwmDTxjR9nQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780990068; c=relaxed/simple;
	bh=hGSBkyL/+f1eAKA5wxlSNzuq4xlRlB6Xwa1aVRTd2uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNVOHaWUXZ2Gz2CNk+i4HLe5G2P/URbyXCcGMrRt91fsgoZTtPcUcGxa2SrKqaVBN6l29hnjPqCYhxXEfECbzaaPufcAw783iSVIqPGUf34WKDrml6QrcAgXPWV7GOrCWdFlQWmeAxboy0dNFT8SdeiX+27/sKqVN/nU5+6Rqqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DeHc6mMg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WwK8RIDE; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DeHc6mMg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WwK8RIDE"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id E40981D00159;
	Tue,  9 Jun 2026 03:27:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 09 Jun 2026 03:27:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780990066; x=1781076466; bh=F96F+Mh+4s
	mv8+hWwETlaYVmlNm/3RZlAUSyyF9MGwU=; b=DeHc6mMgXyNfPGjgTaj32r0Wmz
	fhxjJx1ACEL1geuUEAImI4idmgkpZgM/x6nim5sc+voYbWi4/pdxv3pv3kGNz/OX
	Xk2Sm89aFU5riA+xFbICPjWsIAj34Q7L9ECQdrfDQIBBsEc5PofipbeIjHT+fg6w
	DsB2yAcYmZA2BkUMUMpNasj3mqf/TrIxqKqM9Owaefbq5UkB8izELW9JGcFGa13c
	3F9nOo6szA2kTTCvBZ3/X2c+M2LNU+N77AhoZyhPx7FyuJ8knE14z/GULfmIBtuP
	IgvdeM84PbvE0CuCdhu8ZszKWVWtvdXAWXGk8XL0A0FROxFjQdsEOZ6tR+rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780990066; x=1781076466; bh=F96F+Mh+4smv8+hWwETlaYVmlNm/3RZlAUS
	yyF9MGwU=; b=WwK8RIDEjQwbQzKq+hc/DPNUTHbfZIZiHgZPosZf1kPZc7KgLgJ
	IqXMSbqjL0zo8luk/9jmC5ztjVtRa8gRXdrI7fR9k/0V6hwuhj/nyAWDXiW5Uvsh
	jYvqAxeEJfBMUHHKUrD6EU6VPq+eWGZtPG6ShjHsdvDK0GETt6nKaz5Ea7r1HeDV
	NB0MhY12Nj6yQo0MaTR6jHN+ptKvuBkXHyneUZKzJV7oVyqf2i8WQJ3PgjoSvf3K
	ndH/UYhiZi1QNtrwogAAwPEFkEKjEKNSvadYYLj+VSe/NZ+G24BEWSv7yMSjw+1A
	mv4gguq22AAeEHeS7FQUg4pL5bmg5LDgIeQ==
X-ME-Sender: <xms:csAnaodKkwDwJrVTzyLvu_zYJoSSOw9yVy-fuLqTcoXW9_sfbqttuA>
    <xme:csAnagOlszKvuCEK2gnPEsWmXBQVczP2Ov84NxL24BQA1Df86emfdCYmea0u4kS44
    y12P54ZYkZ64cToieKWrs_aQ0X7hUyyece-azi60Nr51myz14kfDw>
X-ME-Received: <xmr:csAnanLqyukyeS-y8aodwiRrL2iKnQpfVl8dNRpgIXMuOwRYZSjTuecuMa5LKrqENeKBYizxSs7MhtTPYTMz7oebjLYkCmlFYVHAA5lA4fM>
X-ME-Proxy-Cause: dmFkZTE+WiGn93e6aTjpyM1udZTIsILEIP+SMuzxLvAFU5zzzpYSehhDJVkVTdq/uU+Iwg
    avpPTWXyukFYrwMIGwhMWsiePNkRF7jj2GHrDkLERwpQT7lIfyYgfBAi8WaTZv0bNcUALb
    YB4/odYLUPOjvJHTn8qTZlJroTnzCUJzjPoYgO0w6e8gHtJ2RGvVg95G8ZiFsM9YcXyXkB
    mDNnAPmbvXfakYAAOA3rIxcQ991eEt6JQlzG0EK5SKNrIUMkfFgThoHb/MY/iaf8aeZvbH
    bn0vxksPxmNVeyb43q8Sfdq/nO2Sq5OWrHYw9pUt3q+V0+gHL1XGxiYoTTJBl5EC7LiPHt
    +f3H1nexAU2hNjSY4eaznlHJDVQgkjyCE39KYzM4jRtkdzUOMWe+zs1neMbcwlyHbIztjI
    yxgTTboCJPOAUnvfVd3bBcyL+zVv3qncUN3YVutDb8byudVp7bZ3u7fxJBxqKNB2k5yaRr
    ARVs8f1UPGHK3w0d4/irD8uHUwl9iuV3Y0qWB9fVhkXwgNo/VJhU/nto7jAIcI1zkxIWTG
    Yn6pteIzohwLSdyJoW+eMnMQUoGj13OKCsDUwm9uIuc3JLYhYT8D6SEsny2NcQRPRJxX/R
    qQcMKts1/Oewc2AsP4eAxs37bLvlhuDItRTJRFsV86ZID3oUmImDrsX66VVQ
X-ME-Proxy: <xmx:csAnapGH-v4738rsPjh7L1oFhD8i_xEBAF4IsE4upZpGC5qFHlHAgg>
    <xmx:csAnanR86kdJkjA3Sbrm2OdwEDJ0FDaOmOXhTY0C5Xi0LK-bo9_34g>
    <xmx:csAnatEgLzskrCbvcQBxa6iJ0x8Vy-q-LdUiI_AtUMqYxoCW2yfk3Q>
    <xmx:csAnar9xzeSE4YtsZWyoYQ-E_xfQO2Fqm6Fd9IqwnlH0hfMt5wLCsg>
    <xmx:csAnavNVNY7z-TAfhbwN1pPeyfeFcCdBVJHd7bXH_oHcPp0fcgPMNPND>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 03:27:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bbcaa07d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Jun 2026 07:27:45 +0000 (UTC)
Date: Tue, 9 Jun 2026 09:27:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 02/16] packfile: move packed source into "odb/" subsystem
Message-ID: <aifAbwJCPe4Wwklk@pks.im>
References: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im>
 <20260604-pks-odb-source-packed-v1-2-2e7ab31b4b5c@pks.im>
 <CAOLa=ZQ8K53yyopSOp4_Gc-Gpq6ULA0xW6gH5OCWdWNHEyRysw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQ8K53yyopSOp4_Gc-Gpq6ULA0xW6gH5OCWdWNHEyRysw@mail.gmail.com>

On Mon, Jun 08, 2026 at 08:09:06AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/odb/source-packed.h b/odb/source-packed.h
> > new file mode 100644
> > index 0000000000..c17068a4f1
> > --- /dev/null
> > +++ b/odb/source-packed.h
> > @@ -0,0 +1,80 @@
> > +#ifndef ODB_SOURCE_PACKED_H
> > +#define ODB_SOURCE_PACKED_H
> > +
> > +#include "odb/source.h"
> > +#include "strmap.h"
> > +
> > +struct packfile_list {
> > +	struct packfile_list_entry *head, *tail;
> > +};
> > +
> > +struct packfile_list_entry {
> > +	struct packfile_list_entry *next;
> > +	struct packed_git *pack;
> > +};
> > +
> 
> So this is exposed, because outside of the odb, we also use packfiles in
> the transport layer. That makes me wonder if these two structures are
> better kept alonsigde `struct packed_git` in 'packfile.h'.

Yeah, this is quite awkward indeed as the struct and function
declarations are now split up across "packfile.h" and
"odb/source-packed.h". The reason though is that there's a cyclic
dependency between the two headers, so we have to move the code around.

Arguably though, the better fix would be to move it into a standalone
file "packfile-list.{c,h}". Will adapt the code accordingly.

Patrick
