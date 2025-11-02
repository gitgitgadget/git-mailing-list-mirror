Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25334199FBA
	for <git@vger.kernel.org>; Sun,  2 Nov 2025 16:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762100402; cv=none; b=kbB+IFzf5GvUC7PTC7no1LA7SCUrrRcLg1xaCV8AdOIKZzQNA0e2EvhozCfPMsTm1YQ4MaklUhR08PDEchPqvVGuuxeFvhf4Uwwbvsco2tIWl5vuU22Vslli6wukYdGUxAcbrPKgUBzEDCpZBfEeZj3HpXMZCN2xLNVdAtdS4Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762100402; c=relaxed/simple;
	bh=vZyti3JN/P2zqQ26QBQ9TgnoshV24pvU81AWKKLaC3s=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=u6PN2A7BXXUdad5eiYn8UdwPTB8ne+/XZlbbq63E2/8ImsRj6j7TgPSunzjm1qkF/iCafT/hO9CtZj59qINEhQsyeHcjFpyTv2BaTS9oueBYNlmbHVBesbXZ/+F3JUto2Wjj5QRV6BkeF4rldG2ZJmEbF1W364Zh7rqv7XCl97E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 5A2GJhSJ2530779
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 2 Nov 2025 16:19:43 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Thomas Klausner'" <wiz@gatalith.at>
Cc: <git@vger.kernel.org>
References: <7mfgh4ufx6wr3ict2ee6utg3vvfpiy6xi3rfyfu4yionmcwu6a@yry3kefdxbwf> <aQd_iisOrwX909Fr@fruit.crustytoothpaste.net>
In-Reply-To: <aQd_iisOrwX909Fr@fruit.crustytoothpaste.net>
Subject: RE: CVE-2024-52005 status?
Date: Sun, 2 Nov 2025 11:19:37 -0500
Organization: Nexbridge Inc.
Message-ID: <01a101dc4c14$7f8f8000$7eae8000$@nexbridge.com>
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
Thread-Index: AQHgfvU8V4Lk27wIa0Kpb1rFsOReWAEbR8sStM5QCdA=
Content-Language: en-ca
X-Antivirus: Norton (VPS 251102-4, 11/2/2025), Outbound message
X-Antivirus-Status: Clean

On November 2, 2025 10:58 AM, brian m. carlson wrote:
>On 2025-11-02 at 00:48:53, Thomas Klausner wrote:
>> Hi!
>>
>> I'm trying to find out more details about CVE-2024-52005 so I can
>> handle it correctly in pkgsrc.
>>
>> https://nvd.nist.gov/vuln/detail/CVE-2024-52005
>>
>> points to
>>
>> https://github.com/git/git/security/advisories/GHSA-7jjc-gg6m-3329
>>
>> which lists many affected versions, but no fixed versions.  I only
>> found one reference to the CVE in the release announcement for 'Git
>> for Windows' 2.47.1(2):
>>
>> =
https://groups.google.com/g/git-packagers/c/ZWDc6K6tYcc/m/VxikezMeCgAJ
>>
>> The CVE description sounds like this also might affect non-Windows =
Git
>> versions. Can someone please tell me if this was fixed, and in which
>> version?
>
>We determined this was not a vulnerability.  The Git for Windows =
maintainer
>disagreed and listed it as one nevertheless.
>
>The problem is that on some terminal emulators, including at least some =
of the ones
>available on Windows, you can execute arbitrary binaries by creating a =
hyperlink via
>terminal codes and having someone click on it.
>That is, however, a bug in the terminal emulator and not in Git, since =
clicking a URL
>should not lead to code execution.

If the code that dumps messages like this is localized, perhaps we can =
run a filter that
removes any non-printable characters (like \ESC) that could trigger =
this. It might be
switchable in some variable like core.filterUnprintableCharacters=3Dtrue =
to opt-in to
prevent this. However, some emulators might just see a URL and treat it =
like a link,
so I don't know.

