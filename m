Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E513517BAB
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 17:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387556; cv=none; b=BJ1G2HvVjgO1FYplXv1Oxnh8Ma1GMAKzZ0u3WukM69hHMYF3p3lCzhcG+4F83Z3CwcbvJGPkeChi+NVNIevAKpK5fOdzQWwc6o3rf3z1h9vQN0zJSs4CVZy9+SkliqlwPMLO3pirdxJqOktPz5GXu5VjV/lq0cZDVJdD7xOb2KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387556; c=relaxed/simple;
	bh=PzUPSF8UqVgcRa4y7YraCJA6sVqD8CftE3FHkeiQenQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E6nqq99QhPDTnquZ0TV/5YgPxY8ujFM1Zbeobh0MDobRodnMTn8ZLJ170kw61QtXr9O78TPJK2kzby60Fd3YosEK1a3TlVXrKKn+adbKYeYdjMaFGKLMq85F8Jvww7kO4vTqSTCIDkVmxXY16HI4MIOfhhgLwT2/Jp/2NfON2Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=edzHloQE; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="edzHloQE"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C828F1E766F;
	Mon, 25 Mar 2024 13:25:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=PzUPSF8UqVgcRa4y7YraCJA6sVqD8CftE3FHke
	iQenQ=; b=edzHloQEfbXZXzkuIAqoSRrG1v3ranyclUav9k0WTp3WwVbRC71oS2
	3Xh63yPPHlFjIOVvPENKJJqp4SbQfXZgW8TsZuJMdFisTSOy/Yc+dPV5oDAES9di
	X3ni4Oz9fBDURZh//t6xIV3ND+0RkL1CqEcA+IKBZ9IoMDDmukjW8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BFA801E766E;
	Mon, 25 Mar 2024 13:25:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 299C71E766D;
	Mon, 25 Mar 2024 13:25:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dirk Gouders <dirk@gouders.net>
Cc: git@vger.kernel.org,  Emily Shaffer <emilyshaffer@google.com>,  Kyle
 Lippincott <spectral@google.com>
Subject: Re: [PATCH v3 4/5] MyFirstObjectWalk: fix description for counting
 omitted objects
In-Reply-To: <cfa4b9ce503e98035d3ce09b0c9e00bcfb6ff70a.1711368499.git.dirk@gouders.net>
	(Dirk Gouders's message of "Mon, 25 Mar 2024 13:33:35 +0100")
References: <cover.1710840596.git.dirk@gouders.net>
	<cover.1711368498.git.dirk@gouders.net>
	<cfa4b9ce503e98035d3ce09b0c9e00bcfb6ff70a.1711368499.git.dirk@gouders.net>
Date: Mon, 25 Mar 2024 10:25:52 -0700
Message-ID: <xmqq34semden.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BB506A1E-EACC-11EE-BA23-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Dirk Gouders <dirk@gouders.net> writes:

> Before the changes to count omitted objects, the function
> traverse_commit_list() was used and its call cannot be changed to pass
> a pointer to an oidset to record omitted objects.
>
> Fix the text to clarify that we now use another traversal function to
> be able to pass the pointer to the introduced oidset.
>
> Helped-by: Kyle Lippincott <spectral@google.com>
> Signed-off-by: Dirk Gouders <dirk@gouders.net>
> ---
>  Documentation/MyFirstObjectWalk.txt | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
> index a06c712e46..811175837c 100644
> --- a/Documentation/MyFirstObjectWalk.txt
> +++ b/Documentation/MyFirstObjectWalk.txt
> @@ -754,10 +754,11 @@ points to the same tree object as its grandparent.)
>  === Counting Omitted Objects
>  
>  We also have the capability to enumerate all objects which were omitted by a
> -filter, like with `git log --filter=<spec> --filter-print-omitted`. Asking
> -`traverse_commit_list_filtered()` to populate the `omitted` list means that our
> -object walk does not perform any better than an unfiltered object walk; all
> -reachable objects are walked in order to populate the list.
> +filter, like with `git log --filter=<spec> --filter-print-omitted`. To do this,
> +change `traverse_commit_list()` to `traverse_commit_list_filtered()`, which is
> +able to populate an `omitted` list. Note that this means that our object walk

"this means that" could be rephrased in a way a bit more helpful and
to readers with clarity, perhaps:

	Note that our object walk will not perform any better than
	an unfiltered walk with this function, because all reachable
	objects need to be walked in order to ...

> +will not perform any better than an unfiltered object walk; all reachable
> +objects are walked in order to populate the list.

Other than that, looking very good.

Thanks, both.

>  First, add the `struct oidset` and related items we will use to iterate it:
>  
> @@ -778,8 +779,9 @@ static void walken_object_walk(
>  	...
>  ----
>  
> -Modify the call to `traverse_commit_list_filtered()` to include your `omitted`
> -object:
> +Replace the call to `traverse_commit_list()` with
> +`traverse_commit_list_filtered()` and pass a pointer to the `omitted` oidset
> +defined and initialized above:
>  
>  ----
>  	...
