Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1533C2741AB
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 20:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752612467; cv=none; b=Ij5xL+N+Rl93+IgbmA0UIcO8CsaKSmxrX/pLm2mG45giOTESrKQkBiiyrfa0u9nbVkVVYNncm6MuVV0fYdvEMdtjiiO+uCUs5DP6ZTqHeXTnZKTU3x2rM2ml2Ccy7lLT+zGZvCNyEWWofVeGBITfvl2G5XaEXPH500K9AryvEKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752612467; c=relaxed/simple;
	bh=+2yVZb5MrsJNfaFQtmJ2CSoGajTlMYC+OYdANR7CVnU=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=nCgJtWnyNV86lUHOrpEr0wp1yzqm+JWhQnCwGb2AITUIoZgtp/I8cK7abhEUItuXbnitkB/uOxiA7Gxv8h0DSm2l8oZUbKcU+kn1Ht/nOigVinXYpV+AEg9nx2yXOlAUENoRMy0W7hHKb2kNHnl1NWSyxvRzd2Ad+VurVUvXKyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 56FKlVVM1918719
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 20:47:31 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Elijah Newren'" <newren@gmail.com>
Cc: "'Phillip Wood'" <phillip.wood@dunelm.org.uk>, <git@vger.kernel.org>,
        "=?utf-8?Q?'Ren=C3=A9_Scharfe'?=" <l.s.r@web.de>,
        "'Brian M . Carlson'" <sandals@crustytoothpaste.net>,
        "'Eric Sunshine'" <sunshine@sunshineco.com>
References: <cover.1752499610.git.phillip.wood@dunelm.org.uk> <cover.1752587571.git.phillip.wood@dunelm.org.uk> <CABPp-BHoTxT1UQtgy2bH=mc1re_LPngKX-50GPh_wbtMMZZpyQ@mail.gmail.com> <000001dbf5b5$8b316f00$a1944d00$@nexbridge.com> <CABPp-BHjU2NFVoM+wkBxDrr3P85yYzmS-O4mBAc_e4_6wfOBMw@mail.gmail.com>
In-Reply-To: <CABPp-BHjU2NFVoM+wkBxDrr3P85yYzmS-O4mBAc_e4_6wfOBMw@mail.gmail.com>
Subject: RE: [PATCH v2 0/3] C99: declare bool experiment a success
Date: Tue, 15 Jul 2025 16:47:25 -0400
Organization: Nexbridge Inc.
Message-ID: <000501dbf5c9$af9598d0$0ec0ca70$@nexbridge.com>
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
Thread-Index: AQD93G+NRU9hmfxmcUUkwFIcalH0KgJP6r0GAx6rUCkCKRw2ZwJfQHU1taAizRA=
Content-Language: en-ca
X-Antivirus: Norton (VPS 250715-2, 7/15/2025), Outbound message
X-Antivirus-Status: Clean

On July 15, 2025 3:35 PM, Elijah Newren wrote:
>On Tue, Jul 15, 2025 at 11:23=E2=80=AFAM <rsbecker@nexbridge.com> =
wrote:
>>
>> On July 15, 2025 1:19 PM Elijah Newren wrote:
>> >On Tue, Jul 15, 2025 at 6:53=E2=80=AFAM Phillip Wood
>> ><phillip.wood123@gmail.com>
>> >wrote:
>> >>
>> >> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>> >>
>> >> We've had a test balloon for C99's bool type since 8277dbe987
>> >> (git-compat-util: convert skip_{prefix,suffix}{,_mem} to bool,
>> >> 2023-12-16). As it has been over 18 months since this was added =
and
>> >> there have been no complaints let's declare it a success and
>> >> convert the return type our other string predicates to match.
>> >>
>[...]
>>
>> bool is not standard in all c99 implementations. I have to #include
>> <stdbool.h> in order to use this type. Please make sure there is a =
mechanism for
>that.
>
>>From the referenced commit in the commit message:
>
>$ git log --oneline -1 -p 8277dbe987 | head -n 13
>8277dbe9872 git-compat-util: convert skip_{prefix,suffix}{,_mem} to =
bool diff --git
>a/git-compat-util.h b/git-compat-util.h index 3e7a59b5ff1..603c97e3b3f =
100644
>--- a/git-compat-util.h
>+++ b/git-compat-util.h
>@@ -225,6 +225,7 @@ struct strbuf;
> #include <stddef.h>
> #include <stdlib.h>
> #include <stdarg.h>
>+#include <stdbool.h>
> #include <string.h>
> #ifdef HAVE_STRINGS_H
> #include <strings.h> /* for strcasecmp() */
>
>
>So, there's not only a mechanism for that, it has already been done for =
you 1.5
>years ago.  No extra work on your or anyone else's part needed.  :-)

Many thanks.

