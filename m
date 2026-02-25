Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1A01E5B63
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 22:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772060133; cv=none; b=hm7EPU4tVZQH7XqAg53trr+m2g8zUVYzZhE5T1eC/unzKEOZbkoH8yo64G4X4NYXfHkC1Puv259nySnqOe6qdS+OSpNR8Oa0aKUbZUo2cuQ+9ihWxcWnlyvNrIIn9TEgANi2JQ4wBjI0Yc5TMZhZKFXihIOoAmaLLzZE80GU2fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772060133; c=relaxed/simple;
	bh=2kGP5+zZy+L8FNlLXHy20ayefWyo9zdib5J3909pSA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jaj/qmDIcK1FEvOu6xsgoafkW0Q/oxxcvwHTBGoRkDckis4kmgQ30YpArBDIZhd5V1D9ogWDcxsmpsr0S27BEEzfYjb4xqGDZITW8aZol1uuG2xaaZ14wlVxaDKCjt+SKYoM3RYANqIlGg9M4OTfcUQcvQmmS47cM9iP0S5O/Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=hJejAUin; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="hJejAUin"
Date: Wed, 25 Feb 2026 23:55:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1772060123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tjsk2gwGTNDYrLerFocuq1XJjoQKNjnRRvpt/MhgvfE=;
	b=hJejAUinWhffS5rMos2Zq2l9Uj5TdM+wmBskMhS9fdYbObtAzPtZ/jfmtYNu/QSHvXXngy
	47NprwBMcnROPM7Be+gZtZurZsGTnV3IT6X7XlVzgAHmoT4sAvmkbM1Jj1/27LP7Hgi05d
	9gd6GxUiHWy4E9aoRqq7rERHUXy9GuIHcVTsiIMKUxS0nA/u5KuQM3MdVIPtIRPVhGJaaC
	zMI957f6RafcgWFmyZm2sobaDLRGC53nMqY7uRjww9L8we3lHIrLELDrIUelXh7j66Nco2
	MmItZPJ/vRhYbT6af9Ffd6Qb2xvF5auNoJZ19tIPg7oRTbgKoEJ+bwe7KXHggA==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH v2 1/2] format-patch: add ability to use alt cover format
Message-ID: <aZ98aIf2i4bRdlJn@exploit>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1000; i=mroik@delayed.space;
 h=from:subject:message-id; bh=2kGP5+zZy+L8FNlLXHy20ayefWyo9zdib5J3909pSA0=;
 b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBpn320fH9yLImRQ+40K7H+2+3wLABmAV+HfN1N0
 H/69Bpagb6JAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaZ99tAAKCRBIeX6hnBm+
 0eH3D/0XChBPsgrraiFRlPvIbhl5VYs9E6WtiiJUhrH47BVuZ3CVR/M1zw89YrrR0rDe+iVnOY/
 qtYgs8Tk8mfzPLs5GwHWQruo+iAojkop+HbV+8KbBRuPk7RETJUnpjJg0d37v2OVqZGo80Ob9E8
 cm6WLHld0ypvM2e5SbzM6dASaNd3+Uu/sxoKMDJJWT/AU2guGyvvePqKNj5+D55h6lQ/dm1tEJ4
 JLJGbpqJ/22NmQ+iEx/xd1FOeV6/mosluZ9PVfUa0RXpWkiTA2VIQA4EBwnkO7lFJnwx/OyIvMB
 nWzJbIANpfyxHxyUTSVJVctHYggEy497OF32QNR0lPuUoUZV9Maq+nIrFjNc59EOFM4drfS1cVF
 +7cqFgaqa1lOf0LUUe6kNrAEhi96Ylf3DtTGw+gRO39OIyJk5YQ7h61cNITlDmbgFdgn4XFMFHb
 OJbm/+NlicwA+23etSGAjTOQedBDPWTA89Hk0U5TxSwn1D0xqsOruPGfFGo6YTnB5LR/LPGMb+Y
 EsbGYpIog/asGX/ywM53i3G7JEJnCfmWNa57/EeFFKBnzSG6oUSUMb5aeUmYuPrJlWG/nn3hWt/
 WOotpKXCyUfDgDB4Zb37VXx4b/ucMAZRmhZkKkeo7PQzncBnJkuVVNnelpLqbVUO707sx5Z0f0s
 drR7iOnFkwovRqA==
X-Developer-Key: i=mroik@delayed.space; a=openpgp;
 fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
References: <20260224040400.751247-1-mroik@delayed.space>
 <cover.1771925291.git.mroik@delayed.space>
 <66cac565f8a40f8de3dc3d857feb681bb80cb136.1771925291.git.mroik@delayed.space>
 <20260225135628.GD2139176@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225135628.GD2139176@coredump.intra.peff.net>
X-Spamd-Bar: --

On Wed, Feb 25, 2026 at 08:56:28AM -0500, Jeff King wrote:
> When this topic came up initially I imagined that the user would be able
> to tweak the "[1/5]" part of the string, too. It would take a little
> extra work, though:
> 
>   - introduce new placeholders like %(count) and %(total) or similar
> 
>   - introduce count/total fields to pretty_print_context
> 
>   - probably when total is unset, refuse to interpret %(count) and
>     %(total) at all (so they do not have meaning for regular "git log
>     --format" calls.
> 
>   - not sure how to handle the width field for the count. Would it have
>     an option to default to the width of the total field?
> 
> But I'm not sure if it is worth all of that effort. It is more flexible,
> but would people really want to customize how it is shown (after all, I
> don't think we allow configuring it in the patch subjects themselves,
> though we do allow suppressing the "[PATCH]" part completely).

I can give it a try.
