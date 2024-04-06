Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EF280B
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 00:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712362156; cv=none; b=mpVpW8KOhTSHuH8ZkKdnzKmMbqEF3QnjGGCSS7P0S0T3iRHD2jx2ufPAwU87mQI6AQEkm4kS956EfESD2YhOUS1BkSkb1Su0/9v/C622iYeOqOEtypAdix1BU3yaHK8OEcTvi1228sn6FbiN9WEGmOSl+O1Q4dGhdEnmXntxhoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712362156; c=relaxed/simple;
	bh=blVXfTqdy12j+HTgGtXpARBq/hyGX0LThU5hHImfJgE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gPDVDaLiKoD4IY6I58hpDq/tFNS4wUJ03x3dREZOor2XpPR9XfCh3vy5RS2g/V/cBUoygneNCJDZwjmHZrDsq+EvN31UdY/R9QzuwzyepmDIay1HsWfSUpQpNqmK+WWrHLi2iiJRW9HfBPLE/szAt8YqoeWmf5FY1AdUYhpqJoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=boq6d2Hf; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="boq6d2Hf"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 58A9B1DB1F9;
	Fri,  5 Apr 2024 20:09:08 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=blVXfTqdy12j+HTgGtXpARBq/
	hyGX0LThU5hHImfJgE=; b=boq6d2Hfz7JIe40jiVlLONPLsrXNtdVUbK5DU546c
	vDYpJDvX+YYrp+iSdCEfQuK0OACCUxQlsCHZvzrfs5Q7jo/RNIB9S8hByWIWQyDQ
	K5qvels2wBve0dTWkAB/WR+5WeFZUP1pd3s6QxXQfvIgjpwBCDyvJSbNQmk7fLII
	1A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4F4C71DB1F8;
	Fri,  5 Apr 2024 20:09:08 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AD9541DB1F6;
	Fri,  5 Apr 2024 20:09:07 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 2/6] CodingGuidelines: quote assigned value in 'local var=$val'
Date: Fri,  5 Apr 2024 17:08:58 -0700
Message-ID: <20240406000902.3082301-3-gitster@pobox.com>
X-Mailer: git-send-email 2.44.0-501-g19981daefd
In-Reply-To: <20240406000902.3082301-1-gitster@pobox.com>
References: <20240406000902.3082301-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 E2ED2AE0-F3A9-11EE-9479-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Dash bug https://bugs.launchpad.net/ubuntu/+source/dash/+bug/139097
lets the shell erroneously perform field splitting on the expansion
of a command substitution during declaration of a local or an extern
variable.

The explanation was stolen from ebee5580 (parallel-checkout: avoid
dash local bug in tests, 2021-06-06).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuideli=
nes
index 0a39205c48..1cb77a871b 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -194,6 +194,20 @@ For shell scripts specifically (not exhaustive):
    have changed since then.  We'd need to re-evaluate this rule,
    together with the rule in t/check-non-portable-shell.pl script.
=20
+ - Some versions of dash have broken variable assignment when prefixed
+   with "local", "export", and "readonly", in that the value to be
+   assigned goes through field splitting at $IFS unless quoted.
+
+   DO NOT write:
+
+     local variable=3D$value           ;# wrong
+     local variable=3D$(command args)  ;# wrong
+
+   and instead write:
+
+     local variable=3D"$value"
+     local variable=3D"$(command args)"
+
  - Use octal escape sequences (e.g. "\302\242"), not hexadecimal (e.g.
    "\xc2\xa2") in printf format strings, since hexadecimal escape
    sequences are not portable.
--=20
2.44.0-501-g19981daefd

