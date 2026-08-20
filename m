Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6223A784E
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 06:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787205686; cv=none; b=pVy5QWE9VxFU5tTTNhtoMPnisN1pybamv/tgLuXQCKF8foL7novAqnUqtp1w4nJfkmVeh+1iCI04Eg3u8Ty6AnsZGUlxpmLX0c1ImTS64bskWYyr/5Ffu15oZrSztX8lb2rh0EZ5SPXB0iG83cG9A7LtGR2I5UvN3NbHO71eq3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787205686; c=relaxed/simple;
	bh=MzRoJjUKaLWaNSr+VJr4TyEfbX81Gap39rfmnTvvdac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKA4W0s542le+5+TX7f1Z0h3gJbbDH7XpZemNbcOsSpjGNnZ/WI2z+50FAwpdq+FvgpjB/TU0Le1GjbGfw6Bi69DI8tDxAdh4csF1rwOEGyYI75B13pbTaWWS/KqElHn/oGTlBaAzvhpvTUpowsRxJRZ0Ycxo5mSe8qQfIJbzd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=G/1nVJuP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RfVsQt/A; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G/1nVJuP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RfVsQt/A"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 31512EC01A8;
	Thu, 20 Aug 2026 02:01:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 20 Aug 2026 02:01:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787205684;
	 x=1787292084; bh=Ln/dSL8/d7GXmdKHcKTpo5Vw+cL/JhIeIBsgCTePY1w=; b=
	G/1nVJuP8GwlpCUimY/hhEC9P7kMg3VXqQD/cGfc5vlv2hHjM1FlS9XhnSrLjjQu
	Q0lu6d7Em7d8Y7R/huqvHjIGde65tz377sAsYCHxtBm0hdnjNK40Gh0jh0xPPpK7
	pU3/X2AXb+JD/vgEYrjWl7fL79LMXYpY93gJ6MlYl5h8ZlVCldDW8c5fZqkCWneb
	cCAbzkn09agU/DLy3tLZBGmSj5xGmOP8hwQ43J4Le+4KtbC2dWtTRTapUh0gObnS
	tiSbDlgeNo6G/NSugl0gJNDn7alItADGca7CgoVNKgG7hbDsZiZVh4GmFuiWQTjK
	lElgclNhSWXQDJuku/mwsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787205684; x=
	1787292084; bh=Ln/dSL8/d7GXmdKHcKTpo5Vw+cL/JhIeIBsgCTePY1w=; b=R
	fVsQt/AiV/q0ccHVSTyV5w/f4hmaaKxNFKIBjTVkA36ZZ9VQyVUbWDxh0uJIQqqF
	5y5L8e/2fIS1clYVI+3yqoowuJAX4ab+khbmchVh+Q420a0KVABXQ6/IgBnhg4kH
	PXsPDe3UFTHc4qtfAg15ivp2Rxmj9e9xUSKRSCMD+Xr8aKkcv5obT4zwUafwcRjM
	x7QPN+ellpN5Jnaz0wqdfR34Ov99exxW6xX7hcmvjAyY9UK3CPCY6NX2U9uk2Zs0
	RoOU1B3I0HtkRLrQKr81cz/4nvuVNNfeWzGRzmWbepTEozaIJpCl8JikBoV/m4Ur
	okL1pKav8EtWl6wFQBEyg==
X-ME-Sender: <xms:NJiGapNUqO2kuc69wzM-Cuc2m34AfXrxSv9BZ6CxoBzeTtMRF4297Q>
    <xme:NJiGajYM_o-i57OtN8LjaEEFGtrKKa4PLattsVCdbCdQFjrYVi2WD1vjz_axQyYpF
    A4oAuDoESCT0RPcJDh4bymThg2iwpGnJABQvk2qh9nYFj3H1BFh_w>
X-ME-Received: <xmr:NJiGalq_adhTYQpIZK-sna-DoeJd_bXeVwh100za-rik-b5-8VDE0rE_XDSsjMmigQ3eeABW0NOR_yGiVdPF0o_knyy-z42rduRVEgZrOw>
X-ME-Proxy-Cause: dmFkZTGl21RZ9W4wSj4vgdlKjjGfEOBbHP4yz2Ve+/sUkMUlqfLxVRLETs+us7qxd9fl8y
    5V2B8cR9gsp0AUcaoAtvFwKl3TYawd9d7gWM5PBVnVkolsYO/bGGngPA9sUcKhdrjAIzDn
    CXchZm0kciyBvUfsBhu9UogMqbc6F+6sZ9DCh+TCAvXioJ6MCbprRLye3V7r5cz4Wjl50r
    3jzJ7p008nQeMNaNqWdGcgQjHHhZqg4GITJSRYLg/tXsNUdQwUs14QEW+Cl5cy4aH5kio/
    CroMflWVhPqkKTSijxXufpoBFcKy/+nVdlquBYxD+s1OkxOGVmWnVvanPnfcLwuzOWlqAk
    v1/9C4vu1Tv8a7xteYC1Lzv9cjtCGMTvLcmWbQEsfCW7NfmIyLeFdzYSiKgb5mnDwcCo70
    sbZHUiDIuYlYZ8JwjVe/PEwaoXNtcdQ6r5SbHiA2ldk2Aq/P7xMB3qdbfAykZQF8mL5FoN
    ivDJbHD7yv0mJakaOVvmDvmKuOt5yAm7GRrySIrF/TDVZhuOkXYu0LSByvrih46T95lmp/
    /reOHYrUSnrzvaE3xPR5yy9Bs8T8lQeYvA3cPX1/UHLP7KOEWayxeq92ZpImWBtjk07hxw
    o7tfvp7f+9Zs45WSqQ03C63FHL81TATwVmtl32FJoAyEcC8Q1XD7OuGcuiiA
X-ME-Proxy: <xmx:NJiGavbYs4Kziq2tsoW0KJiVkhrboJgyn6TzLOMEVo47P9MXbYbCfA>
    <xmx:NJiGalTgqfy-6kVGOJRgNMMdod9p4W0mU5s4Mid2IlI2VrPgz3TmKg>
    <xmx:NJiGau584eMV3GtQZGysuUclGfAu2o_x3KkEcL-B1Z9on4Z7NE9j4g>
    <xmx:NJiGaiwPe5qTFbZ3sy7Ocamz0fClJoPXwI1b6vALYb8lNz9OZZKwJw>
    <xmx:NJiGavbVqq2N9MkFnqtGvk8uqYjGaGPIa8SXlxjUjg9fCb7X8K0DWitU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 02:01:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 48d8e8a3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Aug 2026 06:01:22 +0000 (UTC)
Date: Thu, 20 Aug 2026 08:01:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/6] odb: introduce interface to generate packfiles
Message-ID: <aoaYL_BinFtgdJ5N@pks.im>
References: <20260817-b4-pks-odb-generate-pack-v2-0-4c8a96ccfdb3@pks.im>
 <20260817-b4-pks-odb-generate-pack-v2-1-4c8a96ccfdb3@pks.im>
 <CABPp-BG3_xvbXtt5BucyOy-dHXqX569d4FBfyZwbLiAb-qRPXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BG3_xvbXtt5BucyOy-dHXqX569d4FBfyZwbLiAb-qRPXA@mail.gmail.com>

On Wed, Aug 19, 2026 at 09:56:56AM -0700, Elijah Newren wrote:
> On Sun, Aug 16, 2026 at 10:40 PM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > +static int odb_source_files_generate_pack(struct odb_source *source UNUSED,
> > +                                         struct odb_pack_generator **out,
> > +                                         const struct odb_generate_pack_options *opts)
> > +{
> > +       struct child_process cp = CHILD_PROCESS_INIT;
> > +       struct odb_pack_generator_files *generator;
> > +       FILE *in;
> [...]
> > +       cp.clean_on_exit = 1;
> > +
> > +       if (start_command(&cp))
> > +               return error(_("could not spawn pack-objects"));
> [...]
> > +       CALLOC_ARRAY(generator, 1);
> > +       generator->base.out = opts->pack_fd < 0 ? cp.out : -1;
> > +       generator->base.err = opts->progress_fd < 0 ? cp.err : -1;
> > +       generator->base.finish = odb_pack_generator_files_finish;
> > +       generator->cp = cp;
> > +
> > +       *out = &generator->base;
> > +       return 0;
> > +}
> 
> Does this have a use-after-scope bug lurking here, due to the
> combination of clean_on_exit = 1 (which makes a copy of &cp for later
> use), and the fact that cp is a function-local?  If I'm reading the
> code right, start_command() calls mark_child_for_cleanup(), which does
> 
>     p->process = process;  /* where process is &cp */
> 
> and then cleanup_children() accesses various fields under p->process.
> You do copy the necessary fields from cp to generator->cp, but
> &generator->cp was not passed to start_command(), so p->process points
> to the function-local cp.

Oh, that's a very good catch indeed. Out of curiosity, how did you end
up discovering this? Did you just happen to remember that we store the
pointer out of scope or did the copy make you have a deeper look?

> I think the normal teardown path happens to be fine despite this
> issue: when odb_pack_generator_files_finish() calls
> finish_command(&generator->cp), it clears the child by matching pid
> (which was copied separately from p->process), so the stale pointer
> never gets dereferenced in the successful path.  But with an
> abnormal-exit, which is where clean_on_exit comes into play, then
> cleanup_children() will be called and start attempting to read
> p->process, which now points to some long-reclaimed function stack
> space.

Yeah, it's a bug waiting to happen. Will fix, thanks!

Patrick
