Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2603191B1
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 10:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765536052; cv=none; b=s87/xteE9jZNIjgv/qKVVP5vcDLpnKvHvQGFy2zA0PlpWoiD+MVK9Mwkc3meob3JXDr37ll9HR5sTpieNzS6THj1fca2Vo5l1fwhy161NV1M+/0Wh8jkLWFFFBopbrUT+NVz/Vkn8nLExDecox8NX6mKHOG52F2H3XSL7Ugil28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765536052; c=relaxed/simple;
	bh=E+hrNEaHhbMJPWqqGqN01+wnJDkv2PE1Zh9G4Y9FYJ8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=GnD2un+lTaNObaSb+U2CeVDkIFXgnaI7oZYvdqy/e93QADG4wZ8TrqXUZpApS7eijewxQVE37UZ/vUvchtqLTm9Pz66UWNyG1/UUzc6czggS4ok6Uz0JsIOJJrjzpeeNvTCdbkRzuKhbUoe+NTz8yh7dfawOG4ElTy/lkAB7FdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=VOO6gQ0H; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="VOO6gQ0H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765536041; x=1766140841; i=l.s.r@web.de;
	bh=x9yWqgyPgL0yjhvfCYVcDJqVsSCbuANt6ZaTTXQyVhU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VOO6gQ0HH5DN2QvCp18ZG3mLN/fybLMMOek5ogYwPQ3MZHlJ8biUvK8Uj7WphsZL
	 Sp8SArWB7IdSWsYawGSs8U1rqtVl+qJt0EXHpPMFGtCe61+afBsKhOw+KtxBQqUAc
	 oUF+wJPRyyHe/2D1Z2F8X9WnpNf3wxWNdfK/nXT8LJsOgDyLh1xzOrEDaQYB+gB2h
	 925oeuG7fTAVQflUP0+4mR+0au0T2a9rjFvIJdKVOezPYtprFOMLcfXZ4bXDL3wOE
	 DQ3sS+UeRaGTUpUp/HuerqBTG8jsfJNqQN+i/Ciy8R98Xl5YJHEwjmGTm2BJ0gUJ8
	 jHI2aIWMYCWqxt251g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.27.139]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N6JxT-1w4shk1Ttx-010MQr for
 <git@vger.kernel.org>; Fri, 12 Dec 2025 11:40:41 +0100
Message-ID: <422eb238-5c75-4629-86d4-1a3c1ba2521c@web.de>
Date: Fri, 12 Dec 2025 11:40:41 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: t3900 failure on macOS, iconv(3) broken?
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
References: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
Content-Language: en-US
In-Reply-To: <53690064-1c98-40e9-8b9a-7ba6bee63703@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:agNZmoQM0NBtB4aR/vcSGuR82qAW/JObI0vnfgsHe1EQiczpCZw
 XzVMhDiIMPvEuBec5CQw4kNpQKqKTseSgz4X89OwpytxgrlWWYXoV1BHBIXKkEA58jqr3iM
 U2IO0LPktdhNVGQs4KFc+Royr5RwzQyAEjNR/vhTHVn5c8lVFAk+Xwg8UNOtZ7vTpYdCjnK
 QJk9Bz2z45ky8VwS+/uBQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:w0AOdrYseC4=;AuIn27m32nsZFjaQDTu5EEFlL9X
 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

On 12/8/25 11:59 PM, Ren=C3=A9 Scharfe wrote:
>=20
> I only noticed now because I used to compile with NO_ICONV for some
> reason.
Nope, NO_ICONV does not work on macOS because compat/precompose_utf8.c
references reencode_string_iconv() and there's no (easy) way to disable
PRECOMPOSE_UNICODE.  I actually used ICONVDIR before, had forgotten
about it, got confused about it after deleting my config.mak and my
backup copy didn't set ICONVDIR, either.  Odd.  Anyway, just wanted to
correct the false impression that compiling with NO_ICONV on macOS would
be possible without source changes.

Ren=C3=A9

