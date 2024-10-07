Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C318510A1C
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 04:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728275902; cv=none; b=uCK2vaDn1G+7m3E3OTlSL7UeTN1uvebJjhxwVHlBsq7yWLOe1x5oZetKG+eSNcGTI7uOChbh0oqqvewdioMysGEi5ZLr6tJm1jzZdb3MiKUCD3gnzmzI5zmC8XfkcNumHrvC4Qeu6zLR6X2q6IlTwe8B/ud2kdgH51iL/u+9yvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728275902; c=relaxed/simple;
	bh=slkWlWHhjR4amjCmh5DJAMD9Ale8i31zxbDD5d3MV7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRrmdEnFl60DIzfkCrv4EPBHx/LXuubPihG+DXCgV6zZKL7RY1ojEQxJ0As4pfXJWpdKwMuhEKudrX7Eaytn4Ozdgedpegj8TUlHsz7IEoWbL4nlZPaVsPCV5g0uAnBjBRU2WNp8kCtA28NIEFyFJBoIq6j57xI9c+Jd2zbgcRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QDg57/Kh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DCIORALw; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QDg57/Kh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DCIORALw"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 9AB37138039F;
	Mon,  7 Oct 2024 00:38:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 07 Oct 2024 00:38:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728275898; x=1728362298; bh=P5crSj46Sz
	PJDqsNixjCefXLYieLoA4MOP1jeGYVS/c=; b=QDg57/Kh3c7OrziO4XUOguVe5r
	PUjQg/ko/day0TpwroxCGHOjlFP9hQqeMifYdDjE1o4ly65RtGaGKR6boTi/WJo2
	gPaY0qUDhHHO+MgID3oWZfSZVbAcfI/+7uvrZMz+lXPjEbCX38macfcA7k8tNtir
	SqQM0ICIQ/PTVmUm9r9eMp9V6k8+2RdW/XOuvGXxWjPZpzqYnvCnQUMtYftEgMEB
	vlH7FErHOoZVN2abK8AkH/6kORPAHW/LKz7qqQ+j2lFDPzEeJdF+ckVaGOm/bJqd
	dq9DuSgdDDxhJuD50AsyeBE6e7PpARYHooduW67PcCtV8FRobjiwsLC1Oz6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728275898; x=1728362298; bh=P5crSj46SzPJDqsNixjCefXLYieL
	oA4MOP1jeGYVS/c=; b=DCIORALwsqWNK8kzsHGwIZEcAcsPtUQJEIGuYQDVj14m
	MbZj3K8ihRdCuiNOFUGLvMuOT3oLmpRMdWKYZ7pl5Bfe0El3sNXceRCZCPtW5YCj
	tCXlrMG1TVyHn/GRYB00gD3Tr8VPGLIc6KPy4ZGavELP0+lfgTiH0Y/x0+wvW+Zh
	zKmBQ7062pk0T9RgtFW0lVH8x9+Nb3/GRBqS3HGPaLbIeLN9IdjqCNpzc/zT4xbt
	RKHHjRAC414ntLlFTNSijNMvAIY7gbgBfChKefd57qYRMXVCR+RuO+6H7AxGnzIj
	IejC8aE8C48vJEg7Kkqhm56V2kR20ebBP5sZGF+10w==
X-ME-Sender: <xms:umUDZzrCX9aOOUomLFl_QA8P69tYZaOSQ1AMTaei7UGaDuWzL--bQg>
    <xme:umUDZ9rqs_AH97uDswzXQ5AhAJS-WJ8eMU9AsRsWd7TOfVfxNiI4hGdsY36FU1T7E
    s0O29izTHM2k8JfjA>
X-ME-Received: <xmr:umUDZwMz86WsLmfBXoF9yHp27664dDSeQ6qFTyUl89uWiRykk-I9RZHxiUfS4Jipet8GELje6hXdY3dxMje-DLVB9zIFT9VraEU2qhGdHmxve0DTDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvkedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:umUDZ27WCA5QWtpUlEJv1QtbgwUPfl7rnXnwOieaJE-EnxCPBEGfTA>
    <xmx:umUDZy7lFTirafbXkkzBfRdjL6Z6Mj0K-3CfcTFIgNln9KmxQjC28Q>
    <xmx:umUDZ-iEiDg3ezdq4OQ5AAt9a4OCJ8wOiuop9oBHZv6EqLT9ZlLdVw>
    <xmx:umUDZ06YBuIWLqm3KGCHl2McpQpiOtXjw_v5Ik3Zf38NJzt9G6Mg5A>
    <xmx:umUDZ4mfVUf-wfII0vvOgeN5CZe6HFu_2xNIlaDf6IBBFvny5vm0CMed>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 00:38:17 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f3104d23 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 04:37:16 +0000 (UTC)
Date: Mon, 7 Oct 2024 06:38:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/3] cache-tree: fix segfaults with invalid cache-trees
Message-ID: <cover.1728275640.git.ps@pks.im>
References: <cover.1726556195.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726556195.git.ps@pks.im>

Hi,

this is the second version of my patch series that fixes segfaults when
the index has a corrupted cache-tree extension.

I completely forgot about this series, and it seems to have slipped the
radar, until I rediscovered some of the segfaults while doing the last
couple of leak fixes. So I decided to just resend it with Eric's comment
addressed, which boils down to a single clarification of one of the
commit messages.

Thanks!

Patrick

Patrick Steinhardt (3):
  cache-tree: refactor verification to return error codes
  cache-tree: detect mismatching number of index entries
  unpack-trees: detect mismatching number of cache-tree/index entries

 cache-tree.c               | 102 ++++++++++++++++++++++++++-----------
 cache-tree.h               |   2 +-
 read-cache.c               |   5 +-
 t/t4058-diff-duplicates.sh |  19 ++++---
 unpack-trees.c             |  12 +++--
 5 files changed, 97 insertions(+), 43 deletions(-)

Range-diff against v1:
1:  413faa2b81 ! 1:  df5a2d0dbc cache-tree: refactor verification to return error codes
    @@ Commit message
     
         Refactor the function to instead return error codes. This also ensures
         that the function can be used e.g. by git-fsck(1) without the whole
    -    process dying.
    +    process dying. Furthermore, this refactoring plugs some memory leaks
    +    when returning early by creating a common exit path.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
2:  4bdcc43518 = 2:  d63087c53c cache-tree: detect mismatching number of index entries
3:  fbffeeb6f1 = 3:  5e578c1f41 unpack-trees: detect mismatching number of cache-tree/index entries

base-commit: 3969d78396e707c5a900dd5e15c365c54bef0283
-- 
2.47.0.rc0.dirty

