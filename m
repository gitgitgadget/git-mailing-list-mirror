Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA4D4F55C3
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 15:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788536533; cv=none; b=BDz8KLgULOnprWF8O0uGXJmfMA1vCTpc7o1kfbnLrPCh3aNtHG6bTIiuHPa/KHaKaWvJyQMEX4yntqfkmQimFPdHR5AaNJdRsKy8+SjN3IRuvIgIV5Z0DIOHUuXMIEhnYHovadtkUQtRRlbZ1sKPumcaaiM/qwChPwFns7xZ7jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788536533; c=relaxed/simple;
	bh=R9jLqtmZuIDhK2/SDpplVkpkDUtqXcTx9mLm/goG5wY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nz2zJSOaqIz5lTd3wwgUAkTv8Mh3sq01NAOF0+QbAm4S00bNl7GzshNkF9W1uN6DOsLzVfhg4zbo6v5j3jIauFxAl9GysjLpH5fZ9SoBOl/smh3OvEtkLuztvYtMEbJ/n2nyRyCE/XukahMFpreikzq8OV5EmRRpbjFSwb8B+vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sM0VslQr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BjZlWO2F; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sM0VslQr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BjZlWO2F"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DBE351400129;
	Fri,  4 Sep 2026 11:42:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 04 Sep 2026 11:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788536529; x=1788622929; bh=nKdQTgPcBZ
	g84mktXhDVhur/8yDJNrdm16PvplTWnXo=; b=sM0VslQrCfgQ1Upa6WDByMRpgf
	bpqo6koJKvZQ0porhnA3iPAz4furx1xD/mofcswluuq5yC18oFI94ycjZtJ4sPAz
	GwDiMMqQZ/leeYN2y+WAJ97tQ073qRNqmN8wwR0IFQNiPiSRP9SZoAIfyP6kE0Sl
	hj0gXMHqyU/uyUYKX/JLlmuvXKQ/1ioY6YOdknLwOZGD3x1Lj63XjrmOdOG7L8gl
	WWmNabGNBICA4108u7+LBBbpupoZJ5c19+z4nEeaODZD2C7NCRILn74XBlJw/5D6
	j+A2jqcR0ndNyjJhi8h6Ldz1WtbjUFXAfBzkM0m6AlpwhWNfWyKJGqjFV0Kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788536529; x=1788622929; bh=nKdQTgPcBZg84mktXhDVhur/8yDJNrdm16P
	vplTWnXo=; b=BjZlWO2F0NaKHQz8expkKbALnL9dHFZYAE+aRaZoxpBGi5KokSh
	Tbdp7lotS1o5ECXznmt09yzip/sC++h+U3ao2R//wRWPrZdUtsxoXDiF0u7teGft
	7E2YGHuuw3asT0h8UOLhOv5zMqqweJv/z3fb6gWhCK1wRR3d86FEWjVNooQlHIot
	9tHudEBwcwFEV5XcffoQyqFb53X8qwm1mCgHQoiNCEjEjr0KI0D0kIi1jtnVrlSI
	gZgqCUGlRyvai2VEfasXWduxlGNaIuc/Xzs3NiW8QiwZvdN5MeNidiS1daqn3c+/
	bdN7uCFuTENdImfrkqTf2Z13Fu5cW/IiCfg==
X-ME-Sender: <xms:0eaaasSEIcK3P0lIJlY4JxDgLlvODXTfCmmvmEr-f53eeN4Thopxfw>
    <xme:0eaaahOXD9SJ9hLUtUQfXY6wN17dFqYIfOIsHxwn1rXe_0XOKYrdc7Ns5V7aPCFuq
    AUtZuX-khoTXPym-M1J4120MGOfNSoMI9kGjX_yztGhbHbYAqJ-ZA0>
X-ME-Received: <xmr:0eaaanNtYEA24iA9EQcKKdIBXp1mNoQ9QrnfUqbUAdX2PQ22oKt8mZ_sNOsj7e5k6hhgCoh3o5T3za8DhJYYHzTRUl2PFo6xZA>
X-ME-Proxy-Cause: dmFkZTGynyakDcUfz1fNhyPw+3KkjlXyS8xOHVcHWdu8zzhySOJK7DsV/htNunWAmwUts+
    ezj8M+6/q2oaGcGLcWEF5LO7ix/xVTLe4SeNpcEqzyyOsfMUFWCiNPOhiGL6dJg47/C81q
    jScHMgdDbw8WQfgxGRUhA2+MegLUPb5KU96yy4HNhPUPJ3mzpskLJCJFLJCzzSZiulrNE+
    x40k7KFFwg1jiHMxhgUOPFU5aoziJad7XaF85XH4TqTRgSL5iXSwh+eHy+khObGFs6ED3U
    wes/8tL6673VRaz1VIhChxGG2w6RlUheqVxVJ8Fxp7GNYdABBPXoxLnkhVKZMTZSBHqLJr
    BN2meJe/ls2mqigdRHUdROtzL1laddnO0Ec7vM275K8fmlsSfsoyENVltIZtFqt/pt3TNn
    k+oFasdBBXnfhcE1ZrbvsxSWPDYQCn2KPJ0+iNquXWIOQn+FZS6BZADrieyHEx/7iSfgx9
    Xv3KTnlWi1ZjFTF5W4SxyiqRXt5PjBziIfEtMyNV0TtpO4GsGTGDKvwbGe1h+8BVFzFhbQ
    A+fuLdGqG29iKMRCN7Wu6b1dKERWkYrjdemtiZ08ST9o3/OIkG5uPPOKTzpeUJeeZJFozS
    ARnJ2IbK8+6xuQ/gZvJI/G5AlI7lnXvlVw4pV3cxB/ZBNbpEPS92gmMf/7GQ
X-ME-Proxy: <xmx:0eaaaptvMpS5Zm6kgiY9OTvHHlkql-aLNiIWTwxEKRfjetQNYhzckw>
    <xmx:0eaaapVCBCFYiw6n9IHe2FuVG4524OpnC53FOBls_egdOqjkmsZYrQ>
    <xmx:0eaaapu4j4RrbQWHUWkcFZhzYuVXZZg9aojIzuUZN3IIbWOV38t1sQ>
    <xmx:0eaaatXlw5drlW1yzKVz3FiC1JqdEXRZLSsCXZvxIM0uFksIJuS-Zw>
    <xmx:0eaaahO3BjQebaASZrvb4kqeduQvTqyHdkYm-EnFSqLFCAOEdng9BXUh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 11:42:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aleksei Sviridkin <f@lex.la>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] push: fix --force-if-includes when remote-tracking
 ref has no reflog
In-Reply-To: <20260904124433.12840-1-f@lex.la> (Aleksei Sviridkin's message of
	"Fri, 4 Sep 2026 15:44:33 +0300")
References: <20260903010547.85469-1-f@lex.la>
	<20260904124433.12840-1-f@lex.la>
Date: Fri, 04 Sep 2026 08:42:07 -0700
Message-ID: <xmqqzexx58hc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aleksei Sviridkin <f@lex.la> writes:

>  static int is_reachable_in_reflog(const char *local, const struct ref *remote)
>  {
> -	timestamp_t date;
> +	timestamp_t date = 0;
>  	struct commit *commit;
>  	struct commit **chunk;
>  	struct check_and_collect_until_cb_data cb;

This gives a known value to the "date" variable, solving the issue
of using an uninitialized variable.  But how do we know if "0" a
reasonable fall-back value?  Why is it better than "now" or perhaps
"2 weeks ago"?

We pretend that the latest entry of the remote-tracking ref was from
year 1970.  And then that timestamp is used as a cut-off time for
check_and_collect_until().  What's the ramification of that?

> Since 99a1f9ae10 (push: add reflog check for "--force-if-includes",
> 2020-10-03), is_reachable_in_reflog() stops walking the reflog of the
> local branch at entries older than the newest reflog entry of the
> remote-tracking ref. That timestamp is read by a callback of
> refs_for_each_reflog_ent_reverse() into a variable that is never
> initialized, so when the remote-tracking ref has no reflog the walk
> is cut off at whatever happens to be on the stack.

This is almost good as-is.  I'd end the above with "... has no reflog,
the variable that holds the timestamp stays uninitialized".

> With the files backend a remote-tracking ref created by "git clone"
> has no reflog and does not get one until it moves. On my machine the
> leftover value exceeds any real timestamp: the walk stops at the very
> first entry, never reaches the "Created from" entry that "checkout
> --track" wrote, and the push is rejected with "remote ref updated
> since checkout" although nothing on the remote has changed.

That describes what happens (eh, rather, what does not happen) when
that uninitialized timestamp is more recent than the current time.

It does not explain why it is sensible to set it to year 1970, which
would force everything to be inspected.
