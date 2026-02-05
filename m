Received: from vuizook.err.no (vuizook.err.no [178.255.151.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0581A76BB
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 04:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.255.151.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770267329; cv=none; b=alUvXmfCyAdM86bxbMw6OxUcYOQdrlRBJfLv4LfV9hr5LPe8fyj2MNahZjkC+RHBT0esRkf8kxDRnrBfVzD/+hFpv/VMSYEETmvxI0BZ1oSQ6KEzKgHNt9qnSB0iyCNQkij1O1uqtGaj42iMKIKh+oxvlOyrLBKVU0EKeqVjo5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770267329; c=relaxed/simple;
	bh=3G+riXJfjpyw79PngTYcJTPzV7fZL06H0/Gezm+tltM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+33khBKqN+5e6EBe3Q5142/Q3nPgxJLo5qPqaPXpec1IqDs6PMh7QiT1YIBaM2ntOVyKstV/j9dRUR4qAle0DTrA73brQZcfMBDcSNWlvWT3Kv+CyShbs35+zQR1zfWIqzLkiQHVOFvZJddXOtzN4Od6QBa+m7vWjTBz3mw1iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org; spf=pass smtp.mailfrom=glandium.org; arc=none smtp.client-ip=178.255.151.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glandium.org
Received: from [2001:3b0:22:ba05:3c99:5d75:c899:ae5e] (helo=glandium.org)
	by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <mh@glandium.org>)
	id 1vnrOm-00000007bNq-2yos;
	Thu, 05 Feb 2026 04:55:25 +0000
Received: from glandium by goemon with local (Exim 4.98.2)
	(envelope-from <mh@glandium.org>)
	id 1vnrOe-00000007xlu-3IbH;
	Thu, 05 Feb 2026 13:55:16 +0900
Date: Thu, 5 Feb 2026 13:55:16 +0900
From: Mike Hommey <mh@glandium.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, 
	gitster@pobox.com, ps@pks.im
Subject: Re: [RFC PATCH] Move rust gitcore crate to a different subdirectory
Message-ID: <nabuy27x5sqyp5sjselp7lbxqnvov2mtemvke7geucn6a2ixg2@62s4t5gkhsdo>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
References: <20260204232208.1615320-1-mh@glandium.org>
 <aYPf9CnNLjJtinqw@fruit.crustytoothpaste.net>
 <5h7fs4smilvvuqyry4uef3rjgky5woodmapb3fy72src2hvlzv@o3bbh7zxqqvt>
 <aYP7KKD1tDsormI3@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYP7KKD1tDsormI3@fruit.crustytoothpaste.net>

On Thu, Feb 05, 2026 at 02:06:32AM +0000, brian m. carlson wrote:
> I can tell you from my experience that mrustc's cargo implementation is
> extremely limited and does only the bare minimum in terms of
> functionality.  It already needs some help to work with static
> libraries, but I'd really like to minimize the work that needs to be
> done on it since it's not lovely code, and using a standard layout is
> going to help with minimizing the necessary changes.  I will admit that
> I haven't tested using a non-standard layout, but I fully expect it will
> not work based on my experience of the codebase.

For what it's worth, it looks like mrustc supports non-standard layout
just fine[1], and that's not totally surprising, because the rustc codebase
used to use non-standard layouts a lot (although that's not true
anymore)

1. https://github.com/thepowersgang/mrustc/blob/7ff9513adb7cdbe0f8799e7b1f2e4df00ae21a14/tools/minicargo/manifest.cpp#L772
