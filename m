Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA7E244685
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 23:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785108557; cv=none; b=AIkSqEFSS6J9IrIqvzZ4qBynuXgU9ydNI+Lwej+ATCEqQeh5LNTyGdLopaulHZ9+R5iLlmJSMQvCgKaBhDZuUxiCDv992ewsZyz0nTNMBr4OuLXLblBgsoWUKSGgr/m0DtaW/R5AA4VjguNbSy9OGw9muQ4w6UmonT0pvyZRLoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785108557; c=relaxed/simple;
	bh=fxJA+3GBNK5ylS4ZtRK6WbEwB1BLbj8lPJKhDoXiBb8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SVhffLPgRh1aXmN2IwQV165fU98fTkcEDWVLdDRptTKjUcVUzKqL0qT0LhlzHik97LGBfkhfOuWjcHx29lpkqD3Y9ZmIWl2olx6p93p/TianbygXI1TkmjCi8w6+B6mhpaM61wAl1loFLT3hfmDDO2/O52AOlJ4RgqwTaDFgVQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QYeVd6We; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZOd40Ovt; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QYeVd6We";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZOd40Ovt"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 586AB1400325;
	Sun, 26 Jul 2026 19:29:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sun, 26 Jul 2026 19:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785108554; x=1785194954; bh=lWPbuMokKU
	ck4AIM7jbD41wGsjTz+egSsfcA7HebDsg=; b=QYeVd6Web6a34dHKseQ2m3xNA8
	6skIFc4yBFo0BMnpBLyOmlCN35V2TLfg/Bc1KbErUYfsTo7CS0bPAQ3tys4sW/dq
	9gYSjfqHlfVSLeEoLbhOv07piB3jnr0MS275usu+EDgLocel1P60P5z4hYihxXHs
	LzlbazjfwDfaEiovc4lKWFxOycNkIvvq6mpIk8kg7AsxsG+VQu07os0jq35MA4kt
	vzbxqU2LSonJLu15A2TlROeOBTnDxa9PHSj1lpvivDIR4uaqvl0+qPfkfBQ++NLH
	guaBueS6UJYcLpvDGyFDEYsWGtbCJ6sxOadSIJpDNDcqqDP76VRxJUAq6FJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785108554; x=1785194954; bh=lWPbuMokKUck4AIM7jbD41wGsjTz+egSsfc
	A7HebDsg=; b=ZOd40Ovt2kCjaTqrhQlf+aqqVhXtGujec5xBXWP2vbnaQ9zHczs
	y3MZiLLv+JqMQzfvxj7jwu415EPNgChZ3H4qvZS5ygQpT9ExOwu4XjYmrsDlHI9z
	jn8jYFWAm6yAOWHX9/CrR4D9w6V4aNXWfPKJyLs5bRNTAPWCmoSAbZrMUgeX57ra
	Q1GSIb/SMgQRYzcKLNw/VTb50+3Ykrvv56ZOrnrpwTsReDAj8BVkI8X9/pe9JBQ+
	GuNmJLywjU4gsOncjZM1Htd78LXse0n5NlaleWUilFOHULSzRq3VLU4KrRCkYJgv
	xsRs5F2exfKqVe2lUbXv1i9RNY+M16ENfEg==
X-ME-Sender: <xms:Sphman51iYomRMwf01VnelxtQBoDkcAOUDMXYhSxHl5qLU2OyfQPRg>
    <xme:Sphmagl8rwdi2HjIODOILcy6NZtssnpg8jw1wYj-n_n5z_eQHB-psh0xwussr5ojI
    VidghXCPDblD1zXtirvioqVJjEQZ1Jc-kJrC3JTPxhsjD-4CGj9JEw>
X-ME-Received: <xmr:SphmaoRAN156Z_jyK0cjjxgv4DwP0t8XwOOu4STkP7U3xtOpbcfnYQ1Yck3PVpwZXdyJIvqiKEE7IklgdbF8lLC_zS6G4SEnUw>
X-ME-Proxy-Cause: dmFkZTEsOFvffn7XADp+b/OSm+DjDOAFsUuTtVdpBNQlFTsn78wXDO8nZBiPXTl9ktyxFI
    aIUhjdsBKnHn2fJZNXTGOnJKM5FjBrXqd69u64hrtR0E+x03dM1GhvXq84DX4DuiiKVLu7
    KACFy1w03Pk3TuWkG7R0DS23Qz9hLjPAMHwvYtEvRhUQeHDKcNL/rBv17rjZU/7WkpSmhR
    7QLUh273fvgD6/nOS7blDdUpVeKVhS47g47KqkYT3mzgYuD5Z5dD2XwCygF5/Vy0hwXqgq
    IX8TYQwNdvwmCrgcFNJsjFk+OrVajthNb9TOw0NhRPVCZQPILhafaDgcga2zOHtLboBQe+
    xPDeIXgWuQlq3QdNP18ZjV4A90KxpIxnCsmMcGeuMbOxYsE+Xa2C1skB3AZne5efkX2ff0
    3AbE1qSBpeRN4o5XoYHUnYTUdz/jbF+aYJOSs+XZ/ua+Dc+7fbkv3/14F3Wu79BvZNiEB0
    +W/A9JsqTvw21ClO9luB5/kmnziRwmtebUxawF0DOd6X3knkATNRZCkWtZBYpnzmD1840b
    Q38NzQZAt9kwqjaobB75c1iNUzNicF9/a81BO11MNu1e6jSbXYozPB7sGATJiBU2Xg5fhW
    XZqYT/Tt/6U2ljTnrJcFdenPzuoZEqI6uX2zmKRAP/9hltNcwW4z/H6dib2w
X-ME-Proxy: <xmx:SphmavF_GpcxSjO4HyYAQ10X5pVmseeUi7xzR19GZlyiXG3j2Q-gFw>
    <xmx:SphmatHO3HuVJgoxeWa8FV5wQpJXeOCArzN_rTNvucQvNpvb3FSHWw>
    <xmx:SphmatTzr5RVcP9SRXg5xki1P4nQ23ha_5ox_bmzJ1NrOmmN--6j0g>
    <xmx:SphmauK_cxHxN579LQ-s7IOmYXkHNA9sQHKbStspDiHtPLYzzAJREQ>
    <xmx:SphmajfCvcNvER073TDtPzErLlz3c10sUfh9cuv85BPaCK68m2q6783j>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Jul 2026 19:29:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Lucas Zamboni Orioli via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Ben Knoble <ben.knoble@gmail.com>,  Pablo Sabater
 <pabloosabaterr@gmail.com>,  Lucas Zamboni Orioli <lucaszam0@gmail.com>
Subject: Re: [PATCH v4 0/2] mv: report missing destination leading directory
In-Reply-To: <pull.2356.v4.git.git.1785097071.gitgitgadget@gmail.com> (Lucas
	Zamboni Orioli via GitGitGadget's message of "Sun, 26 Jul 2026
	20:17:49 +0000")
References: <pull.2356.v3.git.git.1784842831.gitgitgadget@gmail.com>
	<pull.2356.v4.git.git.1785097071.gitgitgadget@gmail.com>
Date: Sun, 26 Jul 2026 16:29:12 -0700
Message-ID: <xmqqcxw9tjnb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lucas Zamboni Orioli via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Changes in v4:
>
>  * reverted to lstat and added has_symlink_leading_path() to refuse a
>    destination that goes through a symbolic link, independent of the link
>    target, per Junio C Hamano's point that Git tracks symlinks and must not
>    follow them here

I'll review the series tomorrow, but the use of the helper function
has_symlink_leading_path() in other contexts like 'git apply' rings
a bell.  I agree the problem you face is exactly the issue the helper
function aims to address.


>  * added new "destination is beyond a symbolic link" message
>  * added tests: symlink as immediate parent and as intermediate component,
>    symlink at the destination, -f does not bypass the symlink refusal, and a
>    regression test that a move through a symlink no longer corrupts the
>    index (see the reproduction reported on the list)

Sounds good.

When 'y' is a symbolic link to some directory (say, 'a/b'), we do
not want 'git mv x y' to create 'y/x' at the same time we have 'y'
as a symbolic link.  It may be OK if the result has 'a/b/x' (a file
in a directory) and 'y' (a symbolic link), but I think that would
be more confusing than it is worth.

Thanks.
