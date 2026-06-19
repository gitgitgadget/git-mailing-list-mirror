Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC4F3B47C4
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781883696; cv=none; b=AqMcnQRn1/5xLXlgrIyQQ+SIDcrmB8RRMemC5JC7NDjje7IfhE0VoNEqjB1/QigqXjUWa77lTXrobDHIsOI+dtUjc6wkBsTv9tExKQDy0S3oI9FWvJMuDmzeBgnHi1jh5soWNNwdryzlhkIs8ln/HJaE77msjqht2y95Dndv4Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781883696; c=relaxed/simple;
	bh=/mE1fhPUn15yIUMIMKiKlaIrD/oo3VBBThyWdhlKQcs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OCdNa8jfKGoI1PGdNbuNnWx5bT3XT67zp/UzxBcsIghZFRUgKeFUVE0UHcok7N4oqz4gYiIO6hVmyvjlEEtvTd0nPlEpncB3Dvqr8hAtmhi9ubDeRaKDnP2S6ImdAlGookcDmrjiIfsisAxDzyEr1U5B3auWsZjkvNzPY3LRbyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Iq8VAyYg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eaqR010G; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Iq8VAyYg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eaqR010G"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 43AED1D00049;
	Fri, 19 Jun 2026 11:41:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 19 Jun 2026 11:41:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781883692;
	 x=1781970092; bh=qYcf3tPXhc3mtUvZTBk6WdNmNuH0M9bXeiqsz9/hNO0=; b=
	Iq8VAyYgc80zIKeUtPSR6IdWo2r2dRkVtUpBnRDw1U20BYfe5qLwUpmAMvosvm57
	ZFnyMGImcSMbgeSo31vjRwmySr6LWmLXHavHZBJU8/PFEp3BeqFIri2ybxrUTBp/
	i5UPJNHw+SmDAtl4qlKqNXU/4q2RiQW/BSRmBrWQitFaRFeUNJo8UymYFlsqk88g
	GRJt9MjkhZxQ0QNZ3K2pFLZiqY3pyYWvyWtsPpbm/QhAlZ1ZcaNDVvegBLSQYFuu
	6Ndq4XdVpq+W+JnW6ToqE0kOyZeH3dGIc7bdAmAi3+3w4BXYnczwQR45IFoZNF44
	vpqwY/tOYMZCJn1gdLgbmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781883692; x=
	1781970092; bh=qYcf3tPXhc3mtUvZTBk6WdNmNuH0M9bXeiqsz9/hNO0=; b=e
	aqR010GQRrVgIYxfXn112bjnqm2PZu+xR4ikGPAH/043UTUlzcBXKUAHlFOjryh9
	CcUsqBuGxfitY0cczYGeVdyPuVpPDQIKeZsd68nIHnUNDPXVdOAnfNNQ9f1q1UYX
	WSAVPjjIZx3r8zhQM8O5N7/1e/bePhdatxpLTdwM8V8qXmslpTS7/RX/5dOkIriA
	thsyg8iz4/RjaMW7lLB2M4uwABkli2o7krsx4RSAsogKKMbbAYt8S0FPOdGEjgDb
	FK4g/XdjwEG7OMJn6zbhMLVl2NdHTmyP2P0ID9ixyh0OJdjH7UhyIk9xsO9UVUcf
	bXvF6u4bYfuMipTs9IMkg==
X-ME-Sender: <xms:LGM1ary0mXKvET60OEafbyNjnp5ZUSZboNL8dhr3Ue3UVFl_ME6ANg>
    <xme:LGM1aqScUeyh4bZMVB4SPg8TLACKyOoQ88LrNrJOrLtcenS51ahMHVpQv_HY23nrm
    6HgucTakRjAA70n7bgJkU9NRFN_RHQbGX6U3JXuDujQhGxSig8>
X-ME-Received: <xmr:LGM1aqUXlf5VbUcG2P3Lb8eud-PLV7KBhsF4Jonz2aPxXxvJFTfnvKl_lWxCL4Nxq8EiXVcpIesvUFe5oKEXPMf2gtYVA7FJFPWG>
X-ME-Proxy-Cause: dmFkZTEUAZwmUXubT2A234bKzNNYmQVK6E9lTjZudJSAyvF5LDxpb6bYy8aKgZ4hV2YX4C
    U0hIChEstg1OWtNsgnIDiI24oTbyU9Ik2dmE6I7TyB0XVpHU2XzZaevRX1R1vdk8TA59tx
    o9YaRBVj7SvuQq/1jWXne9Tbu9W6nPSF40c+mfxEK/eJoSx52hgc0cOg3IoozskmbCU5kR
    EBm4r5G94WotKEk4OoriIMMLqXjoio9++hy2JmicdlSNZY4nji32+SxrjcQaAp6GbNG6YT
    Jo4fCqvzf7GTStU4CHdlYB74vEXtI2kcCS8paxK+6/G74zaXL3Cue7+mJwN8TN72np+4Sg
    fIj/MfmNyJENCI0P7FgSA5LU4/n0UVXMTwnesDc+NFoTMxh/OmKSUX7KY9KTLMQz6rc+9X
    ZVbB/Ens7VUyTF6f6TqQq3su3mdADicZ+L1b0HGs5osnWlx70jhUA/jLg3zyBkEG1rmTxk
    XN8pWbAfZwuGLsGXSSnnIH0l/Vx/u68/3XC/2hoceSucUYKaT7JF0Y0v5HK7nDOqA6e9O9
    qQNUEAFMGDcWE4X7Ovgma7PcMjltEqo7MjMtlxaF78B/9QQzdKHDBcTyLJ+HZbJqGi+Aus
    5qzNC+X2imTfmQ0HpF+ApDCmXPByB2g77nOsyGU/r93JiGTqSPBaCiDvrsrQ
X-ME-Proxy: <xmx:LGM1akZd9ROL8KDEqEk4H10ZRWxWd3OT9hoEroL1Cy_I-f1dO4-J6w>
    <xmx:LGM1ao3QDk_y03uCArNq7TiZ5NYh-DKD2pSGUYUdbmx1DLeiIesaLg>
    <xmx:LGM1aujHP8-jYLIQ9FBxV0oIhOBpCLRpqsKbSMxMrSaeTWkWx1EE-g>
    <xmx:LGM1akahjY2un5DNeRkEPI9fx4HqBuVKYPdM3UhU0SMZU4uklmPlOg>
    <xmx:LGM1ah1e33SMuD31el6LgPXPH4dIEqeVdmtuL5i84qn3XNZOKPpRZPLI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jun 2026 11:41:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH v2] Makefile: dedup archives in $(LIBS) so link recipes
 don't repeat them
In-Reply-To: <CAHwyqnWBb65dC+qSYTw9SKdufjibUmTm065feM5D9906H5SQ4w@mail.gmail.com>
	(Harald Nordgren's message of "Fri, 19 Jun 2026 10:00:28 +0200")
References: <pull.2314.git.git.1780269406949.gitgitgadget@gmail.com>
	<pull.2314.v2.git.git.1780610623006.gitgitgadget@gmail.com>
	<CAHwyqnWBb65dC+qSYTw9SKdufjibUmTm065feM5D9906H5SQ4w@mail.gmail.com>
Importance: high
Date: Fri, 19 Jun 2026 08:41:30 -0700
Message-ID: <xmqqldcamtat.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Harald Nordgren <haraldnordgren@gmail.com> writes:

> I think this would be quite nice to fix for all the macOS developers
> (I don't know how many we have who are active on this list), but when
> running repeated tests it does take up some space on the terminal:
>
> ````
> ❯ git rebase --keep-base -x 'make -s && cd t && prove -j8
> t345?-history*.sh && echo'
>
> Executing: make -s && cd t && prove -j8 t345?-history*.sh && echo
> GIT_VERSION=2.55.0.rc1.20.g1e31474ef6
> ld: warning: ignoring duplicate libraries: 'libgit.a',
> 'target/release/libgitcore.a'
> ld: warning: ignoring duplicate libraries: 'libgit.a',
> 'target/release/libgitcore.a'

While I am very sympathetic that it may be annoying, I have to
wonder if that is ultimately the linker's job to accept the same
library listed twice on the same command line, deside when it can
ignore the second one, and *silently* ignore it.

Imagine this situation.

 - There are two library archives, libA.a has a.o in it and libB.a
   has b.o in it, respectively.

 - The object file a.o defines a symbol that b.o needs, and b.o
   defines a symbol a.o needs (i.e., mutually dependent). libA.a and
   libB.a have other symbols in them. There are valid reasons why we
   do not want to combine them into a single libAB.a.

 - Now our program X uses both libraries and we build and try to link it this way:

   $(CC) -c x.c				# this builds x.o
   $(CC) -o programX x.o libA.a libB.a  # unfortunately does not work as-is

   which fails because x.o uses symbol from libA.a that is not in
   a.o (so a.o is not linked), and then x.o also uses something in
   b.o that is picked up from libB.a.  But b.o in turn needs a.o
   that we already skipped.  One way to make it work is to tweak the
   final link phase to read like this:

   $(CC) -o programX x.o libA.a libB.a libA.a

If your linker complains because we list libA.a twice, it would be
annoying.

I guess if we can assume GNU ld (e.g., gcc/clang), we can use

   $(CC) -o programX x.o -Wl,--start-group libA.a libB.a -Wl,end-group

to tell the linker that they need to be processed for circular
dependencies, but listing them twice is more portable and harmless
(i.e., if all the symbols are resolved by the time the linker sees
the second libA.a, then it would not pick up anything extra from
there) way to achieve the same thing.  

So from future-proofing and portability perspective (which is
another way to say maintainability we care about), I would very much
prefer to see this solved at the linker level, allowing the build
procedure to list the same library twice on the command line.

It seems that on the Internet various folks, including masonbuild
and CMake, have heard complaints from users enough and fixed the
linker by using -no_warn_duplicate_libraries option.  Their approach
translates to something like the following in our build environment.

 config.mak.uname | 4 ++++
 1 file changed, 4 insertions(+)

diff --git i/config.mak.uname w/config.mak.uname
index 8719e09f66..e29eaaf3fd 100644
--- i/config.mak.uname
+++ w/config.mak.uname
@@ -149,6 +149,10 @@ ifeq ($(uname_S),Darwin)
         ifeq ($(shell test "`expr "$(uname_R)" : '\([0-9][0-9]*\)\.'`" -ge 20 && echo 1),1)
 		OPEN_RETURNS_EINTR = UnfortunatelyYes
         endif
+
+	# NEEDSWORK: do this only for XCode 15 or later
+	BASIC_LDFLAGS += -Wl,-no_warn_duplicate_libraries
+
 	NO_MEMMEM = YesPlease
 	USE_ST_TIMESPEC = YesPlease
 	HAVE_DEV_TTY = YesPlease
