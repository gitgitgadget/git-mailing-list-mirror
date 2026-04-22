Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217113EF668
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 19:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776884447; cv=none; b=ta1EQ1MMQzB5HnKcMbhQ0vghxhSubZ25AD4/vM3zVYS+O/lzJJXwSSXqYT6cgArVeYKE0ytW8vcXX0vLS/EYxydoMaMi/ebEi95qhFpYUXABgyhlT1KB76jOPsgsQRgSVGTxUbhS8FpQh8CVVuDrZTfPDKRV0bX/VLhA5K1lCmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776884447; c=relaxed/simple;
	bh=rC3NqrytsLIzLHBIchlDUMG+COYbpsgSeN4d6zJmDyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dA9wv2nnzfmsBUpVfUm+7QrrkaR/yVSJ+HG9fZxrlB+WyAMAOGseR+exj6rGtsBMs76vlNMc8irGW2zAOEZTnHb3AdSh+wXYH8njDwQdvw1D0onwjVFcbxn3eAyeKW+6aoIi5BHpGNzncZdlScidxR3fYXEnDeRe69GmIccRtmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=kxkuiFU2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OS68SHeh; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="kxkuiFU2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OS68SHeh"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 537B5EC0592;
	Wed, 22 Apr 2026 15:00:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 22 Apr 2026 15:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1776884432; x=1776970832; bh=oc
	2QOjaumRigSeMwYxA3ktLmsKMHaHJ4/U1VoKksj9U=; b=kxkuiFU2FNhek8gVoH
	muPUeTnTG7ShI0agcXNd5nc+WpV4d/u45ja/6CQhu+GhEsFcCGysmDHX+SNKYVe1
	x6a+aysWgxCb5Dn9hMNFV5oR7j/mYfwnS9L2ZlZjUUHIE9mdLT+I6EQeRata65xE
	En2gNc5MUGypdyJY7HeIvLi8DMqTZEz5672FeQIKu90BlZHqSfTY6Om0CXr1wPKS
	Qp5qR5xGhLbXtf760bvUBWQxG8JOk6H3lUHwWa3JogZCtFibZonBSmU2SK7Y4OQm
	K8NrCqhNYYYTm02Umi+FJyKWvjUT6moH2iPpO1l084WkZmLciox77HvsstrzYCRg
	G2ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1776884432; x=1776970832; bh=oc2QOjaumRigSeMwYxA3ktLmsKMH
	aHJ4/U1VoKksj9U=; b=OS68SHehCCxV+Ypv8fv8abPKQpeNaNT2op18NoJHQ3Cd
	QMd2m33Q7ZbIC3Yzxe5bC0HsSdz23myWUqnUO0p5nbzFu+uVjJYrZ3Wehwnlp6k4
	Akb/k3P9e3UUE7ICFaeL8aZwd8BiJyUmWZCS4baK6fuVTwCp9UWRKqVcOjI/D8DX
	pYHia+wdAMi1lr+suOmaZvDCoO/c2uiwLVp4wCOkfk1S8cYUy7fncYKBe6HugAIk
	xALvk//5dEFj8UXPZe01oA4g13hokJJ5kZAfcHKOjFcYiWisOGk38qkIel+w0uiR
	sWC969BuUoe2UNX7KiNv4CoM0bWIsAJSgpTUWjm6aA==
X-ME-Sender: <xms:0BrpaUh9NSV6bHRKs8qJBYIzU1KwQaKFnAseUKSSW4eMArqJqwk8nw>
    <xme:0BrpaUf_hoZ89r5OCs_Mklxkwy9O-a5bFjHlG1w_heizqyMycXvwAOH6Z0jUbleyF
    i_ZG4ELx5AkWEZMY41ajAopiaE6L59jr_QueDeD7FaXAkEnsu7Shg>
X-ME-Received: <xmr:0BrpaZeDxqy9vdY0xhCzl_qMpxa5AqCeRc05G5EaYVrJDpxrPXpAiLb-RwAqNAEUATg1GpsScAwhCGo5RYUfJMM_ZppGqR1bqSQc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeihedthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkgggtugfgfgesthekredttd
    erjeenucfhrhhomheplfgrnhcurfgrlhhushcuoehjphgrlhhushesfhgrshhtmhgrihhl
    rdgtohhmqeenucggtffrrghtthgvrhhnpedvueffvdejiefgkeejteduheekgfeglefhke
    ekfeduvdeiueelheeghedutdevveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehjphgrlhhushesfhgrshhtmhgrihhlrdgtohhmpdhnsggprh
    gtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghshhhunhhgsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:0Brpae80vhT5RWOdj0Il85gXAycOx_mXKwbNiEZHtAK_5qZMco9gOw>
    <xmx:0BrpaVm_QDFfScHmgGZxtyiSxoTTn1BT_rWBzbAfqI5OmhprpFZq8w>
    <xmx:0BrpaQ_wGMNUCmPQz-OmppmAAgws-LqKL3yh0ZoeIZwvRKJdigq8MA>
    <xmx:0BrpaTm68jZPb7iIJ7fiyrlm6VKEgyilTe8xTKdd0J5itzagKQCgQg>
    <xmx:0BrpaUfoCm7sMskmvbDySRqYsz2PTCGyNrTI2l2cYhZJXynPUN87ZQ6f>
Feedback-ID: i01894241:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Apr 2026 15:00:31 -0400 (EDT)
Date: Wed, 22 Apr 2026 21:00:30 +0200
From: Jan Palus <jpalus@fastmail.com>
To: git@vger.kernel.org
Cc: Andrew Au <cshung@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: regression 2.54.0: test suite hangs indefinitely with mksh
Message-ID: <aekVSi4iu9YLaPLQ@rock.grzadka>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20260406

If /bin/sh points to mksh, git's test suite hangs forever and never
completes. An example of process tree for such hung test:

$ pstree -a `pgrep -f ./t5702-protocol-v2.sh`  
t5702-protocol- ./t5702-protocol-v2.sh
  └─git -c protocol.version=0 ls-remote -o hello -o worldfile:///home/users/builder/rpm/BUILD/gi
      └─sh -c git-upload-pack '/home/users/builder/rpm/BUILD/git/t/trash directory.t5702-protocol-v2/file_parent'...
          └─git-upload-pack /home/users/builder/rpm/BUILD/git/t/trash directory.t5702-protocol-v2/file_parent

bisect points to the following commit:

commit dd3693eb0859274d62feac8047e1d486b3beaf31 (HEAD)
Author: Andrew Au <cshung@gmail.com>
Date:   Thu Mar 12 22:49:37 2026

    transport-helper, connect: use clean_on_exit to reap children on abnormal exit
    
    When a long-running service (e.g., a source indexer) runs as PID 1
    inside a container and repeatedly spawns git, git may in turn spawn
    child processes such as git-remote-https or ssh. If git exits abnormally
    (e.g., via exit(128) on a transport error), the normal cleanup paths
    (disconnect_helper, finish_connect) are bypassed, and these children are
    never waited on. The children are reparented to PID 1, which does not
    reap them, so they accumulate as zombies over time.
    
    Set clean_on_exit and wait_after_clean on child_process structs in both
    transport-helper.c and connect.c so that the existing run-command
    cleanup infrastructure handles reaping on any exit path. This avoids
    rolling custom atexit handlers that call finish_command(), which could
    deadlock if the child is blocked waiting for the parent to close a pipe.
    
    The clean_on_exit mechanism sends SIGTERM first, then waits, ensuring
    the child terminates promptly. It also handles signal-based exits, not
    just atexit.
    
    Signed-off-by: Andrew Au <cshung@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

From commit message alone it seems the change tries to avoid reparenting
child processes to PID 1, however this does not seem to work for
processes which were spawned with "sh -c".

For example if /bin/sh points to bash tests pass because bash appears to
react to SIGTERM differently -- shell process ends but its children are
reparented anyway.

mksh on the other hand seems to ignore SIGTERM (or queues it?) but
waits for child process and so test suite never ends.
