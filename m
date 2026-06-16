Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2DE4502F
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781631214; cv=none; b=UUqMru6/xJzAoqX/QNah4QMX62n4QjipGkc+uwNpaprU3llGg7MLZkTv0tEGqWC6yEIhVDcomcXc6lcZeFl/mjD7zduw70Gwc9baDMJGBJ/6XXSRHmLQWUQfjRKo+Xp7oYAQ3FeY13MYmHejvnLyxhiA3cvFb8ZTuuph7Q2imk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781631214; c=relaxed/simple;
	bh=tsYYGblG/xHZqhdEYWWqFDXg0DOVNM2NtlTGTVw5mHs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M9cuiN8G5bH9I34ECQ4EyxwE62vXYMMc+ADU9Ar1JZ/Rk5lO7zZfNDdyLZtPDcrf9J9VRoOQlQ2uGXMSUb2rPo/ji0SFH/qxZfO7dpso50aIleUqYBbt6V8Q1KX370EHsqgPbIOYySomahhjZjm3CNnWJtnlPBzCHnySZyHMzeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WeCbruBe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JmUC0cU+; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WeCbruBe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JmUC0cU+"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DDF577A00B6;
	Tue, 16 Jun 2026 13:33:31 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 16 Jun 2026 13:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781631211; x=1781717611; bh=C9MhPRkzJk
	YgQQRynEN7CXpIDcCV+BnFCDyyewZLOaE=; b=WeCbruBeoSHYiK4/ikV6jwAsT/
	IyN2BOaWncQjkxGsH+w2xfTpp+N00Uap9XDFOKlt5Wy3LVv8Y0lqWMs2ppAHAtPI
	zHH4loD6ZHs0VVx01oaGkddvVd7wL1T06Mi1XaVxN501fqVbMRXDdkuUyna/YD0H
	15FhXRZt7Oo6ICks9s7iIU0P0o/FVYU2kC1fBYsBRZ1R6J76eNuFIuRlJp2FWQ9d
	0FCtxtXceIpw9dAErkdIf9xHgdtlp0j/qmXPQQHAVP/+pbsGYxtqbvR43q9pyBY5
	qqI6HLr6xToP+eZ0ElRI6xwStMqjMzaPo/aGdbtehFbSN8RA9G1+tdvLSYAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781631211; x=1781717611; bh=C9MhPRkzJkYgQQRynEN7CXpIDcCV+BnFCDy
	yewZLOaE=; b=JmUC0cU+4A6Bczp4bCpuTgdKm71lKPFNqcB7YdDteFsqe6IuDde
	ZdUtjD6+XSCvu7IpgOJYsbGgG2NOZLX22Rln71whAOLptmZkqWsuNCCjL2IGVAI4
	CnVAVjIAmvM0KzC+XCGmvoNhbTNbOMNd82rG0sbLSvfK3eWZAxcKSIbgjRbGWT2H
	oxCHgLYYR4+d+AOngR5JFYZZ1pYjPhi3fGAHgRP3zSp1Lgz/E58CLSbMTNkcXlZw
	aID1bGkxd7CaX6m2owEwazLXRyLADC87EIdbjpedyUxFmiDZFHRNmrVII5PFiBuY
	tDYbzTRtDFNLVip1cFLJOKNCBqCtz4qnafw==
X-ME-Sender: <xms:64gxalrvGZUaH732wI_bBwGgLNZz2ktTRoVwoah4BGsIt42wadP3IQ>
    <xme:64gxauirOpfuioi8uj1fHER2lK4dfgsOoGJeG5NTChtdcgnTbWEf8JBwqWT37J_EE
    gvLnU5q6xQN50asIWEvF5I0t7itqOoKcYNG34GuiVZAPSdmwItPbQ>
X-ME-Received: <xmr:64gxaqg0YGeUcGz49ga-Kq2cLzw6Trxcm7WdzqpxR2Zek63SluB82IU3-mqPhgSKHsXI5PKMiyAY5deUKTIwNLXuD_h2y_wKsbJk>
X-ME-Proxy-Cause: dmFkZTFInCzrjMNVldCJR394ilV32rDptSJmGudut3skcUdVann2jnj0RNI253QSgmLCSL
    cLHd+O9qL4JWxK2bHqcsgIyH/KdgglMgpoYFLIsznc/vQiIFB5TkvcTf3AdJLZ4HosOQHz
    qtTka2xZ+crTUctwO25QdXP3WJQhEkAlyAhR8X15sTREwg13QeTDJPKtdh1BdVU8IYdxiC
    TKIDUQLdnLk4Hr79CiziHF/AIT8TzhcvJICsVwc9vrDq8UIvRee1X4TOclXXJmkZkHL3jr
    9DwFsQAZ1HPUMhRpNYYuMqkhQd5KvhLlMUIB+4+07Kv6TLQs/qYDDMqvqiYL+AM7+lyefj
    2qO/aRWdBcyZKgePCg9T8oAuXbGHSc2pEUH1i9beQQax3GT56OhVvG11bbM98Dw43tOIBt
    5JFMgRjD4Fe2I1TQvs1WSLCam43d5urpZgyHjz9FEn/i5TZl/lH1+wx7S+1Ggk0kgRuQfg
    uD7upZmK/28a6j/VcKglkgC164H2mXNG8jC/CZCYd8fFIa0TpIo15SgVn1WkI5UgB8FCfq
    9ff6xs/mxPNU1nxjDUVP7+88nPiL6WFFWLYoiurMM0JNVsUzhG3nrUuNtw+XfXqFUGQtZ0
    1D7nPYwOt0xMMD2yRjDoTxb4Ln03S7wqndaujtz1+S0FfDS7CtCT/1W82uPA
X-ME-Proxy: <xmx:64gxasiFxjMDaazNqrfqXh_tQJJt8dYf1zZukWPVAOBh0gxqngOHtQ>
    <xmx:64gxaiJjLmF1KWsRG7VPPW5FazsH-Zf5-a6BGcpdvu-NnisXS0vkXQ>
    <xmx:64gxajEbJfFtQTzh7ti9kvOt86J7rqe-cr4ac4vgT-71vIDPYxPE9g>
    <xmx:64gxauThn-jr1fSIa6qpRLXXSIjbDvSLCqlVSWJRcxLIu5EkMtqHLg>
    <xmx:64gxavzxUkOU88j1OzRv3uIiw7svVrqV0MbiQLP4Sc4AXIw0iCcWNgeV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 13:33:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] rebase: mention --abort alongside --continue
In-Reply-To: <89d72342-5aa1-4dcf-951b-d0c791f91738@gmail.com> (Phillip Wood's
	message of "Tue, 16 Jun 2026 09:36:35 +0100")
References: <pull.2330.git.git.1781551170529.gitgitgadget@gmail.com>
	<89d72342-5aa1-4dcf-951b-d0c791f91738@gmail.com>
Date: Tue, 16 Jun 2026 10:33:30 -0700
Message-ID: <xmqqpl1q2xw5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Harald
>
> On 15/06/2026 20:19, Harald Nordgren via GitGitGadget wrote:
>> From: Harald Nordgren <haraldnordgren@gmail.com>
>> 
>> The warning shown when an "exec" step fails and the "git status"
>> advice while splitting or editing a commit pointed users at "git
>> rebase --continue" but not "--abort". Mention it in both, matching
>> the conflict case.
>
> I'm not sure that the "failed exec" and "conflicts" cases are equivalent 
> though. If you have some nasty conflict that you don't want to resolve 
> then aborting and trying another approach such is incrementally rebasing 
> is the only option. If an exec command fails then it likely means that a 
> test has failed or some something similar which is minor inconvenience 
> which needs fixing before continuing - it seems very unlikely that the 
> user would want to abort the rebase.

It is very true that users who know what they are doing and got into
such conflicts are opted to go into such a situation tnat it is
unlikely that they would appreciate a choice to abort.

But given that for any system, everybody starts as a newbie, it may
be assuring to always give "here is a way out" option when they get
in a nasty confusing situation.  Discouraging the way to use the
tool that can lead to confusing situation by guiding them with BCP
workflows would help, but they always get into pitfall.

The patch adds new message into the existing message to suggest how
to move forward, but as a training wheel option, it may not be a bad
thing to offer "--abort" as an extra hint, separate from the
existing warning() message.

