Received: from bsmtp3.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EBD2857EA
	for <git@vger.kernel.org>; Sat,  2 May 2026 07:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777706722; cv=none; b=anI9K/6Qoh84no7Rij02FedC/Xe3J/xZtNwS9vABz+6HhPc505tG1dgmmfi/BlohGeaciaqbZLr/gO20rpAXyGzyfrusoDxaH1HQ/ncVpsPDrkLmEydHeMo+iWco5L8jfYfg4QMaIy66J/ulE697fz6jB5qvjDiM2TQ0ypogOog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777706722; c=relaxed/simple;
	bh=dIvdPBXS506pujU6oz3sVUUerDhkC0kjp9mLN6agGfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=a+fgphXR8h3bfnRQolna2Q380wSMeiQzEk1+f9ndDoyGq/x0WiobSsm6QTQssUUHfLkTODv8RS8qLjroaJMamU/7V2/onCSLaG45BSgwGaW8l4uTKkz/fG5CDkrxXN7Baj1wSr1YeuILjGr1VLQxIfxTZUX6PWc0MLEa5GXzG+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4g6zvc4fxszRpKM;
	Sat,  2 May 2026 09:25:16 +0200 (CEST)
Message-ID: <157dd2e5-ce64-4654-a66a-86a552c7c9f1@kdbg.org>
Date: Sat, 2 May 2026 09:25:16 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: git rename/moved status unreliable in ruby
To: phillip.wood@dunelm.org.uk
References: <OsOzcjEwvHCQSghLE8LD_wHb_jDlil9I88OUuhpiRONnVd1o9p3gStbK1mx4q7OwY3ePtbZO-BBgTNOCeJ2DMyvBsdlMhRmDrTP894KP5xo=@proton.me>
 <026b84f4-7052-4d5b-a9ae-c2487569d1ee@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>,
 "sebastien.stettler" <sebastien.stettler@proton.me>
In-Reply-To: <026b84f4-7052-4d5b-a9ae-c2487569d1ee@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 01.05.26 um 17:30 schrieb Phillip Wood:
> Rename detection is based on how similar the two files are. Looking at
> the example you linked to below you're changing a file that looks like
> 
> ...
> 
> Which means that git sees that every line has changed because the
> indentation has changed.

That's correct, of course, but...

> If you want git to realize that the file has
> been renamed you could move it in one commit and then add modify it in
> the next commit.

... this is a fallacy. Splitting into two commits helps only certain
cases, in particular, when the commit that moves the files is compared
to an earlier commit, such as `git log` does. However, if a commit after
the change is compared to a commit before the move, the rename is still
not detected.

-- Hannes

