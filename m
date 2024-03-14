Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49587F
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 00:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710374834; cv=none; b=p7iqkyTJZqesnLPJlWEM50fXQwdXuqNAGq6AETle1IoJSvz/cDQHawesngI9jyGs7u8ludGDr9EHykqVKRDSDBPP9GbqBzAnhO1Id7ylh6Rj2i++12oWuoLeo5wFOMHi2DmtQ0FTjlGIe40TxKdzAxWkvvrLOXHx39jmZptYGYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710374834; c=relaxed/simple;
	bh=vxSeEFR7t8v6jCTDeSuxxiBhTt8Qvb65wJNzEZb81Iw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QHbbGC4UJUXHxv+ETHXy8+ns5WENM9aj7/b8GDPMoCYhl4yCrsuu6WMoEnj6rTzRKbOkIlyfEwBiACmt+bA+mJgMkTVpUpNcqR+4HWjW0Gy/68Yvb6erMIhEy+Ntdq83JWP/L4PYgfdVs+uZW0Fa2upuIi0lm6DKo93ymg+IEu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kXP/se7f; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kXP/se7f"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 75B541CD2C;
	Wed, 13 Mar 2024 20:07:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=vxSeEFR7t8v6jCTDeSuxxiBhTt8Qvb65wJNzEZ
	b81Iw=; b=kXP/se7f1ihXnUjvvY+U7nsG7v9aiHOI+481p4aDKrkwBI/Io2lge1
	PxWQyrEe46N0daC6dKZn3hwTAQlKx2idL5NqruMKV1OkmzvbbJvJUZJimG9Ooy56
	SBpkNPXMl5iPvOuT9uny1IelXFo/gqOajARr8jf6NO/eoce+zaAp4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6E54F1CD2B;
	Wed, 13 Mar 2024 20:07:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 02EE11CD2A;
	Wed, 13 Mar 2024 20:07:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christopher Lindee <christopher.lindee@webpros.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] Add transport message for up-to-date references
In-Reply-To: <SA1PR14MB4691A8AC86E290A3539BE1398D2B2@SA1PR14MB4691.namprd14.prod.outlook.com>
	(Christopher Lindee's message of "Tue, 12 Mar 2024 21:55:18 +0000")
References: <SA1PR14MB4691A8AC86E290A3539BE1398D2B2@SA1PR14MB4691.namprd14.prod.outlook.com>
Date: Wed, 13 Mar 2024 17:07:07 -0700
Message-ID: <xmqqttl94qxg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CCAC2A26-E196-11EE-8B9B-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Christopher Lindee <christopher.lindee@webpros.com> writes:

> Subject: Re: [PATCH 2/2] Add transport message for up-to-date references

Same comment as [1/2].  Perhaps

    push: mark forced no-op pushes differently in the report

or something?

> If the `--send-up-to-date` option in the previous commit is used, the
> "Everything up-to-date!" message will never appear, even if all of the
> refs are up to date.  Moreover, the output `deadbeef..deadbeef` appears
> suspicious, almost as if a collision occurred.  To clarify that the hash
> is, in fact, identical & to allow grepping for the phrase "up-to-date",
> add a message to the output when the ref is transmitted, but no change
> occurred.
>
> Signed-off-by: Christopher Lindee <christopher.lindee@webpros.com>
> ---
>  transport.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/transport.c b/transport.c
> index 84deadd2b6..89802452ea 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -670,6 +670,8 @@ static void print_ok_ref_status(struct ref *ref,
>  			strbuf_addstr(&quickref, "..");
>  			type = ' ';
>  			msg = NULL;
> +			if (oideq(old_oid, new_oid))
> +				msg = "up-to-date";
>  		}
>  		strbuf_add_unique_abbrev(&quickref, new_oid,
>  					 DEFAULT_ABBREV);

This code is in an if/else cascade of this shape:

	if we are deleting
		print [deleted]
	else if they did not have any
		print [new]
	else {
		if we forced
		then
			prepare to say forced
		else
			prepare to say an unforced update
		say "updated" in a certain way
	}

The above addition looks somewhat out of place.  I would understand
if the addition happened like so instead:

diff --git i/transport.c w/transport.c
index df518ead70..bacef94b33 100644
--- i/transport.c
+++ w/transport.c
@@ -666,6 +666,8 @@ static void print_ok_ref_status(struct ref *ref,
 			strbuf_addstr(&quickref, "...");
 			type = '+';
 			msg = "forced update";
+		} else if (oideq(old_oid, new_oid)) {
+			... prepare to say "same but forced no-op" ...
 		} else {
 			strbuf_addstr(&quickref, "..");
 			type = ' ';


to make the new logic flow more like so:

		if we forced
		then
			prepare to say forced
		else if we were forced to tell no-op push
			prepare to say we did no-op
		else
			prepare to say an unforced update
		say "updated" in a certain way
