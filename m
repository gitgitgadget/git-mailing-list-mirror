Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741F831A575
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 14:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781101313; cv=none; b=RGc4/lG4exEb8XVnAKtz6He3lRRHYN+wF+YMKXvf4gj/uYZYspkDuCjDWw1v9XtDWJbG2IpyRnxvwlRDe75iZjqDTFjnsk8k2AWVOWDxY/0+nynffSmNpOVUD3lrfOSlLgF5wD8S8SjjZjIO/4SvBrvHXZytzexg1rmJKZLx4kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781101313; c=relaxed/simple;
	bh=nNHG9QHcRTZqV6JRl9R82UgwZIK0O8gY01BuJbc+X7E=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=fzBRURZpoc8titNBWdR6w4mz4W8PjoStWofSs/wJn1UIdN7FPihNRSwMUggqi61FJNy75CqkiaiqR93VUfsie6JLIppmQRrZNqYS3Japz0iysmp0CHYyOcftXROOUQ2AgvMjAGRTePGwmm6GY8pIrkGc9WlDkzxfH6lfy0MYQiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=W0NRCDYH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e8zzDSKI; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="W0NRCDYH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e8zzDSKI"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id C4F831D00131;
	Wed, 10 Jun 2026 10:21:50 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Wed, 10 Jun 2026 10:21:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781101310;
	 x=1781187710; bh=n/RI5wlj13gw8KCcLnuc9vdps9bDXM4Juk3tzOv/568=; b=
	W0NRCDYHdC+g6B4dnSnhlCC/AYT1GFR5DaTnj2uoLEIdgKkNTUeTGX+EZUhZz1xw
	3GBMS9AD3B9pTV0sXPj4nygGCszivyGPbcF+vb40onWtTn3OsYI6LdR/5xM6JAdG
	hWLcOerqtlSjWU1u8tFACzmAK1qrcN/Wae9iKGgwc/rHQiNOKtOYK5O7yEeTOqE4
	xj+Nimu8eoA99Iw3jbohDUo1SAdwp0evX14EQ9Njmb9g7aI9jWH2LO6cXdmexFbe
	wxClvywdHtxjr3mOc4WxFjUJO9Cz0sY477lQAYr8n68sxv6IgF9HTKxbmQKbRPDL
	HwN7wo/vg4HDVrAt1XCnIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781101310; x=
	1781187710; bh=n/RI5wlj13gw8KCcLnuc9vdps9bDXM4Juk3tzOv/568=; b=e
	8zzDSKILWt3EKdvLuQCmbM+XcKDFNR7YkWBPv4SbcMnCiZMceRWzn25o6JNxbUHh
	A9o6YI6zOsYXd1ZcCj0ttoQ2tVaWmG51UJa2ZvTWJy+WE+zJ+7elCJoVBCa7ZSWd
	6Hfu7VLd7jX3X8CAn9nYtbzut6KppX87yYVhGwvmOjroTP/JBp1ZxMgskUVajOCi
	qDK4ZQ1zkgMAxD8giBz4Woo+r4FBaULKhDMsu+ykUondJycSk7YS1nY9UeYDekA/
	aegS2N4YgY/ybO3HbW/C0TnqZVajETQySHaVF8IjUMpmhXyliif9s53yMVlqoyql
	xye+1mKHCahApsod/LB+A==
X-ME-Sender: <xms:_nIpaimTDArjWOuGzftwoYaaGSEYAIHuZSWead7nka5_W7zwUKe0F4M>
    <xme:_nIpakpS7KaeO2oGIMgxczJVGZ2Cc7pVWWg6xA59hGytO58ZhrVt2WBgmwB2zXOMm
    E6ucKkWElWeegLs-53EZ8QrQ7DGm-bDrE-iJugnFovl39vznuh2Jw>
X-ME-Proxy-Cause: dmFkZTEcLodTMtOFykV18D2GbuYPdMDHRKSnPy5B5RNX3jlaa3/8dm4DAZGU6RQNiTBuAf
    WKtYfdOAGE6MH04AbIoUS2J4RQ/EKJ+WxEUPj3wROJsSPDI6GOFPdAIy4cPYNgOPAlB2x8
    Ne0aVCb/OagVMWODlmuZF7wMXAOsdoeziRyzpaz+CGMU5/xhrTrAcMxnZS1lzhXH6300Bd
    3qxSGp288mi90bEAUTZhy/Sf+nILQv8fkbVdnS+MeJflzcPSVz/fJ3N0nY5T0s2ddCYpnv
    a/tG7zpRtffu4vYfIMsyxhAEjj66Z2JILzS4ApcxSuUcu36QlNbDCAGu4m5Nymga41XDH/
    z/Rkf9M7nOuT37MztkHVRYxaKP0Q+ZCTTm/izxo1nDQ0o6CHZLrLYTRiqxfglw9faueWjB
    B7Kqe/Lnw4EO4J+TYIw5oo9yDXBELjFAZ8tZpNqvejhqdsqEODfUtLoxQVSg321ETDgtRI
    Y4TpbQHBQmFD4xVC7a8QzJZNDSBo9BtWWtdvqNVCurf74qL6EB17lky7iSd4gxH/rBHxaL
    TsFQ+isZk2LMIFxp8di+pd/MeKyyYNmS7AP5SX5GqFtElWgcT/zb7qDzN33hRKGP7fktT0
    n1eeTVNpsrBRgc+ZVAEMtqoiWsqSMCWbGGgbGSp64K774H4fVlbbAN/x4cKg
X-ME-Proxy: <xmx:_nIpapQWNrBMbZLVVaOsAN98vddhNXxqtjJzqnpcQRejEVxhiVHoAw>
    <xmx:_nIpagvemu88tJNkWDqeJp0810afUviFOLdO1Y5sAlmhufLavzLpvg>
    <xmx:_nIpambqWE77GmkV7DoeaGld6SLQ5bbH7-6NUqSJFIsitclXgxp5SQ>
    <xmx:_nIpattcE2YRW3I6kHU1P1BhzH53QgD0Bl6cul7RhjMetGdHPWoFzg>
    <xmx:_nIpavE75gcOO-qGtVdA1Q4Q_Jxa9wjlDkG_4xzVDWxm7ZmXkyAiGhTD>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6CC3130201A3; Wed, 10 Jun 2026 10:21:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AAxCzT8Sx1UB
Date: Wed, 10 Jun 2026 16:21:29 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Jeff King" <peff@peff.net>
Cc: git@vger.kernel.org
Message-Id: <d8f7f827-27da-41fc-af8d-72d383b24fff@app.fastmail.com>
In-Reply-To: <20260609004340.GF358144@coredump.intra.peff.net>
References: <ae4a32e7-bacb-4c88-b2a0-5aeaff60b904@app.fastmail.com>
 <20260609004340.GF358144@coredump.intra.peff.net>
Subject: Re: trailers: --only-trailers normalizes URLs to trailers
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026, at 02:43, Jeff King wrote:
> On Thu, Jun 04, 2026 at 11:27:51PM +0200, Kristoffer Haugsbakk wrote:
>
>> The following is a bug that follows straightforwardly from the docume=
nted
>> or discussed behavior. In that sense it is not a bug. But it is a bug=
 in
>> the sense that it makes things inconvenient and violates a design goa=
l.
>
> Yeah, though if you'll allow me to nitpick your subject a moment: I
> don't think --only-trailers is really the culprit here. It demonstrates
> the problem because it normalizes the "trailer" it found. But the loose
> trailer matching is the more fundamental issue. For example:
>
>[snip]

Yeah, this is more precise. I focused a ton on the normalized output
because that=E2=80=99s what makes it obvious. But the fundamental proble=
m is
interpreting URLs like trailers.

>
>> > What's different between what you expected and what actually happen=
ed?
>>
>> In an ideal world to have some special-casing of URLs so that they are
>> not detected as trailers. Does anyone realistically want trailers like
>> this?:
>>
>>     file: //...
>>     http: //...
>>     https: //...
>
> I could even see those as trailers, if somebody really wanted to allow
> arbitrary values that might just happen to start with "//". But without
> the whitespace after the colon, it is quite questionable.
>
>> Just special-casing `https` would go a long way.
>
> Agreed, though I think a rule like: ":// (with no whitespace)" is not a
> valid separator. Something like this:

Yes, matching on `://` strictly is a better proposal. No need to care
about `http`, `https`, `file`, etc. And both of these would *still* have
to be true for this change to be a false negative w.r.t. the user=E2=80=99s
intentions:

=E2=80=A2 They really input a trailer that looks like a URL, but it=E2=80=
=99s not meant
  to be a URL
=E2=80=A2 They really wanted the value to start with `//`

And again I don=E2=80=99t think that is likely to ever happen (with a kn=
ock
on wood).

Thanks!

>
> diff --git a/trailer.c b/trailer.c
> index 6d8ec7fa8d..342ed81c78 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -635,8 +635,12 @@ static ssize_t find_separator(const char *line,
> const char *separators)
>  	int whitespace_found =3D 0;
>  	const char *c;
>  	for (c =3D line; *c; c++) {
> -		if (strchr(separators, *c))
> +		if (strchr(separators, *c)) {
> +			/* special case to avoid accidental URL matches */
> +			if (*c =3D=3D ':' && c[1] =3D=3D '/' && c[2] =3D=3D '/')
> +				return -1;
>  			return c - line;
> +		}
>  		if (!whitespace_found && (isalnum(*c) || *c =3D=3D '-'))
>  			continue;
>  		if (c !=3D line && (*c =3D=3D ' ' || *c =3D=3D '\t')) {
