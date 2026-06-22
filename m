Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15C8352F95
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 20:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782160810; cv=none; b=GeGTZacXcc6f5f3wuBdDVcxNqRU7NTH5N1hlEmSjEUXK7vFnH5QyHu+jGfYR66JDqFtXQ7IC9T50Zgtc1xXE8F6qRMKsgmTWh+OazQD3EO6hbcAsEfg4T43EkF6mPyfLnS84BRzryqdmFZmhCGPU6MbXz30TPZb9C1fBVQ4Eiis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782160810; c=relaxed/simple;
	bh=OR7z4JcEv/wXGcAL9ZNx67r45XwLCtpkTdOpSkvo2zg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rTL42DJfM865CY7QDFMhGWVb1zV1Pnk/GViwGRMRTsDwc+oN8h4N7ZZijPAl9dRYqnfmZfSzvmOihOAOGKKU+8sRnV6qODCBTQnSJ/MJ1CJI3hKqSW6lge+LX4UuWassMnEhz4hC3qNa6uqP+uNnwmAE0EvwIpP640t6m88r9Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Y4wLqVax; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MSz3i/E+; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y4wLqVax";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MSz3i/E+"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id CC85C1D00129;
	Mon, 22 Jun 2026 16:40:07 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 22 Jun 2026 16:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782160807; x=1782247207; bh=0IgmID5QEW
	m3pxxZhpWYr3NDZRUsM0WOLdLnWp+ym8o=; b=Y4wLqVaxJta89Q2P56klRti8Mi
	KfQlzR3ntVAwTjjOulFPej1vvYzi/2qGQu1XrH4oWuAY8DlGYbpk2NkVyrDC8cPD
	a2NV9ip2Zce7rW0KVTE6HSuBt9YMrxiU8LZJX3Y2fp008rwp/2ug55ao2CcoudBc
	nOcZsr3UsPIG5EPZLiILoJqx2icW3DjCFBO/jVAV+s0N1mdW4Obhm6Fe1X1tsbFX
	p/0VYESyYbLV0KOH2PDAYs4D0ekUagy8iOafFgMSPEn6JHI7m075YF4hlu1VrLfd
	J9GDsla3HV6+J+ZLnP5HDx89kn0KqhLZc/3YGP24PrENPvMAmXVtQI+IPr/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782160807; x=1782247207; bh=0IgmID5QEWm3pxxZhpWYr3NDZRUsM0WOLdL
	nWp+ym8o=; b=MSz3i/E+bxXKcJh+PuYeX+khtmE6nl2kBjwKwQc+ZtgkckS/3C0
	cVqdxbu7ZUX4xtYXsebbT/b3tcsLyA69KEOdn1tX/vwXGtVeg4/bx/93H/Za24DM
	0NeQDN725/nrc/EwLDNt2AYlSwhq3bioA3ta/ZB9pCwbhKFCXOKbDM6X+4i9KkxT
	72xAmTUANhx8LEf+RGa1aefk4xAZpEXZQIItTEZ68lrR9+c1hYNwJ/RaHiIwXWGS
	HVZ9tuAOJCZnEqECot9VzYckIRf+IWKXapENfHsSNqihmvlqme6EKE7Irkat6/qj
	CFqmN/roVZ/7SMEA0VpmKPdLmIJ5I6uXppg==
X-ME-Sender: <xms:p505amMuaEdsX7XkG-74FbzQ2xS9xwAAwjSTRx6o0vU2FQuOfw7mlw>
    <xme:p505ar9yewHkbX2kn1odrsbrhJIgwdnBFBn0lUZMFEDczHKg1gQ7zBBExB5PFkmyM
    kOYXvfeydEoBOSx6TuK0wXOCSzNr5sn-S2rry6M1-MXq5FDcmoQ-g>
X-ME-Received: <xmr:p505aiSDpWKMmlV5bac9hvDj2hV1Tv5fCCqCxhIttxyZB7ugpqG1ncYaMMqh1xs7obnXT4nICkDhdIyFXQBNHTGI0xiWTYMj6vm2x_s>
X-ME-Proxy-Cause: dmFkZTGvvs6BY//raJ2Kz2ktPYkC42JY59+54WcDztrqNhV1b0VldFLUR1DUYic6bKRa5G
    FhOFxLk8NmnrlbIo1btRWcmYc4TCyNvb1hEjlGi6SvhBgX6cbW4L7/FYNUnUeQm9Ely4Mu
    CjS+zPnxnm7ra9/gIx+Z2gD0D0c5JL+2eylg8JKspFntPk0aQesy5s3kCyUdyKdSydnK3g
    UxnCuvuWBzok+dq66ZjY/SrU8o9XjknpMAMuYpmEbezs6dZ/CSwjeeKPKyKh2mSflBD271
    qqM3sUrhu37q7ijke8fBKNyCOjdjMY0Mn7A3yz7/3p6xJrUuZfWrrgIX6YHxzHsdqtPAX6
    GQ8oQD8t4N9vHLtJ2GrXKBNO5rZtoEuvRpjKhGJlw+uRYlBVsUef03xn1SOe4r8N1ZWyfq
    KHIKzmi+IAmtntRs0fUHqtBm7C6FZdzkoYGpMWk+aqgZpm3Y9MS7vqRtmlBznXAtfYPaDY
    iPe7IVa72NE/R45UuK4Mi5WngJ3VaUuYx58qKuCHzM2+cVAH8Lc3j2wOLXYkqUtW716GOe
    /cztAVEjQOLjp4iIOlz4nsWXTpvfBec299xRZQaMcseoWm2ACXSWjzIhX4ih52+gWC1mOX
    oLEUWq1av+jR1CPbWCTxhI45pT0S9D1HCa93GRTm8dzuLKbNKDg3dlW2RSMg
X-ME-Proxy: <xmx:p505alk8m6r22ZfHQ0gKybQDHTS7FkF1NYwN-qSJuiCUossafRaNSw>
    <xmx:p505aqTdnZm1NuQrfzokj3CZXiRFjKqZ_X1Wa0At_6w9e7R_2_Y1YA>
    <xmx:p505arMEHxecp-TYiC8x_gLwLBJ5iOsBVtdSqb8amOogLyqrvA2tEQ>
    <xmx:p505arXlXM3f-PFheSm81GQL0BRMQVfH9rhWzsRfLLdYxbTBFcN-xw>
    <xmx:p505alx-ejB1phCNwSlsyfmJ258-4RoQe1qvrIfuuYf0SM6aaIDqfc7V>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 16:40:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH 2/2] push: suggest <remote> <branch> for a slash slip
In-Reply-To: <ea1412b1107f485cf52c953e387a513d95d82b53.1781262619.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Fri, 12 Jun 2026
	11:10:19 +0000")
References: <pull.2331.git.git.1781262619.gitgitgadget@gmail.com>
	<ea1412b1107f485cf52c953e387a513d95d82b53.1781262619.git.gitgitgadget@gmail.com>
Date: Mon, 22 Jun 2026 13:40:02 -0700
Message-ID: <xmqqtsqus40t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> "git push origin/main" is treated as a repository and dies with
> "'origin/main' does not appear to be a git repository", with no hint
> that a space was meant instead of a slash.

This is easier for me to guess than what the user may have wanted to
do in the decription of [1/2].  But it still will be easier on
readers to say

    When pusing out up update the "main" branch to the remote
    "origin", i.e.,

        $ git push origin main

    it is easy for some users to mistakenly say

        $ git push origin/main

    instead.  This however instructs to push to remote "origin/main"
    with configured refspecs, which means a completely different
    thing.  Lucikly, often origin/main does not exist as a remote
    and the command fails without doing any harm, but still may
    leave the user puzzled what happened.  Give hint to ...

or something like that.

> When the argument is not an existing path or configured remote but its
> part before the first slash names one, suggest the intended
> "git push <remote> <branch>" form. The suggestion is shown as advice so
> it can be silenced with advice.pushRepoLooksLikeRef.

Sounds sensible.

>  	if (repo) {
>  		if (!add_remote_or_group(repo, &remote_group)) {
> +			const char *slash = strchr(repo, '/');
> +			struct remote *r;
> +
> +			/*
> +			 * A "<remote>/<branch>" argument that does not name
> +			 * a path is likely a slip for the separate
> +			 * "<remote> <branch>" form, so suggest that instead.
> +			 */
> +			if (slash && slash[1] && !file_exists(repo)) {
> +				struct strbuf name = STRBUF_INIT;
> +
> +				strbuf_add(&name, repo, slash - repo);
> +				if (remote_is_configured(remote_get(name.buf), 0)) {
> +					int code = die_message(_("'%s' is not a valid push target"), repo);
> +					advise_if_enabled(ADVICE_PUSH_REPO_LOOKS_LIKE_REF,
> +							  _("Did you mean to use: git push %s %s?"),
> +							  name.buf, slash + 1);
> +					strbuf_release(&name);
> +					exit(code);
> +				}
> +				strbuf_release(&name);
> +			}

Hmph, if this class of hint is not enabled, do we still have to
spend cycles on these "is this a remote?  is the first token a
remote?" computation?  I would have expected that a change here
would be a two-liner:

    if (!add_remote_or_group(...)) {
+	if (advise_enabled(ADVICE_PUSH_REPO_LOOKS_LIKE_REF))
+		die_if_plausible_typo(...);
	... do the "try treating it as a direct URL or path" thing ...
    }


with the bulk of the "if it has slash, it is not a file, then advise
and die" logic inside the new helper function.

What I find especially troubling is that even when advise for this
class of hint is not enabled, the new code will hit the new exit(),
without falling back to the "try treating it as a direct URL or
path" thing.  Or am I missing something?

Thanks.

