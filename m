Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D456372
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 00:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710202545; cv=none; b=GjFH6QjxPxgRS4jXRIyCtVHtvv6O4NINwkTul1YddNOBKSVjoVQDkPWRFIBgutHPGoeGsSBg7l4IzvvGmDiJSCqqSzF4Ht19FFETICJyujLuyOdUXg2RbICM9jBQww04au6NN4Escbcih0Y8D05n5gTwGXecCEODP7p1eGeU16Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710202545; c=relaxed/simple;
	bh=g05GLmo+EoFCYnX1bLgstXMdwUWVPgnSPrc6MWGonRA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M418ONxUo5OT9jOzXtOS02uOlBsN0LZivBHkeXt8uDRgBK3LM0hvvMYotmdEATaSrLnCdQfFzFfvEh5lf/bj0rNx7PBerqq9JzZDed3fpS9YwvEP5Cr341XXrhJT5JENxZ7TXiiZ3UANxWA8EZ9tnIHDAmgJ0b9r356oetXHZ0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Lt8Jm48H; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Lt8Jm48H"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id F1F3428F49;
	Mon, 11 Mar 2024 20:15:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=g05GLmo+EoFCYnX1bLgstXMdwUWVPgnSPrc6MW
	GonRA=; b=Lt8Jm48H1YgdU9i13jweGXwRetlz+qtyFRuKg46n3dxKKXOy7nN2YZ
	DyHAJOPRRqPrunmHQv7vnpX9y+i1d5L3OoK1WR+a4RvzAsLPH9VdzXH6Ex6rc0IV
	3h6JsL+JP9BdJ9uSqnJf02kZMkkzX7PSsIfDEdmOvL/7OgTHlRQJU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id EB72F28F48;
	Mon, 11 Mar 2024 20:15:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8681228F47;
	Mon, 11 Mar 2024 20:15:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Emily Shaffer <nasamuffin@google.com>
Cc: git@vger.kernel.org, Dirk Gouders <dirk@gouders.net>
Subject: Re: [PATCH 0/5] Fixes for Documentation/MyFirstObjectWalk.txt
In-Reply-To: <cover.1710192973.git.dirk@gouders.net> (Dirk Gouders's message
	of "Mon, 11 Mar 2024 22:36:13 +0100")
References: <cover.1710192973.git.dirk@gouders.net>
Date: Mon, 11 Mar 2024 17:15:38 -0700
Message-ID: <xmqqcys0mhjp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A8C00304-E005-11EE-85A4-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Dirk Gouders <dirk@gouders.net> writes:

> This series contains fixes for some problems in
> Documentation/MyFirstObjectWalk.txt that I noticed while working
> through that document.
>
> All patches except [4/5] fix real errors that cause comilation
> failures or don't produce the wanted output.
> With the fix in [3/5] I'm rather uncertain if it is correct and I
> would like to ask for special attention, here.
>
> For this first round I send separate patches in the hope that
> simplifies reviews and also, because the reasons for those problems
> differ.  Finally, those patches could be merged into one should this be
> more appropriate.
>
> Dirk Gouders (5):
>   MyFirstObjectWalk: use additional arg in config_fn_t
>   MyFirstObjectWalk: fix misspelled "builtins/"
>   MyFirstObjectWalk: fix filtered object walk
>   MyFirstObjectWalk: fix description for counting omitted objects
>   MyFirstObjectWalk: add stderr to pipe processing
>
>  Documentation/MyFirstObjectWalk.txt | 36 ++++++++++++++++-------------
>  1 file changed, 20 insertions(+), 16 deletions(-)

Emily, if I am not misremembering, this document came from your
direction, so perhaps you have enough familiarity to lend these
patches an eye or two to look them over?

Thanks.
