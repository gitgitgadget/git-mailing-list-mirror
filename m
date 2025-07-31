Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2525D25A642
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 22:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754002479; cv=none; b=Xf3E5LfFV9BUPkwr8Y7pwELUQehY3op9xpKUbr9/M8Z/w5T2rhxxSaMR0ViFK4ABijNxHyDDuZdst85LlaWLnSYB587KHpu0ZzQlXw17kQROA0MdISCGK4VMuZ4c2X+19EeCxrFEGAkk6yetr1lAYRW2sWnUVPy8pz54uyIOUfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754002479; c=relaxed/simple;
	bh=l1FP16XqegeLa2iB7j5qoVcP3XwwYkMZggY/sTKo1ng=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWzUD+USeWu1NOH2Cs2DhfyeCQV3bxaZOTFESvhTbHxYhyQL+gEvkX4g9iNpvnXTRMQ/SQSImOncOXdvUkGLJvpktRXfp2ob5If6+gNPqruZkq0422/Y/lIx4GPEpg6DRZbb/0sJtvVM/t8T5amxU670Z/YYSS2wIbGV1+OZpT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VhXR5v7V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X0/Xt1J2; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VhXR5v7V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X0/Xt1J2"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 4E8E7EC151F;
	Thu, 31 Jul 2025 18:54:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 31 Jul 2025 18:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754002475; x=
	1754088875; bh=z5z1REEqIIkoVO1oglXeEM/MBSU2hlFVKb1WDLwGWFk=; b=V
	hXR5v7V4lBmLOilp2sUGe+PJvWqNl6qLDqTLTY6zCt78+MkcU4hF5/QTYtOmGTt5
	brqPv2J9P6QW1tt0VdJ25LvsHn9LK0bKVgvjIzCgYQKZaAqMZhLEhVWYRey24Nci
	X9GqLNkEHrIc7SBHuSrBLb9KJ0fn1/yLD3IXK3NCiMfS119VVpF61112OnFFMKU3
	iWJazMNM3Yu+B4GWmw+L9SjZst69Qou19/knQPKinWjqu6okfs/vRj36R0iT4Mtn
	zdMWghTbCQt9YR8mUH8fd9Sf4I1yibKXJfDn4f6S9p4if0f719HIuCSDtsOuXIwY
	FVsGIYUpOQldi6QCD4SwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754002475; x=1754088875; bh=z5z1REEqIIkoVO1oglXeEM/MBSU2
	hlFVKb1WDLwGWFk=; b=X0/Xt1J2HEpNNlhPy+Cm/X9txUxo6cM/Y+UEusucLm6t
	zVu3SO12uWp/u/Y6dwhJpzur8vDfr7c9z6K+Xt25Yc2JzseWot/5CPgHu2B0383z
	rgvoP3Hbho/+ObQ0WIMMNP+b0G2DP3Cc1HcoUHKyfAbbirIxzVIrH+yEuy5MRq6d
	tYZRy3sZX+/eBjncQs8AiP27ZPnMVC5uTxptbIZo9EZtS6SBgCzLwVzQGIlJoIoS
	Hja0vbdIWFalQp+7H/J2EGnxYoggt/bF2H4DUpo6Du+QAmuoIyJHM5+KDO6WjCR+
	7n0ulJYjfIyXu0eOFE0/wyhbN4Nh56+7Ef/iP+2Q7Q==
X-ME-Sender: <xms:K_SLaHL11sikeWLrEx4JXGARNSgAMvDYIUlmfsR4yQ0lcPYlo1L2_w>
    <xme:K_SLaLXja_kUpGW1HFT1NDKEyOQZifclhrMOZDtfs9SS98ZrcbTpWG3EMD53TcT2l
    5Lm8fR6WJmByQ9nNQ>
X-ME-Received: <xmr:K_SLaBjbOioKIRhh7L6NP5eXWvxHgTzrZHLGJLRSGtIspdlA18nltsKYko6mh0BeFkq5X42AojPb51GuOrJIIV8Kd9lFgTnMXisaAdY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddvtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:K_SLaO9WzY97-Zz4ry5QNMt-deL_aPeqEA1xbI2iyDERMIm8sTmJtQ>
    <xmx:K_SLaDCpdLqYqnl_gJ8LmhubLELDwKR5jXragYpIEPt9SzN-Djctxg>
    <xmx:K_SLaDLcgaeNSiMGdD3BHaTz0-zWdDEb2Xf2PeufiUDF0fORQ1sNfQ>
    <xmx:K_SLaOmkCQoFhVVvc_SOoL0H3J2N_7q8-hmYPX_pvHcVtm-vr4lY-Q>
    <xmx:K_SLaBuSuTt220wkioJtPbChLMPwVdphCkXqjSAGIaWQQv88jT-k7cvD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 18:54:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 00/11] do not overuse strbuf_split*()
Date: Thu, 31 Jul 2025 15:54:22 -0700
Message-ID: <20250731225433.4028872-1-gitster@pobox.com>
X-Mailer: git-send-email 2.50.1-618-g45d530d26b
In-Reply-To: <20250731074154.2835370-1-gitster@pobox.com>
References: <20250731074154.2835370-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

strbuf is a very good data structure to work with string data
without having to worry about running past the end of the string.

But an array of strbuf is often a wrong data structure.  You rarely
have need to be able to edit multiple strings represented by such an
array simultaneously.  And strbuf_split*() that produces result in
such a shape is a misdesigned API function.

The most common use case of strbuf_split*() family of functions
seems to be to trim away the whitespaces around each piece of split
string.  With modern string_list_split*(), it is often no longer
necessary.

This series builds on top of the other series that extends string
list API to allow string_list_split() to take more than one delimiter
bytes, and to optionally trim the resulting string pieces.

I do not plan to eradicate all the uses of strbuf_split*() myself,
not because I found some valid use cases in the existing code (I
haven't yet), but these patches would give interested others enough
material to study and mimic to continue the effort and I can safely
leave it as #leftoverbits to rewrite them.

Junio C Hamano (11):
  wt-status: avoid strbuf_split*()
  clean: do not pass strbuf by value
  clean: do not use strbuf_split*() [part 1]
  clean: do not use strbuf_split*() [part 2]
  merge-tree: do not use strbuf_split*()
  notes: do not use strbuf_split*()
  config: do not use strbuf_split()
  environment: do not use strbuf_split*()
  sub-process: do not use strbuf_split*()
  trace2: trim_trailing_newline followed by trim is a no-op
  trace2: do not use strbuf_split*()

 builtin/clean.c      | 74 ++++++++++++++++++++--------------------
 builtin/merge-tree.c | 30 +++++++++--------
 builtin/notes.c      | 23 +++++++------
 config.c             | 23 ++++++-------
 environment.c        | 19 +++++++----
 sub-process.c        | 15 ++++-----
 trace2/tr2_cfg.c     | 80 +++++++++++++++-----------------------------
 wt-status.c          | 31 ++++++-----------
 8 files changed, 129 insertions(+), 166 deletions(-)

 1:  79164fa6de =  1:  e254c0b462 wt-status: avoid strbuf_split*()
 2:  85006a11ff =  2:  07306ec99d clean: do not pass strbuf by value
 3:  633dd871f7 =  3:  1dc849eb0b clean: do not use strbuf_split*() [part 1]
 4:  60dd58af7e =  4:  69b885a579 clean: do not use strbuf_split*() [part 2]
 5:  49a6606d76 =  5:  ac90eb1b57 merge-tree: do not use strbuf_split*()
 6:  3813cc0e4d !  6:  68dd2be7ae notes: do not use strbuf_split*()
    @@ Metadata
      ## Commit message ##
         notes: do not use strbuf_split*()
     
    -    When reading the copy instruction from the standard input, the
    -    program reads a line, splits it into tokens at whitespace, and trims
    -    each of the tokens before using.  We no longer need to use strbuf
    -    just to be able to trimming, as string_list_split*() family now can
    -    trim while splitting a string.
    +    When reading copy instructions from the standard input, the program
    +    reads a line, splits it into tokens at whitespace, and trims each of
    +    the tokens before using.  We no longer need to use strbuf just to be
    +    able to trim, as string_list_split*() family now can trim while
    +    splitting a string.
     
    -    Retire the use of strbuf_split().
    +    Retire the use of strbuf_split() from this code path.
     
         Note that this loop is a bit sloppy in that it ensures at least
         there are two tokens on each line, but ignores if there are extra
 7:  2bd08bde36 !  7:  1f8c86ad0a config: do not use strbuf_split()
    @@ Commit message
         config: do not use strbuf_split()
     
         When parsing an old-style GIT_CONFIG_PARAMETERS environment
    -    variable, the code parses the key=value pair by spliting them at '='
    -    into an array of strbuf's.  As strbuf_split() leafes the delimiter
    +    variable, the code parses key=value pairs by splitting them at '='
    +    into an array of strbuf's.  As strbuf_split() leaves the delimiter
         at the end of the split piece, the code has to manually trim it.
     
         If we split with string_list_split(), that becomes unnecessary.
    -    Retire the use of strbuf_split().
    +    Retire the use of strbuf_split() from this code path.
     
         Note that the max parameter of string_list_split() is of
         an ergonomically iffy design---it specifies the maximum number of
 8:  ed35491fb1 =  8:  26c782fd7e environment: do not use strbuf_split*()
 9:  5b8fe54684 !  9:  95316b62fe sub-process: do not use strbuf_split*()
    @@ Commit message
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## sub-process.c ##
    -@@
    - #include "sub-process.h"
    - #include "sigchain.h"
    - #include "pkt-line.h"
    -+#include "string-list.h"
    - 
    - int cmd2process_cmp(const void *cmp_data UNUSED,
    - 		    const struct hashmap_entry *eptr,
     @@ sub-process.c: struct subprocess_entry *subprocess_find_entry(struct hashmap *hashmap, const ch
      
      int subprocess_read_status(int fd, struct strbuf *status)
 -:  ---------- > 10:  09e83741d2 trace2: trim_trailing_newline followed by trim is a no-op
 -:  ---------- > 11:  be9c9cb420 trace2: do not use strbuf_split*()
