Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B65B20D4FC
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783864960; cv=none; b=MIvQov2m9q89trpE+2va/6efON+r7IG7t5BCiGAhpVXdzth5IGXQk+Ko7Uian3AsNO/wKiNyeY2q0U6g+Iz9qkWjKBXcZWiHrl1cC2kiD8uiweDh8kGFxx2BDkdQ9F7VXr5XXNKjOI+bGdRyO7WqS4GzmBh09jJKOFBDUq77G6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783864960; c=relaxed/simple;
	bh=Ep6eJtzL11H6F64WXe+WCKApN7ctdq4X5cbRrbLBA4Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PYYVPNwcI6nUgK/gWSZou5XZUJdto0ttGO2cZzvlNG6fZAyV3GenxF81gU88XvnzXmf7Mw1oCG2Ht66NNwvFGp/MYplHWsKLOhQALND+MhzHoIHCPt/DbO8Ew3dU4gFP0jaKOpNszdVla3mhiX0ripzqgHPWgagfyDSVYyaHQi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jAC53weD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nSPQG0K6; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jAC53weD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nSPQG0K6"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3623B14000F9;
	Sun, 12 Jul 2026 10:02:37 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sun, 12 Jul 2026 10:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783864957; x=1783951357; bh=5Eji3XmrIC
	H1Tbz1Zeo3q0wiTvyP8Buj+LkUgYVNP0c=; b=jAC53weDczSFMm3TDEv/piNMoD
	vEgT0gQLlwB2nmFPJfCGgyDrLsp01UscXW4qzcqmwurqx2REJQOShWrd/MJg9HCp
	hDgll3mCZlE7THe6A7ZZ5P9f/Z6bzgkjIrJpccIxlZFZFjupMVYE/5OaFRou88Uo
	Aulu0g7p3YvEy3jIN2ZkIls2g5SEa5n+O9b4wanNaeOxbAlj5af7OqyxZOd3kX7W
	wP5wyrIpVH52+2ddeXAhVYrn4LI3jMWf5yjpnx9m1fcS0LgDHBv3jWerBrHzuL+/
	GUXoKECb28XLJdFTReJ/LFbRgcI1KfTemWwoiRJKgNSMCubrh4lm8YalRrjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783864957; x=1783951357; bh=5Eji3XmrICH1Tbz1Zeo3q0wiTvyP8Buj+Lk
	UgYVNP0c=; b=nSPQG0K60tNuHqqz/+rT1vuT5aLSXuVgC/ps6kzEv46CPUi+GQ/
	rOk2ipTDUa1JvRAlwbmJ7qOqiL+3Z8KnibqLXp8T0DMAbpz8LbxDQIgNUaFtNIsx
	8RUOSephNk/ycjRpWicAsjTY14gogqdSHjKUyxu5bMRUxDKr/X9q3QxKmtd2VB/O
	Yqt+LzapQKv7BZeRi/jtOjgCmdiYaG3DoQre6PVMc2LaslY2HIS4CK89e5WRySMa
	qpxMDv1s9cGFM4Eva3VGdcJk7fAPzVETT3CBVf+9XmtczhmBytWhiSNqsqIiW+5Y
	27Iodxtk4Igl3/sQRNfZhgNauzvXLbjAonQ==
X-ME-Sender: <xms:fJ5TatGWFdfaxWHz_li5kG9weWZPNriqr5SmfdoG013qN7BmTQhg0w>
    <xme:fJ5Taj0n_sVGlTT7COygxkkVDRtCV6R6JfPJYZJm6PniTvck67eRDVM44dvdtpMrL
    TayzdPVDqVnCVg6XQBZQS03xGfh3kfEa-OX-2V8CtbtzB1WjJjVAw>
X-ME-Received: <xmr:fJ5TavM_yetxVTH-1efthjBarfsqlulekI1AQ2fse---BDz_l_HDVSH5bB7d9Ki8KJGVSGk4-tvTikL1raEhD1n5_9Tc8TVm4yPSE1k>
X-ME-Proxy-Cause: dmFkZTGHt3FLkMZ6ZLHHjHbvrIuawf8ziTYSg6xuDYBhR3g7ZvLlr3HCuSgdIL7feJpz8L
    C6TEps7HFK9MHLqhQ58ZbA9XJYFQjmRjG0OvcdQ4KEjZLnZ3MdfgQMpMRuECgeKwLnFAIK
    qoQI8DbNgHfuOt6mn4mT6hRwKPY1gBxVv9pXx6/6eIMt7+ePrpPMVK6PMnesV6wUB+DaIJ
    OGeRXbHfAYgiOKdFrgKXDmpSsF406azxamqd1ymkpxo8+hUBzVQXvD0KhVFITf2yTLVaSQ
    0EAVn14LU8J/NfcUYbBw29CEEZXp8h6zZDVKapGbzxOUP/z1WMAPKZEd4z1NGP/2ovbvif
    ACBH2Zsyu1esGpQ7ZrefeHyQrvJumEiwlnDmgeTrrhxGxkWhVSY4yHOf75Glm7hGso93Vn
    A7oBIsrlCIjtYJZnDW9lmEYBGti1tuAVmTyXmgArQwDzO3gUGgIdov9fJd5+qvmyzB/3Oh
    KQ5GjmXWSEnQt8IOVLEAjh7hRXlHUfnGAdDGqFtRP+XrJ+/lZpv4MF3fPJqVA+bvtbvfji
    vZpQHBhzUSDhESvO21sglVLEGntYYRAK8TFUI/Tykm2NivyfDqQLjMEt1LfQYDbXba/ScS
    zDNJiZXP2lCJj9i4kIt0VaN6HvML09dl6uv0d/6DfAAVmPJhFyd6hwKiBsBg
X-ME-Proxy: <xmx:fJ5Tai7mJObL3WT08cpONQQ0a0wg_uV2KbPEHEaktF3NqSOJH7jT_A>
    <xmx:fJ5Tap2dJJELz-Q_noK8aGfqfcs0suoSswTwT7fp4fVhvLlzhxt7YQ>
    <xmx:fJ5TajxrXxxUYC0qXTHiOHe-hPsmIh66iVa3ZzSLEmx_jlR5PIvMbA>
    <xmx:fJ5TajvrC_siaXFdyBEmxNqy51rq3_2SrZE1RVKYPypMrWAA9Me8Ng>
    <xmx:fZ5Tal94V3Ea4l967_HnavCvKSTd6q87vyMLppr1td_un60nCel_V5hE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Jul 2026 10:02:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,  Patrick Steinhardt
 <ps@pks.im>,  GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] Makefile: fix up lib directory move
In-Reply-To: <ef422523-1c50-ec79-e89a-f43f02ba1ca7@gmx.de> (Johannes
	Schindelin's message of "Sun, 12 Jul 2026 12:15:23 +0200 (CEST)")
References: <0c94331b-7eb1-4116-afa5-811082ad5854@ramsayjones.plus.com>
	<ef422523-1c50-ec79-e89a-f43f02ba1ca7@gmx.de>
Date: Sun, 12 Jul 2026 07:02:35 -0700
Message-ID: <xmqqbjcc5mro.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Ramsay,
>
> On Fri, 10 Jul 2026, Ramsay Jones wrote:
>
>> Commit 9759608622 ("Move libgit.a sources into separate "lib/" directory",
>
> It's not your fault, but this commit is no longer reachable from any
> official branch.
>
> Maybe a more stable way to refer to this right now would be to name the
> topic: `ps/libgit-in-subdir`.

Yes, citing the object name alone would have been useless.

On the other hand, it is good to have it as a sanity-checking
clue.  If or when the patch does not apply cleanly, we can tell
that the fix-up was written based on an older iteration.  The
"reference" format used here carries more information than the
topic branch name alone, and with the commit title, we can run

    $ git show 'origin/seen^{/^Move libgit\.a sources into}'

when 9759608622 cannot be found.

>> 2026-06-22) moved some files into a lib directory, but forgot to update
>> a sparse dependency in the Makefile, resulting in a sparse error:
>> 
>>       SP lib/pack-revindex.c
>>   lib/pack-revindex.c:78:17: error: memset with byte count of 262144
>>   make: *** [Makefile:3446: lib/pack-revindex.sp] Error 1
>> 
>> Add the missing 'lib/' prefix to the pack-revindex.sp path.
>
> That reasoning and that patch make sense to me. Thank you!

Yes, indeed.  It is queued on top of the topic.

Thanks.
