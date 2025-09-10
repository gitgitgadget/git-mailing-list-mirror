Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB7A30FF28
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 21:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757539738; cv=none; b=mGyOPiSUwg4f5fJOwKt6nbCcLVT2jlpMKpc0f99dEfR23qVKOJ4g40BhXo7kTkYbn5mmvoGCoTos/40UV0ggfnVMyIK11VnK2282WStuPXj+vi4hE4kxLpcULNIVdtkPFAPFCTWDFr73lleX1pIB39lXry7tVDZnOIoZMe9xww8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757539738; c=relaxed/simple;
	bh=apulBhtjjHOOMtSgaDPdpZ5XZVv0mqvG8aJF5tdhSKA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uEhPX2wDSFrhJCDQhQmHpvTxMsMSwkhYjOv5Wc2J9+PBuMAXh6dlESzdbDjIVNFhf+Q1j7aokK1WwhRcdDeUphLK5xq23d+pE2JTV3Iw5T6stYEVW8SvXVUtr5m5rNEvRbJUrhtLx/K9ZB4VdwSwxe2qjZq+WvE97Phwaw9iLxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XyeDqB7w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yv2vrmTe; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XyeDqB7w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yv2vrmTe"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id D0C8BEC02D1;
	Wed, 10 Sep 2025 17:28:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 10 Sep 2025 17:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757539734; x=1757626134; bh=JfEo66JTqE
	L0XWZFREaxAgsOGo6ko9PD4KUGjuj0uAs=; b=XyeDqB7wl9ClNK2CyihiVxmrT1
	Ca266IvCj+kegd4PjyOsG6Gv7t1KIH9dcNb2Qir+oVD+p1xPGfjS+4Ca4FuEzZVU
	eAzFPo8c8WKzbgJbtH+bk36E4OubJT8aZr7oBvuDOmrRi3h2OkKXLnYjLxCo53+C
	B9NvnbOeDByANfWBJ/XImfUNJNyLkqUi275vlKjVKE1dnzbcfgIP32Y9wgtY2l1s
	8fUNS8HGcyVGnV/gwzCGmhm28FWSKg7nU68tZvB5n0dE2nsDKU5T7e0m+Tij6Cxw
	6hZ4t0TAbivjribUTEfVzoWgxx0ZzDxXnYWrKXGaxtj6oK0wN/dV0O1Re8uA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757539734; x=1757626134; bh=JfEo66JTqEL0XWZFREaxAgsOGo6ko9PD4KU
	Gjuj0uAs=; b=Yv2vrmTew8gYF//+ndjrxy7DW3RW+wLLgQSQmtjLt3E74FpRTZp
	qtbbiMrsviIfKzKoANqsuVoGq3v8zSsTnwgN+93GJZABEnqSkAnfBB2lxDM709e8
	hKYgtaq1KU7mKrLq438plt73jugJBc8+sOW3dsh1SIfdLGyivW/HF9WBl3poEwwv
	TkGb9L7lV+qz74bSFwbbwNITwTwByD77Ikw9qai9yJG3CUgAlmOoJyQ5QA34Tu9d
	u1MdS1YPqUhTJ0Wzln3OSXh2pa26o6K5JA43rBMUGJcMB8szaxHrP60XwFXKuYoo
	HRAEAwjjVqhxeY42gPn8kIiYBtvZnMVuyyg==
X-ME-Sender: <xms:lu3BaNtLiXvVhSbYiyTk1D6OhiuYggi6QmUlVbLIA7c_b8pTWbnbuA>
    <xme:lu3BaJsW_v86IHwLfS9Vah2DI7ivXrmspnOiSTeNeLTrZz1h4qoFjSsrFvgUSYSfI
    _tUyIpMUBo0TBLk1g>
X-ME-Received: <xmr:lu3BaKNlLXFVBFCcc-V1Cq2x6G8WCNIM16q_PdKamgH6sv1setUgJcShFBuPHN3Bivj8XO-AEApJ7Oa9LV26BG9NKpc_XqcxN8Z1dow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepffeiteeujeevfeehuddvjeduffeije
    egfefhtddvkeefjeejhedtgeefgfeijedtnecuffhomhgrihhnpehgihhthhhusgdrtgho
    mhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:lu3BaP0zSnB3lLVO3Zdx2l9UvAm6IYmn4VIsWyFDagNghcEPXDHf5A>
    <xmx:lu3BaOPxGthzKhE_86UO8kK5LUF8nILOKrgDVqSw9IjnTmafTm0oSA>
    <xmx:lu3BaH354X1IfV3S1hdQl4NfRlwVfD220eO6AJHzDZkVkpiHwiijaA>
    <xmx:lu3BaNFIyGdBW1f8s-sycpFa1aZjRQfA6LuwxsLIMLYXvcZLG2Gxhw>
    <xmx:lu3BaDjI5u8XzacYhtaE4EY-iVWj9_1B_wZRtUjhoUr9uUFACvZG8HgE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 17:28:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: [GIT PULL] git-gui: question helper, fix Revert Changes
In-Reply-To: <4ceca07d-f9b2-4826-92c4-14c95d47fc70@kdbg.org> (Johannes Sixt's
	message of "Wed, 10 Sep 2025 19:14:25 +0200")
References: <4ceca07d-f9b2-4826-92c4-14c95d47fc70@kdbg.org>
Date: Wed, 10 Sep 2025 14:28:53 -0700
Message-ID: <xmqqcy7yq9nu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> The following changes since commit e3923e3e90da55e12545b5ef5aa34f21e97409d8:
>
>   Merge branch 'cb/no-tcl86-on-macos' (2025-08-04 18:27:03 +0200)
>
> are available in the Git repository at:
>
>   https://github.com/j6t/git-gui.git master
>
> for you to fetch changes up to 7ef77ec0054b3b4ef3cfee6ef97c43c01965be88:
>
>   git-gui: sync Makefiles with git.git (2025-09-06 11:59:48 +0200)
>
> ----------------------------------------------------------------
> Adam Dinwoodie (1):
>       git-gui: sync Makefiles with git.git
>
> Heiko Voigt (1):
>       git-gui: provide question helper for retry fallback on Windows
>
> Johannes Schindelin (3):
>       git gui: set GIT_ASKPASS=git-gui--askpass if not set yet
>       git-gui--askyesno: allow overriding the window title
>       git-gui--askyesno (mingw): use Git for Windows' icon, if available
>
> Johannes Sixt (3):
>       git-gui: fix error handling of Revert Changes command
>       Merge branch 'js/ask-yesno'
>       Merge branch 'ml/misc-simplifications'
>
> Mark Levedahl (2):
>       git-gui: simplify PATH de-duplication
>       git-gui: simplify using nice(1)
>
>  Makefile             |  3 +++
>  git-gui--askyesno    | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  git-gui.sh           | 42 ++++++++++++-----------------------
>  lib/index.tcl        |  7 +++++-
>  po/glossary/Makefile |  3 +++
>  5 files changed, 89 insertions(+), 29 deletions(-)
>  create mode 100755 git-gui--askyesno

Thanks.  Pulled.
