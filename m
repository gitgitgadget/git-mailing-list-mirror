Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E8C194C75
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 20:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743021783; cv=none; b=sXj61HrbZOzJpiWdZug0r4tXSycaeLO5uhFYhT6Uu38IhLJwhCSde/TmNk9KW5Dyjv9WuiByKLtGbRpCn2OEEsQ6BOEF+npaMGkyiYInN+7Cb1qXNTMmXB1kOwHlFqhoevI40ERQlWIBPp0s6siYshhG+Ojq1/pLnZTPrZ3Qarc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743021783; c=relaxed/simple;
	bh=kURUMmqZrJhTgZZBBkk9wZzi3QOILTfdgYNWa+wYld0=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=ItO3YXSWzQEc28PeMYT77+tMCPuT9r4UvYdVwIKJocZidZu4gaxR4w9KAQ4GC0K4RtPfkFsZWc+muctnzltcgfyBn6nAzNBmJpd1pMyezJOkjJWrp+I22bX0+S+fwiNMlrvQGlPAQ40LXUPAG45NQabHIUvh21Aqn+EfxKHUKRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=XWRSQkjr; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="XWRSQkjr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xZ888peq4n3DplpmYTlTCwVE6zhxH4kgw95NFVVd/JE=; t=1743021779; x=1743626579; 
	b=XWRSQkjroBbjMTSvkx8uyz4nVQABVkamwUoNxiufBlJs3uMObUP192STvbTRRhRTv129DHyHc0M
	GfIACKF/JzwTusoqkZl+st1X3e8SqotH/+WeMxB4rxcJ+JPn7ZIjxu5uSBPjzdgFKIIrw6ipQ5/cQ
	aEPHDlRXBLfGKYZHOa1FwC5jXdCxSIqJmHViRayV3Y1SnBHh8q40Pv2V3hd/crW5XYNI00rulXq6B
	aQoYaEDLi/scNlCoJApBDXbKdMCB0XxGVcKFe3KkRLY+RAIc7Ute5+eGzq7/BtoboOiUSqHYssams
	ePblBvbK52ULkg3zsE0A9rKa0vst5/4KXgwg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1txXaS-00000001yGf-2Ehs; Wed, 26 Mar 2025 21:42:56 +0100
Received: from p5dc5515a.dip0.t-ipconnect.de ([93.197.81.90] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1txXaS-00000000xS2-1NvO; Wed, 26 Mar 2025 21:42:56 +0100
Message-ID: <89257ab82cd60d135cce02d51eacee7ec35c1c37.camel@physik.fu-berlin.de>
Subject: Testsuite failure on s390x and sparc64 after 6840fe9ee2
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: git <git@vger.kernel.org>
Cc: Derrick Stolee <derrickstolee@github.com>
Date: Wed, 26 Mar 2025 21:42:55 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi,

the following commit:

commit 6840fe9ee29ab51ffd7d924c624dc62da22c50bf
Author: Derrick Stolee <derrickstolee@github.com>
Date:   Mon Feb 3 17:11:05 2025 +0000

    backfill: add --min-batch-size=3D<n> option
   =20
    Users may want to specify a minimum batch size for their needs. This is=
 only
    a minimum: the path-walk API provides a list of OIDs that correspond to=
 the
    same path, and thus it is optimal to allow delta compression across tho=
se
    objects in a single server request.
   =20
    We could consider limiting the request to have a maximum batch size in =
the
    future. For now, we let the path-walk API batches determine the
    boundaries.
(...)

broke the testsuite on s390x [1] and sparc64 [2]. The following test fails:

not ok 4 - do partial clone 2, backfill min batch size

CC'ing the author which is Derrick Stolee.

Thanks,
Adrian

> [1] https://buildd.debian.org/status/fetch.php?pkg=3Dgit&arch=3Ds390x&ver=
=3D1%3A2.49.0-1&stamp=3D1742165887&raw=3D0
> [2] https://buildd.debian.org/status/fetch.php?pkg=3Dgit&arch=3Dsparc64&v=
er=3D1%3A2.49.0-1&stamp=3D1742674659&raw=3D0

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
