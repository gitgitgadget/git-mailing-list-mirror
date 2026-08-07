Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648E043CE50
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 06:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786084208; cv=none; b=Lu3yv0Q4mpbEKNaJyTzzDyQlz83/+ABf0aOV/igQT41uAx9Pt4sFW+qM3p/a6uoBS/maOzG3BKi9xm7dPwMCCUE/nqdgWF3Qu5DpRoSHLuQi150wPYFlzyIsDur9e1+QFn9bLs6Z7G6lITkiZJSkTMFV1mY9DJv6iz56ZjqlfNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786084208; c=relaxed/simple;
	bh=uzMIL6f8MqSVenqkK1M7zGpRKIaPBSLcGMh++QgeBT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BF5o/Gdcm+eoe63CDE2fQcMJN3UvxcUVHrFhSEwPJWAGOybYctoKHXLEbE5/OPkA0pyhRexqolfuT+fhSbhJPXNzl485FKiwVc8CFyeCegwElWIsj8iy4AFpOtk6azS2KOxRRL58d+p7gqmSpBCgaS6YvMwg2EX2GxwmFVu5udI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Iz/+d7AP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jCfZKId4; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Iz/+d7AP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jCfZKId4"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7C42E14000E5;
	Fri,  7 Aug 2026 02:30:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 07 Aug 2026 02:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786084206; x=1786170606; bh=d2k0QYov+N
	3HEQQcPORw1xFprrpdA9gL3Ngb15qtRnA=; b=Iz/+d7APGZGh5qF15XZB02yXl8
	HRosuyLLXnCrJnxWzsgUk31+/ipYmYEDSZco0TNKX2MmofrWb1d46/doyyEHNLk6
	8qSMpYSMRAbpWtQI5wOPjaOfX4LwWf6bhmctGZz3ctx159fbiWbj6Tdw03KlteHn
	qiuk6KLBvqucvlT/aIsiqqIfMt/VSAV48hJc25rMSsCpU1vxqs280fUxsiOSnmca
	MLTAVcNxkoqW0mLJ1lMv/MYK6iihAZVgiqskScb/QyttV99wHJ5O7mdowsb2QpUw
	oW6800JH8tqbLf9n/q7vZ91e7Cde0o2LkQ4is4pRSXNzsbcLVEvomMzZRTcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786084206; x=1786170606; bh=d2k0QYov+N3HEQQcPORw1xFprrpdA9gL3Ng
	b15qtRnA=; b=jCfZKId4q1nMNUqIuPuXNpnb9OGaj6bAvUg29sAxDPM0s4DmCGV
	2cKVfu2OYMxOj9ep4ODkKfxflmzy3rNCjWCdgjuBldrITauXW/8wEkHog1s3UFTe
	SR+PEEgiKpbkLMEQWPooNn53hfm40AtqqUfGoTg7/d/LqaeTcibeohgeP91NcsON
	QtVkXN7bsYT+SfsXwMEBHugrqbmhOdZrXHDDdFWAoHoWs7BxfIsBJ8PiShn4PRGb
	0QM4HR3NNy/4THsP+bqwHQ4183cJIZGynTDG9mKv8zzdPNPGOkNU5kGoEryQFjlq
	uCoQkOJNh0TWe2uVlm1xGuzg6DJsJs+bOXw==
X-ME-Sender: <xms:bXt1ajmTVJ4GnvWZ7W0n0oIN0qr619Eaiud4z6FDEpgv12fJcFZpYw>
    <xme:bXt1aryaYJqc7y9jj6CgqlCZebXt020GxC7KAQ0UHC-_Vt4a4trMYOAXZ706u6KnS
    BCWIaQw1U-37voP8xkTrxPJeemLXfHp7Z2PvUMnNvh--6AEXELZxcQ>
X-ME-Received: <xmr:bXt1at759rSa_6FUCQ4jtOS61N73NwZQmVViQxSBsdKQYiU4pvhdOtu4BhDceNq1jy6xvKVXXf-WrXkyDWuGiUQoDPtGneCD7gU42IOEdfpfWg>
X-ME-Proxy-Cause: dmFkZTGoeF9YasBIXoeD2USczDzi+WO9EPmHgoN0ywUyffC0frPcpeZ0cERpeacA4zJOSC
    fwOtUK6ivGDWVcRY1y7jifXq5Usk/KYUAf/TlxuAYVvlH5agHDrqOrX8kMcB9r7IMTTdnB
    IefQmgkHHoRdWnRNDBYCbIJ22c+sj0xgC58QRvq31ytyHEXuTNHbmi3cthroT56KNK0riH
    xMNBq0V8wBkCnJTl6PdPEl3s2zVmVDK6xkzybRhVfsRZTNa/T/0ZgJsuWiC8QsPkHJL3ac
    /OVsnEMBSSe8QrktoesB66vllZDvRBIfVIfh/BEumCiEglP5DeVwzQ4AA8HhkWLDjCqCfO
    zAFDNVhrDkMv7NakrdhQlk2f9gO1keipPJj2AAfTYtiiiQYsdzzFGI4UdI4YIJG8lmYfmp
    5qml6CLL0vR2WSj24YGkzKSNlyvtBzHzb1XMkkfUFM3sPgVapPN1i2LN/Yf+4oPIrZQHQD
    sHDCh+k6c6EHMmwe5lo1ZXDRWtMhtMOpAK3mz23PCFKmKexIJ3Ri8vorwaCJdMSlN7vwHl
    ukua0JyFwUoT3u4cp4a2x0jgYDzYv6PwZMTTJKjS4uaTzQgnYyh9Ki44OtolBZX7+ELZwI
    Iy5sWPW2b/KR578UCpnTnzZLsgaUm9UrxER1NtjXrX1JJ4h6B/8DDBfl5F5g
X-ME-Proxy: <xmx:bXt1arWN79-HJTgHYYZUOaWRyYSsaMYWvpoGVLGVZ1hKvpUHJvdj9w>
    <xmx:bXt1alLwMvRtbp6m3z1Ns1PcqTFwUKrqX46jf-QHlwkXM0Jq-Dn8og>
    <xmx:bXt1atvl_dxNdoznuCFd_JNQSjTJEc6s3KbowdH2N_sOGeFZ7Ner3Q>
    <xmx:bXt1aiLZJ3gB4BgRJEz3_4CVTTgDRrykug5Fkwlij8iKK7-BVzwunA>
    <xmx:bnt1aiFbQ_t1Jiw46h-HMSNRW_t_S5sBXJG-2PPnxDxt7J5HWXHJI1ut>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 02:30:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 95ffc9ad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Aug 2026 06:30:02 +0000 (UTC)
Date: Fri, 7 Aug 2026 08:29:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Sixt <j6t@kdbg.org>, Ben Knoble <ben.knoble@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	"Randall S. Becker" <randall.becker@nexbridge.ca>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Subject: Re: [PATCH 0/5] Reintroduce writev(3p)
Message-ID: <anV7Z1fmC-HhaNfy@pks.im>
References: <f8050598-392f-44c9-8d66-0454740a7a12@kdbg.org>
 <xmqqo6fso2s8.fsf@gitster.g>
 <anL0nIk6uzkYR9Oc@pks.im>
 <xmqqy0ekr0bm.fsf@gitster.g>
 <2952d9a7-c7c0-44c0-a321-7ddad6497a6e@kdbg.org>
 <xmqqpkzwpg1g.fsf@gitster.g>
 <8ff3c3ea-2604-4d65-8a7d-6acd6218b7c2@kdbg.org>
 <xmqqa4r0payv.fsf@gitster.g>
 <anQpop92SCAA2C9z@pks.im>
 <xmqqcxvvhu6q.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcxvvhu6q.fsf@gitster.g>

On Thu, Aug 06, 2026 at 01:26:21PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Wed, Aug 05, 2026 at 01:29:44PM -0700, Junio C Hamano wrote:
> >> Johannes Sixt <j6t@kdbg.org> writes:
> >> 
> >> > Am 05.08.26 um 20:40 schrieb Junio C Hamano:
> >> >> I think it is OK to explicitly document that any writev(2) emulation
> >> >> is allowed to be non-atomic, and it is also OK to declare that using
> >> >> writev(2) in this application to allow competing writes to the same
> >> >> destination is a bug.
> >> >
> >> > These are fine.
> >> >
> >> > But I'm not worried about current uses of writev, I'm worried about
> >> > future uses: "Look, we already use writev elsewhere. Let's use it here,
> >> > too, where we can take adavantage of the atomicity of the write." It's
> >> > too easy to miss a note about non-atomic emulations when the function
> >> > name advertises more than can be guaranteed. For this reason, I strongly
> >> > suggest to use a different name.
> >> 
> >> That is why I added the "it is also OK to declare" in the above.
> >
> > We could of course trivially restore the non-interleaving property by
> > only ever writing the first iovec. POSIX doesn't guarantee that the full
> > iovec is being written, and write(3p) is already non-interleaving. It
> > wouldn't even be less efficient compared to the current implementation,
> > as we have to loop around write(3p) anyway in our compatibility wrapper.
> 
> OK, by castrating the writev(2) emulation implementation to write
> out only the first iovec[], we are making the emulation "atomic", so
> there is no need to say "your emulation does not have to be atomic"
> and we can rely on being able to pretend that we have writev(2)
> available everywhere.  Also, it is a bug on the programmers' side to
> assume that their writev() calls will not result in a short write,
> so it does not have to be spelled out, either, which automatically
> means you'd better be calling writev_in_full() and not writev()
> itself.
> 
> I can buy that.  Clever.  It means we'd need an update for [PATCH
> 1/5] 1ed0bc4e3b (compat/posix: introduce writev(3p) wrapper,
> 2026-07-16), right?  The update would be a simplification that loses
> a lot of code (and overflow check), which is even nicer ;-).

Yeah, exactly. The overflow check I think we should keep though to be
closer to the POSIX requirements.

Patrick
