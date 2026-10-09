Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DE935FF6C
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 19:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791572721; cv=none; b=TRzHt6/FoBRFW7q4uvRdjOghLDC1r/4ZBTLNyVGpODAuy8aLk0x3V2B6m0xLQN0K6V3Aq+NCzSGjLZ9JE5CfjUaGioA3gQaBdCcAlcfAZYXw5267KNO/zUNTsxY9SLDzdW5D2rJO96oVscHOB56S/rP4KGbdLmnldZL1NoLdOxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791572721; c=relaxed/simple;
	bh=Xm8bKs+9Ztrv/TM/WB62BDRiZ/ijO6wtGU65a4w/XLc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jnYzGDYKiHHAXbDg8jeJJS2TrdZk82/yt/e4PEnk4I0y2U9IJ0RKck0oX7LDqjzckkEkzv6L7wgqv+YQ5cvbekNThNwsPpx3p8XnUc0FH/sLngYH6NA8KAoeVk1WuhPmImG11HS5xZq6R/XaQe7tcUtVAEuOHuYX3KuDmjy0Qd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=msDlBCKE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VBlKrOa0; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="msDlBCKE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VBlKrOa0"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id ECCD41D000CA
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 15:05:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Fri, 09 Oct 2026 15:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1791572718;
	 x=1791659118; bh=Fm7IA+2gFk7DROkuayvG3HVRLYZ1HuGhVQlFksfZvdE=; b=
	msDlBCKE0ce8DQaRwIGp46b40fWlF8NVapF3tBm/SIqh/eiwuIrRwW//Ib3ft89F
	9Pnk8F95VSqaa7Y/tS2Ufzkx4Jx2qhl8inoHYOcFkPsHbv/5ww9ul3Qwif+jE2gl
	ZOtlhSCwhF1FMZ46wPckIlWMOxlFC3DHX9UmR9mCWrYiuGdm+Eajog0XcX2MjRrh
	Id1kOlhImv8gIKJyJnwGaBZP9N63vVuVSbt0Dmb5Qq1T1mjUWhCoO/5KroIqKhFP
	uKmRRAT3ERP25Mp99xvDNa54HoA3QaCWANPCbV34BZVuB3KyDIOMjI9dGnAq+hWh
	G1r2MpnBUZeLG42O16dlUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791572718; x=
	1791659118; bh=Fm7IA+2gFk7DROkuayvG3HVRLYZ1HuGhVQlFksfZvdE=; b=V
	BlKrOa04IglSfP7GqWG8WBCGR6eBYq8RKuS17CkOWgTw8cBJzsAVAWOTDSgHZXFG
	G+jcaCOYTgie1mfp2TzciF9KC3GEJf/Awh9V3+XdM+IIVKLShIT2tyDiuDDbptTz
	mMxSffgXep31t5youCnsKoVChbh0QEjVzyY4QydrqeO4PEA+CgHyKvkTApj+tGFS
	brGrSBkN6dRBIn/KzOfXl1u8Za/gmb67e3FygJHOD1PYAQzJy+1SIUIqH8kn99JO
	o9jQyY69SLwq1sevvQVKNTRmL2UOgvhO6i05XuWBVD+efEz14FiP8BImbJjs6B+E
	lkQ4AS2CoBoTEJcHqym/g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791572718; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:AG1MILGYq5GfE2xXKqRGdMiLqu2Oaxom13dumFPiJP43x4+
	bUCkKtY/LeQITdyLnl9ob1PG1jGKtc7lO9mHpG6YOyRM8Km5GQmgSRyP62WEhEbI
	Mm+5I+2ZZI2k816BxDD1hxtZANWwmAplPqR6XRAzVASVdwxZeLpRWzU4nGRV7wY1
	9v8QyGA4MOfP+A5aDfJdeRvTJG8L5OetxSCBVlSf96xs95KMlM7FbLywvRiEp+S1
	zJ+kLC3RhHnE8WfZsTNxYJE4cReiH98jJmo8XXhuPZ55dXNSitfVpNcxQK3PNHkY
	C683RuEV1P4R7EyES3nnsb+bCtz8xQL1gtKn0rg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:sv77+E8wmOuIuIcwr/gg99PW/7JGLtNGcwI7UREDsGs=:Xm8bKs+9Ztrv/TM/WB62BDRiZ/ijO6wtGU65a4w/XLc=;
X-ME-Sender: <xms:7jrJaulue4_C7iXnEdMOSKERrGHUvaRwqoIN-x8iCUoNIISQ9epOAQ>
    <xme:7jrJamledbBeoN8hsADuCNnw6K1pzeyaI88Lp9Wf7gxQdzG97uaOO0yjr4EPak8D_
    96M2aXaFNfSj_iSS0AqL9BdxiOb7BiQqwZocciP8IUkHYl0MkmCDJI>
X-ME-Received: <xmr:7jrJaoynxzqh1KSLB8-OsRtIxPCWzEwWJSEMHYqqcVFFaEMK03-ccoBaZIREnUMs7yex78Cvm9eKpf-UyH1Mby4FJzyMIPy1aCZ4>
X-ME-Proxy-Cause: dmFkZTEVPMHUQbsRDEiLEjjLCpCwxo1kD7UqZakUk5HNkX7hre+ED120yPq5SGe/u7vSfQ
    VzyqSjy2O/ivhQTpJbIvah92gj2iWAWJ9T28SJs2eVN0b7SomJHeaTdmn7qq8g1btJAI5Q
    /hWEre68v+6CaSsebrlc+oyKwC1Zpa3nVGg5vzdxnGG8bC0lhjtDlTMoCBrnKb8aLjwdKs
    KLaBckw5NSTCQB5LdDm8Otrn7rgoHxS06jVgSoYghki9hmQagTCvHV6whXipVYfHjM/fdd
    d0iZbnpCSh2iGHHThc8sChxdXYABQZepkcRZjEivvHDYODvcZkcGHdjXVx7knr4dkYB2lR
    8e+PxogVwJczjLSDEnCdtPFi3O5guIRWkwSV5RgFXyvmD6F518LInesx4ZGjY8xvDXuPTx
    FNtXDIVRMsz4KnsWH9K+TrNsQGC2FI4wEx/XGHW6fEPoMm4Y7Hh2T/5Or0/BEw/U327kex
    jjzn0Ltdccwe0SLIxsILZLYOOtsKwcVYGU8DfPT4epKeOKQRtFW1RPECPFOLiyMtBvOq7Q
    snuiwFqc2mp6eruPGvMsUB417zaXTMBuGUWZHzpowtfvbyBUWQBVVaIiqfGa4GdT2nXD3R
    2YiUz9vCWBXsVVMzn1SHmaHuqc7T0LKn2xaKYmMix0dxO5mfikxIotA7wfPA
X-ME-Proxy: <xmx:7jrJajqVolKQSfkzKboN8ep9pfYl4pZlQL9BM1d0mg40Ax4dztMG7A>
    <xmx:7jrJav6pkR3axylqXswzMiS3CRyDgbuwIRo6rt1VVIifaKbtKNzu_g>
    <xmx:7jrJaidxK1tiCCgKtrNetfHI8YVrBJhcfhyJTjaAND1Y_fRn0gi-UQ>
    <xmx:7jrJas6ly4lWeqo0dGks1mNHdaX2wrHzKA3fu0E5s9KRiwiW9KvZew>
    <xmx:7jrJasgX5GDkpYFA4iwJg6T8355oW-MY8FzjVddeRH-4ZpPFyWCdcdvS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 15:05:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?6YeN55Sw5LiA6IGW?= <kazumasa.shigeta@kanamei.com>
Cc: git@vger.kernel.org,  shabbir.r.bhojani@gmail.com,
  phillip.wood@dunelm.org.uk,  ps@pks.im
Subject: Re: [PATCH v2] stash: expose untracked modes in create
In-Reply-To: <CANUHOw3N+_yWnh7=2-5fD+XxgYC9-M9fqL8GEjfEC6kN+CD=gg@mail.gmail.com>
	(=?utf-8?B?IumHjeeUsOS4gOiBliIncw==?= message of "Thu, 8 Oct 2026 08:58:26
 -0500")
References: <20260929074222.11942-1-kazumasa.shigeta@kanamei.com>
	<20261001042155.33303-1-kazumasa.shigeta@kanamei.com>
	<xmqq7bk173qm.fsf@gitster.g>
	<CANUHOw1eO0HNjU+-PYNDOz9kHhBZYYfhiKJSX4082YSC1NKxww@mail.gmail.com>
	<CANUHOw3gynMRGN7A-wOnL3PQtgFbMtsB2gyZxaq+0Z5bHp-H8A@mail.gmail.com>
	<xmqq1pa4ksiw.fsf@gitster.g>
	<CANUHOw3N+_yWnh7=2-5fD+XxgYC9-M9fqL8GEjfEC6kN+CD=gg@mail.gmail.com>
Date: Fri, 09 Oct 2026 12:05:15 -0700
Message-ID: <xmqqqzhyoftg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

重田一聖 <kazumasa.shigeta@kanamei.com> writes:

> I realized that I had been treating two decisions as one:
> whether to introduce option parsing in `stash create`, and how much
> of what `do_create_stash()` already supports to expose now.
>
> I think adding option parsing and `-m/--message` now would be useful,
> even if we only expose a few options. That is because we should not
> need to revisit the basic parsing and message compatibility question
> just to add another script-oriented option later.
>
> That makes me think we don't need to expose everything
> `do_create_stash()` already supports in this patch. I now think
> we don't need to settle the public rules for other options and
> their interactions until there is a concrete need.
>
> In particular, I would prioritize leaving out options for which
> I haven't found a concrete request and whose interaction rules
> might make future additions harder if fixed now.

Stepping back a bit, I think the long-term goal should be to extend
the 'create' and 'store' pair sufficiently to allow script writers
to write their own 'git stash push' on top of them if they wanted
to.  'git stash create' does not have to be fully capable of doing
so with the current topic alone, but do you agree that improving
'create' in such a way should be our long-term goal?

With that future vision in mind, I am not sure I follow what you
said above.  Shouldn't 'stash create --foo' work the same way as
'stash push --foo' while creating the stash entry, if '--foo' is
not an option relevant only to 'stash store'?  Under what
circumstances does a '--foo' option that 'push' has (and for which
you have not seen a request) have to behave differently when added
to 'create', leaving a stash entry of a different shape from the
one 'push --foo' would create?

If the wish is "we want to start small because thinking about
each and every one of them and making sure they work correctly
is too much work for my liking", I would understand.  But I
do not understand how "we worry we may overspecify without
knowing the need" would apply to this particular case, even
though it is a good thing to keep in mind in other situations.

Thanks.
