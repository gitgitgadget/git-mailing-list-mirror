Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14641DE4EF
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 02:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791081121; cv=none; b=m7eh03W+PmJnNBZ3ks1UfIpsYeYZ9ZzjKirIC7E4sHnIDBh/x8j2M6cnIlfjgd4gEDpT3wfiUSnX55DSiinAI+lMH1wRP2zSbOeDaCwkytxvi1/pFGP8f5ezTxdrqOAdCg40PNG8sWS4xdYUhznPRwXaTG0rqTfxY587wu4w+9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791081121; c=relaxed/simple;
	bh=0EqbeZPYfjv/+ZeAK+rbkyp7PpQIt4nnTS07kKA9mKY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J3Pc4/rSyLuVovs8DtdmUAk4vM2ke6ZsoceAMjONnzgY7joo6dmaZJWNWfx9C2SqIWe5wsLwUaL6mW9ILzmteLG/mXJF4oj2oYgtDNZY41KekjSnQ4aVlQKBzxczhfs9eRMCdo7/FboaBLzj/JCYQrTY1I6mLoQdwyJ8nGb8dnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YMTYJ75l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kpi6sK+j; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YMTYJ75l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kpi6sK+j"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D6A6A7A0064
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 22:31:57 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sat, 03 Oct 2026 22:31:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791081117; x=1791167517; bh=UrBIuj3Pkm
	9RYjTQFwVvaWB/yXVH4XUEw7B4kJYtWCM=; b=YMTYJ75lzrRcKvcLroTscU6DJK
	KDKan1s0B5/eVYRO+eoBSNMXfgmMz1b2MeA3ujU9htHvHNqlRYpMw5B4hV98YEwO
	fLmlbu4LfGLaAv1Wd6DS1fdpzPbxGmY2xCb/V9qyT0B1FR+sC8tvpUrNVikldurN
	u29QC0neaxQxIW7o8XjQlJWO1qV2cotaJ42Y4fVPftIFM924izDRdxZ8hzzELEbv
	37kjzbzhlSDSyZt11DlQBUvI7lFWq3Zm4wNHlumZ/0mdoptvMM8i6hWOzQEyLZc+
	mL57WUyranpb1UWx/wN/gMptKqLL5gnvmQ3Ihy7+b2jjvoEUqm9iM0Txcq8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791081117; x=1791167517; bh=UrBIuj3Pkm9RYjTQFwVvaWB/yXVH4XUEw7B
	4kJYtWCM=; b=Kpi6sK+jK9Qlig+gS6ed9fYTizUeW11mAQ28yOcKEUe0kEJZFx4
	BwaAMYfe2SqJd7bkKq6yVEdU0xME8zjVjSzNQ+ycFRCVO4KiqP1g55E4J0/9Llfq
	DSAWxjphliQNqkOaiHDwRHEAVmleQDjaon32x1ApDa6+0OYc200hAYvWeULq7V0M
	403dyULmUhab4M13auhoOgRwPe+WjJa2w9j2qtJFGsgEumFA5l1Qdc3aAcUIHDMT
	XkonPIJ2ygR9rlc/T9KIbZGKmiebb2dDHtu6PC2hXPG2QUe/Xd7KPa4i3TMrsaRn
	Jm9D++9uzIcp5SQxZRVCMizAHgpLg56JPdQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791081117; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:g9lNlKDYcmMAYlo5s2c7/WJ6wGQToDmoyjzouaelAiwjJO2
	RYdFo+jTVp1g5yP+akKUjcfBa9/DvDoRdpGMKRGowwWw86S5FHC+Txo1yskSr+Qr
	SBIhPUUp81RU3vRbc4qI9DK2T4zBPIWx+xKbzgkBQQjFnobxjTcVxULzox4OKAhM
	gyFqUnh94g0CfLswuqwVvQanQHgqX5JI7nw1ghGKMpuzLnsxoTPokNm6SRV0zK87
	3lRuPmUxTVbm9hBDBeVobx7aLRDrBDnjYv1u/fVXfkZfQ7VwXIJwyjBmqloH4S6o
	8ZoK1hb+b9K/qx/2z0xh7+hOVk8WdmPZOUyawqA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:d7wm/ei/McqB/e3a0lRhmAYQEsv42shG6qIFlV7NLPQ=:0EqbeZPYfjv/+ZeAK+rbkyp7PpQIt4nnTS07kKA9mKY=;
X-ME-Sender: <xms:nbrBajGdKYYy7rxRfTSq8nj3EDCqHRCqfpISNuMBC6jkA1WTZS8gGw>
    <xme:nbrBanW0TE0zmxxKB89vcKGuvL7L2oLBO3tZ_VRQthtB03P3Y04EYdheLK8Sgxhgh
    vZW89pl75Qsq1-S8XzUYGiKGVOk8zHsIihpUMYNZbVwsJFhW_xKmDM>
X-ME-Received: <xmr:nbrBaqIBkBM3MiCMTLMYkQvTeWIGOMt4CxpHb5EQZeDbvxxWvXSalHo_L8yS5w46VXcxwrXc0CbSXmxp4ad8S-N8eRUvihLq52n0>
X-ME-Proxy-Cause: dmFkZTEZH3VQ9/X2wO65SFBGZETr3nZ6DOKux0tLtfTLbSIVCUSbOR4fWg6unCnu+82PAn
    pRBoIw1Sv5Am9nEeG7J7GVTrkNDUyTtb3wDjxCA2THoQaVewsG/w7pkpw3uC9va5o9BLU+
    oTq0YStfozog+rSjpUJBjxN51cbsnkyaiYE+TVIZ0UDHkbp1+/jCuRTNvnpVLnA/36f9DM
    1fUsWmbIKy8cJENvu+iXABQKzgYt2GN4fhykwWp2nK5ZUCD5WOfte9EmpWA93z6OPBo6YP
    zAlthvw6wgFbykv2sXNuh1Ll/5FRnVFo9J6g3K0ude8gFdMowxnTjCAcAPtQMKjZCSEdQM
    cxHinDave5ecY3p01g9ILl860BwCUEV85Yq77zNjUTEhZuvXr0g5E44C/vUnJtwxRdXKNQ
    tzeeuLg3acZWP9A94b0BPTzy6CweylV7Ox5VDa6E4rQ0SUA1J+HStRCgeqjhlBnOGfkQFt
    Y/3z75fyisUrC5tsFE/niZaXoC/RE0gQproVNfKimaxPoH9FJCQTjvvlZuHkD/GBSdKyWo
    eLSXCEQ7ZrYN9P9QZ5LemSdi80dMab9isBNvnJWwMtsowh3INio+Q7y6J66gZVr5fm2Q78
    42jY/vjuoJAq4VR8Qlh1G3YN1u1Qqd2RZsTjbaqyX/TzhNAh3xqVAcV1ncKA
X-ME-Proxy: <xmx:nbrBav9LQIxLYuN83vhq_0WD58cQ3L0QsvVMtDNQc8Ws9NjFl22UUA>
    <xmx:nbrBalKr_Fma7YIdbU8vUGE1V20kE22t3IcQl73v9D3PjQuxTYrasA>
    <xmx:nbrBasnrrqxNdyzp6UGpopxgSX9yt8Qw4GixQXBRXY-XJ9OcXQ4Usg>
    <xmx:nbrBahMOiOEe1YnwDkCuzhAlKwd3gh83UJCvI_0j9QuD5MT4tMABgQ>
    <xmx:nbrBagzviBDhXQy8eE5joDKKittLdVuI640xhIil-AszDX_dbCGPASBu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Oct 2026 22:31:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Patrick Steinhardt" <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] doc: gitbreaking-changes: replace msg-ids with
 URLs
In-Reply-To: <533e2f52-2c9c-459a-9fa1-dff3ef4bb2f9@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Sat, 03 Oct 2026 13:52:01 +0200")
References: <CV_gitbrchanges7_please.d1c@m5gid.xyz>
	<URLs_not_just_msg_ids.d1e@m5gid.xyz> <ar0OltAkeTiCx81c@pks.im>
	<xmqqeceaa5h9.fsf@gitster.g>
	<533e2f52-2c9c-459a-9fa1-dff3ef4bb2f9@app.fastmail.com>
Date: Sat, 03 Oct 2026 19:31:55 -0700
Message-ID: <xmqq8q4ew604.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

>> Having said that, I am somewhat negative on what this particular
>> patch does.  We should instead give both, having something like
>>
>>  cf.
>> https://lore.kernel.org/git/xmqqa59i45wc.fsf@gitster.g/[<xmqqa59i45wc.fsf@gitster.g>^]
>>
>> in the source, and render a readable link text with reachable href
>> when shown in the browser.
>
> With that I get a regular `href` and a `mailto` href.
>
>     <div class="paragraph"><p>cf. <a href="https://lore.kernel.org/git/xmqqa59i45wc.fsf@gitster.g/">&lt;<a href="mailto:xmqqa59i45wc.fsf@gitster.g">xmqqa59i45wc.fsf@gitster.g</a>&gt;^</a></p></div>
>
> The `mailto` wins and prepares to send an email.

Ouch.

Our primary goal is to give readers ready access to the messages we
refer to.  With that mailto glitch, it would be unusable, so let's
scrap the idea of using the Message-ID as the link text for the link
that leads to the lore archive, unless we can tell Asciidoctor to do
what we want.  Quite honestly, I did not know Asciidoctor was that
broken.

Also, if readers do not recognize "Message-ID used as link text" as
clickable links, that also defeats the purpose.

The secondary goal of my suggestion was to avoid repeating the
disaster we faced after gmane stopped offering HTTP access to its
archive.  We ended up with a bunch of references like $gmane/217 to
refer to their article numbers in our historical commit log
messages, and of course, once we could no longer rely on them, we
had no way of knowing what message article 217 referred to [*].  The
URL to the lore archive does contain an encoded Message-ID, so the
situation is much better than that of gmane from long ago.  However,
if you live in an environment where it is easier to feed the
Message-ID directly to your e-mail program or newsreader than having
to visit the web and then come back to your e-mail environment to
continue your work, having a readily cut-and-pasteable Message-ID
that is not encoded as part of a URL is definitely superior to
having the lore URL alone.

But the important point is that this was a secondary goal.  If the
format using Message-IDs as link texts to go to the lore archive does
not work (either because we cannot bypass the mailto behavior, or
because readers would not recognize that Message-IDs are clickable
links), I am perfectly fine with leaving only the HTTP link that
is so obviously a URL (even though I find them rather ugly, but
I am not the primary target audience).

Thanks for testing this and finding the issues before we went too
far.


[References]

 * It is <Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org>, which I
   think is still one of the most important messages on the list ;-)
