Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4434115CD74
	for <git@vger.kernel.org>; Sun, 29 Dec 2024 14:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735483218; cv=none; b=mhxK+sMQkjktBNuOBCurmQDWslRuX/zXelPWgDmDc/mSXKIVnum9r8PWyDEwXfpOZc4b43siW+IHNLPiJWBh8Fbg7qK5uXIaMX8Y+s1kIirF/5QuMV4NwridZ2FLtllXDWJbj6sxjQvyQGstih9OW06yJ/wPLB5F7M1GOFMqN5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735483218; c=relaxed/simple;
	bh=lHwje9rwAMtZ0Rvjd69PSUwdMelo0mDTzggI7djXa8w=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=ryQi8eEC0OHJ4MIaB9ztLTrm3bj3EmwCtEHMoh8DEh7wSnduBdHB/JoxHSrvuNKDCu4t0jB7a3edi14YoDcxoo2dik0utEzzTU2cCtDd78bHFcxd4TA7r9jS9TBc7IOc630E0NC58vnfqrGdrbUNM63hnQKDNpHi2DagEKlBJGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 4BTEe27F4070767
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 29 Dec 2024 14:40:03 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <crstml@libero.it>, "'Andreas Schwab'" <schwab@linux-m68k.org>
Cc: <git@vger.kernel.org>
References: <a69c4e2e-cbb0-c242-a34a-8997a84fefb7@libero.it> <87h66nk9uy.fsf@igel.home> <5dfb85a8-2e26-92f8-e3f9-5e3fb89ca43a@libero.it>
In-Reply-To: <5dfb85a8-2e26-92f8-e3f9-5e3fb89ca43a@libero.it>
Subject: RE: connecting the local main branch to the remote origin/main without pushing
Date: Sun, 29 Dec 2024 09:39:58 -0500
Organization: Nexbridge Inc.
Message-ID: <030601db59ff$8c966280$a5c32780$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJOjts6fzJ/non6LHwWNa+ljJww/QERmExkAqEHitCx+Uv+sA==
Content-Language: en-ca
X-Antivirus: Norton (VPS 241229-2, 12/29/2024), Outbound message
X-Antivirus-Status: Clean

On December 29, 2024 5:02 AM, crstml@libero.it wrote:
>Andreas Schwab wrote:
>> On Dez 28 2024, crstml@libero.it wrote:
>>
>>> My question is:
>>>       Is it possible when applying the method 2 to have (without =
pushing)
>>>       the local main branch connected to the remote origin/main =
branch as
>>>       in the case of method 1 which by cloning connects these =
branches.
>>
>> You can establish the effect by setting two config entries:
>>
>> $ git config branch.main.remote origin $ git config branch.main.merge
>> refs/heads/main
>>
>
>Indeed.
>
>By making a diff between a folder containing a cloned empty repository =
(method 1)
>and an empty folder in which "git init" and "git remote" were run =
(method 2) the
>only difference is in the .git/config file. In the cloned version the =
file contains the
>following section:
>
>[branch "main"]
>         remote =3D origin
>         merge =3D refs/heads/main
>
>These commands add exactly this section to the file.
>
>"git branch -u" does exactly the same thing when connecting a local =
branch to an
>existing remote branch. It adds this section. "git push =
---set-upstream"
>also does the same thing.
>
>It would be nice if "git branch -u" would work for an empty remote =
repository and
>allow us to set the upstream branch.

It might be a useful contribution to make git branch --force -u =
understand this.

