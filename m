Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70349214A61
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 20:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738788468; cv=none; b=TSlYHFlVvcfqovLIpp0TRsRn6gM8VDLdq1TyXBiTOeBx4dL60IZ9xTcU2j6+JcrEsheqqTNdWBrEtyZ9xVXi9sa3uiCC60HNryjZMwYg/UVGbCB0asvNeJg30NmUltn6jk0YL7ExVN7yb58GqSE043e1at2g9gJp7jqfs470wP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738788468; c=relaxed/simple;
	bh=8kACLy6o4hjvrbkplrTanaY8lr4mFtp373CMre+BSRU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e8flZuOJmD4y9fi7KywStXugpv8JdCx8kOu/vC3laWb1CgLT093lmQlSVEs1x+sbRQNfCZRRhHOFUaaN8rm/O0bzHdBtgP4fPCj6b9X5hH2YyXTbhU6RZM+6tZMIcBNosiEJpo4yDU6d75XZeCAg0cMDM2E3EnzVcs2DYKfHfpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MKgAvlIB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YLOKNxie; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MKgAvlIB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YLOKNxie"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 571A5138020A;
	Wed,  5 Feb 2025 15:47:45 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 05 Feb 2025 15:47:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1738788465;
	 x=1738874865; bh=72aNNHub2QPGG7Gkse7HfpimDUw7Mf5rH6XfbnWJWbw=; b=
	MKgAvlIBZo3xtbkXAklcaWscCtZbGET7OBHzwXerHkbMWXi8XX+TsPbYiKCyPkRk
	OZLpnSNyFVXOSknGQ6BkMvr/XDOA1lREks+Q96s6MFa384UXVbe4LM56rV3hPl+t
	zy+L9ERGEl37ExcvcTmlsRJvHIJWORc76l7z+wGF4KoVDozNPlOeH2MOQpj34Lh2
	1CHSSai0WI/xwu7vhZa7LFH8luENgDcBKkApD33bnYIQNEUK6yiWVihEarif9Zgy
	sz0HyMwG/d5vH6k9LTuhtsFtT4xAhoDFhvntpGo/9VHbuCtW5+qD+yoGh7Q/zck2
	t1474EwqQnqrVNcsBPthxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738788465; x=
	1738874865; bh=72aNNHub2QPGG7Gkse7HfpimDUw7Mf5rH6XfbnWJWbw=; b=Y
	LOKNxie+eskZrwX3A+ozQlzKXAxhPL6IOsYOlW46YVfiLD5kFg9TApT8ihWt2vyO
	y1PsJECcytt47S6g2UH7Lbzy3gIRflI5EjzdiRX2jLJdR2M0uG1LUo6hVEui1Mw4
	KGv/CbBXfKGmE5Ms8zUeM3bxB5V62k+vlCtBwJTNPtJ0MKgbKKLk+bhzVPTded3R
	AOM5AjJbIgALJDYO34ahUMHEpxLX78ZZtwDwmsNA3ssq4N3z3K20q6pSea6xhb7w
	JGgVB+t+Ya/kpEYOCcITUN6hK5rxGB5ME2Vh7eoVAawI0u//ye1Li1oU6lv3ybzZ
	EE7jVCLDhBBjVPSoQYIcg==
X-ME-Sender: <xms:cc6jZyqyjbg4YtRPBiB6sh_9FtINY0LjR8D4KQGm16850bEC9SoSrQ>
    <xme:cc6jZwq0FNXwvAFZx91Q6yksquo6uvH0ZsFevcxcoz-ybUKsqM2iIZcWCXXzNQDml
    lr8xegwXk7Q8lSO4w>
X-ME-Received: <xmr:cc6jZ3P8KfBJ8vbRCQ4TEHku8dxNqpFIJqkr_N_3y4f8SZj-A0Nyrpp3my6fh-XQMONUVDpyuFL4Zb2JRd_YB8v8VsU5Dgqnt4rl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfek
    feehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprgihuhdrtghhrg
    hnuggvkhgrrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtoh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:cc6jZx47l7OJB19PAQXhbjOuZuFuMLSYcRw9Pzmn27ILJjJvZgGHoQ>
    <xmx:cc6jZx7kbBaQKHv08qzjZbUGzMCI0REzku29nuwYstTkIJD-x7sbxg>
    <xmx:cc6jZxix3jFFgLzVskd-giMouHJjOJlikI5GKntSQ2IQkDArZmfR7Q>
    <xmx:cc6jZ76IqtNHYDswUi0YV0ZXN-jeXNuI7wz-AycLmsZDwlVE9gmg-A>
    <xmx:cc6jZ00xUU63t6c9E60S6QEb8qTEREc6VDmggEd2YQtUYRPtCWUGf9LK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 15:47:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: git@vger.kernel.org,  sunshine@sunshineco.com
Subject: Re: [GSOC][PATCH v2] t6422: avoid suppressing =?utf-8?Q?Git?=
 =?utf-8?Q?=E2=80=99s?= exit code in tests
In-Reply-To: <20250205142817.42117-1-ayu.chandekar@gmail.com> (Ayush
	Chandekar's message of "Wed, 5 Feb 2025 19:58:17 +0530")
References: <xmqqjza5x3go.fsf@gitster.g>
	<20250205142817.42117-1-ayu.chandekar@gmail.com>
Date: Wed, 05 Feb 2025 12:47:43 -0800
Message-ID: <xmqqh658m840.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ayush Chandekar <ayu.chandekar@gmail.com> writes:

Thanks for practicing yet another iteration.  I am not going to
actually replace the previous one with this one, as the previous one
is just OK, but let's pretend I would to complete the "simulated"
iteration.

Below, pretend that we will discard the previous one and replace it
with this one, and plan to merge the result to 'next', but that is
only for practice.

---

> Subject: Re: [GSOC][PATCH v2] t6422: avoid suppressing Git’s exit code in tests

This is about 6423 ;-)  I'll amend while applying the patch.

> Some test in t6423 supress Git's exit code, which can cause test
> failures go unnoticed. Specifically using git <subcommand> |
> <other-command> masks potential failures of the Git command.
>
> Instead of executing a Git command as the upstream component of
> a pipe, which can result in the exit status being lost, redirect
> its output to a file and then process that file in two steps to
> ensure the exit status is properly preserved.
>
> Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
> ---
>  t/t6423-merge-rename-directories.sh | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

OK.  And the change to the test body to lose input redirection into
"uniq" look OK, too.

Thanks.  Let's replace it and mark the topic for 'next'.

