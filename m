Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336BB4C6E
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 11:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709726400; cv=none; b=h3FUZAXj2nePeCfdjwAuJMPD2Z7CB5fjkdmT7avAJlS3Faq3XCJ5Oa1cfrNMPIqnhjSqar7vCFPYr0eQBG0lCUurboSS59oIv/vdGqfbg1RGNbWa4Du/Hjln18qUkJCV4xBYs1RRRjJrbRrGM17MzaLq5fmpT0gXCoH7VcJRAnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709726400; c=relaxed/simple;
	bh=fjOp/UfrFdMrAWgeVl1LF78O6z7ylMic2rIW+65QzvU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CF1O6G7oV63vM8jRScHw6/hQkZyAIVFIKot61F7n1Diwx+MLZw9IFOWy8sTTsHv3X+kxyXudd46udTMKvsMQqUtpFzbYsMXYVQvHe5zNJZI6MXqpm/43e+Ygo87R9Lfo6Ls/afF6FvfnrIb2K6SSSfEhLpd+4QwoRIjOU//l2as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bws/S3tA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WAko3rDM; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bws/S3tA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WAko3rDM"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5254111400BD
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 06:59:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 06 Mar 2024 06:59:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709726397; x=1709812797; bh=KFFIo4GB1e
	f0GQ6mhIa8HqV1cK7blEHATugSLuYxvH8=; b=bws/S3tA/Lm3BRCVhxgY0b2NjD
	+s1fOY3tEfGInMhkYNzLjZU/VvYbKun17lTH0556p58sei+hRqX/0/+V2quRxotg
	VkG004t8wCizm0l1OK+COTPh0dHLXuSgKXhC7cNy16uCzAO3ufQ6B0RRbsv1iOTk
	OXOYQPNFCT1/ptm73/qqt6SIkK+WQ/YEEfRsWZKbSbq7ME22/V6AwoIW/1A/8Wu2
	OsQ+65yqQ8ICZGEwac5/2E2EQb0SrbLEBtkgEbWIG8M38XaNPgiCitOdDXZ8UUTC
	Aqvcroa24wD9BcYd4iUg4X7FEZVPwU+2nk4vo9JMvlGDY2FEp8r8CtLCjw8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709726397; x=1709812797; bh=KFFIo4GB1ef0GQ6mhIa8HqV1cK7b
	lEHATugSLuYxvH8=; b=WAko3rDM/737UO/ilEE5zoUMEhmGg92MtW+aB5D/3IU0
	O9oh/Q8lI0066wwr8W47D8lT8U9b6SM6+u+NFqu0dajW1QAOVXvDAZkF04u4BBIr
	kxftyeAFc5yB9G1rWhmkoC/nhI3InIM+TL8FGjAAwlj2FBgt2xIYw6JfktkqyHbl
	CKmDsMcSkbwnU+/Lid/WKIttQkSV3oRPCFwdnZnDy5vcYwbjkqgvmeEiZgkhb3nM
	IuFeqHQ3lrw7hU+hSVxGKUQMjNhGAq4UeUz1l9es+KO6wRjK3RBThzNUyBKv8+FM
	0kqGgma0aE0pXVHriTCdmNKWDVCW/+HV93Y72T6MTg==
X-ME-Sender: <xms:vVroZevrChHhYIZ2CEmAnFvIMASuhy3E5utGV4NfyaI_9z9Ed84jng>
    <xme:vVroZTexNaAlB3cGey0Jrpr98VCVbP0wIBnYrqWd7Zap5hDCvhklVZad4nafK93QT
    xlauFwiO3Cby_WzRA>
X-ME-Received: <xmr:vVroZZw2KHzAxH0KCbLGEEqK6bEruopfQHxzyRkoohgBEy7TCms44YbAyGl4QyBdZIWMURDc71qHQqbSunJqkwIT56Ds0CW2KeIPZfdz7rbOifsNbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedugdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:vVroZZPU4uIXwgWeKjzZ8sJ-4lztFE2TBUH5QFrTFVTQA-WH2uE9OQ>
    <xmx:vVroZe9YWBNrAwOhjMpFCQzUSbGTaBesc_8zfPS02e9kqnBcVFhKRg>
    <xmx:vVroZRU0v1uxdMaDvlYP-BeI8oSThFlMnGE2jXcE0N71qF46f0oV1w>
    <xmx:vVroZUm_2kJ5w6lXZyrnVOjEvwXJXAoASo9VVlob9DIdQ1o-LPyd0A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Mar 2024 06:59:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5e18ae45 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Mar 2024 11:55:25 +0000 (UTC)
Date: Wed, 6 Mar 2024 12:59:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: Re: [PATCH 3/4] reftable/stack: register lockfiles during compaction
Message-ID: <ZehauDgP4L40QKcH@tanuki>
References: <cover.1709549619.git.ps@pks.im>
 <45b5c3167fbfd64d8d1e14ed55bae94cb9cba28b.1709549619.git.ps@pks.im>
 <mwhby7dxpiyrvknqe2uoli4ulygjy6hbxcxpqt3alw3dthwntr@4o24tp5jp6h7>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g9qOy3VTciGBVWj3"
Content-Disposition: inline
In-Reply-To: <mwhby7dxpiyrvknqe2uoli4ulygjy6hbxcxpqt3alw3dthwntr@4o24tp5jp6h7>


--g9qOy3VTciGBVWj3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2024 at 05:30:48PM -0600, Justin Tobler wrote:
> On 24/03/04 12:10PM, Patrick Steinhardt wrote:
> > We do not register any of the locks we acquire when compacting the
> > reftable stack via our lockfiles interfaces. These locks will thus not
> > be released when Git gets killed.
> >=20
> > Refactor the code to register locks as lockfiles.
> >=20
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> > ...
> > +	/*
> > +	 * Write the new "tables.list" contents with the compacted table we
> > +	 * have just written. In case the compacted table became empty we
> > +	 * simply skip writing it.
> > +	 */
> > +	for (i =3D 0; i < first; i++)
> > +		strbuf_addf(&tables_list_buf, "%s\n", st->readers[i]->name);
> > +	if (!is_empty_table)
> > +		strbuf_addf(&tables_list_buf, "%s\n", new_table_name.buf);
>=20
> Something not really related to this patch, but I noticed and had a
> question about.
>=20
> If I'm understanding this correctly, when a newly compacted table is
> empty, it becomes possible for a range of indexes to no longer exist=20
> within the stack. If this occurs in the middle of the stack, future
> compaction will likely combine the tables on either side and restore the
> missing index range. If the empty table was at the end of the stack,
> would this effectly reset the max index to something lower for future
> tables written to the stack? If so, could this lead to issues with
> separate concurrent table writes?

Very good question indeed, but I think we should be fine here. This is
mostly because concurrent writers will notice when "tables.list" has
changed, and, if so, abort the transaction with an out-of-date error.

A few scenarios with concurrent processes, one process which compacts
the stack (C) and one which modifies it (M):

  - M acquires the lock before C compacts: M sees the whole stack and
    uses the latest update index to update it, resulting in a newly
    written table. When C then locks afterwards, it may decide to
    compact and drop some tables in the middle of the stack. This may
    lead to a gap in update indices, but this is fine.

  - M acquires the lock while C compacts: M sees the whole stack and
    uses the latest update index to update the stack. C then acquires
    the lock to write the merged tables, notices that its compacted
    tables still exist and are in the same order, and thus removes them.
    We now have a gap in update indices, but this is totally fine.

  - M acquires the lock after C compacts: M will refresh "tables.list"
    after it has acquired the lock itself. Thus, it won't ever see the
    now-dropped empty table.

M cannot write its table when C has the "tables.list" lock, so this
scenario cannot happen. In the same spirit, two Ms cannot race with each
other either as only one can have the "tables.list" lock, and the other
one would abort with an out-of-date error when it has subsequently
acquired the lock and found the "tables.list" contents to have been
updated concurrently.

> > ... =20
> > diff --git a/reftable/system.h b/reftable/system.h
> > index 6b74a81514..5d8b6dede5 100644
> > --- a/reftable/system.h
> > +++ b/reftable/system.h
> > @@ -12,7 +12,9 @@ license that can be found in the LICENSE file or at
> >  /* This header glues the reftable library to the rest of Git */
> > =20
> >  #include "git-compat-util.h"
> > +#include "lockfile.h"
> >  #include "strbuf.h"
> > +#include "tempfile.h"
> >  #include "hash-ll.h" /* hash ID, sizes.*/
> >  #include "dir.h" /* remove_dir_recursively, for tests.*/
>=20
> Naive question, why do we include the headers in `system.h`? I assume
> this is because they are common? Are there other benefits to this
> indirection?

Well, "system.h" is supposedly the glue between the common Git codebase
and the reftable library, so all Git-specific headers should be added
here instead of being added individually to the respective files in the
library. Whether that is ultimately a sensible thing and whether it
really helps us all that much is a different question though.

Patrick

--g9qOy3VTciGBVWj3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXoWrcACgkQVbJhu7ck
PpQYVA/+PBRB40GcJRTGkK6SctV5bl0TP1jrdYTWAfmnYEGRO/fc4e0i1aqHXZTz
0DDu8uj1mZfCXofJPRbEq1diXqJUiFuiKwzIVCZXQUthC5UeSSWPBGyaav6HbQ54
grNSTxh+F4bCRy4PrnGQr6irzjR0mWZKvqMZuNT2GJq3G7RlAMy4bitww6VHrIYQ
D1tf+OfYi9BR3ww77drwHv8xsFcKhBVWLMubDE0exAFaOy6OGxW2k1HYEu1b/d5G
MQ7MQuP695XWt0MWZ20AWtL1nclC8Dc38KgqosdYJqKB9u5mQT7cPbPRczu9fqsC
Q9gAXQfmy8+AIdQjM6ZRyN6ni1flvn+py1oUpNcUQTGAfcV80U7HYiVEuf28ce34
zRaP1/gSLVWnBnANce+CHHxkVGiGpQmZdk6Is5g5244yP45p8js79uIyqJzpzT2Z
RYrJ4k0DcvufaTvwhwJPuiCmzjDwfAoxigRvmqtR9SBlY7kzdVFPZvTQ3QJ3mlfG
v0e8StMNFEhXSVfRTe+CnxHtLB5KnY63whtCopoDGoUv8I4SZ98+/Y6SrvWOfVde
b447m2uivyWI/TBCiGSbLFjH5qTYAZcKKDe3JlcAJz11RZAbqssVZ3xH7T1Wf+Xj
MsSvcQf0L+ziztE4yYRMbAz4EQdMemI1bSmHjsaSjNIaPJpI3Ss=
=Bdle
-----END PGP SIGNATURE-----

--g9qOy3VTciGBVWj3--
