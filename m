Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B201A38DE0
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 19:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727983294; cv=none; b=i2DvoTeDY2kD8jx+6fKqs08hmyAAMGZDKYRNGAERUdI+ZUNmBfABtEXq6WQyVtN0tsOoi4k+q/HU43NzZWo+/638dxjOm/f52Rppxl9iB1xO+utH0iFPTpfxxb9HMDv69obc/8Y3eLEaHXknIeIG+sLJNm3L2VBa2mSm+AG5N10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727983294; c=relaxed/simple;
	bh=QgHr70OjGH8mpH6YgV834nvcDruX4DJcy6wmr88xN7w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UJv9oAbk7wcKfPdXwTN6exuRQYj6PwmXBfRFGM5ijco6lz/rOCeCLom0TEAOg2yPcrPOGJySTlyuuU65QAWCkZ1DJsIgAm6V0BjCS0kPqLXuYJIWjEqqTI1OiR12vLbXmYHaN37OT86Nnb9LKjDb+EAkCs98ATIwoNInKly/GUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mHi8hseW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VtDibTQB; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mHi8hseW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VtDibTQB"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id BF9581380246;
	Thu,  3 Oct 2024 15:21:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 03 Oct 2024 15:21:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727983290; x=1728069690; bh=Jkojolypsj
	gztSO6OZ612VIJdUiSDtD++94VUeT3Hw4=; b=mHi8hseW+/OxZhqIhyhHOSVSxF
	iW9afK9gFudK2poW7s9R1Oprs6Ts4jT1qaKDcwoUcYCtQEzPAMKwK45HY7HNm0RO
	LCzGLU05bBdj2ZotqS8SAfH32Lz6iOwtz79qbSlErVrErNAiY2/EyH6sphouD//d
	0p4Qrvo2yh3Jl8xesdqYoH4xcvNXms3UIssh+eWALXsp1/DYmCSgsZtgDPIEwDF9
	4s2nBj6n5Xa+g46Qak1i04pUgEG3xtiHvP+SwzMkTRK/n78t/5N2HV4ApQ34zEhk
	mDzNdW3Myvo3nsb2kLWEM2VE+iw0npPu9NWiayOK2oTOvhXPv3ttcf2krXxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727983290; x=1728069690; bh=JkojolypsjgztSO6OZ612VIJdUiS
	DtD++94VUeT3Hw4=; b=VtDibTQBURqFH/xdi6MDGvjdlZcuxq+0edZYvLmkSwI1
	GOsLwAwa+juzOgkryYXEx9+izb/++TIe8A7c+RH+m7MUB/CH0wIZ76Wndp1UK9yD
	ObItKKenNQpx6U8GSP3uBzDYMabkivDDYAoUxYCqkajff3f8V4Jk640X44IK2gBA
	NJgzoblkTKF8daaQbJMY8znXNhXGXp+uRdhwB3E/PoN6I8PnExNnLkZuBlsQWOve
	8j7N1Rvj/G9b/GdR2F/9X54luqEtHIMcYkI4dC1D4BECTXzu1Ljft/ZMedhiQqg7
	jPK13bJ21hMMPS8tt4IOTrwST9DXUI7D6foRhg0XrA==
X-ME-Sender: <xms:ue7-Zv71bbhddxoAdNGAsKHIN7H6JQzyGtD3_MeLnB3_Xi8jAUW4zA>
    <xme:ue7-Zk4N8qOt1iMXfbfXgIAbZkkrqibM73X5HPsMz08xnAP_-k9TtZOAkeqRVTtr8
    GgbmFRv9kjb8Hw1CA>
X-ME-Received: <xmr:ue7-ZmcWTCWX1kaaNdei5Ay5auwCdi82YbyxEtRNZNt4OyFYbd0WZ-UVpJzGRFfazOZIPjjlq-_UEkgeoJ165MChX6Ps-WO59ERZPkM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvuddgudefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghntggvsehfvg
    hrughinhgrnhguhidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrgh
    druhhkpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehl
    rdhsrdhrseifvggsrdguvgdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvg
    hlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ue7-ZgKAXXvGcBj9XZQbNAVNwlh82dhG7LjAEvSQUiRuWblTNF7hcw>
    <xmx:ue7-ZjIR7YFm3zMxdsAS1Bg8VgscBdXGlixEIVfpYCMPz3G5QoDiVQ>
    <xmx:ue7-ZpzaYQYLinSmEzldfDeBeukxinAizA7-d-3J5O511nOxCjBXlg>
    <xmx:ue7-ZvLNf-SOwWGN4Y8un8kq2POnTYdLXK1-qctJfY2KvCdd3ODXqg>
    <xmx:uu7-ZgqHUb7MGDQlSAfyeKUf25_npKzrCLC2pMx7tDccbcjh2d9UsTHa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Oct 2024 15:21:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org,  phillip.wood@dunelm.org.uk,  Taylor Blau
 <me@ttaylorr.com>, 	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Johannes
 Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 0/5] improve handling of remote/HEAD
In-Reply-To: <20240930222025.2349008-1-bence@ferdinandy.com> (Bence
	Ferdinandy's message of "Tue, 1 Oct 2024 00:19:50 +0200")
References: <D4JIG4VS5WVN.2F0PNU5514UEL@ferdinandy.com>
	<20240930222025.2349008-1-bence@ferdinandy.com>
Date: Thu, 03 Oct 2024 12:21:28 -0700
Message-ID: <xmqq1q0xhu13.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bence Ferdinandy <bence@ferdinandy.com> writes:

> Bence Ferdinandy (5):
>   refs_update_symref: atomically record overwritten ref
>   set-head: better output for --auto
>   transaction: add TRANSACTION_CREATE_EXISTS error
>   refs_update_symref: add create_only option
>   fetch: set remote/HEAD if it does not exist
>
>  builtin/branch.c          |  2 +-
>  builtin/checkout.c        |  5 ++-
>  builtin/clone.c           |  8 ++--
>  builtin/fetch.c           | 83 +++++++++++++++++++++++++++++++++++++++
>  builtin/notes.c           |  3 +-
>  builtin/remote.c          | 43 ++++++++++++++++----
>  builtin/symbolic-ref.c    |  2 +-
>  builtin/worktree.c        |  2 +-
>  refs.c                    | 35 ++++++++++++-----
>  refs.h                    |  7 +++-
>  refs/files-backend.c      | 29 ++++++++++----
>  refs/refs-internal.h      |  8 ++++
>  refs/reftable-backend.c   |  6 ++-
>  reset.c                   |  2 +-
>  sequencer.c               |  3 +-
>  setup.c                   |  3 +-
>  t/helper/test-ref-store.c |  2 +-
>  t/t5505-remote.sh         | 13 +++++-
>  t/t5514-fetch-multiple.sh |  9 +++++
>  19 files changed, 222 insertions(+), 43 deletions(-)

These seem to break some of the tests, either standalone or when
merged to 'seen'.

I have the topic queued directly on top of e9356ba3 (another batch
after 2.47-rc0, 2024-09-30); here is how the summary report looks
like.

Thanks.

Test Summary Report
-------------------
t0410-partial-clone.sh                           (Wstat: 256 (exited 1) Tests: 38 Failed: 1)
  Failed test:  32
  Non-zero exit status: 1
t4207-log-decoration-colors.sh                   (Wstat: 256 (exited 1) Tests: 4 Failed: 1)
  Failed test:  2
  Non-zero exit status: 1
t5300-pack-object.sh                             (Wstat: 256 (exited 1) Tests: 56 Failed: 1)
  Failed test:  51
  Non-zero exit status: 1
t5512-ls-remote.sh                               (Wstat: 256 (exited 1) Tests: 40 Failed: 1)
  Failed test:  32
  Non-zero exit status: 1
t5527-fetch-odd-refs.sh                          (Wstat: 256 (exited 1) Tests: 5 Failed: 1)
  Failed test:  4
  Non-zero exit status: 1
t5514-fetch-multiple.sh                          (Wstat: 256 (exited 1) Tests: 25 Failed: 4)
  Failed tests:  9-10, 18, 24
  Non-zero exit status: 1
t5521-pull-options.sh                            (Wstat: 256 (exited 1) Tests: 22 Failed: 8)
  Failed tests:  2-9
  Non-zero exit status: 1
t5505-remote.sh                                  (Wstat: 256 (exited 1) Tests: 114 Failed: 7)
  Failed tests:  4, 31, 51-52, 54-56
  Non-zero exit status: 1
t5574-fetch-output.sh                            (Wstat: 256 (exited 1) Tests: 14 Failed: 3)
  Failed tests:  11-13
  Non-zero exit status: 1
t5703-upload-pack-ref-in-want.sh                 (Wstat: 256 (exited 1) Tests: 26 Failed: 1)
  Failed test:  12
  Non-zero exit status: 1
t5616-partial-clone.sh                           (Wstat: 256 (exited 1) Tests: 46 Failed: 2)
  Failed tests:  10, 22
  Non-zero exit status: 1
t5516-fetch-push.sh                              (Wstat: 256 (exited 1) Tests: 120 Failed: 1)
  Failed test:  102
  Non-zero exit status: 1
t7814-grep-recurse-submodules.sh                 (Wstat: 256 (exited 1) Tests: 34 Failed: 1)
  Failed test:  33
  Non-zero exit status: 1
t7900-maintenance.sh                             (Wstat: 256 (exited 1) Tests: 53 Failed: 1)
  Failed test:  23
  Non-zero exit status: 1
t7406-submodule-update.sh                        (Wstat: 256 (exited 1) Tests: 68 Failed: 1)
  Failed test:  59
  Non-zero exit status: 1
t9211-scalar-clone.sh                            (Wstat: 256 (exited 1) Tests: 13 Failed: 2)
  Failed tests:  8-9
  Non-zero exit status: 1
t9210-scalar.sh                                  (Wstat: 256 (exited 1) Tests: 21 Failed: 1)
  Failed test:  11
  Non-zero exit status: 1
t9902-completion.sh                              (Wstat: 256 (exited 1) Tests: 256 Failed: 56)
  Failed tests:  54-55, 59, 61, 63, 71-75, 77, 86, 88-89
                92-93, 95, 101, 113, 116-117, 119-129, 138-141
                143-157, 162-163, 168, 170-171
  Non-zero exit status: 1
Files=1029, Tests=31709, 371 wallclock secs (11.74 usr  4.74 sys + 853.87 cusr 6465.88 csys = 7336.23 CPU)
Result: FAIL
