Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F16F3A1DA
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 17:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722532033; cv=none; b=i/XPlk+JD+GHqUbhqlMxs5/Ljmxf780DtwmI2lM0vKd2iynEroMn5GP3vw1EfSaEqRCErF1UWYUhi+fS6/2I6scWWDRp8EqDj7kW5idpf9NKGPW9uf3v4zkWGpxcpdrhQE5fZ2qx2qhkOz7pVeHCswcX9d+Svgwg9hm9/fYi92Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722532033; c=relaxed/simple;
	bh=lCVQWOlkwNBe4Ge6VHszPI6HlrPJX9y6MDnzW+7P770=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=GL/mve+jRZ8anjT2XoR24NtrY/zvnIpDUdTvccRB0rBdk03phu39F/Wz3nbyfUg2aS4LduFscq3nu7Xaiw2BywRkyqdF8RcSasx0C+8jjUJDqlG8lF0LL6OZK8ja4n9+1xJgfou5BdDlHusS8UThfCGFfaXy17gRVcOD4XxqY/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 471H719j3486092
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Aug 2024 17:07:01 GMT
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
Date: Thu, 1 Aug 2024 13:06:55 -0400
Organization: Nexbridge Inc.
Message-ID: <02bf01dae435$3a5130d0$aef39270$@nexbridge.com>
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
Thread-Index: AQHOPvlDZNo/jbhsLoaIqw/awlXOYALkmT4KAVwZTGUB2+aESgLXgUnWAYAIFx0B/s5joQGBwcBKARAuUtsBb1EvmQJNHeVPsZXhl6A=

On Thursday, August 1, 2024 10:44 AM Patrick Steinhardt wrote:
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

Fix #1:

diff --git a/t/unit-tests/clar/clar/sandbox.h
b/t/unit-tests/clar/clar/sandbox.h
index 0ba1479620..81a40f26b8 100644
--- a/t/unit-tests/clar/clar/sandbox.h
+++ b/t/unit-tests/clar/clar/sandbox.h
@@ -116,7 +116,7 @@ static int build_sandbox_path(void)

        strncpy(_clar_path + len, path_tail, sizeof(_clar_path) - len);

-#if defined(__MINGW32__)
+#if defined(__MINGW32__) || defined(__TANDEM)
        if (_mktemp(_clar_path) == NULL)
                return -1;

That gets past the clar build problem. Probably more to come as I encounter
issues. The assert issue was just a warning about a constant expression that
will always fail.

