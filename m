Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5DD3546F2
	for <git@vger.kernel.org>; Fri, 29 May 2026 05:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780030976; cv=none; b=XivKaK37UGHIKrpz+0iBbn0C9xQP89f1kUV7sprVnqAl0dfQNx5uqiyu3ytaklgFQQG4buSV+xGrp/u8h4HoLbt4kgqKmhduFFMsWK0Gwrhc+D86vpfQYmiPCG3II35T3UY92eoJQSx49U2DlpfVNl/tt8LyNIdFBCChVfLHMVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780030976; c=relaxed/simple;
	bh=woyOPVrwfkrc7FiCJKzUrSgNm1nx8rqSPpkkSZsqi3g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qcEt/bfnreNbX0xkFRd21ZrcviC7JpwxLHbBhYgW34WYgD6VB5p4UGWJ2J5H9MlXa8tfzQ+hM6xZVf7iGsCi96ecE6D77e7zNwSl34QtbevtebpxA4yTKwuQyppzusZvzXoyQd+o7ZkwfKSlrMRCmVOk2ND5jabM2OaSWAdzjx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fwdtzJX5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nYHGde53; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fwdtzJX5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nYHGde53"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 99DED1D00136;
	Fri, 29 May 2026 01:02:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 29 May 2026 01:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1780030973; x=1780117373; bh=kuceTlnzWk
	ZmlxQUs9j63UumU5YxTXp96wul9J+1kAY=; b=fwdtzJX53rcR/gIwATEhjP0yHj
	9FJhy+nj5hMECqG57ffi9kuCbckb2mmrI42BNizRq3FoDj4U3S0Fda0zTZz3KU/f
	KyoD9Ne1A0YhlFpdViDe/1SAWm58jcFrePqQlsXZf3+McZs+tAt9BH4Rl+6sKib/
	054E/5xX4eawE5ZDaRBDwWP6pUlKdRmF/R3KPZF6VrjCkm7LUt4OeYzpeQf7gBec
	yNT8TBVL5U2rxDfzn4JQbhiEiNSfO9V7ToPa2aF9ic8G2lKRDRdZ27tcsfLzupL8
	0WQaYKULboRMjx183FdZ5KNiEHCYHJCLCGmalDppyBy4YBGDQHvMIN2kddjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1780030973; x=1780117373; bh=kuceTlnzWkZmlxQUs9j63UumU5YxTXp96wu
	l9J+1kAY=; b=nYHGde53eWWqvuyEpP2Rb+e3YopAZc+rTSTen27ooVLYsdcdDIR
	c8EhtFT6qL3VPyjx+52/C14L8YzFZh+vxWHo/hSC/FRKIan0VtdlJlGIReLWfmhl
	nK67Ldn/APIF/25PFSDXs2+xoOqat/7jTRvoSOA0r3QG30LUF02FAzE+7Pa0m85H
	NqWUZ+cqsrat9W3Q6FXrCLnhZqy/eipvkwHAevCLYafT1YukDujsyC6yRT7aZcVQ
	q2tnezCTt7E7Q4pZipKp5VznEKItl/AHdrBxJSDl+0WtvZdwsTPLHuecC6jvxUta
	YtyZCdxpOlcTNasa4lxHxlNmjkpfd4mTbaA==
X-ME-Sender: <xms:_R0ZauFSbH53mZbh2S_UakvqhzyZo25JMmOergVY8PiMdVZpoXNYKQ>
    <xme:_R0ZamUwMA9lEe7-8SfJPSvwkVLfcmKiB3s4mhCTN0EscpEiFrUBXe-tgO96bOju2
    2fX2FJ3VTc4eiYbXdOOt1gAlXa1GUweW1r7-fG2-vyqoyyEJw7g6w>
X-ME-Received: <xmr:_R0ZatJmBWTWl4oreDMg-j_alVR3Y4rMddMWypSUdFxJM2kqAYZ9BMqVXj4Vdzi3rhfHeuzsbk1EnTVeNtUrItnSXSbHVs0j91hE>
X-ME-Proxy-Cause: dmFkZTEUUNPSk0/TC9Vznq0utitxzvmIG1LRp+21GtgN5cqHdcsKxRoMOM7b9rUDoOGNKd
    IWc4p3wnfMMt6X7pqfCZ5OM8jneEutByFykBqjZXvGsmeTbA+MjuH7uYhBGKXIt4VTUfpp
    IwhcOclSPmzaPbRhqHwj2EVotpOfuSRnWUl2GbmgbdpgR7WWawZj9AUNL4eFledH9w4eo2
    GU1iuNF9XaOj1Yhg7w26OzX/lFOJ0wFd7FymBCT3L4O3jZSenW6xG7VTsKzLRS8hURJzCL
    XnDym44Lu8lgYe7OF6OB0lGCNtURxZSZPSR9JHs+wJUv+hdj0W3t8cYoNoprhkSj5CkJiv
    4bPFWsaiYLINXFPNZZR4oF5mV6l6AAgwITnfIAQJIsdcDQyHz7dVopRrOBMyAnWZmrQM3n
    QN/KOd7btNw8xslLlznNmtB1KpWW4EpKZ5FLPKFhV1FnZtY5a1qEty8ruDCs9tjKFWn1UI
    sR2cNi4FUivmRMAb0mXil+GNgAmQtctF42a1VLW5TIt8bOxsgkJFTdiQwP0OxJCMNt6NJY
    HEoDGWDtCmc7uiJtEytTRAzRfRZJI3YzEcsH7H/FxJsGjPGvVDjlHCOKJ4bLUFH8FoeWRF
    5D5LsMSfgXgng16TcQt8hKmgR1fI6mMZLsEdVH3K2EzQBEc8gKuWw6wXcHrg
X-ME-Proxy: <xmx:_R0Zam-BZS9ktbH3WZybri5MaN9Mwxn2U41UcaKE5dICzdu4U7xYPQ>
    <xmx:_R0ZagIMF6LrxyXXPZ8sT5u5b9VvyBsKCkuDBYYZq0NsMQU2GYAEGQ>
    <xmx:_R0Zark2CNUQpwFlUB7naAuEygFclXqpWFw3De1ue7xD45HmovOnXg>
    <xmx:_R0ZakOWIH45CfAN0QMXNK7m5IecI2hJJQGJqwofMABwEmtCD_tvXA>
    <xmx:_R0ZaoqHzOab6r3AzQfzJmOmIHlDLpXHpRp_Z8YboknkfudHIWSWzgrY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 May 2026 01:02:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Brandon Dong via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Brandon Dong <brandondong96@gmail.com>
Subject: Re: [PATCH] doc: add missing --message long option to merge docs
In-Reply-To: <pull.2315.git.git.1780019726297.gitgitgadget@gmail.com> (Brandon
	Dong via GitGitGadget's message of "Fri, 29 May 2026 01:55:26 +0000")
References: <pull.2315.git.git.1780019726297.gitgitgadget@gmail.com>
Date: Fri, 29 May 2026 14:02:51 +0900
Message-ID: <xmqqo6hyiz9g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Brandon Dong via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Brandon <brandondong96@gmail.com>

As you identify yourself as "Brandon Dong" on the Signed-off-by line
below, please match this in-body From: line with it.

> Include mention of --message flag in merge docs to match what is
> accepted (builtin/merge.c) and to make it consistent with the git
> commit docs.
>
> Signed-off-by: Brandon Dong <brandondong96@gmail.com>
> ---
>     doc: add missing --message long option to merge docs
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2315%2Fbrandondong%2Fmerge_message_docs-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2315/brandondong/merge_message_docs-v1
> Pull-Request: https://github.com/git/git/pull/2315
>
>  Documentation/git-merge.adoc | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/git-merge.adoc b/Documentation/git-merge.adoc
> index a055384ad6..6581f4c69c 100644
> --- a/Documentation/git-merge.adoc
> +++ b/Documentation/git-merge.adoc
> @@ -68,6 +68,7 @@ OPTIONS
>  include::merge-options.adoc[]
>  
>  `-m <msg>`::
> +`--message=<msg>`::
>  	Set the commit message to be used for the merge commit (in
>  	case one is created).
>  +

Hmph.  This is still not consistent with "git merge -h" output has,
which seems to accept --[no-]message as well.

It is not exactly your fault, but there are a few options other than
this one that support optional [no-] and they are not documented as
such, even though they appear in "git merge -h".  "git merge -m foo
--no-message other" behaves as if "GIT_EDITOR=: git merge other" was
run, it seems.
