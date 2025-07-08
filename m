Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5558B5383
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 05:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751951101; cv=none; b=ISaSkcK4IFXImOS6BauJiQMRhCbQEOhFUFuYi8p4xTN1o8PqOo1dFhxq0LyLRCz1ttkE8FbgLX5XKfKMOo1MbmvPYXEP8xhkul0n7y/4TVU/2u/cap8R5uPJelx1CzsClezaU8uKirYi3IRiItcseYpYYyDcw1iAzQyk6/33Cc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751951101; c=relaxed/simple;
	bh=PNaxKo6lBYHNA3onEx6R/gmQdUneOhFr/6lJlOypAtc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Un9eAQPQvP5SbtodJbpjuFsqkqCfULlRBYnm93+zwJ1Oiw7y1cdjwJC+fCbqimamZfsCM5TFyPEhX5WCnQIwwVkM1QUFJAvr2bDRmQptoRE1buSY2Ctw3oKpoVjHvArNxjeR0fzCdECZt0Q1tNt6/5y70pLvdOeIqcxjSAbj47E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Lc70ewNo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cVWSfvHv; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Lc70ewNo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cVWSfvHv"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id ADD96EC066E;
	Tue,  8 Jul 2025 01:04:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 08 Jul 2025 01:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1751951098; x=1752037498; bh=ej4l9hgF7I
	QALXvvTDeUD0GJiUNmwskrJT6616H8DUg=; b=Lc70ewNoNUQaEwMiErOJAaKynX
	aizezpweWiem4AHRmI/JLCPCc075GLhoZ4sHWKR6SdVhi852W78UBwjWlRSCM2by
	K4+5qm4h7IcElZDQ5FspZkJaT0INOjkO9fsu0P9lcYY7C1KKmcbQuDKSiUTS1hgF
	JJyy1zXT/GoH1WqVRtvN04A225E33mfbmiQOCyfbgFU4HeSDNpELgbGxK+CQv9Bj
	xmW2iqiuNZztAtFKX/AK41IrdhGdML7NJNJ5Lcw39LHkOISIvF2yUpRtOVOqWtnm
	qXg6fvD+3mhkJFuk55mDIO9jz2JmmehnX7vdC94qcRa24KObUrzrjoz2kMHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751951098; x=1752037498; bh=ej4l9hgF7IQALXvvTDeUD0GJiUNmwskrJT6
	616H8DUg=; b=cVWSfvHvHjHL/iKOSQIwpS6OupNmMXQKWumllvE5+ntdmtGQ6Bl
	qtsFCVttwjw5woZ2Da9Z5i3kJcfT8nz/ZGQRHhiX882okw6tKY2xXnTJ2tr8x4i2
	yOb7mDWekQeAzTTJI7cAbWt8If7HEHQ+xZxFO4I51WbUxhn2RDXpOZYsex3c1Nnu
	draQ+aQzrHjEsZQYp5s0yyZ9eWZPAM9PzKpE1hVPKtrpL+RqIqWKr1UJQ1AuxE6u
	x9T20eFP7oX47k5OWO8OdQwHmYNv+fWqLWD5eBbTU8cx5XyTygIOC684+Rwplv2z
	PzakXAlrf13pVB88+jxbrPnsxzhtXqqcyOg==
X-ME-Sender: <xms:-qZsaMqpRZHylVs9toiZPXSCqP2ybrJZh_pe_AJYzcOCfgwoYkOUhg>
    <xme:-qZsaF7P6lfYMxH3xcoD_5cYXR8zbNvYLT6Dx7fPRMEXT08_LOA0e9q-Ci8K3RQCZ
    cH25aTQmi7Z2Vmrvg>
X-ME-Received: <xmr:-qZsaKpCu_x4Ex0L-nuB8BLrbkH0yC_Im-kXGrgxgpZDtNTPtLUvdvMXTpL6g4Mh-fAa63OHCEA2OmlwfLoI-epvfsOPI1S-TYPn-2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeffeejlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeejteefvdevuefhtdduveehteffheekleeihfegveevhfekfffgvddvfeefveel
    teenucffohhmrghinheprghnhiifhhgvrhgvrdhfohhonecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprh
    hhrghnnhgvkhgvnhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-qZsaPiZuSRIgbag8jaM0Hi94pZ9FTtgmO4Mv9USgpEeqXG03Hw1tw>
    <xmx:-qZsaMLfjG6qOUcYwUrrZT6mdVpBVFfAGokB62SNINttEqPLs7Cjqg>
    <xmx:-qZsaHCbrpNDsgHOUhEBgWeIww8dz0zM3T50QraiAnFnlOlyXrze0A>
    <xmx:-qZsaEiPbY-5v7m11vvKo11fY3ICqZ5jWUTMREzqBNpg7khdZKPvFg>
    <xmx:-qZsaFehcMpt_mZDKz4ui2-nAOCwmLtOjkjrj8u-iMxHg6A0YX3dNyB8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 01:04:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Russell Hanneken <rhanneken@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/1] doc: correct doc for glob pathspec
In-Reply-To: <20250708024507.62386-2-rhanneken@pobox.com> (Russell Hanneken's
	message of "Mon, 7 Jul 2025 22:45:07 -0400")
References: <20250708024507.62386-1-rhanneken@pobox.com>
	<20250708024507.62386-2-rhanneken@pobox.com>
Date: Mon, 07 Jul 2025 22:04:57 -0700
Message-ID: <xmqqikk3xog6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Russell Hanneken <rhanneken@pobox.com> writes:

>   - A leading "`**`" followed by a slash means match in all
>     directories. For example, "`**/foo`" matches file or directory
> -   "`foo`" anywhere, the same as pattern "`foo`". "`**/foo/bar`"
> -   matches file or directory "`bar`" anywhere that is directly
> -   under directory "`foo`".
> +   "`foo`" anywhere. "`**/foo/bar`" matches file or directory "`bar`"
> +   anywhere that is directly under directory "`foo`".

So, the change is that the explanation that the pattern `foo` would
match the same as what `**/foo` matches, i.e. a file or directory
whose name is `foo`, either at the top-level or in any subdirectory.

Sounds correct.

Will queue.  Thanks.
