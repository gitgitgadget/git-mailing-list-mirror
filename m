Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC4D1CA81
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 01:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729646434; cv=none; b=rIGQCs40/3rp7P6XnnThwo1zMzO7RNua9y/nEp87hfxbCwB6wZCfwd220ZSf0gWDzbP6cYwfwzt4sZoWqQ59bsPlqAIo+Qb/yxFRPJ6+aNlP1qb6tnGSti1MXznKckY7y069TXk8vPPbHnxHUxOliF3oOn9DnwQi4kkc/muY5Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729646434; c=relaxed/simple;
	bh=EYcszAra0N+6riI9rR7/mtweGZhc+ZIJnCauD5iiiuA=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=h9w7+LdR80miLAj9ekdOK2HaCJ+VVbp1GU8XAWCD9UIGFXwpmZSwLlsxhRjbOSj+WpmjAlghP1SHiVjV7X65+lB3FnNUyS+zkxNEZI56Ajyy8QJKOkE6XcMaMjoOzlc2XwliArx/hWLni1HkwfpeDVB/DIgy4NEokiKcRMt0YVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 49N1F7DS3000207
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 01:15:08 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'brian m. carlson'" <sandals@crustytoothpaste.net>, <git@vger.kernel.org>
Cc: "'Junio C Hamano'" <gitster@pobox.com>, "'Taylor Blau'" <me@ttaylorr.com>
References: <20241010235621.738239-1-sandals@crustytoothpaste.net> <20241023004600.1645313-1-sandals@crustytoothpaste.net> <20241023004600.1645313-12-sandals@crustytoothpaste.net>
In-Reply-To: <20241023004600.1645313-12-sandals@crustytoothpaste.net>
Subject: RE: [PATCH v2 11/12] Require Perl 5.26.0
Date: Tue, 22 Oct 2024 21:15:02 -0400
Organization: Nexbridge Inc.
Message-ID: <010f01db24e9$00250e50$006f2af0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHAnR9StMNONYzAAmwEURVcWfNXrQEiTVpAAko++0KyrTKVoA==
Content-Language: en-ca

On October 22, 2024 8:46 PM, brian m. carlson wrote:
>Our platform support policy states that we require "versions of
dependencies which
>are generally accepted as stable and supportable, e.g., in line with the
version used
>by other long-term-support distributions".  Of Debian, Ubuntu, RHEL, and
SLES, the
>four most common distributions that provide LTS versions, the version with
>mainstream long-term security support with the oldest Perl is 5.26.0 in
SLES 15.6.
>
>This is a major upgrade, since Perl 5.8.1, according to the Perl
documentation, was
>released in September of 2003.  It brings a lot of new features that we can
choose
>to use, such as s///r to return the modified string, the postderef
functionality, and
>subroutine signatures, although the latter was still considered
experimental until
>5.36.
>
>This change was made with the following one-liner, which intentionally
excludes
>modifying the vendored modules we include to avoid conflicts:
>
>    git grep -l 'use 5.008001' | grep -v 'LoadCPAN/' | xargs perl -pi -e
's/use
>5.008001/require v5.26/'
>
>Use require instead of use to avoid changing the behavior as the latter
enables
>features and the former does not.
>
>Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>

Please be aware that the most recent version of Perl available on NonStop is
currently
5.26.3. On the ia64 variant, we will not see a newer version *ever*. The x86
platform
Supports 5.30.3 and may evolve. By the end of 2025, the ia64 platform goes
away, so
as long as we can keep 5.26.x as a minimum, that would be acceptable.

Thanks,
Randall

