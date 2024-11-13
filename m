Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5DC1E1037
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 15:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731512494; cv=none; b=QiowB1mT1lGigGbO3mk7IzEbyvQIpemYT3EpwxWuVAJSjM+IvHXS6e3mxOefZucMa+f3YN5F8cFmEzokML8BzER9mbxmhzEEq7Hba2A71pUZIGHlPYTWeuwpJSYELJalFuM3SiyD2qwff8MTlQjVCXOSAaLR62AHLuNjXiWyWoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731512494; c=relaxed/simple;
	bh=+0cyU8mpShTvAtFprg+ORV+XzZA0zAO4tie7DWbIPCU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Uwm1kOip7ru50Gzu2xoKpIZRwtSaE0/HRQgQscsQqrjd/0RcEw9PeYYtEl5InXMbUovIfFiVkdt7VOuFQuJ+lNpDaCq1iC4IoTZa9PleFSkikOCGNE5wAK9CTDXIwOySO5iCrRBUraNtFSxT2Fv9E3/u3khKUgz5IrzwRI0zFqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=FhRIL76n; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="FhRIL76n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1731512486; x=1732117286;
	i=johannes.schindelin@gmx.de;
	bh=aKlQaXzgd435H+Y1bYNc8cIvPznm+i2plGvt5RCcYO8=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FhRIL76ngHKNqWe/ZqQOMO/fQ4llKYDaP9igxvHz52nRRf1rfzmhZ4ArEWYERnnv
	 BIPDdZ/SFGETsIdhMym11eqPcLVVNyhjcb6rBiMFymZrzoW3HxNkeJI5px1esWo58
	 iwmENjw05N4oaSyppnrMZXCiEAI+BGawiWhWDBLB25MnqqUGd9RdNxxBCSmJDk7M4
	 xPdPIrGCVc/8CFX6PBLsjuJuC4BmNnSPA3NITHIjFpJF3+1UPy92LHnE5p3ZT9bXF
	 ikRM4qH+4Sh4DIHhitYWk0oZkCX1mSMY5Bo74NBUHXwdYw1pN0RDEyt0fEt6rmLce
	 sxHPLbBb/jRliMOx6A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.196]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mel3t-1tjUNk44ZR-00ZOEN; Wed, 13
 Nov 2024 16:41:26 +0100
Date: Wed, 13 Nov 2024 16:41:25 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>, 
    Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] cmake: use verbatim arguments when invoking clar
 commands
In-Reply-To: <20241111-pks-clar-build-improvements-v2-3-d4794d8d1b30@pks.im>
Message-ID: <82d3f3aa-b11c-318f-9d47-35e0ebf3ebce@gmx.de>
References: <20241111-pks-clar-build-improvements-v2-0-d4794d8d1b30@pks.im> <20241111-pks-clar-build-improvements-v2-3-d4794d8d1b30@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:RfrPCHnPehIWNdHuAW0UCDYDSBQvNSPcwVChqyV5/xayIAC4jX4
 vRDDDjW8mYFvAZ1ekQNcY7eZ/kiu7u7UycCt1+VQOKpp7OPnZyaVW2rSW+pKGsLM8cxkIeq
 r7w0IvB1qhcbbAG/iKnM63abrSLh+rWfK95emG+1/EBYkLr9fTw8SmdyFlpP8pSYB2Tj0cr
 zYBosv0ItcVXBImFuocYA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:H+puYIcstSM=;zJR30cplasV04YtlTNDhDMEOLzk
 9TTxRNleL1ILKcXf+ACoIFEHKCuBlxr8/8xBD25aRw84CLENFjmrfKDND5Sboh+qfjTCAx3G8
 vG7IwCrcJe6hyrlKJGqAJ4Ni1GDjOqYqpbtnZycxzA3xZZmgB1uFsdUNW+bl/3Tmru+TJeStG
 k9ahIkPHGg73t2H6/A/Ao+KHueOOSOI/lkpHXKxZSKsJF9IKl/qoJg4o9YHlRnEMbAINyJSad
 ndYkD6E/aKuxkLzdlQYaI1904QE61bbzUlCi2KQvdU44OJYo40Nd+iefdw8tmYGXUMU9cLBtc
 Gr4T/HnXgXFs3qhtfCFTQQ2a8Uu65GT9N5CTi2Df/ut4U4pxozD3khWi5Qqw8/gjtwKzcvPNA
 ISlsZEVRABTQx9/vXi51PNJty0WCnJeMnWBtODV0KBIuC4247vsWwKESzBK4BBRw8oqdheqot
 lgbV3aN+c0OCS5jlAxh4pY9OwEfjIDRL30qQmrXcl82aCHzNr8i8k81k0VYyeTiUvZPvJFWuE
 hpPiMjMkUV1bGaqp6sjYx0W1tcam8V361wozkBPMDJqn0Vwb98A6xh6VviK5VeS6OOP+cC9J6
 pCSuPHCDPRVfsPnIBczfmwBMhQPhC2Yw4Itp0xVw+P556Kqvea8GXYrPwP69rGVj6gJKkp226
 vcnNMJQ2PRwYtwBmHn3TMKralzULC0IWLXegUW5u39GdyFZlFBbpJ3pNw4FZ5YNzAFOyY6C/1
 IuGf/VjbObRG0trvGC6KomXYhV1mEymhXj90e72b245xQ8hXD2JZywQai0EKyN7rr95qDjZfz
 U3YmDfcLMhhWzt6KHQAQZAfMGspdi63xSVM7wysc1F+ahpIJyb5WNGgaV1+fnWlhXH+AWzICx
 PMPC18+LjspGXnrJINc0yqyD8jxwF9BXJ7VIOyVdcyYEYB184CFKWt/uf
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Mon, 11 Nov 2024, Patrick Steinhardt wrote:

> Pass the VERBATIM option to `add_custom_command()`. Like this, all
> arguments to the commands will be escaped properly for the build tool so
> that the invoked command receives each argument unchanged.

I would not be surprised if this `VERBATIM` was unaware of the quirky
escaping that the MSYS2 runtime (and therefore the Bash) requires. See the
commit message of ad1559252945 (tests: add a helper to stress test
argument quoting, 2019-09-18) for details.

Having said that, this patch certainly does not make things _worse_, even
if it probably does not have the intended effect on Windows. But then, it
does not matter because most git/git source checkouts live at absolute
paths that do not need to be quoted.

Ciao,
Johannes

>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  contrib/buildsystems/CMakeLists.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/=
CMakeLists.txt
> index 2db80b7cc3c6aba840f18ffdc78d2cda1877d8cd..8c71f5a1d0290c9204e094fb=
266f10c7b70af9fb 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -1009,13 +1009,15 @@ add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/t=
/unit-tests/clar-decls.h"
>  		"${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h"
>  		${clar_test_SUITES}
>  	DEPENDS ${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-decls.sh
> -		${clar_test_SUITES})
> +		${clar_test_SUITES}
> +	VERBATIM)
>  add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
>  	COMMAND ${SH_EXE} "${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-suit=
es.sh"
>  		"${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h"
>  		"${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
>  	DEPENDS "${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-suites.sh"
> -		"${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h")
> +		"${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h"
> +	VERBATIM)
>
>  add_library(unit-tests-lib ${clar_test_SUITES}
>  	"${CMAKE_SOURCE_DIR}/t/unit-tests/clar/clar.c"
>
> --
> 2.47.0.229.g8f8d6eee53.dirty
>
>
