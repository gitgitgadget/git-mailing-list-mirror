Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E6414F10E
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 19:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732217334; cv=none; b=s/v+/KYuz3tRnH0qaIRy5GvLK0rNhKdefnYUgxisGRe3KRz+ZqqLzrevBnFjcunbZyPe0K3Tf/7F8pqiIn539CvY5i3XB1rKtCQSFqTmpg1+zdyExcmtlgYR3aew7pS1U0p6J5Zd7qGx/rSUmL4oO5oUhUAFEaCbHUceK8EdwuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732217334; c=relaxed/simple;
	bh=Bdv33av+dn8J/ZCYm7mCFCBGjwi/Puy1WzeTVAGWwNw=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=rniXjYtqxc00TpWihBOZX8x3RAhXMVrMOzHvb+ZSI9TjaO6hHxTiN6F6zeBDXOuEJDkBAAv+8INtni1515nI4S1LpGy+FysMjebqmo+7OYjjTtYvvwuJcf6iEdQSKVpfc2mUMdSJNcThfpqbJpPLxh/BVJ1H+npCRuoge1zqiv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 4ALJSdYc786949
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 19:28:40 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Konstantin Khomoutov'" <kostix@bswap.ru>,
        "'Luis Heredia'" <luis.heredia@tool.es>
Cc: <git@vger.kernel.org>
References: <e020539e-b66b-4d4d-80da-9f51d4b66683@tool.es> <20241121190522.6s63bsvhxm3w5f5b@carbon>
In-Reply-To: <20241121190522.6s63bsvhxm3w5f5b@carbon>
Subject: RE: Git problem in windows server
Date: Thu, 21 Nov 2024 14:28:34 -0500
Organization: Nexbridge Inc.
Message-ID: <035401db3c4b$91ca9c70$b55fd550$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQK5//uDx/kTx87d9mSsrBInM2yP1AKj0SlVsO93/rA=

On November 21, 2024 2:05 PM, Konstantin Khomoutov wrote:
>On Thu, Nov 21, 2024 at 11:24:42AM +0100, Luis Heredia wrote:
>
>[...]
>> The problem is when i try to clone in my windows 10 local machine =
(cmd
>> git clone - v ssh://user@serverIp:port/gitServer/git.git c:/temp) i
>> always receive the error "fatal: =B4=B4/gitServer/git.git''=A0 does =
not
>> appear to be a git repository".
>
>Does it work if you call
>
>  git clone ssh://user@serverIp:port/c/gitServer/git.git
>
>or may be
>
>  git clone ssh://user@serverIp:port/c:/gitServer/git.git
>
>?
>
>Basically the problem appears to be in that the Git process spawned
remotely in the
>SSH session set up by your local Git process, is given the path =
component
of the
>repository URL, which is "/gitServer/git.git" in your case.
>Obviously, this path is not correct on Windows filesystems.

Some SSH servers restrict interactions to a specific directory rather =
than
allowing access
to the root of the disk. I got around that by setting up a link (via
Cygwin64) to the target
location, which bypasses the configured SSH root. It would then require =
a
different
URI to account for that.

--Randall

