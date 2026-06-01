Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C27935F609
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 06:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780296198; cv=none; b=Y8anWPYFXwZ/g4AN1Wahgbl5ltjNP5DRkMuX86RYxRMm33iEEaQ/Xun0ZpGfMz41Nw389peCaLE39KzerHeQEiCqOFjeIUQUqJHPuYExTYlrmkNn3VCiBttSyf5gqy8BjxH6Xioe4YuEwegtRTwsWixJbCUnoj7gP6okamKr3kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780296198; c=relaxed/simple;
	bh=CzVDCbG5dmf/d7U5W4oo5ys7fByxKh8gxzAP8rj5Sg0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IuAcDtYe+yfSjmryX0mo+xL9NQStWaP+A5PrUGGOavggbLxWLq0WhGkiwY2W/Q3HjvyTw9ue8sLD/MR0ibWBEzzu2aunpmJyMHrds7g62zAQICppmzSaEE1JqXoGjtKI8gvjCRm337kFPeX2r6ql2rHo1uZvbRwYqxQM5j395UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QfPhw9BZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KVT3lPIq; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QfPhw9BZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KVT3lPIq"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 1330A1D00268;
	Mon,  1 Jun 2026 02:43:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 01 Jun 2026 02:43:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780296194; x=1780382594; bh=ubti8wtZWe
	znfNUZY1QdTlbeZNrBNZGH8mjyn6ZT360=; b=QfPhw9BZOTs8xpI11wjqh7/7E7
	RDAUFiPX2+h5Z4TXdp2dwSDgB+XKnZVEkk2Jq6IYTd7RfhvbarRPzni8/ul0qHqZ
	bxCK7fUwXz4QHIiCU5uGixuvLv/xk/HHxgfr1ZvjnilnWr63qjPhAIFm58pMjGvP
	rCt4ypnwHmwhCP2I5lZ9oer9KniHMQTEhFMNBCxma1hALjeSUwRIGw5Ml6rC74WV
	VAkox+CVj4gABPDUCUrbHhbczgDPqcjGWQAJtHiqDtB8MwrAZYKlIxOK6kJBxuRw
	ACwFeBmsMxFEc43R7l9NJcXLkd9FL79oquNorNWlZdAgn4XwACEJyNBzPn3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780296194; x=1780382594; bh=ubti8wtZWeznfNUZY1QdTlbeZNrBNZGH8mj
	yn6ZT360=; b=KVT3lPIqoM8pKKlZe443dM8wJC1RYli7cD0tc86WYuFNxZTgXDu
	+wJ5Q3wgSirhAmu/sU5OzMPT5C2kF+1+Z+vtdtzR9b4EhAlbrOh/llzBcZHwY01A
	Zllodq+IN/VB7+R08LXvxyVAkqRuT2RS3Ad1QHbeBORl1FkJ2tOOxsjaiphhzLDd
	WnEK7lMFPYbFQTUd+p4z/vqbaIJt/eMVrxFXlBpNZWIAcgbhbLy908036dGbTxQA
	MoubHKnd4vxXsaM7+ewmoG8GgkzLjwri/Q2MpiwB+UX/iOQ0d18+VtkxmsuGQTya
	XzcGy+lY1bPxHz3NEfT+7kDdQbqWKrmW+ZA==
X-ME-Sender: <xms:AiodainuOkjRuTMYK_5SGtTUFBgyYG-uLN24NH12E88ykmFtFK0WDA>
    <xme:Aiodag3-CjIuIplbtxj9EHmbe2h6UQBxbmPQaxyXC7J2ZWNHQ_Y1FPrfkgA5cgVI5
    PzEZY2QcqbXDswr-mE21L3Bz3Cv_fyAz5c3Az_2Zid4ukMUl7LN1Q>
X-ME-Received: <xmr:Aiodalrn0xY_CuaJjQVgocYMDAfdnUtfOk2-Y0TKeWOslN6fuJQmQB51HAhmiYkyP9FGI_S_5pm6vxxXU41-73hX4F0DZepqNx9T>
X-ME-Proxy-Cause: dmFkZTFtgnrwG50RKBJH/AFxO/K9pwxOUuWGW6DpoOY7N0uVYX1EPJOTzB8aKunuVgf6xL
    Px4ZN2aELXxfj5+zXzZnvb47hQY2WcdM3ke3MJMemWxv9rkyLnoVzNIPWuWjIRc2ghs+fM
    ++xrh0EC6vzvOBIejLQZTAjRzfm7RCEayUJfGcESzYxfKwx4/TINmnZFHoKpY2VBUk+/5J
    o8zlMa0QJgJXcz+7Kpk7gnQSekYDCQ5rQzT1tMMUD5ciYFqsyw+Y6SV7xko9Acslt8cGNw
    ykdRyjsaymeSPxvfnbe6IA4Hx+MC+dO/DVXyEoFbmGycJJ1Mf0ARfp3WoDPB+K9VFA68sf
    Uwjh2aignydr9Sv8dzcBVEDRd9KdNE/uCDs1vcJeRwWqs5o8uIXKPBKGMZvkb2IeMxsTOv
    3mUWa5N6Az4BSv+qpuC1P6MqRNj1Ho6KaZ8HyI8sMeiALxIX2w7TiHWq0bAOwk6VFKk86Z
    OaCeOSt9bjDsb0Ser3mCfNye6C+YVOeb4AWhNwmM8iYmd9TzXVM2R2UO/AjlnP89bbwefE
    2G3p0KUS7r+rEWE3Vs2brHki9Xe9L2bVC1s5+WMCJdzxV40B51PB5+BR5oJtVkKfG7SKLa
    oDZOE85TjbS/9dSggACd+X5erK1Ep6dyekgoqAu8HB5tmJAWYFMCrXdXegyw
X-ME-Proxy: <xmx:AiodaldrLEaTQ5Ahq5xVDRfejYZZe6Tqu3UJt9g2E1A5Xv68eeOAcQ>
    <xmx:AiodasoTz9zLgBzzhDRSB52RDX_H-1unAcdubxKZl8ki8KKjCCW-LA>
    <xmx:AiodauE2wci8vuJ8_Bi11eng7gUzlvcuCjNi20AvuaHkbguqrTfh6g>
    <xmx:AiodakuX6U6vawh6vgyDVjK6tZ7V5J9ajT3NhPrjG8cRsgzLg0NUsQ>
    <xmx:AiodahICBtdsb2OyOeSb5Mn_gYw2FXfS0gdg8oLWRoIvQvVSC9zdYodc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 02:43:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Michael Montalbo <mmontalbo@gmail.com>
Subject: Re: [PATCH] sub-process: use gentle handshake to avoid die() on
 startup failure
In-Reply-To: <pull.2133.git.1780287309846.gitgitgadget@gmail.com> (Michael
	Montalbo via GitGitGadget's message of "Mon, 01 Jun 2026 04:15:09
	+0000")
References: <pull.2133.git.1780287309846.gitgitgadget@gmail.com>
Date: Mon, 01 Jun 2026 15:43:13 +0900
Message-ID: <xmqqo6hu92wu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/sub-process.c b/sub-process.c
> index 83bf0a0e82..22c68bd10d 100644
> --- a/sub-process.c
> +++ b/sub-process.c
> @@ -132,18 +132,19 @@ static int handshake_version(struct child_process *process,
>  	if (packet_flush_gently(process->in))
>  		return error("Could not write flush packet");
>  
> -	if (!(line = packet_read_line(process->out, NULL)) ||
> +	if (packet_read_line_gently(process->out, NULL, &line) <= 0 ||
>  	    !skip_prefix(line, welcome_prefix, &p) ||
>  	    strcmp(p, "-server"))
>  		return error("Unexpected line '%s', expected %s-server",
>  			     line ? line : "<flush packet>", welcome_prefix);

If `packet_read_line_gently()` returns `< 0` (due to an EOF or read
error), `line` will be `NULL`.  The error message printed will be:

    `Unexpected line '<flush packet>', expected filter-server`

This is misleading when the remote process didn't send a flush
packet; it hung up or crashed.



> -	if (!(line = packet_read_line(process->out, NULL)) ||
> +	if (packet_read_line_gently(process->out, NULL, &line) <= 0 ||
>  	    !skip_prefix(line, "version=", &p) ||
>  	    strtol_i(p, 10, chosen_version))
>  		return error("Unexpected line '%s', expected version",
>  			     line ? line : "<flush packet>");

Ditto.

> -	if ((line = packet_read_line(process->out, NULL)))
> -		return error("Unexpected line '%s', expected flush", line);
> +	if (packet_read_line_gently(process->out, NULL, &line) < 0 || line)
> +		return error("Unexpected line '%s', expected flush",
> +			     line ? line : "<read error>");

We catch error return (< 0) or a line with payload (!!line) and
report an error here, because we want to see <flush> here.  OK.


> @@ -171,7 +172,7 @@ static int handshake_capabilities(struct child_process *process,
>  	if (packet_flush_gently(process->in))
>  		return error("Could not write flush packet");
>  
> -	while ((line = packet_read_line(process->out, NULL))) {
> +	while (packet_read_line_gently(process->out, NULL, &line) > 0) {
>  		const char *p;
>  		if (!skip_prefix(line, "capability=", &p))
>  			continue;

While this correctly stops the loop if packet_read_line_gently()
returns a non-positive value, doesn't it introduce a subtle bug?

`packet_read_line_gently()` returns:

  - `> 0` for a normal line (which keeps the loop running).

  - `0` for a flush packet (which we expect as the normal terminator
    of the capabilities list, stopping the loop).

  - `< 0` for an EOF or read error (which also stops the loop).

In the original code, an EOF or read error would have caused
`packet_read_line()` to call `die()`, aborting the process.

With the new code, if the child process dies or closes its pipe
during the capabilities handshake, the loop will terminate, and the
function will return `0` (success). The parent process will proceed
as if the capabilities were successfully negotiated.  Any further
communication with the child process would fail so the damage may
not be huge, but somebody must check if the loop terminated because
of a flush packet, or an error.

	while (1) {
	        const char *p;
        	int len = packet_read_line_gently(process->out, NULL, &line);

		if (len < 0)
			return error(_("subprocess `%s` failed to give capabilities"),
				process->args.v[0]);
		if (!skip_prefix(line, "capability=", &p))
			continue;
		...

or something, perhaps?
