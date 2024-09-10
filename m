Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF2519412D
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 19:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725995666; cv=none; b=R5ncGtAxxWWgMbdqaDou2leFKQrthlJebFJWdblfuoDzP2QQDPb0zU/OsLeNpFvIvuU6uCMNTkI18fZj+gldJXJi7r4TAu9KRk7q79wz12O3fRMT8yo+3rFSY3pjgryCQ4DD5YUHq6D9Yae5xdAd5qh27SoTQ1Dv62xaJtBiUnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725995666; c=relaxed/simple;
	bh=QJgTVAzIPQudiF1pkgAEl89YkkfzoqzEyrVFDvlRizY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OPrP1b+EK3gEGz8kvrr6so967aQ4BZyk4nU/TGLV2G1PAhJTFb/UlSQ1pEz7UTbinApAXlJOokB2dU8GijQ+8BHN2J3jTZl+8x19XJFLhlTu07sw7IsGTDdreI7HEnH8LFlx98VM4daJkokZGQaOwsdWeRiKGy3L9NAhFlMiS3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=s4nT6htT; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="s4nT6htT"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7337F3411A;
	Tue, 10 Sep 2024 15:14:23 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=QJgTVAzIPQudiF1pkgAEl89YkkfzoqzEyrVFDv
	lRizY=; b=s4nT6htTn4RJ9jyJNZwKCRjEExtL7r9M5US6jMIum/1SPsop/0LagW
	JSiU0loPaZJz477qXedsFEYv4HS2TmLQCKv0HL67ZYSCYr6jOFy94KfJd2AqUA0C
	bscR7g5h0un+63BGSNoie4hVgMcS/l1DGhFqBn3KaB1DszpjCPMFw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6979434119;
	Tue, 10 Sep 2024 15:14:23 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CBAC534118;
	Tue, 10 Sep 2024 15:14:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Calvin Wan <calvinwan@google.com>
Cc: git@vger.kernel.org,  steadmon@google.com,  spectral@google.com,
  emilyshaffer@google.com,  emrass@google.com,  rsbecker@nexbridge.com,
  mh@glandium.org,  sandals@crustytoothpaste.net,  Jason@zx2c4.com,
  dsimic@manjaro.org
Subject: Re: [PATCH v3 5/6] libgit: add higher-level libgit crate
In-Reply-To: <CAFySSZBECCQafaLEv80WoK6SMovwC97-tf9gh_btPc+8OuP4NA@mail.gmail.com>
	(Calvin Wan's message of "Tue, 10 Sep 2024 12:04:37 -0700")
References: <20240906221853.257984-1-calvinwan@google.com>
	<20240906222116.270196-5-calvinwan@google.com>
	<xmqqv7z8tjd7.fsf@gitster.g> <xmqqcylcpnah.fsf@gitster.g>
	<CAFySSZBECCQafaLEv80WoK6SMovwC97-tf9gh_btPc+8OuP4NA@mail.gmail.com>
Date: Tue, 10 Sep 2024 12:14:21 -0700
Message-ID: <xmqqttene2ya.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E32FF4B2-6FA8-11EF-A332-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Calvin Wan <calvinwan@google.com> writes:

> However, I agree that the public interface should pass the
> compilation test and your approach does that -- will reroll with those
> changes and I believe that we should also fix the build.rs so that
> warnings also show up during cargo build.

Thanks.  I couldn't quite tell if *.c was supposed to be compilable
into *.o directly (if not, then Makefile needs fixing), and I am OK,
if the shim layer is only internally used, if the public.h defined
all pointers as "void *".

I wasn't happy to cast "struct config_set *" between "struct
libgit_config_set *" merely because one embeds the other without
adding any other member.  If they have to be bit-for-bit identical,
shouldn't we just use the real name of the struct everywhere?

The situation might become different if you address others' comments
like "why do we want allocation-only interface exposed?  shoudln't
it also initialize?" etc.

Thanks.



