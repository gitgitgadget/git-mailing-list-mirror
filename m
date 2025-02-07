Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D598419340D
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 06:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738908989; cv=none; b=XF0X+LrQnvMV41asV30/PWL8lhfxz2MR7UGmefPONg06nmuHJN2EmIJR7pWJdmCyv7Ltc6kgGU/NtkGJ2hyAw+teYgDNoQbZYOQmebTGShwx9eS61aQOVGjgXHA49i03zvxEM0muNyGBaSMYY5MuoyCSTk5mIWCSiDakV/YFDok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738908989; c=relaxed/simple;
	bh=WWXUpWJokVHcRkGl0YML1AsH2OB9BC4XQc0fyG1DvPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEaUVO0Vnz3ogxfPHFxeF0LEhgli4ic/426OW1uzz6jAiCdgiWj0MfI6XGrYAZLj00T1HaTwmUgpI21B3g+HE661MnVpg2ifEROgEhQgfQcoXxJfHLYiiRbB+ej3TOGK5eleR182k0UDCyyZ61FN42Cl7NxKYcZ7/Jb/utkep8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SskYJ9pS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vz/oZylJ; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SskYJ9pS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vz/oZylJ"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id DCF9B138021C;
	Fri,  7 Feb 2025 01:16:26 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 07 Feb 2025 01:16:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738908986; x=1738995386; bh=ccjSgVXyQu
	ii1p9Cg+1Ia4NCSc+zvofhM5cQO8FoExk=; b=SskYJ9pSU/MbFaJDMkmyp2lqqG
	RWXKMZ67WGTqkAeb0zPIHiSmFPptSmeT+pskRuNqmdnoe6fAu0utv00x/1/SZf+w
	utYwOYhgzvRP19qcTXXPkoFR7yQF/+GuMKKnGFswX06Wo6iNHnBqstHKSuFVaLPt
	y7xgCXqd5KwgQzlO6Bfn06ZRDJvYkUxNg3V3v2G8L8RhcS9c3vx5DRM6JL66kzjF
	kuLLAVECT9VcO4iryHawD3VF7vRFoqfcRlO+8r60bT7kVkpZCmCVGSrILsLi1DS8
	8K5LqUGXifj1tBSgvftYGDi/dxAgb+3I+ZXTxi2aCM0DyhiqpzP9SzKRZeAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738908986; x=1738995386; bh=ccjSgVXyQuii1p9Cg+1Ia4NCSc+zvofhM5c
	QO8FoExk=; b=vz/oZylJlk9Qqmg5NnviOk42zEpQ0BjKFlaUCpq4u7vocMkoZpo
	wht8vn3T4Qz5+nwmxKoiRNikDhu54rNg7UV+hOFgkOPcSi6Y1pjSnkaxFZOysqi4
	2LXGGTUcbE6dVT8roEX+rpG3PaGGV9bMJi88QS4nycAYYJ/nvarfhZn07xXz/MFl
	GXk3R0nIbHYL0S0zIDltMQG8tvGeyJbL5GWycFeZu9RfO+pxg8xzkOtNFEQwm5sO
	tYwSFV/lDINCh+gwEtMPBflkK1XGKXBRX10cTinc7u+VJ3PVg1WH+6T87DmqNKEa
	vTmf2K7EUOknikwcVbRChpMln4zEiF3kCFw==
X-ME-Sender: <xms:OqWlZ6RvoRalr3J6sYoVfLIbr15gEa0j1gmp4_bszjvWi0MesHVJow>
    <xme:OqWlZ_z8LxidgHBT5x5q7cTmH8e8DOsKpFbsg1nVflaek6C0rCzzOQcxSxEanoLIw
    svTsNMMTY78FOkT_g>
X-ME-Received: <xmr:OqWlZ313aSEf2KUpqVFiJMTkJ6sKCyAiE8i0AGiKhon2T8wILITO4da4emDTDvjoGGw9Qdobcny61HSMVve-X1_W140wNRtZkUANhaxRqFXtV0Mn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:OqWlZ2CaYc1pI5mvo2Jnww41aK2R5nOrl3eITblHQcVLq0dwgV_dkw>
    <xmx:OqWlZzi_BPD3_wmRnyuRBVy6mSI4MOdzat-FszBmCndUb7HlPi4m4Q>
    <xmx:OqWlZypXWM5YAzVr6ky1wXlQ1-UeWjAH0AG8JmRoj-9wIy1eWhxXFA>
    <xmx:OqWlZ2hqQnOlo1yKqxUAGZG3Bqv_U3MqAluUJffP1b3S8VaHFsHw0g>
    <xmx:OqWlZ2t7QwsJEF2qOZANoqG_eOrh3M2Hvr_Vtd-uN3gv4GbpVUmGIHpQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 01:16:25 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a027e4dc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Feb 2025 06:16:25 +0000 (UTC)
Date: Fri, 7 Feb 2025 07:16:24 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 05/16] path: refactor `repo_submodule_path()` family of
 functions
Message-ID: <Z6WlONTM0lNaXTH5@pks.im>
References: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
 <20250206-b4-pks-path-drop-the-repository-v1-5-4e77f0313206@pks.im>
 <CAOLa=ZTJ7ef9rP3fQfNwSCD54zeVPL1Rd_hQfzDpEpFiStx_PQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTJ7ef9rP3fQfNwSCD54zeVPL1Rd_hQfzDpEpFiStx_PQ@mail.gmail.com>

On Thu, Feb 06, 2025 at 04:05:13AM -0800, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> [snip]
> 
> > diff --git a/path.c b/path.c
> > index d918d0409e..d721507be8 100644
> > --- a/path.c
> > +++ b/path.c
> > @@ -560,14 +560,15 @@ const char *repo_worktree_path_replace(const struct repository *repo,
> >  }
> >
> >  /* Returns 0 on success, negative on failure. */
> > -static int do_submodule_path(struct strbuf *buf, const char *path,
> > +static int do_submodule_path(struct repository *repo,
> > +			     struct strbuf *buf, const char *path,
> >  			     const char *fmt, va_list args)
> >  {
> >  	struct strbuf git_submodule_common_dir = STRBUF_INIT;
> >  	struct strbuf git_submodule_dir = STRBUF_INIT;
> >  	int ret;
> >
> > -	ret = submodule_to_gitdir(the_repository, &git_submodule_dir, path);
> > +	ret = submodule_to_gitdir(repo, &git_submodule_dir, path);
> >  	if (ret)
> >  		goto cleanup;
> >
> > @@ -586,13 +587,14 @@ static int do_submodule_path(struct strbuf *buf, const char *path,
> >  	return ret;
> >  }
> >
> > -char *git_pathdup_submodule(const char *path, const char *fmt, ...)
> > +char *repo_submodule_path(struct repository *repo,
> 
> To stay consistent with the other repo_* functions, should we change
> `struct repository *repo` to `const struct repository *repo`?

Somebody noticed :) But no, we cannot, we need to internally pass the
repo to functions that expect a non-const pointer. This is because deep
down in the callstack we end up calling `repo_read_gitmodules()`, which
modifies the repository.

I'll add a comment to the commit message.

Patrick
