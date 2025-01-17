Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46231AE875
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 21:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737149512; cv=none; b=V11EZmeXehyiSN783kGmM/yD5qMgVhVerkAk8jFu+s2fKtKIwVhyC6buMsQ0tmafZCjxBVRKhRJyxU43Ph142WMiplx0eTYAJDQQdtIDARnZSee5ZciQS1PT4qIl357Bj1xE4dd4oBl1+Oq2mpv0VXDLJe8SYVElSCJbz01AhpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737149512; c=relaxed/simple;
	bh=NdWXUah8WOJCAh4iFg/U31dR4PMHmRYBslAv+ZJl35o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g0yid8LS57frC2IApzWJ2Vsg/2Prh/GcCxYZ8VbfdiP+LGR5FVC2Il3FIUaeh94cjZv3cYMRHgSGJ1JjVA3eY/V+sjpIcAAQOLxs6JclQrf9LvAZaBVtFwbD2gwTKI0ChOlDeEpfVZAPr/+wFYqTMVZdYmAN/CHcOuMbzAxFcEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VYe4oiQe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R/tbnFNj; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VYe4oiQe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R/tbnFNj"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id C8C591380128;
	Fri, 17 Jan 2025 16:31:49 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 17 Jan 2025 16:31:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1737149509; x=
	1737235909; bh=c1yz68LhAzNQ0d6/YJoLPiUgsGRxM78tRS/ExeXAXbU=; b=V
	Ye4oiQe33HfA4Ln2T1nQHRT4eGxFt7tpeRmiufHXwFnTRgAlNHyVrMQTzVMIV3Eu
	NZ6JBrUrGgEImGSrOW5Ohs9axoEeh+mMT6zT/o+dkP8MaaSBZZCaORBaDTXKKuIr
	I2Q64iSBGdYB/prMLahi1aOtgCVJMEfxJJiE0UeQlS1uW+Cm/5rHHCgCtK3CfWEp
	X/6YobTlrzVZcFmDHdj+XngTAM+e4UkPyJjZ80g25bN3pBPCIKPtS9QRSUSWmGcr
	fJYqpEGsEHfDs+v+1pAjKwy6oOFkyw+F8Vm/ioLhU8qRk82tni3hyI38Q+ws9IeV
	Q3tFB8eLWAm/3botRmMGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1737149509; x=1737235909; bh=c1yz68LhAzNQ0d6/YJoLPiUgsGRx
	M78tRS/ExeXAXbU=; b=R/tbnFNjQHEjP56ENmowPiXrZd6+Prwjzdo8c8EdFAoD
	aoaAfU0nqOdT/NrI25EkkA24yYzpEw+5RPuwJ3mkriF7/MgWQ6Fegq8Jv4XoFTXW
	vSJ4LcET77Dwsc9SCIv9F4LosOE2G0oWMEP+eoYY8TOShVZzGHLzuy2xcQi7s44m
	VrCoRLhF4jYxDadLMSPMMywdqfi0DRYL7YdFz9foFu/pyv0djRJYyUn9JkzyKV9d
	jESgNHZ6dD870Vns5aqOrqj81EN4ImcRvRAsHGDOSjYZuFgjEBoc9GQYbs7ZM8Fl
	qhstbyrD5eDfHyafQ65NlFmyvS0qPyVay1KgHFqLbQ==
X-ME-Sender: <xms:RcyKZztR789gifhFLzL0stXKFwx2Ug02wa5xuhruEONHiKU-dCvkgQ>
    <xme:RcyKZ0e0OuB-NJ_7V43UKhe2mn5wl8TlKZzn7R9XksmP8eCct5nQxIZE_ouYOUs4l
    dvSf5hTbxLWYSaCVQ>
X-ME-Received: <xmr:RcyKZ2zkyvEs03bSpDE73jQcqG2_87NXWBMyYKfI_c65oxzADgHVWfaw-MSWBSzVdnWmCKtsDMHU-j4mIDUTUH2VKtZUgnbZNQul>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeifedgudegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefue
    evveeltdetfeegveetiefhhefhtdduhfettdetfefgffduffelgffggeehgfenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:RcyKZyO2D70vbaKkA_Mp1gp1BjIAddNBBO2ebjTx7Ps7pDIejxq8tg>
    <xmx:RcyKZz_D2xsvQYmyYe5QmYEDRpBDSPmosYLCUXuKZEGxq9iLQugdlQ>
    <xmx:RcyKZyVY927tIVUn8JgBTb7mH58nnOBXCvJxzncChhz8_GwcrRFlVw>
    <xmx:RcyKZ0dXO0NSkCk99Up_4KRQGrhUrSAjWnfOQSk4GW5oypYgPx8Rjg>
    <xmx:RcyKZ1JZfiulYH9kp9NGTfwHdIHbfogzp1Q-YE6211MsvYtPuCHCieSn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 16:31:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v5 0/6] Send help text from "git cmd -h" to stdout
Date: Fri, 17 Jan 2025 13:31:42 -0800
Message-ID: <20250117213148.3974552-1-gitster@pobox.com>
X-Mailer: git-send-email 2.48.1-218-gc7e8be6a8f
In-Reply-To: <20250116213553.2563751-1-gitster@pobox.com>
References: <20250116213553.2563751-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jonas Konrad noticed[*] that "git branch -h" started showing the help
text to the standard error stream.  It turns out that we are fairly
inconsistent in our implementation of "git cmd -h".  The users of
parse-options API will get "If -h is the only option on the command
line, give the help text to the standard output" for free, but some
commands manually check for the condition and then call the
usage_with_options() function, which gives the identical help text
to the standard error stream.  And "git branch -h" Jonas noticed was
one of them.

Older commands written before parse-options API became dominant show
the help text by calling the usage() function, which is meant to be
used when they fail to parse their command line arguments, which has
the same problem.  An explicit request for help text "git cmd -h"
should be fulfilled by showing the help on the standard output.

This series teachs "git $cmd -h" to send its help text to the
standard output stream consistently for built-in commands.

There is a related "what status should these command exit with?"
question, and an argument can be made to switch them to exit with 0,
instead of historical 129, but it is left outside of the series for
now.


Changes since v4:

 - vfdreportf() helper that took a file descriptor has been replaced
   with vfreportf() that takes a FILE * instead, with Peff's help.

[Reference]

https://lore.kernel.org/git/04cfaa3b-847f-4850-9dd6-c1cf9f72807f@uni-muenster.de/

Jeff King (1):
  t0012: optionally check that "-h" output goes to stdout

Junio C Hamano (5):
  parse-options: add show_usage_with_options_if_asked()
  usage: add show_usage_if_asked()
  builtins: send usage_with_options() help text to standard output
  oddballs: send usage() help text to standard output
  builtin: send usage() help text to standard output

 builtin/am.c                |  3 +--
 builtin/branch.c            |  4 ++--
 builtin/check-ref-format.c  |  4 ++--
 builtin/checkout--worker.c  |  6 +++---
 builtin/checkout-index.c    |  6 +++---
 builtin/commit-tree.c       |  4 ++--
 builtin/commit.c            |  8 ++++----
 builtin/credential.c        |  3 ++-
 builtin/diff-files.c        |  3 +--
 builtin/diff-index.c        |  3 +--
 builtin/diff-tree.c         |  3 +--
 builtin/fast-import.c       |  3 +--
 builtin/fetch-pack.c        |  2 ++
 builtin/fsmonitor--daemon.c |  4 ++--
 builtin/gc.c                |  4 ++--
 builtin/get-tar-commit-id.c |  4 +++-
 builtin/index-pack.c        |  3 +--
 builtin/ls-files.c          |  4 ++--
 builtin/mailsplit.c         |  4 ++--
 builtin/merge-index.c       |  7 ++++++-
 builtin/merge-ours.c        |  3 +--
 builtin/merge-recursive.c   |  6 ++++++
 builtin/merge.c             |  4 ++--
 builtin/pack-redundant.c    |  3 +--
 builtin/rebase.c            |  6 +++---
 builtin/remote-ext.c        |  2 ++
 builtin/remote-fd.c         |  1 +
 builtin/rev-list.c          |  3 +--
 builtin/rev-parse.c         |  2 ++
 builtin/unpack-file.c       |  8 ++++++--
 builtin/unpack-objects.c    |  2 ++
 builtin/update-index.c      |  4 ++--
 builtin/upload-archive.c    |  6 +++---
 builtin/var.c               |  1 +
 git-compat-util.h           |  2 ++
 parse-options.c             | 10 ++++++++++
 parse-options.h             |  4 ++++
 t/helper/test-simple-ipc.c  |  4 ++--
 t/t0012-help.sh             |  3 ++-
 t/t7600-merge.sh            |  2 +-
 usage.c                     | 27 ++++++++++++++++++++++++---
 41 files changed, 121 insertions(+), 64 deletions(-)

-- 
2.48.1-218-gc7e8be6a8f

