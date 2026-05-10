Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A4A3002C8
	for <git@vger.kernel.org>; Sun, 10 May 2026 22:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778451680; cv=none; b=hcV//ChphLtyionIWpEo+F/0F+snJA2Giv2S7JMYWbiXIAmYsLOFhtcShLBRIV9qfV8EaDzIFkuov0HfoEppXQ1b8bM3osuNngqPKI/zbW89+Y1uAexoG/d1lyzTEvngPbxiHPXWmmekgM4FkB/aXA+hdbf0qJu2MMvjkmiDE6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778451680; c=relaxed/simple;
	bh=MSRg4aFJIzz+bGWjPrhf8rB9vHrJ0IRoY8auhAOmmGQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DjZMTEWsHMomTipBwlRu6ipd06iK7eXIW5+IG0ZGq661ukJVxNa8SgmXBPWuOk830lEy7E1VoXV9SJDzgiIpBRxRiXF0VqZVdi5tte8pPDNMgpyr7VKsLDAGGy6mCUF8/q8tDRn6MeU8Ra+3+e0rmVMl+3wHCPgOHvR1qdhxA0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=n/ywRMDA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uu+19r0A; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="n/ywRMDA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uu+19r0A"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 77868EC00B3;
	Sun, 10 May 2026 18:21:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sun, 10 May 2026 18:21:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778451678;
	 x=1778538078; bh=xNGwJJ8byLm9uyjSm+s+qcdINTeezvyJMeJy/A2saFA=; b=
	n/ywRMDAhNXUdpPiXFXd2vpph/UC4wTgcvDfrnWyVsFOKr67burqqdR7ty2n28wP
	oeIiUiwWaWRz+bY7kMYeQ0xHOG044BbMYZdcDpCzMI9YDxFS0UmqLdR/Tq8DbGIG
	Y3z9eGDAjGb6ZGAI4Dm6WLQguMKZ3AoR/Yx7Lp+NdCQMImNNMLIDsOHxvnQCC7Ju
	P7wtskuWwKXss3ysffG9Z0Gj9WzeZhauQsLKGMrDOzyqHTfnOX9wgZXJlb4jwcw2
	z9SS2oGzcV/xoUtoe5wV/5gVuJm3umMufDsASl/XCZXGKYdXq98PyCxR09XHBS/8
	6ANdevCB2n8Lio45BhlnnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778451678; x=
	1778538078; bh=xNGwJJ8byLm9uyjSm+s+qcdINTeezvyJMeJy/A2saFA=; b=U
	u+19r0AkHVq3UeVaW4D8r7VmEGgmAzGrzFwFMzEtbO3qgaWIAa7CaEFeZbLvUjAP
	P6AywquSOnUP/vAhoEvzRsty+vyAjdLusVddQL38FHIjavkmzSIwZi0f5dC+mdRC
	KYxeKw6IE/8wX1OkLw0P6jbaQX8F96wsdK+PUGLcGEqOBLLJX2fSbQa716gQ0oL7
	OEFHDy9XDSFHmpuoNslOmcFSX8GaIvujAqPRVcNYof6snrli8a2ZrAINztLDIDbI
	OKehVY9BiGr34n2yWVjIbi4n5kQ73AYEDCyvyKPDFDuBuB8UBgOz6AutPyV2yF0E
	+nLTJfpYt2VxlHUy5BH+w==
X-ME-Sender: <xms:3gQBakXMBSsI-gVaNNIIe0gsj-5RZItawyOfVADCbGp-w49QtqN-xA>
    <xme:3gQBavfdxscCZfRWqNwPtskZOpNhu3IoxRdsPRpb6mtooeESQ4WRyJkWjapHxuwCN
    Xa19xwTn97TI2WiozkSxy-LPeJk0QV7sWu94OmJHszmpipIFwgClg>
X-ME-Received: <xmr:3gQBagv_3i8vMxF_8RKB8yh25s-Kd735SQTBnyCHq3IqIknDW8KqEsXWorJ3ULTrdrIGYbtoIBOHck-TwZ6EQNmW6GHsbu7fMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudejvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpeefjeeugeeiiedujeeitedvkefguedthfeuffekudduieelkeeffffhteeg
    keejgeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhmrghkrdguvghvpdhgihhthh
    husgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehprggslhhoohhsrggsrghtvghrrhesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepshhnrghtuhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:3gQBau-j2-hf3JJvkkjBw0dKkKXggeS62xOK5cx1sgj9kiHhos6eTg>
    <xmx:3gQBar1DNxIMWLtGRSC_r8t36gEYX2xMnKsg3GcOSEUqSBE3nVei8g>
    <xmx:3gQBajD_m8QQnwh6k815_goi5-cFZSmhymHdNfnJ3yPDQBTSeqYo_Q>
    <xmx:3gQBancPKhQC-VkYxeI-Zhbim69qRwzk6rA6vBOBm5JJYOkoQgiB3Q>
    <xmx:3gQBagAISfLqY9sXH6ywJDRYJOqAkDvDUKqQHcuC0E_nrSfcEFbMz-nV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 May 2026 18:21:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo <pabloosabaterr@gmail.com>
Cc: Shardul Natu via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Shnatu <snatu@google.com>
Subject: Re: [PATCH] config.mak.dev: suppress C11 extension warning for
 Clang on Linux
In-Reply-To: <CAN5EUNRn+SqALbGR3KE9zUKxUfuJrqvK+XJcq-t=biTw56m8kg@mail.gmail.com>
	(Pablo's message of "Thu, 7 May 2026 12:07:39 +0200")
References: <pull.2291.git.git.1778120192298.gitgitgadget@gmail.com>
	<CAN5EUNRn+SqALbGR3KE9zUKxUfuJrqvK+XJcq-t=biTw56m8kg@mail.gmail.com>
Date: Mon, 11 May 2026 07:21:17 +0900
Message-ID: <xmqq5x4uaote.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Pablo <pabloosabaterr@gmail.com> writes:

> El jue, 7 may 2026 a las 4:16, Shardul Natu via GitGitGadget
> (<gitgitgadget@gmail.com>) escribió:
>>
>> From: Shnatu <snatu@google.com>
>>
>> When building Git with Clang on Linux with DEVELOPER=1, the build fails
>> because Clang treats C11 features used in glibc headers as extensions
>> and raises errors due to -std=gnu99, -pedantic, and -Werror.
>
> Hi Shnatu!
> This is already being discussed at:
> https://lore.kernel.org/git/20260505-b4-pks-ci-tolerate-glibc-generic-v1-1-5786386fe512@pks.im/T/#u
>
> You might want to check out that thread.
>
> Hope this helps,

Yes, they aim to solve the same issue, but the approach taken by
this patch to use -Wno-c11-extensions on clang may be with less
damage than the other approach that drops -std=gnu99 from Makefile.

The other approach uses the equivalent of this patch on the meson
side, so it may be doubly so that we should use -Wno-c11-extensions
on both build systems, no?


>> Specifically, glibc's string.h uses _Generic (a C11 feature) in macros
>> like strchr. When these macros are expanded in Git's C files, Clang
>> warns about them being C11 extensions.
>>
>> GCC does not exhibit this behavior because it suppresses pedantic
>> warnings for macros defined in system headers.
>>
>> To fix this, add -Wno-c11-extensions to DEVELOPER_CFLAGS when using
>> Clang, but restrict it to Linux (uname_S == Linux). This suppresses
>> the warning for glibc headers while keeping the build strict on other
>> platforms (like macOS) to catch accidental C11 usage in Git's own code.
>>
>> Signed-off-by: Shnatu <snatu@google.com>
>> ---
>>     config.mak.dev: suppress C11 extension warning for Clang on Linux
>>
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2291%2Fkiranani%2Fnext-2-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2291/kiranani/next-2-v1
>> Pull-Request: https://github.com/git/git/pull/2291
>>
>>  config.mak.dev | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/config.mak.dev b/config.mak.dev
>> index c8dcf78779..f1dcf4329a 100644
>> --- a/config.mak.dev
>> +++ b/config.mak.dev
>> @@ -87,6 +87,9 @@ endif
>>  # The bug was fixed in Apple clang 12.
>>  #
>>  ifneq ($(filter clang1,$(COMPILER_FEATURES)),)     # if we are using clang
>> +ifeq ($(uname_S),Linux)
>> +DEVELOPER_CFLAGS += -Wno-c11-extensions
>> +endif
>>  ifeq ($(uname_S),Darwin)                           # if we are on darwin
>>  ifeq ($(filter clang12,$(COMPILER_FEATURES)),)     # if version < 12
>>  DEVELOPER_CFLAGS += -Wno-missing-braces
>>
>> base-commit: 4f69b47b940100b02630f745a52f9d9850f122b2
>> --
>> gitgitgadget
>>
