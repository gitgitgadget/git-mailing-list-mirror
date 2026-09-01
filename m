Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B10347CA7D
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 16:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788279827; cv=none; b=YM/PstTqkNLLrp+jWalxhoOLlDQgyTr3hnm+9fJ6qirkW1YVEojIx/RZBbcRtSbe15pyIiSCV+0xBVbOKVv7bTRVTX4QEXHpTAbHVFWXtOewbKyZKORo+SwFfX2saiOsXVGJcepJaPp4bUN7W0G1TeFYgCxtoxnBUWYcEJykMdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788279827; c=relaxed/simple;
	bh=Jw6ANTDK/WN06ktDInCY75kqC6NADAP7Zn0MBNGLpxo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TwSgAZTXqN0RkFreYphN7iVgAqkwsLwtR8omLytzMVRC9hnhnu4Irtu8A0b6mcrbBf+OPJax9aLhNJIrOM/fbDPFLJ0c+ubmm83QoJTieYe1Ot1OzsVe6s4lAYQ6IrBRCX2QpfcXoVjrN59AQ+YVTxrBavluvSsUziPVkv+ULUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oPOvYmxi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LlTrGJip; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oPOvYmxi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LlTrGJip"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 43FB31D000C7;
	Tue,  1 Sep 2026 12:23:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 01 Sep 2026 12:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1788279825; x=1788366225; bh=WsL6Gk7ypc
	4lf2RT3IsnDfJzPd8PjbcCM+7b75UnI20=; b=oPOvYmxibVEhcelWWxej/kKJfi
	Q5jaOb4mdPC4L+roKzxSU9Zmh12h7/g6TSzbwDA0jxFmet2Npij5bxfpZ6enHYl6
	UQdcGPSLfKGGb6lhLRtK7cC02L/IQCDztR54L2D5asqk+Vt9IBM/hOrpIWXZuRjI
	z842FVoZIwngwi1b2Y/6AjIXgYvknI4THTk+DpxY/gY7cPWlxIOQTIm7ZshZ6RzT
	q29LQhCAVxF2Hivlajy3Th4ezizOjrJx2BpfSxN/jaiEigyG51N+sikxWsWTpSNs
	lHS8h5/0sVCIOr686sdfIBqIWg+Ko4fWaJRCeBt+ban8jmbMSLQ5DRo8ZGOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788279825; x=1788366225; bh=WsL6Gk7ypc4lf2RT3IsnDfJzPd8PjbcCM+7
	b75UnI20=; b=LlTrGJipBgiImgrtbLb6Lop/c/Kj4Z4KLt0v8JLxg8MTXrSSAPH
	v1nDVVSYtIWZA1R6IaByqIffaZjHfE7AwgDFqvm9jE4iOjNvgby7adSrpmoAvCt/
	1nfvkh06z0VMYgVBTmw/SfURZ5rsIbYFYayNuxSoc4Aec8QA8nG1ll4aT/y4pUgZ
	OK1DKSRO1GOWvjuBH5B5lwfbit8FLM6iRgdcnQOwjSvdSCN1vuowVPL34lYT5SWF
	NSnvbzc7lPCUtnwFzWFPo+tmJo05NixrAvpsgqBsGVWspEy+JherPEn/BCLztZmS
	6kQ8hxQJoEgA/jnIwRi30zAPDKHINeZKvow==
X-ME-Sender: <xms:EPyWai7wE4rBDURJ6ThM4A4vTjva8XaaJEL7wcNYcaSSsmcp_x1nTw>
    <xme:EPyWaskFXpHip_vnIth5bkhbCjM8UtHkFrmS7y3qqjyZqV0hQURB-qnwx5edw_c-N
    Z7rGefcOBACTWucw855BiBLxMJ_b0bY4RETjbNKRlLOOWlSZzlJXeg>
X-ME-Received: <xmr:EPyWavrgO0n7jPHFwn_g-Inm6MYoUQGrV1XBw4D9XJpHNsAByh5v32D64pbMVrU99wya2hBSk0yUpkJZQc-vG8YkXD6ybCtrPw>
X-ME-Proxy-Cause: dmFkZTGpzl5mwH2hhwFutx8kQUR2cvFKexX+dIgP0A+paLrynqy8QnfPqMRo6SvWDyRPn/
    YhFELhSBfNp4mAT8KbZCsC7yjR0PUcJqQZvUVs6cBQYq2YCwovxkg2ZHdkMay4TS80QsyT
    /qM0ZMjAxloFMGaAUVjVfueQivwPDOus4Gc2Ae5W/IZ31Ns69rmLMTbz2zDnBPf87enYFQ
    gC9ehzvk3a8JUw0BTj5r6u7K53Zc/ZB0IqfXSzlOUSh7tkz2WBuSYiLRZPqUra28CC4SRC
    +/DwUfTvvtWxS+bb0EsTcHjqfHhITiUbdHG8SiKPzej/dnOl0wXhFqJe8a9LAq1kGWGVRW
    s1iyu+vxeKwcrrQQgw2PkIkl10tc/w5u+F6zZXKaxhLL9XlqR8r/2MFij0q7rBJQdR68/x
    f5aokcnuxDLKW9DG0RDQIR+ENHZsfptODMdasZfoz29bHCAN0OoLKISYdM3pTie/SK5V9m
    jPIQnlPrM3Tr+a8EZjeNysCbTh5s64A1uTvUpsAm+pjkQy6xCNZ5sd03EeycIakv3RZ4gv
    COuStpdJXAGGq59mjY4sLaEuKkVxhSpA42oy2fGtTo48+W2jt8u6pQOTd8S3fclN/iSwmA
    jBJBKRBG2xUHctOLKm2JkvgYE5hUx7YH3lE+f0who06RgV+E9vBoOAC3aLog
X-ME-Proxy: <xmx:EPyWajvGZH90FxcwEnuWSHX7xh1CDLA1DYOyIHSxhgaJQBEKALYFfQ>
    <xmx:EPyWasHEPyQMgPITv-TbrQOFpiXM3HuuCaliz1HDlMBhPcUyqQUlAA>
    <xmx:EPyWakYnQQj8Tm4iUO2FPs9KNUalWgTjsArweOWR9-SDlpoxYnnt9Q>
    <xmx:EPyWasVaG4lk66bDza714Azbo-8uFXOR5cMcnFa7o3RoHhR53YAQ2g>
    <xmx:EfyWag3GE-iONz1gcgnVu84PQ7z8JYG2XHDtIOLyeThYhdFSnPOeiV_1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Sep 2026 12:23:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  jltobler@gmail.com,
  kristofferhaugsbakk@fastmail.com,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v5 2/3] receive-pack: move message generation to
 separate function
In-Reply-To: <20260901-758-introduce-hook-v5-2-35cdc6be3cc1@gmail.com>
	(Karthik Nayak's message of "Tue, 01 Sep 2026 17:19:24 +0200")
References: <20260901-758-introduce-hook-v5-0-35cdc6be3cc1@gmail.com>
	<20260901-758-introduce-hook-v5-2-35cdc6be3cc1@gmail.com>
Date: Tue, 01 Sep 2026 09:23:42 -0700
Message-ID: <xmqqbjahszxt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> After git-receive-pack(1) has committed the reference updates, we call
> either `report()` or `report_v2()` to report to the client which of the
> references we have updated successfully and which updates have failed.
> The only difference between those two functions is that the latter also
> knows to provide a more detailed report about how exactly a given
> reference was updated.

I am torn between praising "bool detailed_report" and frowning on
it.  As the above describes, the difference in behaviour between
report() and report_v2() is if they emit details of per-command
update status, so in that sense, the word "detail" in the name of
the parameter that controls how much details the shared helper
function gives sounds very much appropriate.  On the other hand, the
difference in purpose in these two functions is which version of the
receive-pack protocol they speak, and "This parameter controls how
much detail the report contains" may tempt careless developers into
adding random new pieces of information and break existing clients.
It may be more honest to give it a name that hints that it is about
the protocol version.

Using

    enum report_version {
	receive_pack_report_v0,
	receive_pack_report_v2,
    };

might allow future extension, but it may be overkill.  I dunno.
