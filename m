Received: from mailgate01.uberspace.is (mailgate01.uberspace.is [95.143.172.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3261C5489
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 06:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.172.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753423619; cv=none; b=bS6T9PYepV3O/zHkA0L3tkQkCVBSwE/rph6BIOBQZqTQnxg82O1Lr5LosRsO8DWzR2B695qMwUs30VrQx0hyRTN3IzkHJkpg+4dJq64t9nvMetv+WU4dPclRL/tB9E+X8GWVTmr0rFWf1nqMEVe7aaFmCwo0fC4TVS4hMoaTsBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753423619; c=relaxed/simple;
	bh=08LPZ//B61JnIijm2Fyw+OVuwDnXXDz367zAmQ1/fcg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kLKIQD1mekdC1rJCWh4vb07dPFZMCG3tWix+KNt2c0kexdEqatf2rlCgFhhAUSdD6OVsMAMymgVxsyQPj8MFDoVeeVC2XY9jA292NErT8GXjz8Vq8jiylCYhO7PV3WQBcCrerMTqPSxS4vGl+E9pX3ZlMIr5PXg/0gkoQh4HbAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=arnes.space; spf=pass smtp.mailfrom=arnes.space; dkim=pass (4096-bit key) header.d=arnes.space header.i=@arnes.space header.b=c2jsn38q; arc=none smtp.client-ip=95.143.172.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=arnes.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnes.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=arnes.space header.i=@arnes.space header.b="c2jsn38q"
Received: from machholz.uberspace.de (machholz.uberspace.de [185.26.156.167])
	by mailgate01.uberspace.is (Postfix) with ESMTPS id 308F860D22
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 08:06:54 +0200 (CEST)
Received: (qmail 29873 invoked by uid 990); 25 Jul 2025 06:06:54 -0000
Authentication-Results: machholz.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by machholz.uberspace.de (Haraka/3.0.1) with ESMTPSA; Fri, 25 Jul 2025 08:06:53 +0200
From: hi@arnes.space
To: Junio C Hamano <gitster@pobox.com>, Lidong Yan <yldhome2d2@gmail.com>
Cc: git@vger.kernel.org, =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?=
 <michal@isc.org>
Subject: Re: git-diff: --ignore-matching-lines has no effect on the output
 when --name-only is used
In-Reply-To: <87v7ngstc8.fsf@arnes.space>
References: <87a54v8nmz.fsf@arnes.space>
 <12095AC3-BC38-48DB-95B4-394F9F7DE054@gmail.com>
 <xmqqqzy6omul.fsf@gitster.g> <87v7ngstc8.fsf@arnes.space>
Date: Fri, 25 Jul 2025 08:06:53 +0200
Message-ID: <87qzy4st1e.fsf@arnes.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Bar: --
X-Rspamd-Report: BAYES_HAM(-2.097748) MIME_GOOD(-0.1)
X-Rspamd-Score: -2.197748
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=arnes.space; s=uberspace;
	h=from:to:cc:subject:date;
	bh=08LPZ//B61JnIijm2Fyw+OVuwDnXXDz367zAmQ1/fcg=;
	b=c2jsn38q7STHWKEvzgfYoPVE6C72OAW1MJqQCwi8xfZYbK5sMcNAjECgQm5S5WOZehUmyYfaAp
	X07SvrUSQF5y2ulTrvuxvSpaA82m8gp007eNTaBYaVO7qdXHl49WQI+kgkDoZujypSgd3I7ucrAc
	eytjL1WW8k8eGnSy/KPNOJwDgkXxro7wCAboaPRrVRuEnz/kLcGJmHaL7W62xSOLIyBSva3CsEd9
	BAT6mL83Utlx/1XMsvzVLBwPUXnCwvnozdFeGYv5mwO6mtYox65MkNcW4I7zvuOrC0j0AeMX7Spe
	0l4FB/zr0zlKT5xsdzZLq9pwLsDCuQ/tjQSU4p11Tq9lBBFjGNkLF3dJ4CZzCfBVUBxrw7xPKyNd
	Azdh+G2O8Hhnve4XQxFL9YLV+B9TEocLsZKSRzyK7O9PCID7mfQV13B37TkiAsynZedFC5cLzDDs
	0DsDitLXyQEI5pB5urZM5OGgMhBWgxye1LcNJ0GhFCLF9h8mgt/fqfPA84tO8Lo3hNUhb89e8KLG
	/VZj/ClFKExFQO7LRp8K3KvANzzsp8dlUXrk2W8t98CXigz4wYwUneIm3lC94yGHpBCjprgM29F/
	k6D29gvNfeQBYot1JDMdIO/wr9UmjHnRj0uWK/b7RbGW5AgN0k/uaVG5qy80QVBJ3sunYss1TbO+
	M=

sorry for the noise at the end of the previous message, please don't mind my cat.
