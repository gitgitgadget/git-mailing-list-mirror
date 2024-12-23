Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD451AF0C8
	for <git@vger.kernel.org>; Mon, 23 Dec 2024 14:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734964116; cv=none; b=M2RS3ha9otjk6LlawD3z/w4A6aiRqtoinfF2/BXIUqyuX6mHyZ4Kb8OhT24iAv6o0MTU/bZ2004G06psreXcuCJkYKT7Oopd15FgetzBaHKhk4moj+4AQlruhfHJ3KOTAvR2NHRhOl1eDTrkxcMNk0br8pO1zb9ItFrsduwqB+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734964116; c=relaxed/simple;
	bh=kemjBFNZY/bmf62SFVj36HpzETKK8HxV9bYozXDQi3c=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=h/kIDAZlRdgs8ZKhy3KSj1ylEwWGHsfetUxTkzqDRjL3+RXgKWwhug/mhVI4N1dXyDZ8UqFYsRazY+wDiQRVcPGaSRxP+fqrKpnmSKz+JN7gSyyFMJkpxNx0hoq3k+44hrK545Z2Jyhc5z+qAXk+o1t3k3g8MFc6gXhHx0+ZPeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 4BNESThO3015175
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 14:28:29 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Krishnamurthy Ganesh B'" <ganeshsurfs@gmail.com>,
        <git-security@googlegroups.com>, <git@vger.kernel.org>
References: <CAMmT1pKVMB6ZUbsEdB0RqbWERauGVqgo_RbXj4j9+csXLHCStw@mail.gmail.com> <CAMmT1pJnZxxD3wFikiDRCqZZMxO8P6EgVHe9mJEsfA8PK4-OfA@mail.gmail.com> <CAMmT1pJ0ReaX+g2_gFQ2oLUrzhR5wCXGvCj_WwDMXcfG2DNG_g@mail.gmail.com>
In-Reply-To: <CAMmT1pJ0ReaX+g2_gFQ2oLUrzhR5wCXGvCj_WwDMXcfG2DNG_g@mail.gmail.com>
Subject: RE: [bug] encryption of metadata in .git metadata file inside .git folder
Date: Mon, 23 Dec 2024 09:28:24 -0500
Organization: Nexbridge Inc.
Message-ID: <000a01db5546$f034b7a0$d09e26e0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE9S4jCGqhjbNSSY2OizRhtIoMmUgJAbH3YAstrfAK0B5a1oA==
Content-Language: en-ca

On December 23, 2024 7:04 AM, Krishnamurthy Ganesh B wrote:
>i am raising a git security red flag on the.git metadata files storing =
git logs, commits,
>and other metadata inside .git folder not encrypted using a two way =
salt or some
>other way like using a key for a two way encryption or some method of =
software
>encryption internally if / because the .git folder metadata is not =
encrypted.
>
>this has been raised to github before but will be raised again via =
hackerone security
>bug and to gitlab and altassian and other git repository source users =
if they are
>using their own internal modified sources.
>
>most of the errors like these will be directly closed.
>
>https://kondukto.io/blog/git-scm-affected-by-cve-2024-32002
>
>https://socradar.io/critical-security-updates-for-git-scm-cve-2024-32002=
-cve-
>2024-32004-lead-to-rce/
>
>https://stackoverflow.com/questions/45578579/what-file-metadata-is-
>preserved-by-git
>
>even packages like git-crypt do not encrypt metadata.
>https://github.com/AGWA/git-crypt

Have you explored using disk-level encryption to solve this?  While I =
understand your
objective to "encrypt anything that might have data in it", there are =
solutions
independent of git what would cover most use cases. The problem with =
adding
symmetrical encryption to git is that it opens git up to export =
limitations and
related CVEs. It would also cause adoption issues with many =
organizations
who may have restrictions on whatever techniques git adopts to solve =
this.
My preferential solution is using COTS hardware encryption to solve =
protecting
data-at-rest content.

--Randall

