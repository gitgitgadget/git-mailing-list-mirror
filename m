Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94EA339B3D
	for <git@vger.kernel.org>; Sun, 30 Aug 2026 22:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788130478; cv=none; b=MTgGOKsHsLOgA8rzssF7BcWwVIKKkJHIdtIoQap4HHIa7PdA6XJ/1TKRh5RviwHvFM96vq5lOmNmB+ySYcN6Yw05WwTRBYzDLKPt0FgO/OqaOhXPlrIiznqEluiAc+beUHPBE8MLCFf30EwnYx2xotlgrOrl1ehU2P7YxY854J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788130478; c=relaxed/simple;
	bh=N9QnR2M/m9MdneNz+rBAaOWYm8TqMZxZ3DHdoLM0Lcw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kdUunS61/wQ18YiXhNyIIMvdWymDEBoeJsSl7OmsSooiHjrhLfuPBvNGLTFzXXa9bmzrIPNvS90MALOKX3nKnAlW+n/TPuzTndkbFsDRF7nf6g3n5YU9t2NfKFKgea6WJBrTIc66r4g8vK3q8n749lW3973puhroiqu1dDddhv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PutdIrAn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aakgNYmo; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PutdIrAn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aakgNYmo"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 0A424EC00DB;
	Sun, 30 Aug 2026 18:54:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sun, 30 Aug 2026 18:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1788130475; x=1788216875; bh=pt8PoQOI6B
	0Z1j0B6mfytlI5FemBRb4M+DQH+2fa6so=; b=PutdIrAnEku4qAK9wtrp1XvR/p
	EAIwMYHC4z2LH4lOjH+jDtiUnUU8aOTZEKmXbRWb9grk+k8H1WjX1ab5kygRrkPg
	X8Dv6fOTfaX3WfyrSbRkBuXo1+uWytPsmHFX4vYO711UW2IQ5ya9u7bKtZk3iPPp
	Z2WHTg7jqY2c3ywA+LyJsWvZCdEW0ZszSI9VLcJOwjnkVeR0fvEFwooOia/ayIbc
	3lHSHvywsoNfx9Vh4BNtmgEjI2suSIMKUFiKKwDPP7w3u90gfY6+Z4r2xTkj7/8/
	F+/v4SwFoFDXuqVLBt/C9v88ZYOE5rTKLetjcZVkW5d1Dyb0OlNyILu6pFuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788130475; x=1788216875; bh=pt8PoQOI6B0Z1j0B6mfytlI5FemBRb4M+DQ
	H+2fa6so=; b=aakgNYmoeXztnAWZW+CLHw/quu7vGcFku9+LFtZhqfJPGpuHlzl
	Sgh+U1hdocKJFuwcPcaD2i3yayUGCt6aOYbabaA1L6tIeAqY6numzpm8WTXnaUa2
	5129mLFTnEm8lbREcdVSMRAcUB3mom8qxpE1abtd69NR+8g/AdyodXSDPcGRUehZ
	p7IHexi/Cdgspj76Q1cE8twE7Lii89dfgRT0KQyhR0L2PRU5u27XcsuU+I2MYnSj
	WWQ9cCrojEtmtZTroczvTle1KLpqS/e3HzzZ6bAisMH2+3wdWmhDUYyOk9IY7rw/
	8xOoM4IQBffFnWFKoZB98GPK8NCCOOnk55Q==
X-ME-Sender: <xms:qrSUav36fAhP0UB_zMMG32RX18LU9ibb-phdJw6VXWRCRSsUV7A1ZA>
    <xme:qrSUalHsIBGadTOx--BHGuhLr2vf6Mq3fj-9WoY-J_RFtOf9oD20pPA_-H0fgXp6U
    OKS2QW69m1UBSl0kTEoAYj86dgTKVWphR6qBk8UFuth1mp6B0mtCA>
X-ME-Received: <xmr:qrSUak5y62VXz8FUguG3mAPXZ1UDG5plmu6wiZ2bMjM781ZERAI5adI9BC6Dp06U3pG1t9SJO0nCpzAZ6XdVkAWSxNKswAWnoQ>
X-ME-Proxy-Cause: dmFkZTFmhjccQ1cKjeyx0+Y6RUwCgpKP1/0eAcquGZhC6Z74gMneJ3ALuXwAxbU6YZVPsS
    O3RzVLm7WKeDSkDx2zozNjcIPphIq+ipGtY05AY+epY4OT512oTuiy2wFXw8tG6lnvzo6l
    517o6WchHavK5XM6LaXMVE0UtJe3b/GrH5uljUEaiUOhrbm1eWr5pTnDy5DUh2Qo9a7MqK
    oWvjPXjTlf/Pgqur134eJhw/wEkdzP9aWUzTkGXBPWK/xg5qSZTJelb+djADWFfNqJg9FS
    NjvZQBlS58h7JAN+ERyO5AK5Z5m2DHst2m1Yx/TrTC6Cdimyxur9ERL63L/mxN4SosNlhF
    KA19ciLm0KtQ6Va119BsWiXXLWoE+M9l/aoR+w8bcX1Ft0vGeIPuE5SNFYa/dsDJ78W9jd
    ENpUpDVky+5iQq6yPuYYmFnnxTESe9JmG6hogMC/Ntakn17nyU5A1mYcSZmuVJR4iwWwO4
    zCOHzYVU5HOcTC7pok31OzuHgeTYBJop9S/o6QtuttpoOLkIQdRzpJk+crRfm2BG5Rhm50
    iD7+PtbKMZzvQsi2HEVephr8S8tjY/t5141diAsy4PgDv371IBW5wYcWknAFdXwlndNYMP
    DmBdWDhgKTM3C3riFAB4oV0oBu5GVAb1Daf7plEI2tzOZ2mwqIkYN06HAZ+w
X-ME-Proxy: <xmx:qrSUajvN-cqrKoS-e8fO1PHjygwWjQ3JAoTkes2Gqy1Z4ywEEnL3DQ>
    <xmx:qrSUat6ZZOQ2WHNI1ba2tAT3TXaqysHC3v7kChoAU22kdxDLOn22YA>
    <xmx:qrSUamVFUUwLXvdApUc9rqDlcw1NpDxEei3EZvVbwiG6F1jG8Jpb3Q>
    <xmx:qrSUan9d-pltdfDqRfO1QYu_ScCRGpTRVPym4zpOsOMpof1mqrnjyw>
    <xmx:q7SUagZGaU9KJvRAiUwMlo51CkLPz5CSBMZyMMv7hpT3vhvW97fRcrI6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 30 Aug 2026 18:54:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v2] ci: cancel stale pull request workflow runs
In-Reply-To: <pull.2369.v2.git.git.1788087560290.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Sun, 30 Aug 2026
	10:59:20 +0000")
References: <pull.2369.git.git.1785492641983.gitgitgadget@gmail.com>
	<pull.2369.v2.git.git.1788087560290.gitgitgadget@gmail.com>
Date: Sun, 30 Aug 2026 15:54:33 -0700
Message-ID: <xmqqqzjfz0ba.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> The CI workflow previously grouped all runs by commit hash using
> `group: ${{ github.sha }}`.  This meant every push to a pull
> request started a separate workflow run, and all workflows
> triggered by the same commit shared the same concurrency group.

That's the current status that we normally describe in the present
tense, no?

> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
> ...
> +# For more details about the `concurrency` attribute, see:
>  # https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#concurrency
>  concurrency:
> -  group: ${{ github.sha }}
> +  group: ${{ github.workflow }}-${{ github.event.pull_request.number || github.sha }}
> +  cancel-in-progress: ${{ github.event_name == 'pull_request' }}

If a user has CI enabled on their own repository, pushes a commit
there, and opens a pull request, wouldn't GitHub Actions trigger
two events for the same commit at the tip of the pushed branch?

Before this change, both events are assigned to the same concurrency
group (the commit object name).  One waits while the other runs, and
the skip-if-redundant logic stops the second one early without
wasting cycles on the same commit.  With this change, the
concurrency groups for these two events are separate.  Would we end
up building and testing the same commit twice in parallel?

I suspect this may not be a problem in practice given how our
contributors use GitHub Actions in our official repositories (either
those owned by gitgitgadget or git).  They push to their own
repositories where CI may not be enabled, so 'push' does not
trigger.  Still, I thought it better to bring this up before the
change gets merged and wastes build cycles.
