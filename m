Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C2E1474D8
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 16:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726677286; cv=none; b=VupBH+ls0fVmordqGX9nPjGJ/qWO3B6ZH8+dJo63ixom7xmbISqkqAsW2HZiHyMjOkNvlEgUBiAZ7NOR4cFsyC68yVv/hLvsbeOgR4aGiv/bCQsn80BJ8n7AQzeNmS+7q5cnx833iyuU2+/7RY0K5cBURveD8g3z0ELleaTxpd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726677286; c=relaxed/simple;
	bh=dUo/SqQp4gVBlkAFeWHZPdPXEygQuxtw172exNrQDIY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WcWG7K6hsXS3Gr2vCrWnog1g3O3nJBA02yyozXIWzUajd4SEH1bgSwOKmEnuwzNesWatnPBV9xMbv2CfvYQd73hWL5QmJpvJzonk86CGcWYgIFSLMszrbHquBD7Ew1zfRa6H/08ffApKIzYbpqZ2yaK1rE0suIegD1MsTHp/Es0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jXkHlCOs; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jXkHlCOs"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EE6F330171;
	Wed, 18 Sep 2024 12:34:36 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=dUo/SqQp4gVBlkAFeWHZPdPXEygQuxtw172exN
	rQDIY=; b=jXkHlCOsoxejmH9b0KEdIqk+P6mE+B2GxXn/0bRohuDad9OHjIWTBG
	KTFh9Mk/K4bjrjG0WXU2iXm9BMyZCP1wqM0oT3hCq4WogsTnhntMSUPsOmUGGwgO
	wrfv3s9laBCtOtQB2QC4BaIilbE6rmEPqsdAjhCCywfQ5+a0dHZ5U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E56FB30170;
	Wed, 18 Sep 2024 12:34:36 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5DB633016F;
	Wed, 18 Sep 2024 12:34:36 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: Calvin Wan <calvinwan@google.com>,  git@vger.kernel.org,
  spectral@google.com,  emilyshaffer@google.com,  emrass@google.com,
  rsbecker@nexbridge.com,  mh@glandium.org,  sandals@crustytoothpaste.net,
  Jason@zx2c4.com,  dsimic@manjaro.org,  phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 5/6] libgit: add higher-level libgit crate
In-Reply-To: <honvpowfa6zze7p56pcefrzokjjawcc43du7vuxbdbjbv2vzlv@eskr2npegzxd>
	(Josh Steadmon's message of "Tue, 17 Sep 2024 15:29:25 -0700")
References: <20240906221853.257984-1-calvinwan@google.com>
	<20240906222116.270196-5-calvinwan@google.com>
	<xmqqv7z8tjd7.fsf@gitster.g> <xmqqcylcpnah.fsf@gitster.g>
	<CAFySSZBECCQafaLEv80WoK6SMovwC97-tf9gh_btPc+8OuP4NA@mail.gmail.com>
	<xmqqttene2ya.fsf@gitster.g>
	<honvpowfa6zze7p56pcefrzokjjawcc43du7vuxbdbjbv2vzlv@eskr2npegzxd>
Date: Wed, 18 Sep 2024 09:34:35 -0700
Message-ID: <xmqqo74kj4ys.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E485AB20-75DB-11EF-8259-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> We want to namespace types as well as functions, as Phillip pointed out
> in 47b18fa4-f01b-4f42-8d04-9e145515ccc1@gmail.com.
>
> Is there a reason why we need the shim struct from your
> xmqqcylcpnah.fsf@gitster.g and can't just cast directly like so:
> ...
>  int libgit_configset_get_string(struct libgit_config_set *cs, const char *key, char **dest)
>  {
> -       return git_configset_get_string(cs, key, dest);
> +       return git_configset_get_string((struct config_set *) cs, key, dest);
>  }

Not at all.  I just didn't see your intentions in the patch if all
you wanted to do was merely to flip names, or wanted to leave the
possibility to allow the wrapped ones to optionally have different
shape (e.g. for bookkeeping purposes for either the host environment
or the shim layer).  If it is merely "we do not want to expose these
names but we want bit-for-bit identical data", then you do not need
extra logic at all---the casts would be suffficient[*].

PS. I am not feeling well today, so please expect delayed and/or
sparse responses.


[Footnote]

* Building objects that go to libgit.a, partially linking them to
  resolve internal references, and then rewriting the symbol table
  of the resulting relocatable object file to expose only the entry
  points and data you want to show to the rust world to whatever
  names you want, would be a less gross solution, I would imagine.
  You only then need to write a (fake) public_symbol_export.h file
  that will never has to be seen on the C side, but to be seen as
  the header to describe that C library to the rust side (and
  obviously you do not need public_symbol_export.c file only to keep
  these casts).




