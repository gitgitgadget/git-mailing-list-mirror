Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26D25D8E4
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 20:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707684616; cv=none; b=XKgVhOdLqidrbzOVE3PdmcvnTLD5IyfX3g0SLOQQ3YEGGwupaOjjqWvuRKBsgx5gkOsUa9dhdJljs9H4MSddS3krmQ6XV2Tuh8ZmKryYQG5hx4hpu482r1l/HRCzeq0Ldm2iwxqt93MgtwnUrg2nc4DccUl932D17xdJA6bFQ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707684616; c=relaxed/simple;
	bh=PVJGD8+md099uAjoLSnhV7IVMiTL+nG3MNe2Y+R6KRc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZFV+91dtdNq8TiPQwRbd9wCj0faru5a8telH4Cmh4Lek93XTILw1ZB3aQOriwc0J88NCL8vi3b4Dz6qVjVa0napGN73Xj6w5+xWpUjETNc5O79sng2+kEAAMJn/4cYPGf5/FjdC4NeFu2y/anAEQoWJDienV4zs2DNij+no3/Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=Hp4p1aca; arc=none smtp.client-ip=212.27.42.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="Hp4p1aca"
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:c2d2:c7d2:a4cd:bda7])
	(Authenticated sender: jn.avila@free.fr)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id 435BE13F838;
	Sun, 11 Feb 2024 21:50:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1707684606;
	bh=PVJGD8+md099uAjoLSnhV7IVMiTL+nG3MNe2Y+R6KRc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Hp4p1aca/PblIbbEo1P64tAxE213To0BfKA8OoTVV/ZNITXa3bb4LdwV0UwTGH980
	 RCZkKEd7ocW8wmDQpZNNvIyuQpHuGdQo7L4r0R7rotHvdEKXfEgRtcGZ1WtRiUx/Rw
	 fEMipqgNpNOnc8VENKuzk8IluNBcTrFyByelKAOfJ+eKDT5hmcPEu+uyev2MRvvYqi
	 1no7kWYsgfHpt4xk6jz9pIjGRnRDdKJpwMIemlvI4MpU896B1q2CjJvGe3Qph+HAJq
	 +xAxo0oNiGjbiH3oIL1/H6rv3p9HKbwpaLJNzOXummc9jSc0I8K7SxZX+FUHFIsyQX
	 9PjFoLcK7sT3A==
From: =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To: git@vger.kernel.org, Brian Lyles <brianmlyles@gmail.com>
Subject:
 Re: [PATCH v2 8/8] cherry-pick: add `--empty` for more robust redundant
 commit handling
Date: Sun, 11 Feb 2024 21:50:04 +0100
Message-ID: <2345401.ElGaqSPkdT@cayenne>
In-Reply-To: <20240210074859.552497-9-brianmlyles@gmail.com>
References:
 <20240119060721.3734775-2-brianmlyles@gmail.com>
 <20240210074859.552497-9-brianmlyles@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hello,

There's a typo.

On Saturday, 10 February 2024 08:43:56 CET Brian Lyles wrote:
> +--
> ++
> +Note that this option species how to handle a commit that was not initially

this option *specifies*

> +empty, but rather became empty due to a previous commit. Commits that were
> +initially empty will cause the cherry-pick to fail. To force the inclusion of
> +those commits, use `--allow-empty`.
> ++
> +
>  --keep-redundant-commits::
> -	If a commit being cherry picked duplicates a commit already in the
> -	current history, it will become empty.  By default these
> -	redundant commits cause `cherry-pick` to stop so the user can
> -	examine the commit. This option overrides that behavior and
> -	creates an empty commit object. Note that use of this option only
> -	results in an empty commit when the commit was not initially empty,
> -	but rather became empty due to a previous commit. Commits that were
> -	initially empty will cause the cherry-pick to fail. To force the
> -	inclusion of those commits use `--allow-empty`.
> +	Deprecated synonym for `--empty=keep`.
> 
>  --strategy=<strategy>::
>  	Use the given merge strategy.  Should only be used once.

Otherwise, documentation looks good to me.

JN


