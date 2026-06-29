Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1931137B023
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 15:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782746470; cv=none; b=Dq4MivlkUlQfVE3stua8Lk1eFqIlSAdGd4NOrb40tPdVlhf2mO8t/jPRO3JQHQ1gxEogxZDkTmhaSeLS7hq3y/nHgHhe8JfbngR5sHwX3z0F7x1i+JAW77yU0jAm3ik8qEB4wwZZwjljtLFT9TPA2DoLipgy3/MzLKbxMtQ+pH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782746470; c=relaxed/simple;
	bh=9fu9RhjAxvVAllWRz6wiYAFXgrAk/qr58V+tIZDDZzw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NMc2ihkesBWerIbE1TCGm497iTp2/cJ33V/g2N0k6uX+mDlb97h5phtcpTbJPI03992tmvwursa7afmIoE2QiKOB+jwSFwMkREWVlvzNklp8YlSCU4s2vbXvAkNlTE4/5Aty3SGB2nzrSwlYFhITtdlNA6NgasRGCq5UMyWyNbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EJuNhGuo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Awtub9PY; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EJuNhGuo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Awtub9PY"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5C57F7A0018;
	Mon, 29 Jun 2026 11:21:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 29 Jun 2026 11:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782746468; x=1782832868; bh=F27EAZcuDd
	N2jazcr0PufEyIJHNewnTu9Atn7+xPZY4=; b=EJuNhGuoKSTUwm5DPzKngMY/1y
	QDV+XFmI/ysS47Vzsco8bLZtRVLRLDFZehjIhdcLxarqA+Xg/61B60CZ7xw8AaCs
	rGWXInUuxXYXK+uWAeN5tClVsRC5U33U5Wx4rz4jH3cjpvUds4oFKkipyKYXJP3K
	ZADHCMd78nchUtnh1GyUGuNkhXg5iszHWB0wkZiXvVchJgdDdk2QHaOP3vIVAt8Q
	lemjav/aGvA0YqHFyNJ8hESTecbc5pNgQsYE922er+96Xa680s/kYj6e2u05h+Mw
	84ykzl0blxt4Yi7Yxec1eccW8noWhY1SsjghPHOwmmKYnGT0alZXtQOXN+5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782746468; x=1782832868; bh=F27EAZcuDdN2jazcr0PufEyIJHNewnTu9At
	n7+xPZY4=; b=Awtub9PYvchEdj7lEPfMnY7VNEcWoLpcLxGhsW6CSAIFmJQWQ24
	aY41GOT5LWVIluEx6HAP13K+J7aRSthLhW9Ml48skJAROEt6SaYo2I1tvAIJkmh8
	LKWIT+thPXRsXEIeyl1MXM0v/x44zMMlzcvkCymLk7JKNqJy0SnwPMHFQGEKnjxb
	3URVwTrvX9kxa6VVPqBhBjWQRBbpatjtu4q+GIKi1MCOLx9dEYKIZaBeVuhBBCkX
	VLazRDoQwq4kC14iJiYqRbfpBE/3RZDOF/D4smJw4i1dd0EGZ8Bmya5DpNcu+gBs
	k3iOv382QPZXc0uzLC0FMKTQ71frYnqMyhA==
X-ME-Sender: <xms:ZI1Cahc-Ln_ffxvAt2ZEJI2QPKRMv4I0CECJ4A1azf2H7VA7ClC6bQ>
    <xme:ZI1CamPa20QZwKQFVg5d9HsOSDbDTcQFxPRhTPf4F0RpKIR1EsDqxQbcxsRjlFUk-
    ZSb0bUwvyBQ9AmjhY03jUPHXt51IV3rIyZ062VgHSy9TV4akKJ2fg>
X-ME-Received: <xmr:ZI1Cavj7_nJaiZH9TbMyFadxon5BCHayb2FaXhiXHrfwE_K-9K3FwxRZM88g7L7glSFS_QWrqhSfGP_g4xENFf3O6IYxzcabh40y1oA>
X-ME-Proxy-Cause: dmFkZTEFRrlDBvveseuzCe2ebL9XVzR4UH55xLFF44AfB6gk0WydL0nqAWu5926wrI0wp5
    2rBCpcEYXCN3Co+0WCvL9agRVTiOdxk4aDFbYUpa9oOkwZy9QKrnQ3abyKsNGWzG2RT4CZ
    TGY5HRNrQtFZNRmcSz3PMLcT1OTt8rbqY/6FHaaoXVFPJKa19yI0PBgciwmTRs54gqTjV2
    sAHFHQDz1sSGKIxbIbXgk8wReZei/f0lmlUimBRHxeTujW3Ff+FIl3zikCYgoKZy9Iu4PT
    PBEVCjLgbRc1xRBaz9MA96FgJQ766MzgVwGuf6qOr5jcxMVE42MyL2AJ1Foyt5n2Zjfot+
    c9KKPv9rVN0XJk+zlalrDWw94gwcmd38Ks6zEkA0+NwsqlNqL8ZdqRUBPzrSpM6gxagcvv
    B+N0lHZVRKOVb66Jxl5U7vgtW4z5Mz4AJcZP/kgoWs1zXJyyIfEXhroQVp8QjBkoyXvlLE
    TLeJu9gzaRZF5YBwkx+LTD3U9g0zG3dNeEtAO/jWVmS98unc0fYxs+if9aaENHNocVHD/O
    Onfqi89lNaam91FBnfLAPWRs8Mw4Vus2/5iiyEDPZQKD9jgMrwmRaKTR7BST3MW9eWRQPr
    ARqytwnCLnqgAre4+0LyC2PQGvKlE4Px0w0EPb4cRD4B5K3IUix4I8Cliq3w
X-ME-Proxy: <xmx:ZI1Cap0msj6FxaOMrzCxehn_NBB61kSgVJJUG06IeZbefNDB9prvXg>
    <xmx:ZI1Capi0iCzG7vU7hEzEF7Dr1027FvkXm3jvDapr-3VnkO0I0Oz2eA>
    <xmx:ZI1CapfCK2OLL-0Mt_AbtoRCKcrI8G5W6OBbBp4ay_48A47P6NdXJA>
    <xmx:ZI1CasmXlGfZAtDY0v3AQHe0HEzwXoqFgHD72EwtFJvLQfh6ZGdBcg>
    <xmx:ZI1CatdBjGZMlhLkfbAkp2AAVTTbfo-6ntmIZrXe2cJm_xwfvnPdQBry>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 11:21:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] history: streamline message preparation and plug file
 stream leak
In-Reply-To: <akIRrmD4Tqp-Gi9d@pks.im> (Patrick Steinhardt's message of "Mon,
	29 Jun 2026 08:33:18 +0200")
References: <xmqqecht8df1.fsf@gitster.g> <akIRrmD4Tqp-Gi9d@pks.im>
Date: Mon, 29 Jun 2026 08:21:06 -0700
Message-ID: <xmqq33y5z82l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> +	strbuf_addstr(out, default_message);
>> +	strbuf_addch(out, '\n');
>> +	strbuf_commented_addf(out, comment_line_str, hint, action, comment_line_str);
>> +	fwrite(out->buf, 1, out->len, s.fp);
>>  
>>  	wt_status_collect_changes_trees(&s, old_tree, new_tree);
>>  	wt_status_print(&s);
>>  	wt_status_collect_free_buffers(&s);
>>  	string_list_clear_func(&s.change, change_data_free);
>> +	fclose(s.fp);
>
> This is fixing the leaked file descriptor.
>
> One thing I wonder though is that we don't perform any error checking on
> the file in the new version. Previously, we would have died in case
> `write_file_buf()` failed. But now we just `fwrite()` without error
> checking. I don't think that "wt-status.c" does error checking either,
> so we might end up with a partially-written file without us noticing.

Yes, the fwrite() should be protected with an error checking and
die() the same way as the code before.  Will send a v2.

But isn't the end result the same between preimage and postimage?
If the stuff appended by wt_status_* are still written without error
checking, we would leave a partially-written file that has the
default_messages and the commented hint/action but not necessarily
whatever we wanted to add with wt_status().
