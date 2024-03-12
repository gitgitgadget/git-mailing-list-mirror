Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AB61272A4;
	Tue, 12 Mar 2024 17:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710263501; cv=none; b=lh4dDicVOp4E5IDyr9At06gXYgsQFxW1yEg6x0WwcRtcKWh/oeTt9+tpe2HCBYNXrmQmlqkasorCYz3gO70hF1ep+BfFH9GGpQRlsCG0zzLLdlWySdzPxkoWyHmSsGbdM4REwMjHJ7NP5z0KAhJbCE+hXJNc/qpIievQpG261fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710263501; c=relaxed/simple;
	bh=/XDl9JFBxe2JHs3HMHGRZPhmxtltk0cXxx9fKq/ARC0=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=SOEqZGW0itGr72hpZluvqfClfheSZT4baz24Xc72kW+qqqxLDHNiLGlIA3NtdBCoz1vIGtrhB0wHHdCYgRUHvnY2+nbTtVLV/akZGKrhGFU5QoYOBFfU/woTLdrVGvn6H31AJwMMtfZZVQQU2Au+rNJiDcDsUiRe+jZ27LRG/Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 42CHBKC41500530
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 17:11:21 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Chuck Lever'" <chuck.lever@oracle.com>, <git@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>
References: <ZfBwZTL9zqDsac5m@manet.1015granger.net>
In-Reply-To: <ZfBwZTL9zqDsac5m@manet.1015granger.net>
Subject: RE: t0032 fails on NFS mounts
Date: Tue, 12 Mar 2024 13:11:15 -0400
Organization: Nexbridge Inc.
Message-ID: <0cb701da74a0$4e39ef60$eaadce20$@nexbridge.com>
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
Content-Language: en-ca
Thread-Index: AQFkY1eQO/h1gwqT5zKDUTUm94UDG7IgeTWQ

On Tuesday, March 12, 2024 11:10 AM, Chuck Lever wrote:
>I've checked out "maint".
>
>Unit test t0032 fails when run on an NFS mount:
>
>[vagrant@cel t]$ ./t0032-reftable-unittest.sh not ok 1 - unittests
>#
>#		TMPDIR=$(pwd) && export TMPDIR &&
>#		test-tool reftable
>#
># failed 1 among 1 test(s)
>1..1
>[vagrant@cel t]$
>
>But not on XFS:
>
>[vagrant@cel t]$ ./t0032-reftable-unittest.sh ok 1 - unittests # passed all
1 test(s)
>1..1
>[vagrant@cel t]$ cd ..
>[vagrant@cel git]$ ./git --version
>git version 2.44.0
>[vagrant@cel git]$
>
>v2.43.2 seems to work OK.

I have seen a similar effect on a standard POSIX file system (NonStop) when
run in a special platform container (Pathway). It does not happen for me
when run from bash directly. This may be something other than an NFS effect,
or unrelated to what I observed. I'll be monitoring this sub-test for
repeats.
--Randall

