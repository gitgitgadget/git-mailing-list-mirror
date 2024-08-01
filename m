Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6824B1BC9E9
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 16:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722529930; cv=none; b=UjObITkaHmuDj1XvO98Z5eokFbbQyyq6//bcWufPyHYAVl3u9C5Xo6CPxWpgHgrg5tgnzr3UHyjiJpaghWP5c7Aivm2tS5YoGn1GaZ5yi6E/g9DPA7tnDFxuXSgsZkJvXqernUZCMF0u/jqY7wENLjSPr0HquO1qntLWJQAXcYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722529930; c=relaxed/simple;
	bh=mWVAeOxh3em5tYi+itESkw5N6Io/N5ik03HVwXsca9Q=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=qptA6HtfcvoNaTasgLU+r4jVOqI9iPP/aGZpONypWDOkUJl7UnbAtcenISYWpI5Z5kc+kCN2KfEFwT4On7QUmvckVC2m1rnF+ms5w5dCcszBI0caDnohgo1l7pANd005+CfuIC1vSol2r+GE+BpMcx0wxTmXpipGgvgMJjdMzcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 471GVvZD3479341
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Aug 2024 16:31:58 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Patrick Steinhardt'" <ps@pks.im>
Cc: "'Josh Steadmon'" <steadmon@google.com>, <git@vger.kernel.org>,
        "=?iso-8859-1?Q?'Ren=E9_Scharfe'?=" <l.s.r@web.de>,
        "'Junio C Hamano'" <gitster@pobox.com>,
        "'Kyle Lippincott'" <spectral@google.com>,
        "'Phillip Wood'" <phillip.wood@dunelm.org.uk>
References: <00a801dae384$de2780d0$9a768270$@nexbridge.com> <ZqtWDtqkXzjz2A8u@tanuki> <01c201dae40c$821ab5e0$865021a0$@nexbridge.com> <024601dae411$faab2cb0$f0018610$@nexbridge.com> <ZquPfiAWgYjIPGRB@tanuki> <025f01dae419$636bb790$2a4326b0$@nexbridge.com> <ZquSkkR_aw2IUdX2@ncase> <027301dae41a$41ea7ce0$c5bf76a0$@nexbridge.com> <ZquT0B-UXy73x6QI@ncase> <028501dae41b$c277ec20$4767c460$@nexbridge.com> <ZqufLYWnj75VeDXB@ncase>
In-Reply-To: <ZqufLYWnj75VeDXB@ncase>
Subject: RE: [RFC PATCH 1/3] t: import the clar unit testing framework
Date: Thu, 1 Aug 2024 12:31:51 -0400
Organization: Nexbridge Inc.
Message-ID: <02b901dae430$5461a720$fd24f560$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHOPvlDZNo/jbhsLoaIqw/awlXOYALkmT4KAVwZTGUB2+aESgLXgUnWAYAIFx0B/s5joQGBwcBKARAuUtsBb1EvmQJNHeVPsZXX8cA=

On Thursday, August 1, 2024 10:44 AM, Patrick Steinhardt wrote:
>On Thu, Aug 01, 2024 at 10:04:37AM -0400, rsbecker@nexbridge.com wrote:
>> On Thursday, August 1, 2024 9:55 AM, Patrick Steinhardt wrote:
>> >On Thu, Aug 01, 2024 at 09:53:52AM -0400, rsbecker@nexbridge.com wrote:
>> >> On Thursday, August 1, 2024 9:50 AM, Patrick Steinhardt wrote:
>> >> >On Thu, Aug 01, 2024 at 09:47:38AM -0400, rsbecker@nexbridge.com
>wrote:
>> >> >> On Thursday, August 1, 2024 9:37 AM, Patrick Steinhardt wrote:
>> >> >> >As mentioned in another mail, we do not use its Makefile at all.
>> >> >> >Did you
>> >> >> check
>> >> >> >whether the version I have proposed here works when running
>> >> >> >`make
>> test`?
>> >> >>
>> >> >> That is the commit I have been trying to use. make test in clar
>> >> >> or
>> git?
>> >> >
>> >> >In Git itself. `make test` builds and runs our unit tests, and
>> >> >that now
>> >> also includes
>> >> >unit tests based on clar with this patch series. The clar Makefile
>> >> >exists
>> >> only because I
>> >> >did a 1:1 import of the upstream dependency. We could just as well
>> >> >remove
>> >> it
>> >> >altogether, including other bits that we don't end up using.
>> >>
>> >> I see. Well, the 2.46.0 test passes. I ran 'seen' 5 days ago and
>> >> 'next' is going now. Would that catch it?
>> >
>> >No, as the patches in this thread are only up for discussion right
>> >now and
>> have not
>> >been merged to any of the branches. You'd have to apply them on top
>> >of
>> v2.46.0
>> >first :)
>>
>> Do you happen to have a public fork?
>
>You can pull the branch pks-clar-unit-tests from
https://gitlab.com/gitlab-org/git.

Two issues so far:

    CC t/unit-tests/clar/clar.o
                        assert(!"Unexpected commandline argument!");
                        ^
"/home/randall/git-clar/t/unit-tests/clar/clar.c", line 547: warning(317):
          controlling expression is constant

        if (mkdtemp(_clar_path) == NULL)
            ^
"/home/randall/git-clar/t/unit-tests/clar/clar/sandbox.h", line 132:
error(114):
          identifier "mkdtemp" is undefined

mkdtemp is not portable. assert was not #included. Thoughts?

