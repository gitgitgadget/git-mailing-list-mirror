Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EF814EFDF
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 21:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709068299; cv=none; b=PcsKhpdCkZ6RI79oMjLFCG8cPvUuq1vzhI/v4K0UCGDOCc6jScBFdglMH/hq/50GIS3nsWGg53vhj3dr4cPcENMprIWsx4kw3TamFYdJyuvrDJThfdsm7abT/CHv7jNNbRBU64Cv/t0pspLUo+z2/3tQ7njBC9SXVh9o2TJgliA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709068299; c=relaxed/simple;
	bh=uykFf+id8mv5xsT1NqIRae6H6zs05dkzwHUAAIx3We8=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=O2Mkz+0il7yr2IjNxansMVgLJWd47xwlpFji8tlRmx2BBba26OEGsI4INBNJ0va26/dTZSi1Guvl8ImEzws4HdQfmFJGGxOGYI70GtteZA4bhqynJBWJWObjJAkwmflGVVFep9JP81Bh8q6rKCWGfI88D1ikWBSXyL9td0wtLQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 41RLBYU12444194
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 21:11:34 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <git@vger.kernel.org>
References: <20240227150934.7950-1-randall.becker@nexbridge.ca>
In-Reply-To: <20240227150934.7950-1-randall.becker@nexbridge.ca>
Subject: RE: [PATCH v2 0/2] Change xwrite() to write_in_full() in builtins.
Date: Tue, 27 Feb 2024 16:11:29 -0500
Organization: Nexbridge Inc.
Message-ID: <03d801da69c1$8b7339c0$a259ad40$@nexbridge.com>
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
Thread-Index: AQGTtmWLBzH5H5YYc4gTr69qQSdMrrGsFecQ

Please withdraw this series.

>-----Original Message-----
>From: Randall S. Becker <the.n.e.key@gmail.com>
>Sent: Tuesday, February 27, 2024 10:10 AM
>To: git@vger.kernel.org
>Cc: Randall S. Becker <rsbecker@nexbridge.com>
>Subject: [PATCH v2 0/2] Change xwrite() to write_in_full() in builtins.
>
>From: "Randall S. Becker" <rsbecker@nexbridge.com>
>
>This series replaces xwrite to write_in_full in builtins/. The change is
required to fix critical problems that prevent full writes to be
>processed by on platforms where xwrite may be limited to a platform size
limit. Further changes outside of builtins/ may be required
>but do not appear to be as urgent as this change, which causes test
breakage in t7704. A separate series will be contributed for
>changes outside of builtins/ at a later date.
>
>The change in unpack-objects.c is necessary as len is being passed into
xwrite that exceeds the size supported by the limit in that
>method (56Kb on NonStop ia64).
>
>Randall S. Becker (3):
>  builtin/repack.c: change xwrite to write_in_full and report errors.
>  builtin/receive-pack.c: change xwrite to write_in_full.
>  builtin/unpack-objects.c: change xwrite to write_in_full avoid
>    truncation.
>
> builtin/receive-pack.c   | 2 +-
> builtin/repack.c         | 9 +++++++--
> builtin/unpack-objects.c | 2 +-
> 3 files changed, 9 insertions(+), 4 deletions(-)
>
>--
>2.42.1

