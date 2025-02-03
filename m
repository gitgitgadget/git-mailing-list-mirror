Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BDF1FC7D7
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 08:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738572028; cv=none; b=qr8eEW4IREQpgWPaAuxwBLaH/p4VZ8Kpzkz5DY2F7RSYPAMpMy9F2aK0kGmWwrOhu+ISq8HttKIqNdx2WTFNiS45JtpeG8l1ONdocv26jx8rW+6EIjiM7S1E7CD1amFJF1zF42RWYKD8+ELhYuH6B1jn3g+zjELXVr8AVo110ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738572028; c=relaxed/simple;
	bh=vct0WUQXALtyhlDNObB3UhoU1ATD+iU3o2IUj0kunJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZuLVDuC+8GIRqzT5LF7PhD5D0VAjlps65Xa6X1QOpMhoEDxhT/uTfu3qLAuhJlUVncYGnf5xh8yVVZ9sEh5FpZHm+uU22qKXmRUWw3KNRWi0TDp2eevGN/h+EksKARbWoeWwXaqoO9MnY2vXQdY7astqLFTt7BBhJRzgkqNj73w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ciGI7LmA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o9SExjZc; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ciGI7LmA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o9SExjZc"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 1F376138085A;
	Mon,  3 Feb 2025 03:40:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 03 Feb 2025 03:40:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738572025; x=1738658425; bh=paLYDikVKI
	kqze83ntezMSNEpNDy7DKg/xnbaV5Iyqc=; b=ciGI7LmAMW7DydqAY3HLq08B7T
	8Fc8cEVE82AY5w9uLyu86cdiCpKlTdS6NFNz/cDJ1rqDggOifSU+QOEou47GAKNS
	ksn0OA6amk8tYkMJ/nzK5k2CYtLGSzBFQ+OYyk001Utd9R7a2XWEjo4f83xzgDpY
	kALIl42JqFBsatCKJKk8wQ8AxT52AIiOVjViHTo8rIOnO+AK/qMUwPjophYtOuC1
	A6QhakNMembcynKFNN6d7M4QB99CFU1k56Q+slDo57ku2A6bBXj/whfV3nXMSihd
	bPBjfTPM9E0InqNNLqugamN7nJ5D+iF9dgRSjJCE3dSLbHcd+Z3QIJdo1tKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738572025; x=1738658425; bh=paLYDikVKIkqze83ntezMSNEpNDy7DKg/xn
	baV5Iyqc=; b=o9SExjZcLiTmHGtxj0UcR8uZaSitayyKNHNjYsYF76R0qxzYDgD
	S29jKV/b4YaQ4hRidKnXOqkwcSoGRhu/vOD3Cb0QqZQ7KLURlHPIil+6CjgAPb1v
	P7pMh2KoWa2YJmoAl2AnWD2KzoubnQr+fb3aMaVKks9EJRUCLBWwQumoUYT7pUSc
	HmgHNbVzFTpI57REMW5LwETiI/OMazHR822G4ryY6nr+vS3Yg+FKFZb2vBJS2fJU
	rVUpVjbCpv5LCHnsdTqcFFvpXSN4e8QkFIDQ1hLUprP5/3WhYAe8w3l2kNNEc5YS
	DsHe+0LiiMEOGkb6H5phQw624uGVUx1MZSQ==
X-ME-Sender: <xms:-ICgZx2Yp195uID73UaLf8yh57azt-A_PcsQSpCbhC7vf9G83nNIVw>
    <xme:-ICgZ4Hut_XzJ-ECa5aUlDTdAmTex_sOO2LJYE8SsmdYTljXnDR9JcfHU-WOSF8GR
    w8tV_4m-1fjQDgt1Q>
X-ME-Received: <xmr:-ICgZx7L5JPkaGIWX7_h5X0QKwouw4-puCHryjDDtP9GMHQxsFX_UPuby2iZK2kExC0x77lLrvGrYN3_qo7W5wq0LQXZjw_b8SKXuFewN2-Xmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepmhhhrghgghgvrhesrghluhhmrdhmihhtrdgvughupdhrtghpthhtohepkhgr
    rhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdr
    tghomh
X-ME-Proxy: <xmx:-ICgZ-3bcg9t7te2r3qmsDwXtGi0mki4S8yxjM-dDCM3lbtCbCyUog>
    <xmx:-ICgZ0FWPkY8KAMWgh-GfL3Wff3UliUDdxjB_mvz5oyV9-QyhFBHTQ>
    <xmx:-ICgZ_-720wM8D08Q_wZxNxbc4cOpHKYX9s-zdtGWGvhl3hWetBHjA>
    <xmx:-ICgZxm3Jwh3MsYShHFae8ZU_mekipbN2Zx3haBmB3lfqj-C31cVWg>
    <xmx:-YCgZ5MZHDVYcj_cFPIRX2BRY1Cp7JEfBuEHmYjhpH99Ua45HrqWYgxp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 03:40:23 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7430fe70 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 08:40:23 +0000 (UTC)
Date: Mon, 3 Feb 2025 09:40:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 5/8] packed-backend: check whether the refname
 contains NUL characters
Message-ID: <Z6CA9qCLwMnOsKxR@pks.im>
References: <Z5r6ZnLH3Ee8IQnN@ArchLinux>
 <Z5r7EkDwEsxuLJzn@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5r7EkDwEsxuLJzn@ArchLinux>

On Thu, Jan 30, 2025 at 12:07:46PM +0800, shejialuo wrote:
> We have already implemented the header consistency check for the raw
> "packed-refs" file. Before we implement the consistency check for each
> ref entry, let's analysis [1] which reports that "git fsck" cannot
> detect some NUL characters.

This paragraph doesn't quite parse. I think it can simply be left out,
as the remainder of the commit message already explains in more than
enough detail what you're doing.

> "packed-backend.c::next_record" will use "check_refname_format" to check
> the consistency of the refname. If it is not OK, the program will die.
> So, we already have the code path and we must miss out something.
> 
> We use the following code to get the refname:
> 
>     strbuf_add(&iter->refname_buf, p, eol - p);
>     iter->base.refname = iter->refname_buf.buf
> 
> In the above code, `p` is the start pointer of the refname and `eol` is
> the next newline pointer. We calculate the length of the refname by
> subtracting the two pointers. Then we add the memory range between `p`
> and `eol` to get the refname.
> 
> However, if there are some NUL characters in the memory range between `p`
> and `eol`, we will see the refname as a valid ref name as long as the
> memory range between `p` and first occurred NUL character is valid.
> 
> In order to catch above corruption, create a new function
> "refname_contains_nul" by searching the first NUL character. If it is
> not at the end of the string, there must be some NUL characters in the
> refname.
> 
> Use this function in "next_record" function to die the program if
> "refname_contains_nul" returns true.

Yeah, makes sense to me. NUL bytes are invalid, and nothing good can
come out of it.

> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index 883189f3a1..870c8e7aaa 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -494,6 +494,22 @@ static void verify_buffer_safe(struct snapshot *snapshot)
>  				 last_line, eof - last_line);
>  }
>  
> +/*
> + * When parsing the "packed-refs" file, we will parse it line by line.
> + * Because we know the start pointer of the refname and the next
> + * newline pointer, we could calculate the length of the refname by
> + * subtracting the two pointers. However, there is a corner case where
> + * the refname contains corrupted embedded NUL characters. And
> + * `check_refname_format()` will not catch this when the truncated
> + * refname is still a valid refname. To prevent this, we need to check
> + * whether the refname contains the NUL characters.
> + */
> +static int refname_contains_nul(struct strbuf *refname)
> +{
> +	const char *pos = memchr(refname->buf, '\0', refname->len + 1);
> +	return pos < refname->buf + refname->len;
> +}

This can be simplified to:

    return !!memchr(refname->buf, '\0', refname->len);

Ideally, we'd be amending `check_refname_format()` to do the checking
for us. But we can't without a wider refactoring because that function
gets a C string, and C strings are naturally terminadet by NUL
characters.

I think that adding a new function for this is a bit over the top
though, as the check is unlikely to be useful in a lot of places and the
logic is rather trivial. So I'd just inline the check into
`next_record()`.

Patrick
