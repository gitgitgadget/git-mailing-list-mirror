Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C34332637
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 20:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787086447; cv=none; b=HdM75WY57e5OswmqV/DHyNg76wiYU76hwDuwqf5DQFqjl35zJNbFGo+L7AQx5W2kZLHM2VFNQ+9Lg4UUl4QCPFso03AQC6z2TbI10ekAz4BgvP1bip461Go6dpfkUGwMIZwdLk3VMeX6jtS5HL4JIx/8OeYseeJ/5dxILfo4ueI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787086447; c=relaxed/simple;
	bh=AlyETnW0z9FCw7MwFK8SgPnEvtFQgYxhESoIEVoWmJ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=juOM00LrH/rDkwxQtTsVzBWXnyqG8fwnSteSntJa2CYuYwSkKNd1+/F8l4/rxDjptWh4tGIF69emMaDWREPufccOOtru43ShT/7WXZBaPR0uSApB7FHa2NMOjQzOpI3tPIpf5uJirttapPb8EP0Gwetyd2Fbh3DjBMBEfG5bEmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lGFPTmiE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LR6jc/Xo; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lGFPTmiE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LR6jc/Xo"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 531871400094;
	Tue, 18 Aug 2026 16:54:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Tue, 18 Aug 2026 16:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787086444; x=1787172844; bh=nbpht/YMk2
	jjm6LJ7eHd3IF2R0wkQcXOLiPi8Tw9iQ0=; b=lGFPTmiEJ9y7wX8k16valAw9V+
	EmmIxBTyfY8jkytyocmGvUl5nwQaVBKV87ij/ACcksdgU4igocDvtJzQwdRg9gJP
	TBZYyEbdPTIV+7zqFzHhKrD3fVyNU6bB/naNaejoy3LaVfbUKJHhFOhzTmLU7L9W
	EOvb0JMjg3AT0ZhalOuIYbEHA5XTtmanyViXAesMhG+Ee9dd5ALRIfoBzR11bxu+
	n52m/W/sy4TysA3/GhSDASyEOWiZM3gNtQdOvYagk1Zp+GquieNukE0v3iiITBLU
	U9q0pFhZo0P+ZxXVjtrPIXMOgXtMDKq5favuB4Og943ywabLIPE5PQmgi27w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787086444; x=1787172844; bh=nbpht/YMk2jjm6LJ7eHd3IF2R0wkQcXOLiP
	i8Tw9iQ0=; b=LR6jc/XoMGMqoXESrP5EBgdphw8/icLYJ/XX/LA7rgc/BdcsyvV
	QTtKMZvZq2F6z0HPSqcuAJaG1QIsc0kzQz26JtM5oRSSwUQUKJPHwJsbPBcmZ7Ky
	Rk9Lpcvo8pmhmNCyUtxIPYD+yQdX8ndnDatXFza+mK5ioZe6a+yh88tURX4cnBrP
	IRq+6bcZH/d6umfOPHnPLSEv1tp7NcFoydnjlabbEiVxpo6qV3aeoOTsfb9cUbol
	9OsooUHEiYiCbTjPqlFDfRLqjXE/KH0trAlEzAD4LDAfNmtn3CZbqAsizPKb+nLv
	7no2BcJQ4R+zou3xZCkLfVkzm0m07i1nqNg==
X-ME-Sender: <xms:bMaEajUur-PZrkRJRVuMoqlRdD257lDZ2Ohfw5ODQPCB92m_EiP59w>
    <xme:bMaEajBCyJVuuagNNtBKJMRZ2ppfAPPrt4gmi0II-pTzwricVHs2jExh1x2mfMUAF
    NHPBf_rVET0Bg7wcWfGnmwSiyQMzuER1-W00vA37J8FrPmel-4GOfs>
X-ME-Received: <xmr:bMaEasxWeYp4GzGd5gPSNPnM-DR-F9Xh8-pAzTddcQNnZR-qZOdbEbo1zitHUSBQGLd6QyQOPNrAj_PzxTdhJfwl4wD5w52NVA>
X-ME-Proxy-Cause: dmFkZTEs5WK5SG7gFP5YBtOB8YXpG1/1j/hIZXLagV/Ira0kX8r9G22cuDCSw+f90UrN50
    ZxMOtvh61vL2i9WZPWtJrmEHZWvDbSBRa2KSqH1iMK/Kmi2uWxaxCwLGX7dso8//bChK5p
    GJxIFrALPrN02Cy3NFQMIL0iRcfvWhbTWRbBFPGoKk275+5VWhTsermPip3Pw8F6gkalTJ
    vCyhe50I9FCflW3FLxun7JKlwzCWEkm3J03q0TGR5pv+Wy2eBY3giiewNtPKKNOZHazOK4
    LW7h7RZhkvZBYILzEdRMFBR3TR27ItrmKn78ZwKUVFS2HQlieHBRT5p3avPEg996oVwlII
    xkukAHTojYkhl8nvjaHvk8iMesQiJN1bpMVIaxSpzv9vhIwIuQGix4OWGkocwvewXgNcTB
    /Nf/Jd+FIiZak/lrhWmg1hmwyi+yLimwz42XekAJsXkdHJDO5PkRKcPYlcBsPKpNSkBFcB
    5zrNl6n8aZgdxCegJDaqGx2ORuub/Aj4a7eUPIQZov0J01MZ2+uOmKDkiOIWfAXjrJanH6
    +kMUEQQsFPomJR5Z6e1l1cqf5rEonCu0nPEJeBQQ230wZYf6YSOL8xcIGoCaWT5zZvZL0/
    HmnG8BiLoiMDm+xGHuhxBCW7uws5N3SZIRw/lp0o02aafA+R5Q2Yx1FRwz9w
X-ME-Proxy: <xmx:bMaEaoDAf87G4TdRcpQDPBpaO8DHOcPpkQNDxK4JRcicCdJpt-XB2w>
    <xmx:bMaEahZyuZNG3X5srrX0FD6aqkwki5ZoJdFnx8zmqjmjwfw018U2JQ>
    <xmx:bMaEaojYTs1JKkoqhFSyhnlH8J4lqCPbp3-mm1Ht4eCX1qCrEF6ITw>
    <xmx:bMaEar5rTzwdZw2shGKfwBDVy7qMA543ux-IDyMro399Kq2vuc8zPg>
    <xmx:bMaEanCI3FvcbirOkVxOIO4KC02K-79PVbnkfjfS9WzT36xad1-71_Tt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Aug 2026 16:54:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] hook: introduce the report hook for git-receive-pack(1)
In-Reply-To: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
	(Karthik Nayak's message of "Tue, 18 Aug 2026 09:55:55 +0200")
References: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
Date: Tue, 18 Aug 2026 13:54:02 -0700
Message-ID: <xmqqcxvfw3o5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> When running 'git-receive-pack(1)', there is currently no way for the
> server to intercept and modify the status report before it is sent back
> to the client. This is useful for servers with custom logic that need
> to transform or gate the report based on the outcome of external logic
> post reference updates.

One sentence is missing.  The fact that there is no way for the
server to customize the report is not useful, but that is how the
above reads.  Drop "currently", as the introductory observation is
always about the status, explaining what is missing to make
readers realize why they may want the new feature introduced by the
change.

> Introduce a new 'report' hook which receives the pkt-line encoded
> status report on stdin and whose stdout replaces the report sent to the
> client. A non-zero exit status causes `receive-pack` to die and the
> client to treat the push as failed.

After getting asked to accept a push to three refs and receiving
the object transfer, the hook can say "I'll let these two refs be
updated, but refuse to update the other one" and return success by
exiting 0.  What does the other side of the connection see?  Two
successes with one rejection, I guess.  If the hook instead rewrites
the report to say "all three ref updates were rejected" and returns
success, then what does the other side see?  Failures on all three
refs, right?

What should happen when the hook says "all three ref updates were
accepted and they updated to point at objects X, Y, Z", but the hook
itself exits with a non-zero status?  How does the other side tell
if their push succeeded (as described in the returned report) or
failed (as receive-pack(1) noticed the hook's exit status was not
0)?

How is the failure due to the hook's exit status propagated back to
the other side of the connection?  Does receive-pack(1) hold on to
the report until the hook dies, and if it dies with status 0 give
that report back to 'git push'?  And if it dies with a non-zero
status, then what?  Ignore the report and send a failure report
generated on its own?

The observation made in the preceding paragraphs shows that allowing
the exit status of the hook to further affect the outcome is a bit
iffy as a design to define what a "failure" is, unless it is more
tightly described.  The hook can signal failure in its report
output without exiting with a non-zero status at all, and if
receive-pack(1) wants to allow the exit code of the hook to affect
the outcome, it cannot stream the report back to 'git push' as it
receives it from the hook.

> @@ -2547,6 +2582,9 @@ static void report(struct command *commands, const char *unpack_status)
>  	}
>  	packet_buf_flush(&buf);
>  
> +	if (run_report_hook(&buf))
> +		die("report hook failed");
> +
>  	if (use_sideband)
>  		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
>  	else
> @@ -2592,6 +2630,9 @@ static void report_v2(struct command *commands, const char *unpack_status)
>  	}
>  	packet_buf_flush(&buf);
>  
> +	if (run_report_hook(&buf))
> +		die("report hook failed");
> +
>  	if (use_sideband)
>  		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
>  	else

OK.  The other side does not even hear the report if the hook
aborts.  And lack of success report is what the other side
interprets as a failure.

Ugly, but may work OK.  Needs to be documented a bit more clearly,
though.

Thanks.
