Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F70F5B694
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 13:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712927151; cv=none; b=NW6YaBPaiMR/bm1EnE6SRmjiyAHx6iOWh2bfTJ5GAAmIPsIZk98W3/r3njbuUvFtbv/55mknxw5FMecQB2gJN2b+3G+uR0yQv3w2UTueiRfB1YvaP0yoTmDq0P4YEk6oimlShgtXGj89KK25FIqWcvj3iHJjPTw23Ta/5xKelT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712927151; c=relaxed/simple;
	bh=Ko6W13Lh53L1Mnq1M3n4h6lxvIo5WehwK3WTqH0ixWw=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=g5/LdLWiIZkgSRn/hzsn8tNEAddGbM7URPsYdglMf4a8zvV8wAqN5ras7UxWkmqQwObv9M19+lN+t/tCGCU/1PSshmjnIa1rTqpBxu6zIkmrC8Voshg4FupHF2VlD/kFuZDGS3/Yp+COKFTVamP7ssuwtLJ2Axfv3A11pOI3S/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amyspark.me; spf=pass smtp.mailfrom=amyspark.me; dkim=pass (2048-bit key) header.d=amyspark.me header.i=@amyspark.me header.b=HjxByJBT; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amyspark.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amyspark.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amyspark.me header.i=@amyspark.me header.b="HjxByJBT"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 82CE160006;
	Fri, 12 Apr 2024 13:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amyspark.me; s=gm1;
	t=1712927142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RDXigxZWvA75o7JdmPvg9QZWt2+WJEJEcA/ljXV/VoI=;
	b=HjxByJBTNhuDAH2RLSmOGJAiwzstUPNUywkqu303hScC7M+hPSIg+9cU6fmHwDxX5yY4q0
	pi5q6d8lWdiJqqYwSA1Vm4EksTZOymm9CYqoiO2Q4Gt051I6Ury91sO1J5EQKA8gOwhHq0
	D8QtEY5WKPPc1gVWdunsU6RlGPskiyRNW74uWe5b58cdSDIUtJLxBBngXvu1NECpDcBAWo
	Esf5lYFSRzgPzVFarhmRKiNxXtK5EvMWcK6ww/9hcZ23QJ8nl+Y4ZR5wHB/KP+dmCPzuzm
	8FZEV4rUpYqr+CSEYxf7EiiQqE05jLdywtO1xnWA6tsPwbfTxwgynsaT0CcyzA==
Content-Type: multipart/mixed; boundary="------------nhvUbryoJ0hIMbLB41nNCMpg"
Message-ID: <e25bbce7-8338-430b-865f-690fe3c94fb6@amyspark.me>
Date: Fri, 12 Apr 2024 10:05:36 -0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [BUG] Clones from local repositories do not work correctly under
 Windows
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
References: <44020a6a-707f-4505-adde-e79cda63d711@amyspark.me>
 <2f069d1f-aa4a-4259-9cc5-dcf912f59a17@kdbg.org>
Content-Language: en-US
From: "L. E. Segovia" <amy@amyspark.me>
In-Reply-To: <2f069d1f-aa4a-4259-9cc5-dcf912f59a17@kdbg.org>
X-GND-Sasl: amy@amyspark.me

This is a multi-part message in MIME format.
--------------nhvUbryoJ0hIMbLB41nNCMpg
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Johannes,

Under a MSYS2 shell, follow these steps (feel free to replace the choice
of remote repo with any other supporting a Rust crate):

1. `cd` to a directory of your choice (let's call it `dirA`).
2. `git clone https://gitlab.gnome.org/GNOME/librsvg.git .`
3. `git checkout -b cerbero_build`.
4. `cd ..`
5. `git clone <full path to dirA> -s -b cerbero_build dirB`
6. `cd dirB`
7. `git status`

Now switch to any other shell of your choice, such as Git Bash, CMD, or
PowerShell, and try issuing commands such as `git status`. It will
result in a wall of "error: unable to normalize..."

To further the error state, try `git am` the attached diff to the repo
under the MSYS2 shell. It will succeed, but afterwards you'll also start
to get fatal errors from `git status`:

> error: unable to normalize alternate object path: <dirA>
> error: Could not read 819d81aefc255dee9d8845363038f7fdec809673
> fatal: Failed to traverse parents of commit
90042c71ef79cebeba782c98b26f0532de0e6a25

Attempting to build the repo using the well-known pair `meson setup
build; meson compile -C build` (assuming you have all the dependencies
around) will, at this step, crash at the very start with the following
Rust stacktrace:

> Error: CliError { error: Some(failed to determine package fingerprint for build script for librsvg v2.58.0-beta.1 (<dirB>/rsvg)
> 
> Caused by:
>     0: failed to determine the most recently modified file in <dirB>\rsvg
>     1: failed to determine list of files in <dirB>\rsvg
>     2: object not found - no match for id (32467a0191907fd571b502e395d033a06dfee655); class=Odb (9); code=NotFound (-3)), exit_code: 101 }

It should be noted, however, than exchanging the shells (cloning in Git
Bash, but then checking and patching under MSYS) appears to not cause
any errors. That leads me to believe there's some part of Git that is
not handling line separators under MSYS specifically.

> What is this .cache here?

This is part of the Cerbero package management system, used by GStreamer
to craft its SDK:

https://gitlab.freedesktop.org/gstreamer/cerbero.git

The above mentioned steps were reverse engineered from its caching steps.

Hope this is of use.

Best,

amyspark

On 12/04/2024 03:56, Johannes Sixt wrote:
> Am 11.04.24 um 19:03 schrieb L. E. Segovia:
>> Thank you for filling out a Git bug report!
>> Please answer the following questions to help us understand your issue.
>>
>> What did you do before the bug happened? (Steps to reproduce your issue)
>>
>> Under Windows 10 21H2, I cloned a Git repository off an existing local
>> copy, then applied a patch to it using `git am`.
> 
> This is an imprecise description of what you did. I did my best to
> follow these instructions, but could not reproduce the problem mentioned
> below.
> 
> You should post the commands you have given with their output.
> 
>>
>> What did you expect to happen? (Expected behavior)
>>
>> Operations on the repo like `git status` and `git log` should work out
>> of the box.
>>
>> What happened instead? (Actual behavior)
>>
>> I keep getting this error:
>>
>>> error: unable to normalize alternate object path:
>> /c/Users/Amalia/.cache/cerbero-sources/librsvg-2.40.20/.git/objects
> 
> What is this .cache here?
> 
> -- Hannes
> 

-- 
amyspark 🌸 https://www.amyspark.me

--------------nhvUbryoJ0hIMbLB41nNCMpg
Content-Type: text/plain; charset=UTF-8; name="0001-test.patch"
Content-Disposition: attachment; filename="0001-test.patch"
Content-Transfer-Encoding: base64

RnJvbSA2NTE5YWYyZmJhYjE3Y2Q0YjE4NjFlNmI5Y2JmYmIyYzc2OTA2ZWRmIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiAiTC4gRS4gU2Vnb3ZpYSIgPGFteUBhbXlzcGFyay5t
ZT4KRGF0ZTogRnJpLCAxMiBBcHIgMjAyNCAwOTo0Mzo1MSAtMDMwMApTdWJqZWN0OiBbUEFU
Q0hdIHRlc3QKCi0tLQogQVVUSE9SUyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspCgpkaWZmIC0tZ2l0IGEvQVVUSE9SUyBiL0FVVEhPUlMKaW5kZXggOTk3MWNlNTgu
LjdiMmE5MjY2IDEwMDY0NAotLS0gYS9BVVRIT1JTCisrKyBiL0FVVEhPUlMKQEAgLTY4LDYg
KzY4LDcgQEAgS3Vyb3Nhd2EgVGFrZXNoaQogbGl1Y291Z2FyCiBMUk4KIExhc3psbyBQZXRl
cgorTC4gRS4gU2Vnb3ZpYQogTHVpcyBNZW5pbmEKIE1hYXJ0ZW4gQm9zbWFucwogTWFjaWVq
IFBpZWNob3RrYQotLSAKMi40NC4wLndpbmRvd3MuMQoK

--------------nhvUbryoJ0hIMbLB41nNCMpg--
