Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9E71F77AA
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 12:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731414301; cv=none; b=VgQuAjeasdYt2gAYccTUrikf6x1oheGfJRjsDj7IH8Z+UE90nS1aEtn/YFSaAI8+9ytI89ysnJig8ZVxKB0DvioYowYBtGXocw33/x5ruE3LxBqfPiaI6N1+t6iJFXNQxrYCwitCr8kweeS9x9XuS9pUhnF3s5SiO3v+WjECIbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731414301; c=relaxed/simple;
	bh=Mzq6dNjUHgRzta2zzKGdQDn4tPd2Z2qZcTCwKOA6Y4E=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gGH4gkCqUrG2IUvwZXr2lZ8Bkvq+tmZcLO4A33ZIuw31mb4fXD9QtlPJW8+z7vS/YzfToVKCyjWRVCQn1zii/Ocw3mlBv2B4OrjPjMv2SSFxp5K0gHUqM9tFyD4Mx7/vs9O12mRuk2WEnUZqtswz5dDuhpnsMnqvM6yjghW3vdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ylGB/WJC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=N4ae/iLF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ylGB/WJC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=N4ae/iLF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ylGB/WJC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="N4ae/iLF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ylGB/WJC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="N4ae/iLF"
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D926C2128D
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 12:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731414297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Mzq6dNjUHgRzta2zzKGdQDn4tPd2Z2qZcTCwKOA6Y4E=;
	b=ylGB/WJCZCpdMWMzAE5Y+ruaBx8/gAmxBv0KZImdGVemK3/GuIELso6RPlYv2On5Bgwryp
	+76Pw65S25l3MgrlQ7JdSfMjjgkFfsNUFkswCgxTlvEZki3pYqOPzptCZRGw+9kdeLU84j
	BHVVge8oZlJNS2bsyAPTNxsSCEzVo+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731414297;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Mzq6dNjUHgRzta2zzKGdQDn4tPd2Z2qZcTCwKOA6Y4E=;
	b=N4ae/iLF4T/+aZyLnrzD6mJKcSRThplVwL+8KLyAdS7FCjhw+jiNwQU6MvQ5wugbkuVFhU
	mqld2Lyby3bQw5Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731414297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Mzq6dNjUHgRzta2zzKGdQDn4tPd2Z2qZcTCwKOA6Y4E=;
	b=ylGB/WJCZCpdMWMzAE5Y+ruaBx8/gAmxBv0KZImdGVemK3/GuIELso6RPlYv2On5Bgwryp
	+76Pw65S25l3MgrlQ7JdSfMjjgkFfsNUFkswCgxTlvEZki3pYqOPzptCZRGw+9kdeLU84j
	BHVVge8oZlJNS2bsyAPTNxsSCEzVo+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731414297;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Mzq6dNjUHgRzta2zzKGdQDn4tPd2Z2qZcTCwKOA6Y4E=;
	b=N4ae/iLF4T/+aZyLnrzD6mJKcSRThplVwL+8KLyAdS7FCjhw+jiNwQU6MvQ5wugbkuVFhU
	mqld2Lyby3bQw5Bw==
Date: Tue, 12 Nov 2024 13:24:56 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: git@vger.kernel.org
Subject: Shallow clone of a specific git revision?
Message-ID: <ZzNJGHMlxGQyFV_c@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Score: -3.29
X-Spamd-Result: default: False [-3.29 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	NEURAL_HAM_SHORT(-0.19)[-0.949];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Hello,

Looking through clone man page it supports shallow clones of branches
and tags only.

Would it be possible to do shallow clone of a specific revision,
and checkout specific revision on clone?

Thanks

Michal

