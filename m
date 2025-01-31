Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62601B6CE9
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 10:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738320816; cv=none; b=amPg4mdF6dhwtbb1KBp6tMFSRi+vws1xtSknPuVyKLFhl2Kz+edsOCCvSusYaM+SCggoUP9ONcvJu8iKKbuBQ6zhfP7Z9Ro9LyFiH7ZSUGg3ldMawDM6withVeDzTaYN3YSxGWxf8w6sfynptytJtQWEdXNsFbcSLN0nPX8fQmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738320816; c=relaxed/simple;
	bh=rjaglM5pc2rXmJQbWeVZ3lDgrGFLjp2lDJ3Id9xUuqU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=Cw8JdGKjXFSFfCB4le431Cv5viIGsPrpKl1u6R+1GgNc9hU5B2LcvLwPKp9fT5rUbhg/oy/mGvuJymLAuhZVDpZdb107VlQUYfmS+dSrxF2/tJeIi/j6QCG0HMzEHKxYNEG6w4GMcvbqKk693Ir1tFyJXfvg893aiNpmZ1g8m4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O2nkuxn+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fu1rtVRA; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O2nkuxn+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fu1rtVRA"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AE2D711400F4;
	Fri, 31 Jan 2025 05:53:32 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 31 Jan 2025 05:53:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738320812;
	 x=1738407212; bh=8tTui/Zi/nsgclZGqvWny4VACGEX3u3jyDDLzlkvDWU=; b=
	O2nkuxn+g3T8J65iEJFyTKgcLObjRgRiHDTj2/Kc67EBvWQrcBeHiw87rbI35lUc
	du4FO2GHNeEpT8BPehlYSbdlZpWE7TM/9LZtwOCvMv/tuad7cZrnhSA2OJICMpND
	rZFbAE3ykWAPGjcLcPQbB2S3f0GR2S3ijktXADbAzpOsspBlf2JZquiY/utSvatO
	XcVeQj3dYLrMhricHlKDFO56FbYMGfRniURQDYyGvK99xXc6PcLZuSwOPP3snpYK
	o0crdn745gp6eLIJDUzu7Homr66bR6CvwyxBbOCATE4Tw9DMa9JkR94VrxcZOMl6
	3AhGtAHLL7U76KtutY8mlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738320812; x=
	1738407212; bh=8tTui/Zi/nsgclZGqvWny4VACGEX3u3jyDDLzlkvDWU=; b=f
	u1rtVRA1cU9P3Z5tBALKaJpN+I9S00Cz0V2JUaMQROCHsi7AkWigk1ah++JlrOXr
	6VRdg2PW3zLPnbVU/b+43k+pmABP804iS16mq/ARGjFvpVJgMapAuErbFFrDx3nv
	hSmNJjbfItRJf+owAqvgfkpQHVAn7Q0NDivZYBYXDgI3z2TXIYiidATYVQF66rnA
	UWudLPk0h4GEAbTjxGGlH8A3DhnnPH/IlOS+qyP1MKWRXSMRKWfPOr/ereP3kzmD
	/A7vMgsHLYpQRo3zHRkNV0DA0nB06wYlLMXzEhiajGaCRAtM4qGpcmqfNgNzR9GA
	tJaZjFCOplBGbDJwn6r9w==
X-ME-Sender: <xms:rKucZyfrT0usee4DheciHsvqw_nDQmF0UAxOLFPg7sdYRPCFLGe3dA>
    <xme:rKucZ8NFNsCiM9fFw_2mdWExrGWeVpgpJf_cdTOErRfsKpZsGPccD63449eVyR7jm
    IVaOG2yORZwnx4rSw>
X-ME-Received: <xmr:rKucZzg-7fpeaSl7fBQHrd7tbW6cSF1u7_zrhtzoaB5j1gqUJngqFOhQbB3OhwnGR4n4oFsu1-BOmn-y-D3jBsDpHMnD6zICXuRCQF9lujsHTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhufffkf
    ggtgfgjghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepteeuueehhf
    fhiedtueehtddtieekfedtudehtdehfefhgeffveeggedthfehuedvnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopeiihhhihihouhdrjhigsegrlhhisggrsggrqdhinh
    gtrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:rKucZ_85bS2_s54pG2z-kKACdTbNpOl4TwrjwtWaGavGdyePgSpywg>
    <xmx:rKucZ-uP9E4akRPdtc0qcmo-jlTRPc9w17gfgpX8LGgaOAgIxcRccw>
    <xmx:rKucZ2EF-U4skHtsi-Ok4F4fzuJuboS8AxlbnfwFvFbifWKKnzsKbw>
    <xmx:rKucZ9MB5uDJJdLSXY_hgd8uRYBNvGA1cMXuPPuQQt5rG4c7dETPjg>
    <xmx:rKucZyJWHsTdx4EaXPlUNQIWgGSFxnNvjY51EJXmr5zNeE4HOPm6UEov>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jan 2025 05:53:31 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4784fcf9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 31 Jan 2025 10:53:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 0/8] transport: don't ignore git-receive-pack(1) exit
 code on atomic push
Date: Fri, 31 Jan 2025 11:53:24 +0100
Message-Id: <20250131-pks-push-atomic-respect-exit-code-v4-0-a8b41f01a676@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKSrnGcC/5WNQW7CMBBFr4K87lie2CRNV9yjYmGcCRla4sg2V
 gDl7piITVcVy/el9/5dRApMUXxt7iJQ5sh+LGA+NsINdjwScFdYVKoyiKhh+okwXeIANvkzOwg
 UJ3IJaOYEzncERtfOGG3rbdOJ0pkC9TyvH9/7wgPH5MN1vcz4XN+pZwQFTVtve4XU9IZ2xZF8F
 s90rtac85mCxEZjrXTbojxykreBr/4iT/PO/vLBHizw6KTzL1P/NfWnVgbVf+ayLA/vtz5EQwE
 AAA==
X-Change-ID: 20241113-pks-push-atomic-respect-exit-code-436c443a657d
In-Reply-To: <20241113-pks-push-atomic-respect-exit-code-v1-0-7965f01e7f4e@pks.im>
References: <20241113-pks-push-atomic-respect-exit-code-v1-0-7965f01e7f4e@pks.im>
To: git@vger.kernel.org
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Hi,

we've hit an edge case at GitLab where an atomic push will not notice an
error when git-receive-pack(1) updates the refs, but otherwise fails
with a non-zero exit code. The push would be successful and no error
would be printed even though some things have gone wrong on the remote
side.

As promised last week, I've now adopted the patch series from Jiang Xin
to make some progress on the issue. The series is now based on the
latest master branch at 3b0d05c4a7 (The fifth batch, 2025-01-29).

Changes in v4:
  - Rewrite the commit that adds two new tests for `--porcelain`.
    Previously, the commit both reordered existing tests and added new
    ones, which made it hard to see what actually changed. The reorder
    wasn't necessary though, so I've adapted it to only add new tests
    now.
  - Fix the URL prefix in t5548 to also work on Windows.
  - Document why it's fine to start ignoring the return value of
    `git_transport_push()`.
  - Improve comments to document behaviour better.
  - Link to v3: https://lore.kernel.org/r/cover.1733830410.git.zhiyou.jx@alibaba-inc.com

Thanks!

Patrick

---
Jiang Xin (5):
      t5548: refactor to reuse setup_upstream() function
      t5548: refactor test cases by resetting upstream
      t5548: add porcelain push test cases for dry-run mode
      send-pack: new return code "ERROR_SEND_PACK_BAD_REF_STATUS"
      send-pack: gracefully close the connection for atomic push

Patrick Steinhardt (3):
      t5504: modernize test by moving heredocs into test bodies
      t5548: add new porcelain test cases
      t5543: atomic push reports exit code failure

 send-pack.c                     |  10 +-
 send-pack.h                     |  13 ++
 t/t5504-fetch-receive-strict.sh |  35 ++--
 t/t5543-atomic-push.sh          |  30 +++
 t/t5548-push-porcelain.sh       | 443 ++++++++++++++++++++++++++++++----------
 transport.c                     |  17 +-
 6 files changed, 407 insertions(+), 141 deletions(-)

Range-diff versus v3:

1:  5001da5515 = 1:  5a68112d63 t5504: modernize test by moving heredocs into test bodies
2:  de1b7eab6a ! 2:  bb3b9cd8b7 t5548: refactor to reuse setup_upstream() function
    @@ Commit message
         setup_upstream_and_workbench() functions.
     
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
    +    Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## t/t5548-push-porcelain.sh ##
     @@ t/t5548-push-porcelain.sh: format_and_save_expect () {
3:  be1daa20cd ! 3:  7268ab4fdf t5548: refactor test cases by resetting upstream
    @@ Commit message
            hook by moving the operations into the corresponding test case,
     
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
    +    Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## t/t5548-push-porcelain.sh ##
     @@ t/t5548-push-porcelain.sh: setup_upstream_and_workbench () {
4:  d353cc13d0 < -:  ---------- t5548: add new porcelain test cases
-:  ---------- > 4:  1b721338eb t5548: add new porcelain test cases
5:  2f4723d34f ! 5:  7be03b6fdd t5548: add porcelain push test cases for dry-run mode
    @@ Commit message
          - git push --porcelain --dry-run --atomic --force
     
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
    +    Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## t/t5548-push-porcelain.sh ##
     @@ t/t5548-push-porcelain.sh: run_git_push_porcelain_output_test() {
    @@ t/t5548-push-porcelain.sh: run_git_push_porcelain_output_test() {
     +		;;
     +	file)
     +		PROTOCOL="builtin protocol"
    -+		URL_PREFIX="/.*"
    ++		URL_PREFIX=".*"
     +		;;
     +	esac
     +
6:  73728ec873 ! 6:  ea0e885613 send-pack: new return code "ERROR_SEND_PACK_BAD_REF_STATUS"
    @@ Commit message
         We cannot ignore bad REF_STATUS directly in the "send_pack()" function,
         because the function is also used in "builtin/send-pack.c". So we add a
         new non-zero error code "SEND_PACK_ERROR_REF_STATUS" for "send_pack()".
    -    We can choose to ignore the specific error code in the
    -    "git_transport_push()" function to have the same behavior as
    -    "push_refs()" for HTTP protocol.
    +
    +    Ignore the specific error code in the "git_transport_push()" function to
    +    have the same behavior as "push_refs()" for HTTP protocol. Note that
    +    even though we ignore the error here, we'll ultimately still end up
    +    detecting that a subset of refs was not pushed in `transport_push()`
    +    because we eventually call `push_had_errors()` on the remote refs.
     
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
    +    Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## send-pack.c ##
    -@@ send-pack.c: int send_pack(struct send_pack_args *args,
    +@@ send-pack.c: int send_pack(struct repository *r,
      				reject_atomic_push(remote_refs, args->send_mirror);
      				error("atomic push failed for ref %s. status: %d",
      				      ref->name, ref->status);
    @@ send-pack.c: int send_pack(struct send_pack_args *args,
      				goto out;
      			}
      			/* else fallthrough */
    -@@ send-pack.c: int send_pack(struct send_pack_args *args,
    +@@ send-pack.c: int send_pack(struct repository *r,
      	if (ret < 0)
      		goto out;
      
    @@ send-pack.c: int send_pack(struct send_pack_args *args,
      	for (ref = remote_refs; ref; ref = ref->next) {
      		switch (ref->status) {
      		case REF_STATUS_NONE:
    -@@ send-pack.c: int send_pack(struct send_pack_args *args,
    +@@ send-pack.c: int send_pack(struct repository *r,
      		case REF_STATUS_OK:
      			break;
      		default:
    @@ send-pack.c: int send_pack(struct send_pack_args *args,
      	}
     
      ## send-pack.h ##
    -@@ send-pack.h: struct ref;
    +@@ send-pack.h: struct repository;
      #define SEND_PACK_PUSH_CERT_IF_ASKED 1
      #define SEND_PACK_PUSH_CERT_ALWAYS 2
      
    -+/* Custom exit code from send_pack. */
    ++/* At least one reference has been rejected by the remote side. */
     +#define ERROR_SEND_PACK_BAD_REF_STATUS 1
     +
      struct send_pack_args {
      	const char *url;
      	unsigned verbose:1,
    +@@ send-pack.h: struct option;
    + int option_parse_push_signed(const struct option *opt,
    + 			     const char *arg, int unset);
    + 
    ++/*
    ++ * Compute a packfile and write it to a file descriptor. The `fd` array needs
    ++ * to contain two file descriptors: `fd[0]` is the file descriptor used as
    ++ * input for the packet reader, whereas `fd[1]` is the file descriptor the
    ++ * packfile will be written to.
    ++ *
    ++ * Returns 0 on success, non-zero otherwise. Negative return values indicate a
    ++ * generic error, whereas positive return values indicate specific error
    ++ * conditions as documented with the `ERROR_SEND_PACK_*` constants.
    ++ */
    + int send_pack(struct repository *r, struct send_pack_args *args,
    + 	      int fd[], struct child_process *conn,
    + 	      struct ref *remote_refs, struct oid_array *extra_have);
     
      ## transport.c ##
     @@ transport.c: static int git_transport_push(struct transport *transport, struct ref *remote_re
      	case protocol_v0:
    - 		ret = send_pack(&args, data->fd, data->conn, remote_refs,
    + 		ret = send_pack(the_repository, &args, data->fd, data->conn, remote_refs,
      				&data->extra_have);
     +		/*
     +		 * Ignore the specific error code to maintain consistent behavior
7:  b26774fee4 = 7:  6930d7ec2b t5543: atomic push reports exit code failure
8:  ab4d0906f6 ! 8:  c2c82673fd send-pack: gracefully close the connection for atomic push
    @@ Commit message
     
         Reported-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
    +    Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## send-pack.c ##
    -@@ send-pack.c: int send_pack(struct send_pack_args *args,
    +@@ send-pack.c: int send_pack(struct repository *r,
      				error("atomic push failed for ref %s. status: %d",
      				      ref->name, ref->status);
      				ret = ERROR_SEND_PACK_BAD_REF_STATUS;

---
base-commit: 3b0d05c4a79d0e441283680a864529b02dca5f08
change-id: 20241113-pks-push-atomic-respect-exit-code-436c443a657d

