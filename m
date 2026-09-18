Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2287E497399
	for <git@vger.kernel.org>; Fri, 18 Sep 2026 07:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789715563; cv=none; b=kKplplMeRTQjPZjXWW2on1P0DWUvAowagTylkFqVGiJJSIGrqQbJO6tO41jQtBwacFL577xl9gx0KMVbTB84ms29eidS95q1tcJZ8nVx7ULjG9xA+adKTqkt6d24Fv2SXDCVl9vRtiJBgD3ho/xASfKiBoWrehrAdJ4wCY4iibA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789715563; c=relaxed/simple;
	bh=Qsr2UUS601iKubGUlSnAm0zn4LhYqy3+6FGVdGc9PTA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dKYuICm/mffesaBB+sMrfOWxbKzZQlG2PdfJGBw5A9ur8BjAf9O2yLZZey6n+U3LRQppTpgHKnGluYm06MlVA1Fj3tCsRdl5x7xMpS+EklyftyCTKQnAtMpO3vKVw54chKkcktUQNLp9Jt2Pk1LDzx7xEoXoFWie66mr1x0CdoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=K5EzUFlT; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="K5EzUFlT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789715553; x=1790320353;
	i=johannes.schindelin@gmx.de;
	bh=eKV6v1eQwqC9q0LhI0XW27nkoqkxvjo7pcfoQsNjeaU=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=K5EzUFlTMephc35WFXqBIk+NbRRV2+MxSrRegfGdyrEJrbq5T1d3axumEb96Lues
	 tpoJSxlGK9+2JR0DduQxnEzZ613TbyZ3EAbC9nq77dqUMqJbDG7bOrky49t3cNkuM
	 SK8XrZLQ9VGLYbzdkrEsVTEIMyZXgR+1Oc7H/DUClNfStOOGGi/fBbCJrzDnZMGOD
	 5j36YNQ1NZ05Ha5NQJPOI9jNeet9d334R28fqZ0rAg4aSfpfiqIlmenSUiW0y8IiW
	 3Jsgkgvs+NCnhQkcWRFZn+U6JOBc7k9L1140Y/Zjc5dBmnsOECl6OtTpMwNmI8Zc/
	 2ndnRmfcATieNpGiTQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0oFz-1wtFNU1GJ3-00vQtN; Fri, 18
 Sep 2026 09:12:33 +0200
Date: Fri, 18 Sep 2026 09:12:32 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 2/7] gpg-interface: make signature-prefix matching
 length-aware
In-Reply-To: <xmqqa4pfu11i.fsf@gitster.g>
Message-ID: <e20a33ef-181c-6dae-ce9a-8dfbc5d560b0@gmx.de>
References: <pull.2231.git.1789667556.gitgitgadget@gmail.com> <3fc7774ba867a10f35f7a74424baa4527f038232.1789667556.git.gitgitgadget@gmail.com> <xmqqa4pfu11i.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=832332829700015317897155541273
X-Provags-ID: V03:K1:MFDf0rnRDmq4Ah4DV750JhqhsqWlxp+GiI2sOS0jYBlVvq9NM4a
 ivUMPjlSAiQKOlCsl/CZwNYQgThjl5pxaP9K///rNs6hS3Ez+EAJ2YH5xlf2iku8BEqI6wk
 4qr1V4BepQxYn/Ula+VzBeuisu/bg+51JZVX9k8UGx7xWSyo2M7APvsCFtKP50WJ5obP0II
 rViOwd3O/4r9pZYUEMziQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4YrZrOeV7sI=;Rr7t9AGJPjD6JS/WtKEvS8kXnrv
 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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--832332829700015317897155541273
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Thu, 17 Sep 2026, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>=20
> > @@ -669,7 +669,7 @@ int check_signature(struct signature_check *sigc,
> >  	sigc->result =3D 'N';
> >  	sigc->trust_level =3D TRUST_UNDEFINED;
> > =20
> > -	fmt =3D get_format_by_sig(signature);
> > +	fmt =3D get_format_by_sig(signature, slen);

This hunk is a direct consequence of `get_format_by_sig()` gaining a
length parameter earlier in the same patch: it now has three callers,
`get_signature_format()`, `check_signature()` here, and the loop inside
`parse_signed_buffer()` (the actual site of the bug this series fixes,
Coverity issue with CID 1678690 if you want to double-check).

Once the function takes a (sig, len) pair uniformly, every one of them has
to pass a length, so this call site is not optional scaffolding; it is
what makes all three callers correct by construction instead of leaving
two of them trusting NUL-termination and one bounds-checked.

> >  	if (!fmt)
> >  		die(_("bad/incompatible signature '%s'"), signature);
>=20
> All the existing callers of check_signature() pass a NUL-terminated
> buffer which is <buf, len> pair of a strbuf.

That holds for six of the seven call sites: `commit.c`, `tag.c`,
`builtin/fast-import.c`, `fmt-merge-msg.c`, and `log-tree.c` (twice).
`builtin/receive-pack.c` is a minor wrinkle worth flagging: it passes
`push_cert.buf + bogs` ("bogs" =3D "beginning_of_gpg_sig") and
`push_cert.len - bogs`, an offset sub-buffer of `push_cert`, not that
strbuf's own buf/len pair verbatim. It still ends on `push_cert`'s own
terminating NUL, so the observation holds in spirit, but strictly the
pattern is "ends at some strbuf's own NUL", which is more a matter of
code-review convention across call sites than something
`check_signature()`'s own signature guarantees.

> Another approach that may be simpler is to drop the slen parameter from
> check_signature().

I would rather keep it right where it is, for (at least =F0=9F=98=8A) two =
reasons.

First, `slen` isn't new here: `check_signature()` has taken a `(sigc,
signature, slen)` signature since 02769437e142 (ssh signing: use sigc
struct to pass payload, 2021-12-09), three years before this series, so
dropping it now would fold an unrelated API change into a bug fix.

Second, and this is the one that actually worries me: `slen` is used twice
inside `check_signature()`, not once. Besides the `get_format_by_sig()`
call above, the pre-existing `fmt->verify_signed_buffer(sigc, fmt,
signature, slen)` a few lines down depends on it too (there it is named
`signature_size`). Both concrete implementations of that vtable member,
`verify_gpg_signed_buffer()` and `verify_ssh_signed_buffer()`, use
`signature_size` to decide exactly how many bytes to `write_in_full()`
into the temporary file that then gets handed to `gpg`/`ssh-keygen` as the
detached signature to verify. That is the authoritative byte count of the
blob being verified, not a defensive nicety. If we dropped `slen` and let
`check_signature()` fall back on `strlen(signature)`, a signature blob
with an embedded NUL before its logical end would get truncated before it
ever reaches the external verifier: a correctness regression in the actual
cryptographic verification path, not merely in the prefix-matching helper
this series fixes. `check_signature()` has no doc comment promising
`signature` is free of embedded NULs, so dropping `slen` would trade an
explicit length for an implicit assumption.

As the commit message notes, we have been down this road with this exact
function chain before. In February 2024, Peff concluded there was no
walk-too-far problem in `parse_signed_buffer()` "because we feed it from a
strbuf":
https://lore.kernel.org/git/20240208214137.GB1090198@coredump.intra.peff.n=
et/

But that conclusion was already four months stale: c8762c30df5b
(object-file-convert: convert tag objects when writing, 2023-10-01) had
already added `convert_tag_object()` as a caller that does _not_ feed from
a strbuf: the same gap this series closes. Applying the same "audit
today's callers and assume it holds" reasoning to `check_signature()` now
risks reproducing that failure mode a second time.

So I would like to keep `slen` and the `get_format_by_sig(signature,
slen)` call as in the patch.

Ciao,
Johannes

--832332829700015317897155541273--
