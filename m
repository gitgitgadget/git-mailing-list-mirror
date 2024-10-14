Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7230E1A4F20
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 13:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728912549; cv=none; b=NhRSYj2rZorGiSAJTx4r2h6d6DjnroqwsD/UoQGPOwVss2zitr2GwAhvoY0tWTAC9x3cbNLXT/o8XxdjDnMoqzv/Mrk9EZYc4EqH6d6JTsZjU58ReWu+qFml2UJPxeR8o2lLwqBaAWwT6PtpaAMOJ+eB8nUsFhdB70brbrSHzWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728912549; c=relaxed/simple;
	bh=JNxTN5ZiF8PX0nNzMF44n/BFwByboOj2RH313HRfq2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z8E9TzuiO9HKh26h/OU/rFewA9wmbNXiXP/3bwT4kVmYTweDFOTeWp8KaJ5OeuC+B/YG7RCZV/qyocDntfaaT2bElc5BTYD1T4XKgh4xA/RT2BU/Tl3kLFg/EFSV0zVijNociSwFqa+AEqA6gLHV5rPUKHJb8sUT9jx4J+iw+n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=eCfaKVkn; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="eCfaKVkn"
Received: from localhost (CSAIL-SQUARED.MIT.EDU [18.9.64.19])
	(authenticated bits=0)
        (User authenticated as asedeno@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 49EDSu9c010558;
	Mon, 14 Oct 2024 09:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1728912538; bh=aXgFKuWCMW3VB94sE8owU7btJ77uhxCD0NOlvt5Kyrg=;
	h=From:Subject:Date:Message-ID:MIME-Version;
	b=eCfaKVkn5DUTUXS5r2IbODQP7lHZgPo3BxR98TAFf1GmEralGHyII7GfhiMTOsHq0
	 Bqlv2QrKrQh43k0HpfyWOyu3QJ7ffmluaTzJvBZlzJOaVPzsls7mGyRzGnKDR8fRw/
	 lmcKno8ckHwIb4l/knjeXfUYuSyNyjny8xE0Dfb5FrvXrrs2x0vIw2iSQ+qg4o9gzj
	 fdaJKHHhjr4DKGacn05HdNIKRfGzt+qQHm3SCHk6FWir5mkqnSv6H06yB7lW/eDcLm
	 taE8nAChd2a9bIPJMfs37lFMK6CVzTP6WGaCgM6umIpQKh4bKMX5r0pWsS+/kqNUmF
	 scAU4wEE9Ikmg==
From: =?UTF-8?q?Alejandro=20R=2E=20Sede=C3=B1o?= <asedeno@mit.edu>
To: sandals@crustytoothpaste.net
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH 00/13] Update versions of libcurl and Perl
Date: Mon, 14 Oct 2024 09:28:56 -0400
Message-ID: <20241014132856.3558224-1-asedeno@mit.edu>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241010235621.738239-1-sandals@crustytoothpaste.net>
References: <20241010235621.738239-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> The Perl changes are a huge upgrade.  5.8.1, our former supported
> version, was from 2003.  5.26 has substantially improved Unicode support
> (including Unicode strings), s///r (to allow returning a modified value
> instead of modifying it in place), postderef syntax (which also provides
> better interpolation for complex expressions), and subroutine signatures
> (although these are experimental until 5.36).  These allow us much more
> readable, modern Perl.

This sounds compelling, however...

> The final commit introduces a small but useful change that we can now
> take advantage of with our newly updated Perl dependency as an example
> of why this is a generally beneficial change.  It can be omitted without
> problem if it is judged to be too noisy.

The change being made to illustrate the point is not at all compelling
to me.  This appears to be an update for the sake of an update, with
very minor benefit at great compatibility cost.

I'm especially opposed to the change in gitweb/gitweb.perl, as that
script is the one that is most likely to be used in a web-hosting
environment where the user does not have control over the version of
perl being used. And yes, those users would be better off hosting on
a newer platform, but that's not a good reason to break them with no
real gain for git.

-Alejandro
