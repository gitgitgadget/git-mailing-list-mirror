Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2914A30F531
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 09:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780911055; cv=none; b=Wz1wYcDgfJtBkOhdlyKQwmbtaAVdmkD/DeVOwOTh8nr0zMxNIyL/tUdybZ+I9hnxNwnfH9KeFvYQwfQKyCclrfkm1b7R8thcp6fgAb+cM0K/jL3wkxNuihbtBPxR1ykkJWQAjWf2V1usRdM1L9I3LOHtRIomgsDikk54wvpR4Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780911055; c=relaxed/simple;
	bh=rUDC/oswwf4WcJNhxBAuyYt8z/2WHSnNkipC4CsFF58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgdVkx2sgtiMfCriohoYkNDOs441WT4nh3xCvLMUHG4Ur7lkIUQxuYiUMIGVNh9/2Z/tsNtebGkDEkcyWdlr147c0RCvLGGlE1D/j98dZSw12Xw1NYMjRY5ac/sLVZKjKW0j671izmFCbcNEoviASaKc62ruOvlUs9s9kNDQ1Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EXDJRyR2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PJeU7jgv; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EXDJRyR2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PJeU7jgv"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 706277A0035;
	Mon,  8 Jun 2026 05:30:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 08 Jun 2026 05:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780911053; x=1780997453; bh=1pMAP46RlP
	S8G9DTtLkm8tBRunLtN7peRtA7UZonIy8=; b=EXDJRyR2qpKLMO5Mipyqgx9qv3
	9wmB8GvZ1SMOiFaTbNUyBfHho0rObNAsJdxIn5yJ+Kz7i2aG400aSNujhZBL67yD
	RrZ43jRVuRAkDOsVELmkrEu/MAikUV+bBvSiFs1++26EMwAn+hos7cRFrhLEGLYf
	Ui0FlPD5vtxXp2rz3XwMGEIs2QJwhtSqYSwiRH6YWgb6VdmhzfyDsjjqQEk+P/FQ
	osaWw+ytQCvSdfQUVlnO4MVhsn1+UNvSY00wYRsbSGNHGjfzZFx85YTk+KI6WJxz
	5OSDUFYdGLa9ilh2yLhFjbBqcxEBb/eJtcBvWjCaoDYSORIquKfzzlw5YpWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780911053; x=1780997453; bh=1pMAP46RlPS8G9DTtLkm8tBRunLtN7peRtA
	7UZonIy8=; b=PJeU7jgvKVgZ5F50EcSYWNpx/s759095HAgOwiwJE7vE6X1rTS+
	/C9nTeez0v/ItRyjvLDycF+TDy8bDDD1IFhK2ZmjZA4DppgSR+UbkT/bGwaDNSFA
	a2F3fvXpMzoODZz3HJAgM0xddUiKWEHfqkYozaZUZD4knJIDf6kA4LD5SpBVulhb
	/IN11ytK1CJOeosYXifLKTdfgGLo2cnf8picC/qqWLC4CqmKRL+bznbcLZayg6Yc
	HyYhwJB3+2uVS9DkmdwbFm7GUPcKDPbkRdBv3fBf5FueQPcG1iIHNi0b2UAKEsX7
	4WY1+YJy/G81AXWGCf5YR7bwV6+2+TJ7vyA==
X-ME-Sender: <xms:zYsmakbt8ikcxeUFOBENQO9vi54WOGvXn6iWENynXJoBy13cwpQFsA>
    <xme:zYsmam3i9T8FB6pvwjnMXTKkIWiOP0jJvuHMz8bWimo5e5ba5ETteSY-cevQJPbBx
    OBIAVKtSrnX1BhUXzB5GZaixGjs3utBpjV7vPmSZTfFP87Q7VIM>
X-ME-Received: <xmr:zYsmasVeGZx-0XDQo6_jzD6Z26BIBE6vSWJCzw0zgV5_kdc6N-jV9GTiTovC-bAAuDkpJtcKo6WUpE2UfYRH19iPi49ziilDrYdQoVURIw>
X-ME-Proxy-Cause: dmFkZTFl/Q/8B3xeE/n1oXTPSvqaqUmqdlHQSMkrd9LKRSOMyDOu/PUFZy58YJ0ukMxtYy
    3QKo3Zw6S0q5v01xO+2NHu5EHgYiCiL4Oltr4K2AGfsaoZA8OIGGrwzHcLGPAFPUcrlbLh
    5GfarSZTXvfoYRxDYyH1jMOZ8yi6AfH+LfJ8C/6oxgP+4MCP+m+W+r9z4KEi+muckkMquO
    Klk2+Nwc+Eu7jT7cVf1wn1Fc7OMMDKIXLqAVx6V/VEma2noF33mMsSoZIlUd6mvkLsWk0o
    uQNHpL+EP9Q9llokpm8oOQ8GTDq2njhx5xvw77JQFZp7n0euB2zCteuZVRYgXut1JGi6D4
    25niUBBeA4WtPP6JFKn6J2/ltWW5SHNODzXGvk2p4B5ihJUWEUMb+X7fZYFh0D0SFd/dpm
    rFT6g/h0sIxDip7Nf6oZUQL+nMY2qncJEVSTdqmaeOxFN/ejlcz0DwoLt5+TmJMWaOMylY
    U2m3Oq8bKz8wYUAms2HCfk6CnVQh5yu+yzWMle5Yi6/k9zck3gy1LUE9xap7NgkTG3Eb+W
    ZLxBJw59iolvldWxp80SlokXBv1M60HDL5tuxkTjvMZJdyO7iPqSODq6UH6ymSthhpl+Fa
    ywptD2qAHuA1OuIZq7HNWybqralgd9w9pmC7prDODynFDorLRXOzV9emE4Mw
X-ME-Proxy: <xmx:zYsmaoXbWF7-PJROaoYo6Nxzah26TFguqdwi9AVprxfPwbtSPRKxxA>
    <xmx:zYsmajdxDCC4qqXsa0s8oYcx4b3IB-moyG-bG5bnHELU1SCvP0kXnQ>
    <xmx:zYsmapUfSe5iQTOrZh9BFGdeL7Im6d4eusdir-9ExRi8ESC9zP9y2w>
    <xmx:zYsmakdasehVLwUZQuCV1kVoGz3XG1PnZUFYUrFeG3F6xGFJ3KK0kQ>
    <xmx:zYsmaoRZITZTMtMFZhgCmQk64gMNmXBYFcs2jmaBjZrWxIXi3L3R79KT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 05:30:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2f97669c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jun 2026 09:30:52 +0000 (UTC)
Date: Mon, 8 Jun 2026 11:30:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH RFC 2/2] builtin/history: print feedback after successful
 reword
Message-ID: <aiaLyQvo8kqfv4js@pks.im>
References: <20260607-ps-history-reword-v1-0-ba43a3cbb81b@gmail.com>
 <20260607-ps-history-reword-v1-2-ba43a3cbb81b@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607-ps-history-reword-v1-2-ba43a3cbb81b@gmail.com>

On Sun, Jun 07, 2026 at 10:07:21PM +0200, Pablo Sabater wrote:
> Unlike `git commit --amend` and `git rebase -i`, `git history reword`
> doesn't print anything, this makes it feel empty for a porcelain command
> and hard to tell if the command did anything without using other
> commands like `git log <commit>` to check if the reword was done.
> 
> Print a message on successful rewords so the user has feedback about it.

I dunno about this one. My take here is that a command should be silent
unless it has something to say, for example when it couldn't honor the
user's request [1].

> diff --git a/builtin/history.c b/builtin/history.c
> index 51a22a9a1c..0f1ba3b531 100644
> --- a/builtin/history.c
> +++ b/builtin/history.c
> @@ -739,6 +739,10 @@ static int cmd_history_reword(int argc,
>  		goto out;
>  	}
>  
> +	fprintf(stderr, _("Successfully reworded commit %s to %s\n"),
> +		repo_find_unique_abbrev(repo, &original->object.oid, DEFAULT_ABBREV),
> +		repo_find_unique_abbrev(repo, &rewritten->object.oid, DEFAULT_ABBREV));
> +

Seeing the implementation also raises a couple of questions:

  - Why do we mention the rewritten commit, only? Shouldn't we also
    print the changed HEAD?

  - Why don't we print any of the other rewritten branches?

  - What makes "git history reword" so special as compared to for
    example "git history fixup" or "git history split" so that it needs
    a message while the others don't?

It might make sense to maybe introduce a verbose mode where we do print
such information. But if so, we should have good answers to the above
questions and implement this in a way that makes sense for the other
subcommands, too, so that we can apply the same principle to all of
them.

Thanks!

Patrick

[1]: https://www.linfo.org/rule_of_silence.html
