Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9073E51D6
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780931429; cv=none; b=JPQq78UM1M4n6xmi+ZmHdPnfgknIJISRxYnlbHi5RhsOhdgj++6KLZb9xse3GGuqOZqp2rkAYCSBkKBMX1gc2v0ucZaEgc8NO4lFMuV/xZ8AH5F3A6jvUHHucWmXjEyl5zBXq52CkV1x4yxr8BhZIPNZ7fHxtmGDz53hhqFJNzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780931429; c=relaxed/simple;
	bh=rZNuBuixRFjmYd8yPPS0P19z05DfRzMnnsp2owfvqtI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rm4KN8Wp9ljWOdJo5Vdnw533+QHqsGkD6db0wWfPEM7xvtUaGA1Zm5cXCPASxCL6w7AhPUOsJjvqvfY5m5QuaRlc+Xi3oNF08wqThjTtB3QKrEzfuIGimnSfj88bPYg8UnG63uKb/JpU8kvipKIn63LpxovAZvB6b7SszxyJm8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VjFhyk1+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QuWjssEx; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VjFhyk1+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QuWjssEx"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 707CC14000EC;
	Mon,  8 Jun 2026 11:10:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 08 Jun 2026 11:10:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780931427; x=1781017827; bh=9yTYbpkcIE
	WVRIO45s+OA5mozkjbzDBSEPA2ui2b3Aw=; b=VjFhyk1+sbdojotHcUmDIxOcIj
	co4GDLvheh5K3bYQThDk+Sr+BOY5HoV3QBeYW7JzfYVQ4JvU2E2QMsnJcPrbNeUw
	J8i/LdeM7+b2dcp1pNSScOHqZmdWsa3LwtpJYmu0wCmH+C+nIneeeqtNW4dLIoqU
	M1kMJZI5ZAMHX9Wsxnie5CLxabExcVK3QP6/7TwerJ+NK8J5vW5+D8EiWeGQO8Aa
	n96p2AE6EFszrW2glE+Yx0IuhK8gSlZoN4plJzxvc5XcXQhohl0CcMBzvn84RG00
	rv+UTwDB7S296oo2T5wZxlpojrxiaOAMmgA8DM9ruXjIWBSv+WjiOEboS6+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780931427; x=1781017827; bh=9yTYbpkcIEWVRIO45s+OA5mozkjbzDBSEPA
	2ui2b3Aw=; b=QuWjssExehgCBACgZHjAy7oVSem2/JiKMOriFjugWwrJNo9DL5c
	TOzE+jypXI7cMahrNRbn4U1gswskCPAfNEZ34ZUKuCxh7javwAQ4/dP0M7AB0o4y
	VklUClJBvh6yxvZL1aEf+n9NDv0opeMkFD0b5kFw9LKdDfZ2BqC+DQpcfgs23L8V
	pKBm79v/1Cinkr3bOG2IO65nU5l7UeJ8RUn8c68NQKanRCYkG9kSRQhZIsO3BunI
	OE+pIc1+5FdGpV/HKRUel5VMB10Ji3NIXXABPRo2h1RsmtNzkPzbkJ/gJW4lorFb
	kh/MV/nwbH2XAHdV3xb7KlILX0XxjKXXhGQ==
X-ME-Sender: <xms:Y9smalzb6QCBKtKsVopQYz3LVzwiVtjYp94-iph8HearxN0rXJUzaw>
    <xme:Y9smasTOpeL8-UbZClUR6CU2cM87PpiqFvdw9depEaT9HHCPea1UtRNdRzFV6JCJv
    hdEXiDfws4D5QieOUDZpq7IF_8PoEeZhivOiAWO6vqNrsInd6LbmcE>
X-ME-Received: <xmr:Y9smakUv93pvQlmbmkmPubODNsZX6MTBAOmvUjJu6sprpvd3w2k9pDO-C_WoXk5YwYYwnRhKUD49uRzDMv8aeVXHOiSYUUbVEBAm>
X-ME-Proxy-Cause: dmFkZTEfheXr+rZ8fDiS0fwGsyqd2ZhNita6dbwM6H6N872TtWMCWHiIX42IXyOXEoRl+l
    uKxUA2bGS8TfDsWzhvRcEPSAbkBXx6DElTmiIdy2vcbTVfY2yDK4WQYz3R4k5hWjWw+IOo
    fuxukg6Iq59YBiAHdBSS9/QwW22Xd5Svzk17zDwpuc20W4m8Txzq+0Ez7itbhgLlBt27HL
    HfyKsea0dakTAN7DIFC7TUmNRvoe1kNwNKvQYNjA03xnNFIMS945QJZqOT9lSIqjV459mS
    fGLfX4DpnKLj+l3ckVfq3AGnNbFR7uMCyNbEnmOUl4m9rLWLuL97HIF26hLCRcYHufo9QU
    hWTqo+IzR4p2oZLDS5XarI+yXhcl2UW0ZZ5i6Fcy/JYt0Mwo3Zxyx8ZsnSVvuWsImS7468
    jWntI0nt+fk1hEWqp4pKu1qhojx4Jy+Cv7AnnpRLvKT0Uqb10+WeOsLNE0txCrBYePyta1
    obVMoIZVrZTOhIxl0EPpZeBQhnr9lXEIY4kccKsmJyfdctJFiwHyX3P3V7/VnUcJRdh7m9
    FaWcOtyIPlm95MLIiOf4uqZkunxnl7eVx1xe+If8Da4NvFRQdENLGqEPTzpOMfeJZGh7uM
    +j3yXO/Fkr0QqjKyE7G2G9rkyjjj/f3ja+kigbTF7IoYQAOQZjD4swoV6fnw
X-ME-Proxy: <xmx:Y9smamYsc7J-9u0ZX-ZAywFMXjlCauf9az__40ttqe3KvGdjNjBRZw>
    <xmx:Y9smai3BNoTVxiuoeJhhdIebQjpL_boTlEGObglwj0T-v_sHY90tsQ>
    <xmx:Y9smagj88OZti1HDuBxuFtABXl-DueFnNK8CN2oacBrUI-u1DTzfeQ>
    <xmx:Y9smauaSVaYzesIaBd_zden2_lAOohgVDsgvhsmoR5V4aXYinH1LIA>
    <xmx:Y9smav9CXu4JT_1AnyjA9iiYByxA_MC15rvSSUfu3q6wIMjnRv9TXip_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 11:10:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Miklos Vajna <vmiklos@collabora.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH] log: improve --follow following renames for non-linear
 history
In-Reply-To: <aiZipugmA7z8oBcd@collabora.com> (Miklos Vajna's message of "Mon,
	8 Jun 2026 08:35:18 +0200")
References: <aiZipugmA7z8oBcd@collabora.com>
Date: Mon, 08 Jun 2026 08:10:25 -0700
Message-ID: <xmqqpl21vzj2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Miklos Vajna <vmiklos@collabora.com> writes:

> Have a repo with a subtree merge, do a 'git log --follow prefix/test.c',
> the output only contains history in the outer repo, not commits that
> were merged via a subtree merge.
>
> What happened is that 'git log --follow' used to store the followed path
> only in opt->diffopt.pathspec, so in case the commit history is
> non-linear, and multiple parents had renames to the followed path, then
> the end result wasn't really defined: the first commit that happened to
> be visited in one of the parents updated opt->diffopt.pathspec, and from
> that point, only that updated path was visited.

When describing a problematic symptom you are trying to improve, you
should talk about the current state of the system in the present
tense.  "used to store" makes it sound like in ancient times back
when Linus wrote the first version of this feature it was so, but a
few years ago that changed, but that is not what you want to say, is
it?

The above may sound picky, but using the consistent style of
description makes it easier to follow the thought process,
especially when you need to read many commits to understand what is
going on.

> Fix the problem by introducing a commit -> path map
> (follow_pathspec_slab) that stores that will be path to follow when
> visiting that parent. At the top of log_tree_commit(), if the slab has
> an entry for this commit, we replace opt->diffopt.pathspec with it, so
> the correct path is followed, even if an unrelated sub-tree changed the
> path to be followed to something else.

Can a "map" cut it?

If a history forked at commit A, with two children commit B and
commit C, and you started traversing the history from a much later
descendant M that merges these two lines of history (i.e., M^1
contains B, M^2 contains C, and A==B^1==C^1), while traversing down
from M to B you may find that you need to follow path1 and similarly
somewhere between M down to C the path you are following may be
path2.  And the traversal meets at A.  The slab records path1 for B
and path2 for C.  Wouldn't you need to be able to store both path1
and path2 for commit A?  What path do you need to pay attention to
when traversing past A to its ancestors?
