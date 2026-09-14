Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44A943DA4B
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 13:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789392214; cv=none; b=EgzXLsqqqrXc9Xkh/1ViDauWlSBQNlCIzlMUPVMEscqa46TnOaYXytQZa6AwoxRqWgTN4gfkqYostS/kythsOC0vh8OF7WhDs+ZFRiPvj0rJda0wg+W71lf/imi6N/7RvsFnzQyfGz8X5wJmAIVt1iKFoxizb7jvFNUGnt6xsGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789392214; c=relaxed/simple;
	bh=Ncb31QXNc8sIS9zZhVyNkLdH5Lk0UvPWj6K3ibOgFi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSbGp4Iw/NxXj1is9G67fvRBOnaxKRJisC6qZS7rlS51OByI6nDGYMJnTsi+MZ5d6g2dHAKrxLfn3285uUe/wqNPo1OCzXoDloygQWmMzLMM16CRcn8dKfp63iKTdnhEbujhEdOO3Y0opL0dYb/3YaSRQy4Qt03845w/9paRNj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M/XJFF89; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M/XJFF89"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccfd61ecaso19534975e9.3
        for <git@vger.kernel.org>; Mon, 14 Sep 2026 06:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789392211; x=1789997011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ncb31QXNc8sIS9zZhVyNkLdH5Lk0UvPWj6K3ibOgFi8=;
        b=M/XJFF89hj4gCsIbhlTdBF4p1RiTO6QBWo8YofsPGKxe1hBXn8oVuSdzIIw/Myofqm
         sEfwLlFIaEMJHoH5Xcl7JnKcCcMsDVkYhn6h8JPNXGGZ+RzCksVCFoiuwDUL6M9ujBGv
         iwCh4OfDBZJi4Cjbf9eW5rLv0QL2qdx8vqxdKc36pVYY0SIgvPGk4x9Xmg1/IMVfRYxc
         mUsNuENkQ7q4N7m119TsUfPxyVwt4ac76BkncMY5XHFvA7MsPeO9nS9vTqeg9lzX34jz
         6JI7sWslK3ffF3RZ1nWmVlN0U+lzHoWdZCXScsem/ZR9N8qxzJ9A8s4XR+mqqjgIYVtq
         PYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789392211; x=1789997011;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ncb31QXNc8sIS9zZhVyNkLdH5Lk0UvPWj6K3ibOgFi8=;
        b=VrWQ43axg7dAR78me1Hv90f6/s/zzT7CQUcHW66x6sExbcVPQ9/px0EUMuCSwOPPyo
         EpCjjsjMcTwrzG5R7IGIbIInyXO3Jixgsn02FWTlr4LgsyKerFxIaUHMY34IiiL0RY1i
         zQONt7GPt5ORqWr/u9dwMp+wlw99azIHdKU/q6y/LnYomCBGemcH/nHEC9o2iFncqs1X
         Y2Cfnso0TFxUv6zY51pHvpjgqyxMwIn/S5QWEnAmhNBdc2qNcxYc5zPfnZM4G9Xk1EU1
         PMNfOGikuDPbU4oLn72V9qa9zrfD9BeF+GSF3X1OuHqYTlnB84klpb8ePnfmtfG1o804
         TRKA==
X-Gm-Message-State: AFuF++ku4JsTmVS59MdChvldPrim0nuLnBfwYFcVuLtiIgtZ1TR+xIb1
	FaS/8nV4+4OTGqwRfdmV8PsEt+StDhu97s3AKpSx9YThijOsNbzcqjALT1xgDQXKlANc09g3BZ5
	elib5W7g=
X-Gm-Gg: AYBFou2pl3wDZDlU8UGkoI7Vex02xrPkmNOvluawNwf3Th99L3rIHuBqrs6f8fgLy33
	ndJMHN+XnBMHCBZfi3Gvbg0ByF7GY9MMD7RZj3hJz/kd1rjta/R9NTxdGnpN+wPNViOmcGVoRxP
	VUZTu5CHefafn7ssl76npPqvPffIqi2pq1lEEAG/HsNK4qvtY3UOBCcGD6PFLpiMiA0Jydnbf/l
	hiDPO1Gi5XnZFD6cPDbvdXWDt70L8XGqVbIaa4BMXLdYBdZF1if+3zlBZJn7cIXp0YK4e/7NSTZ
	JjcuCHwfAX53U3F+ql8Bx9kK7PeawPkmiJAJEFV+b0uy8k1vzUanXlp3aRBlLlXM0eEzCH2r74e
	oAwZAcKL14I1Bdos6EH0Fg05Th+u7hF7AaQJJP3Rt+zFKvKSgAdfx2DopVD+/smLnjKGpT4vBRg
	wnP6hAgL91wjm3/zK2GSvjxkvnDFP52p9jc+QFMyi7umY+Ouyz0RQWsONddSLFyHfmVorPMsSbC
	g==
X-Received: by 2002:a05:600c:a015:b0:49d:1f32:c911 with SMTP id 5b1f17b1804b1-49e7a65ce8cmr32511085e9.3.1789392210823;
        Mon, 14 Sep 2026 06:23:30 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7d27c88fsm269415e9.2.2026.09.14.06.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:23:30 -0700 (PDT)
Date: Mon, 14 Sep 2026 15:23:28 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Jean Delvare <jdelvare@suse.de>, 
	Elijah Newren <newren@gmail.com>, Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, 
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 0/3] merge-ll: Cleanup merge driver temporaries after
Message-ID: <aqf0fw2igdjsXe-V@localhost.localdomain>
References: <20260910150608.1867930-1-mkoutny@suse.com>
 <20260910162242.GC251185@coredump.intra.peff.net>
 <aqQN_Q6ZAeyTy7WA@localhost.localdomain>
 <20260911171044.GA1609692@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ehlzwpsyjpdjhgyw"
Content-Disposition: inline
In-Reply-To: <20260911171044.GA1609692@coredump.intra.peff.net>


--ehlzwpsyjpdjhgyw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/3] merge-ll: Cleanup merge driver temporaries after
MIME-Version: 1.0

On Fri, Sep 11, 2026 at 01:10:44PM -0400, Jeff King <peff@peff.net> wrote:
> On Fri, Sep 11, 2026 at 04:43:08PM +0200, Michal Koutn=C3=BD wrote:
>=20
> > > In the worst case we can just call register_tempfile() on each path, =
but
> > > I think this code could be taught to use the actual creation. Somethi=
ng
> > > like the patch below (only lightly tested).
> >=20
> > I've tested it and it works (cleans up both after SIGINT and regular
> > termination).
>=20
> Thanks for testing. I considered putting something in the test suite,
> but it gets ugly (we'd have the external driver pause, signal a fifo,
> then kill git-merge and it with SIGINT). I guess an alternative would be
> setting GIT_ALLOC_LIMIT to something low, and then generating a
> too-large output, which would cause xmalloc() to fail, which I believe
> would also fail. But then we're not really testing the signal handling.
=20
> Hmm. I wonder if leaving the files could actually be a _feature_. If you
> completed the merge with the external tool but we barfed reading it back
> in, would it be useful to leave the file in place? It's possible, I
> suppose, but I think it is more likely to be a nuisance (and we already
> delete it for things like read() errors, just not anything that would
> cause us to die()).

=46rom the user perspective, this is unnecessary. (Potentially useful for
debugging the merge tool.)
For the former, the whole merge can retried (after restoring state), the
latter is quite rare and can be worked around easily when the merge tool is
under development.

0.02=E2=82=AC,
Michal

--ehlzwpsyjpdjhgyw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaqf1OxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AhROwD/UMuRm2++p+Fb+KCPk4FB
mc+zLdfU/Hl7b7255fOyR6kA/iLMsYtayISR1eROvoVZ/tl+LQ8UfqnhdVRj1jWY
B9cL
=SEoK
-----END PGP SIGNATURE-----

--ehlzwpsyjpdjhgyw--
