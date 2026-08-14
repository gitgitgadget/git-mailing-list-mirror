Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A51741A574
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 11:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786707286; cv=none; b=C/T3PkiShLsSDbedNHqGg98oU9UcrqhdIL4pcb2433KUaxsa/UuBHIk7lb+XksBEElb+MTSHTyYf71B8W5f1H4PkxBq+4Bp5hOf6yCh44ykqiiihTiDDr08dNYtx3RpJQKtfBNshh0I0N4OiwdCrV1pD2NofF+DnRqoU+h78UoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786707286; c=relaxed/simple;
	bh=NG+e2SWja2oZJZPPBGkh2A0pVZ+oD4wKK+QMRldw5Gk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=a3fMG1a6gUEsmH8SMjYUXCb4/oTIBiqsGpywRTOYvUm1n4krUB4Rd/eu0erWglz61Hsf8c8h9P6rnmEgauyYA64n3CQO9eJ88NYqMzdHwDnroinVSK00fBlws0KXUndZ0rJbCbK+F13PknGo456v0xHJiUQzWUPFYujmM777j54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=b2cFrtOQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W9upTIX7; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="b2cFrtOQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W9upTIX7"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.stl.internal (Postfix) with ESMTP id 601311D00293;
	Fri, 14 Aug 2026 07:34:42 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Fri, 14 Aug 2026 07:34:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786707281;
	 x=1786793681; bh=NG+e2SWja2oZJZPPBGkh2A0pVZ+oD4wKK+QMRldw5Gk=; b=
	b2cFrtOQQxLx0hJTTotxEDOrI3UMl3CwcQnPPafeAKGRnx70zxlUxlzr0zz7gWil
	BTV1TPiMZ0BLAubC9Q7UB+8NJo6F7K3fCTHoHfoK6SZ6XGa6KOk764L63pPHBUbQ
	x6jVenr2G4OsU5WP3aSeYukOUPBhApm/WGtTuTU5JkQEhnCCgycLKjmFVJvdayUz
	++ACc8fixmGrEBWOHMbQQftXMfBik3+I6E4GAAcoswhovauMNYBQ1h14+ye+Q2y1
	xCILyUij+RKznNhWEmQML9jwgxIbmeD4KsGpGYthaI8yXIBbNl4j8WPyjkOd4QYS
	2ysMIIqepX54h84PNXSHfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786707281; x=
	1786793681; bh=NG+e2SWja2oZJZPPBGkh2A0pVZ+oD4wKK+QMRldw5Gk=; b=W
	9upTIX7Os9ieameHFBR+tuZ1zTJmPASub6ML3cKhD6s2nyg8xqwG4xN5KZuOv7oH
	D4awNpW1CehvoH6BMwUFaXV8rtzT3RjyiskUpIXXQHUMFTdZfaETbq2AvDMNZxuJ
	jZT0zkx/0sG0KRGMZWkHzfwr3QR6TXxtgmK24oKiXro0cEaK73TGRMOr2jOUeKyb
	MW+pzjb/pd6pWXdZP+dT/sYLDQG+sw3tOUv+LteGKq05UALJVRglJhXaj5/LMMOq
	3UiZLIlUodWZfL7ubGM1XJ+FXLIuSkEX+inbFm8T41b00A1h92mFO2nO3Qz6b+3g
	UNL+7WgQsujw98OYLXBlw==
X-ME-Sender: <xms:T_1-arSE4NxBCzjF9sV3-g92qmLCUNEM3uZ3EyjldU_mV6jt6tDy8Qs>
    <xme:T_1-ankMUQxEZYI2cUNVKC4Pymwp9lU17s_KgSph0OjjSeso8BAUer3QvoKhwlP4N
    YNvPslal28xpHKV6r8_p5ZFNqZ79-MK9K8tW0dsvkEWbxZbsJcd>
X-ME-Proxy-Cause: dmFkZTE7xo+O3Taf42oJ9h1kvM/OgYEnqirzzSsgeOHhkv/XYvhHBWrucgrvLfWquZoIW3
    kdU2wrGZDCUwWH6nCDfdlAMlzXq23lQl054VAzYmaWhYpzNV2mA91/2eVJ6m4bwb8g/0X5
    +nDyr9pkmPHYBmNLWQFB1AqvyPCMhrF3PZ3JBr413zGRWh5ZDifdUmB/CczxmnUlGYuOiV
    jE/XzBeK47qJzdp/dVFxGB82JJwj+u5zx8fSHEMfmyZRI5RnDI9Z3jwWLhWKHr2GTzkXEF
    bmTb9aQhxWHT7iSmlS3Nhdngdffc6APeA3BguVAVOJ7trraK/xXG3Chr8r4pcIsvbMi0Rt
    wJmQicbwlx0vs0Yu1vYmTexnWxrhYwkCYIbaJl6s+dQEw4IsRTx0QUPIpz7RyFVzw1x7i/
    hV8MmLpY20BMzCZzjKSpqfXfEE264iZEL8bmYzj1nR6/zEFJadLBQNb3bX0Jf4eSuDzXtM
    towspyfp7mU8z0j6fFWhmRv5S0/ozARpQ9YeLsfpvIIl6048gn3B1inldTZ0WaTe7yMZ/v
    5/rwB6F/qmIGBMfFRQarS0KzLu09IxwbP2jdXRKoaSsat8YKFQ8oVL5roHYfuFqkV0zVrX
    bYU5XAwk+XyHVqVeij8CJKPi8bKvdZj7lH77gH0XbXMT1bJekQPQsU/AcJNg
X-ME-Proxy: <xmx:T_1-at-A5XK2TE8X2AmuaJnNu3iCXJTaqLBqDr0wXLOkHJY5QDMHBg>
    <xmx:T_1-avqB7nSp0nGUjWF_4sD-rOVzeeTnZdPVpxGyHGGFajzx23v8lg>
    <xmx:T_1-ailxkppUz3TjvQxQHa5lnhQ8gMHXHbMgMg5VdPaqhIo0CRzyZg>
    <xmx:T_1-auLvaN_p554YWo2FqSXaL4fR4Fsa6AxB6U-CKiMi7lTCdVnOzA>
    <xmx:Uf1-agW-LBys_tk7JU3oWdpX1mry1Wq4xk2mxKBa4C5jR3NWsAQDaoSO>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id E662822C0079; Fri, 14 Aug 2026 07:34:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A4FwHZfX4lP-
Date: Fri, 14 Aug 2026 13:34:03 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Peter Morris" <mrpmorris@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <b00dbcb8-8f83-46b9-9271-bb789994b262@app.fastmail.com>
In-Reply-To: 
 <CAOqWQbLEakpQEPsfw-GB70fdwbxW8EcdZ8EWzaN6ZAaHUU+jGQ@mail.gmail.com>
References: 
 <CAOqWQbKn88m=OBDF7W8bBPjeOxtRsvNmhsqNy9AryMKrOKtLUA@mail.gmail.com>
 <7d0e9933-1a5f-4755-8bc5-fa4fea42f61c@app.fastmail.com>
 <CAOqWQbLEakpQEPsfw-GB70fdwbxW8EcdZ8EWzaN6ZAaHUU+jGQ@mail.gmail.com>
Subject: Re: [RFC] git worktree: use filesystem cloning where supported
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Aug 14, 2026, at 13:12, Peter Morris wrote:
> The PR says it only supports Linux and macOS.
>
> ReFS is available on Windows too.
>
> I believe that if the source and destination are on the same ReFS
> volume, the Windows CopyFile API will use block cloning automatically,
> so if CopyFile were used we would get this for free on Windows Dev
> Drives.
>
>
>> [snip]
>> https://lore.kernel.org/git/pull.2317.git.git.1780685368.gitgitgadget@gmail.com/

You must remember to Reply-All here. Thanks. :)
