Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100E033859C
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 03:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780976524; cv=none; b=TToTLrJRBYbFRlf8vfBNoMFcx4sZ1VvoKyUuhDoiMRCkQQBv8dZRM+rbbsACk3ri0Ktz0HGrJywLhY+NxEPkDRvQYUAfs1mi83NVFniPDZrzsPo0OINfXt59vn/XJxU0eTJ1qTClYCvVnIAgveH1/wJva2+GElXGv8DttdxG6a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780976524; c=relaxed/simple;
	bh=UXw0MZFDiKLnSt8SqW+xZ9GJmU1VeNBAHyZX6AcfJWc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tZbqN3gytV5glTKKzJTOQesU1wnncpzpU0QxV23dqjZEWgyWFcROa/A02YHiROSE7TCoeF0L53pY4r7WWHLwwGNQ8paVapM5Z4HCGzeJWf0jzph8Gmt+kj1fCM2dRVgfjaljQOC0udQnF2Qnrenpasm/iRbrwJBJpWV1ZBqBrMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Lrqq2OQk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gH7bAKKD; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Lrqq2OQk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gH7bAKKD"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id B9E081D00107;
	Mon,  8 Jun 2026 23:42:01 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 08 Jun 2026 23:42:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780976521; x=1781062921; bh=jtQVAMvvFN
	mCaqxVD5itnQAqQc0P8ac3ziws+S1Al28=; b=Lrqq2OQk3xetI+8GiZ2IODLuPf
	3MkYE03biKKSGWM96VYxqZWrhOJrLvdf+ty0xBzuqv/Xh0E5+R7u4asYnSrMRLJW
	sELwdeX841YPJ2DLmZui5P0Ehrc7AqIWoCzlrll5enqXI2IVZGi1Mk/NITUBMQDA
	1sVrnBUqwsTCSJSRhUx+nKsicks5jK38DzDF8v9CfNnAfekVmvT4qUiUmYdlVIOv
	aE3oDmzvSBGNyzjQxLBR8RG/dR2k/BIX1aZ7usBDzXdaL33gWPNhI+OHJ/QZVIXJ
	rvqs5BUjeCO5zRxzOtD47+H0JIoOTBV8F8nj3i858d+GkSHHqJdA43ph6qgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780976521; x=1781062921; bh=jtQVAMvvFNmCaqxVD5itnQAqQc0P8ac3ziw
	s+S1Al28=; b=gH7bAKKDM0YuBIuEgs9bj6dqh312AASI8ruj36euyTfgNQxaQ7k
	b/mBoJ3g1yGM+OpeOoMfGxNOHhAmZwRyQAEyNSoL/zSOw8LFG9+W6sxzcicLXEJr
	DHFfa86bcgsZL1cdQnNxdj/7lIfanYxr4Kd5A8h8bsyYhYz92F9aQ7LwPgQdw6xd
	++Fo9zoZvni5hGQdcrvwuaDkdTQhduSHG9MZK5u53QIczLwIl2rOir79BD5/kL97
	pDIs8ZxyO4arj0+n+6tglYxUadQY+lfuUpj72Q4/YOwuTwYjQGFY4WZRtimCt7fT
	wQymfZnv9qW5mXJp5UTKqi9W8whsLzwzvQw==
X-ME-Sender: <xms:iYsnauj84bhTul1l8p87wlVh0hfLD965nYoGEJhRLssmXtlut_Ok6w>
    <xme:iYsnaitgwg6P0mTI1BQKLpDk1H7YZ1NyKFJgX1RatvkjTpPfYnCxchfuvcMtsb92a
    lySmX7UQICuQp3YbamjolBRMYCEf9eTXbwmN2BSwHx_Aoq17VdhwA>
X-ME-Received: <xmr:iYsnav7ukCVgT0r3jM8nUE601mbJJaoCAxl3683kuJ2NRpqCBPBPmdg_5rcsKsHaPCO04u-bIZ5DLZ_pPTc_4ZbcwqPuv0hgwU83>
X-ME-Proxy-Cause: dmFkZTECfs6yoN2/boOb1AMcjv593nlHKVm7EtpaP7jMrY7HvioHyccIMmMDqURF9aT4y8
    geFkv11qQNS9RUCWK5OkXspj3lCj2um2fE1T0584Oyi4oHj7dg7zlhLKtAbB+zKYgWikfh
    Xk21blckZzNSERumcRn5w/m4eaFFMS4dAqKWEw3v3vc6s/SKY4+2WGszG07yl1HAQ7vmi1
    Pe11lFwyKK+GfK8Mo7qFh3t+viaY5y8/4JLfPkLyYvN6mZK65dMY/gwKVpN3tOyhVMLafg
    teMtXsajBtocJhj+jKNqi1vPAmbtpohlRM3geThw+DB8LYaR0OIGpLeemlIOTpAAMGhuKF
    NCm0d0ntAZNJdu9zg1C6YFKKlmOZGMGeJnaIC81CRPgrk4F++FHkcSFDxRUOu8mmDZgGRw
    KI0EviHNVttO+BsZxCZhCECiZw37VrdlH7nwUHmuCuULVWva6MeB7otS0kAqGznxy5qJnt
    V7NZm1JxqK6R3vy7f93ZvrxTJJX9RxkwGBVtlrp3L6o9XJehTy0CiikAG1kC8JPvnTqd8S
    E/Zmdd6DiDAJBVhIoBM0WwBYCl+fB2QHvueQnG4xo9q0rGb4f1WhKH5qMo6iG/p1+2l/wB
    gZXXfeXZYJHZPDlAE54PJbhaScO1m0N5G9gzgdOtqDx1S0C5b5yC+F4OQWvg
X-ME-Proxy: <xmx:iYsnauNlg6-nCyAzMOmuu3aawCNzvEDVmGrZgeHHVXglNSb1qnknZQ>
    <xmx:iYsnatsiNvYIPTk137OMbPV_73oj3K0OAAnjmA2PJ0i3ZSQ7ya_UjQ>
    <xmx:iYsnaha4cRPqhe-r-KK7_BD63nV5VUPfhx94xUDsva-wn--l7xB1MQ>
    <xmx:iYsnavybH0n1RaOEMRGCcU3U09XZ5BbkJ6NMj0Slbd46WPPXaJ7d5w>
    <xmx:iYsnahcBK33KI0-QohMkaQkoBsu7FvNGSLdPq0JRaGPT-NB3KbG18SJI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 23:42:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
  Patrick Steinhardt
 <ps@pks.im>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] ls-files: filter pathspec before lstat
In-Reply-To: <xmqqv7bstmw8.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	08 Jun 2026 20:26:15 -0700")
References: <20260608-ls-files-pathspec-lstat-v2-1-fb734b28422e@gmail.com>
	<xmqqv7bstmw8.fsf@gitster.g>
Date: Mon, 08 Jun 2026 20:42:00 -0700
Message-ID: <xmqqecigtm5z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Please make sure that your v2 is a response to v1; otherwise loses
> sight of the previous iteration.
>
>> Changes in v2:
>> - Restrict early matching to one pathspec, avoiding the regression Jeff
>>   demonstrated with many pathspecs.
>> - Add all-matching and many-pathspec performance results.
>> - Drop the Assisted-by trailer.
>> - Link to v1: https://patch.msgid.link/20260607-ls-files-pathspec-lstat-v1-1-8cf40b730146@gmail.com
>
> And it is *not* a replacement to force human to follow such a link.
>
> Instead, please make sure each piece of your e-mail identifies where
> it fits in the discussion thread by pointing the message of the
> previous round with its In-Reply-To: header.

I won't complain about them individually, but it seems that all the
other v2 in different topics from you share the same problem.

Documentation/SubmittingPatches expect that the messages on the same
topic are threaded with In-Reply-To: headers; e-mail based workflow
tools like "b4" offer a useful feature that lets the user to feed
the message ID of an earlier round and fetch the messages in the
latest round.  As the message IDs of an earlier round that have
become commits for v1 are known in the refs/notes/amlog notes
(published at the usual places), replacing a topic with its newer
iteration becomes:

 (0) check out the previous round.

 (1) learn the message ID of the previous round we have checked out
     using notes/amlog (e.g., "git show -s --notes=amlog HEAD"),

 (2) detach the HEAD at the base of the previous round (roughly "git
     checkout master...HEAD", but not always),

 (3) ask "b4 am" to fetch the latest round of the thread the message
     we found in step (1) belongs to, and apply these new patches,

 (4) run "git range-diff @{-1}...HEAD".

which is very much automatable.

Unless an author breaks the thread, that is.
