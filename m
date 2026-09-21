Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB184DDB41
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 18:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790013682; cv=none; b=JSpuphhr8+SvBkSZ1k/N/128wN8khGzTgxA6tcSrBIVn6bYLRrTt9HHw5rdX0HUOXdI0h8Bw8E8AGw6eqBY8modFbvFNmLjxuwXrzEaGtxUGuGJaqEK8sccrfTzeqTbg9ybLUbbwevexUAwLVjSYtl07lf/dp561xoRlfV9a5xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790013682; c=relaxed/simple;
	bh=SZsqAZFEEHG+l73TE+crl6oKVktY/jSnB/bOieRKp8s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TtpqoDAGINK+Wd0QHpGzAT1fHY8wJzVGwumZBmL9kQMbqqPx4LAEyRvdhGqcQ7UXuFG7c2oiWTwZiXPwzdIwsfjuHCYE/WVjiZe5rXA3+jkFyf6AcYNpScz6pkagYYC+MQB5Rqp31CgxBCvfRM9gum3bSPEO+w4paS/HkCJXMjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EXoFoUME; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SDpkK3gH; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EXoFoUME";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SDpkK3gH"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 07D4FEC02B0;
	Mon, 21 Sep 2026 14:01:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 21 Sep 2026 14:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790013680; x=1790100080; bh=VNNOKQFgc1
	oWwKrefCdv/TGDSuwbpsy9BawYgAG8gNw=; b=EXoFoUME7Qw59N+/xubskpkVkn
	vcBIfaOE2uxms4rknvFFWAhNQR+q7GBNpHp1006Lbi19Aj0HaahfrXm12x6gdIzj
	rDPfjkfc8rrjMUB8t1DQPIri4kPvR4VFt7GTzGjuOT0QDHchbYoKUUZpfKx0JxMC
	q0X9bzaHpSM8sIft3leVofRFBK8/86NHuFmQuC/yBp4KjVFR3AR4elMqwG3FAuK9
	EzyUMj4e8WHFtEbIQbxg69HgZYFJpuwIirIloPV1TlAvDnYuhO01e3fkFM4NtUEK
	VPc+v+LTVGXVj+7BrI0cpxyJ4A5+nCCnvgAluoblZ7Ei1WQk7UM1btAq1qbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790013680; x=1790100080; bh=VNNOKQFgc1oWwKrefCdv/TGDSuwbpsy9Baw
	YgAG8gNw=; b=SDpkK3gHMx/Ab8d5b2WbXHKIgpp0KomXAbcrCfFZcVMt8Yk+sWD
	m040DAK9JHGk+q3Fq0dlhV5VLl2SDvmiRw/0zgcG67mUEjEr/KhlH7j5Hm054vGh
	FD4YMv2EGyfy+QVnR9itMRa3y0aIaHl5j6c7VaPFRey4GlNGHeXtwlx39+bESZ62
	t00E/sGwsSHkzvNN31bYH746OcphWOCVgbLaRv/rTVDSHkyBaOFw14RuuX/4ykyj
	c7Q/LYFMHV7Ubhd2hJVlb1QqEouPG+7XbhG0h9sncVOBTe7oD8MdbN4o4ph6NaFr
	ZEx3KaT+cJGLFRqjVEc6Nur4J2L63sos7Rg==
X-ME-Sender: <xms:73Cxanln_V0tAOFchAjh7YZKGWL1rs81DqTKlxmY0H6Fg3NNUy-_Kw>
    <xme:73CxaugF2fh5G7Nbacvc1Qv_jazNQitS8EwE7igVWsmB8nEQABhEgI8uD327e04iW
    zrj3eRfGtHzZSiPxmt-Lb0gzhsRYED9ttFJFZz6kOQonOeE34K98DA>
X-ME-Received: <xmr:73CxandOWdrbVUo7CU4Z0AY9SSnRaYux-0enBLm5xKa5b4d1NXyHxR7Mk9jr6mm3nR6F9buVzEf40ag8De_JhiUURMWzMsicl2Eg>
X-ME-Proxy-Cause: dmFkZTE9uH+/hEeXFfMOZf4B2RCKnscFr/DQUo+mtA1tQBVJpSW+j/oUJo6J/51WZyzsbJ
    fdX8udF3ndLdU6fPnxXCANBW2jdInK/iVxRrsys3KCgPC4LrUpTup62fryRoEulARZKFHo
    cc21Ya3B1GtQIfcNHVoqFxaOpSsHGP70ErvbmnhLRQXcsCWe4zo8kcCr1aDwTBq5+hUOOJ
    8Pw2tEmBgHAm8bEEXddnCW7TQR48kM/y2i2Y4RBMSjYS5zDShwGphjeOX6U9mQGEsXxhCo
    WVwFaJ6WPj1PPag0QxhqsSvO6w78D9zEaukB1qZMX8fzA8Bt3WDY5ymXCAAH4FoupEV6m9
    DO8CnSUKs7B6WQHK7efh6MgCfEGj44xKb6H6uPtq/Z68gmJp6Xs9iHfPEpBcMzzazEEIsp
    bq13GglbPBzsEpVH7sZ04YRYgBn/EM7N+pJZARUTKZznQXsvbn6qvpTkQ+q/lA7OipwVtR
    Z1Ol2SsZ/5gdcaIR0hepoAyt5nI6zVCIrBa41wltR5jAE28t1taUofTteyLT/BVGKZa2cw
    IB5QdCqIqVXcYDrUCBh/XvmMmhSLNn7IahWdJZDAwAFN6QdkuooilXOEnxbx8IBFvIqzs5
    kZIeru3qljUZQBQ44fjo+bxiRkUwytrI4jbocJPxjh7UOkfOFc0vZwnU2Jqw
X-ME-Proxy: <xmx:73CxamjCJqAIPdSKa_a-i8Zo9tT4_M2q0ULWVQebgQ-9OiItqkTW8Q>
    <xmx:73CxanwFgNG-swt-94gagzS0orve2TIOLXPtr0xvIby1agPL5ONWag>
    <xmx:73CxaqPc710uPhO5JrBf2--CZOvSmT7nWGOodVsv3qoSQF8hfoW9ow>
    <xmx:73CxagXap02CCDMBvHE5zVTW9ZLXYRYq0O8QCPcwFrhoHeisDesOhA>
    <xmx:8HCxauJSftf_b3tMydbJQCaAXotCik_NjKF9Xnr2v94jdUkQViHOU8DF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 14:01:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Haokai Ding via GitGitGadget <gitgitgadget@gmail.com>,
  <git@vger.kernel.org>,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
  Haokai Ding
 <hk_ding@outlook.com>
Subject: Re: [PATCH] diff --no-index: fix -R with file/directory conflicts
In-Reply-To: <0c82d50e-f2c0-4db6-ade8-7a403cac73da@intel.com> (Jacob Keller's
	message of "Sun, 20 Sep 2026 16:04:32 -0700")
References: <pull.2232.git.1789715946888.gitgitgadget@gmail.com>
	<0c82d50e-f2c0-4db6-ade8-7a403cac73da@intel.com>
Date: Mon, 21 Sep 2026 11:01:18 -0700
Message-ID: <xmqqfqz2mqkx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob Keller <jacob.e.keller@intel.com> writes:

> On 9/18/2026 12:19 AM, Haokai Ding via GitGitGadget wrote:
>> From: Haokai Ding <hk_ding@outlook.com>
>> 
>> When a path is a file on one side and a directory on the other,
>> queue_diff() queues the file separately before recursing into the
>> directory. This early queue entry bypasses the reverse_diff handling
>> used for ordinary files.
>> 
>> As a result, comparing directories d and e where d/sub is a file and
>> e/sub/file is another file reports both paths as deleted with -R.
>> Reversing the operands reports both paths as added instead.
>> 
>> Swap the filespecs of the early queue entry when reverse_diff is set,
>> so that -R reverses the file change as well as the directory contents.
>> Add regression tests for both directions.
>> 
>> Signed-off-by: Haokai Ding <hk_ding@outlook.com>
>> ---
>
> Thanks for fixing!
>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Thanks, both.  Will queue.
