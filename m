Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E864C204C2A
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742313481; cv=none; b=TjKLJzidnuV3OMiwAgfXJ+tdRJLkYOQ1OHwCzEgBdIpsd1gvSITJyjHVqYf3PQT5mTUa0jLCQZ3jbwCAuko0WxtT5AdTDUoq/PCPq7WyHaxfiCOWjaE3mL97CKt18oQIxA89ahcYsA/Y8dgGSu4yQ1BCn5IMyk4R1AdKVBEA1NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742313481; c=relaxed/simple;
	bh=R8G5XLW70ZoBQ/cv3Cs6gkXgN5cLzIP9AD9VEusY1qM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mUxemIzbFf+wYmdVYHMhIdjbFRTOWirUWBB+TFWe4CM2k5KgDNBbrT3M43+8Xb8VYcviWAjQOOmtGB/mlDjZq81SFZXwxSf4MH5c9I4V4cNuw05l/sdd0ZTDlp7BF9lI9qsTwsOxrMszhMns6S80GAnRql4Iwh4xCXL7DLrKb7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GDt3xQY0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=al9jyzJE; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GDt3xQY0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="al9jyzJE"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DF6532540161;
	Tue, 18 Mar 2025 11:57:57 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 18 Mar 2025 11:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742313477; x=1742399877; bh=Yv/rfHFeVl
	sX/l5ex41cjVyLGdDKi5lnEPsayShZZDw=; b=GDt3xQY0+L4XsvyypJwWEr5/kI
	kdRnAPi28v4QcCoB+EFP6Nrws2vRf2TudwDu/CVKMnnR4OHPg0ICDYYrnasJ40D2
	mMGlkXiro44jWaDOdATWJlBtewvtu3uwSx1Foihsh9NGA6yjPnLSrzcRzFJSfRwT
	scUankwE6RvQj1qdeVj9QI/uee9ml+D3lyGJ1ACgOTZ2XtyAU4EUPdx/4iTaf5Ra
	R7gIm2H/S6qIgSM6pFq1AtkKNbCEbxjl8Km6UcOZsX/BXA1mykRW0T7I+fjshjgX
	muZKJFGR44Nv5zN2F6UqJzaBMpXl2KR7euYBQOHjyjFi8wVpOWsVbb6BWQRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742313477; x=1742399877; bh=Yv/rfHFeVlsX/l5ex41cjVyLGdDKi5lnEPs
	ayShZZDw=; b=al9jyzJEWd0pY0XmGjCG3lrzP3EUVikYWP9j0xP7zXeF5f1rjrW
	E0g41X7VvnHpP5M74E/D7zU8v025BlS13eQAQX15tcKZPYZCWqUUUcd6Dq0Kln+z
	2rozC4oA7rH3+D+AcWLT2lqbNMuySMQqIe2M3cx63gTX5BeOi/oHAzaj2qy9exqo
	Ob2ovE1aBJet1zEt8UlCbHWCWyCaMVWp209xzhKvLhl2GQn08PXssVP730DmB+0V
	6jY26X7gQz1+aGjxekpBBGqUz3PXCFpYyk5yV+cCT/dK8d/kBqSprnFzSzMXpDuo
	5ryHa1As0ihTzksaFexbI4wMnePF5jSi+FA==
X-ME-Sender: <xms:BZjZZ1juOP8A88hHBeefyk35_X6fo7RvKCGuN6V2nn1vCc5AR25XPA>
    <xme:BZjZZ6CndiJgKIOuSi7C5FLRpr3Nt6V20x4Q7LuMA5KJRVdMPtdcoLuNBn9dxQW3U
    PQrTxafZj8XuevTbA>
X-ME-Received: <xmr:BZjZZ1F3_4UnQklAj_eAXyUiSkAFwLrrUHapC2cKk7E8-U02ipXHoZcVAq35xtAS3cH5NDBaP0Xd-scGG9SkyUD-QAVTgNx7pMkbxQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedvkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepffeiteeujeevfeehuddvjeduffeijeeg
    fefhtddvkeefjeejhedtgeefgfeijedtnecuffhomhgrihhnpehgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:BZjZZ6T_hxSdCGjkM2YSbmRMJdTkhH0DWikh9bNdzmXhfj3oGxoGjg>
    <xmx:BZjZZyz1CA1KRje-R2Q2k2d7_pU74E5noFtBHMRxiywWA9HH3E2hlQ>
    <xmx:BZjZZw6IjEZzBiRZ7J-Fflit5wVHuYiwXgSynkt4uvUjQ0WfF5BNcg>
    <xmx:BZjZZ3wTmE-XRMNMHwZzCjdqAa-r6W6qhaLSSB-Yziwf2MSw7GDGpg>
    <xmx:BZjZZ8sVkuCchJW0olawgVOvYQmi-1RCHsi_15-ukg9VrIdHT-wTAiOo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Mar 2025 11:57:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,  Jeff King <peff@peff.net>
Subject: [PATCH] install meson for Documentation job
In-Reply-To: <xmqqy0x7cg9h.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	14 Mar 2025 17:02:50 -0700")
References: <xmqqv7sbfra0.fsf@gitster.g>
	<20250314184130.GA578421@coredump.intra.peff.net>
	<xmqqy0x7cg9h.fsf@gitster.g>
Date: Tue, 18 Mar 2025 08:57:55 -0700
Message-ID: <xmqqmsdi49h8.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> On Fri, Mar 14, 2025 at 10:36:39AM -0700, Junio C Hamano wrote:
>>
>>> * ps/ci-meson-check-build-docs (2025-03-12) 1 commit
>>>  - ci: perform build and smoke tests for Meson docs
>>> 
>>>  CI update.
>>> 
>>>  Will merge to 'next'.
>>>  source: <20250312-b4-pks-ci-meson-docs-v1-1-5e7cf7ac959a@pks.im>
>>
>> I didn't dig into it, but I'd imagine this topic is the source of CI
>> failures on the "documentation" job like this:
>>
>>   2025-03-14T17:50:13.8749066Z + meson setup build-asciidoc -Ddocs=html,man -Ddocs_backend=asciidoc
>>   2025-03-14T17:50:13.8752287Z ci/test-documentation.sh: line 50: meson: command not found
>>   2025-03-14T17:50:13.8769502Z ##[error]Process completed with exit code 127.
>>
>> that I'm seeing in jch (and looks like you have a similar one in the
>> latest build of 'seen')
>>
>> -Peff
>
> Somebody more clueful than me about how the CI dependency set-up is
> supposed to happen should rewrite the proposed log message
> altogether.  The install-dependencies script pretends as if two
> case..esac blocks are orthogonal (the former switches on $distro,
> the latter that we see in the patch switches on $jobname), but I
> somehow do not get the feeling that we can move Documentation job
> from ubuntu-latest to alpine-latest for example.

Ping?  Anybody wants to help explain how this part of CI works to
the commit log message?

> In any case, the change seems to "fix" the issue for me
>
> (bad)
> https://github.com/git/git/actions/runs/13867157977/job/38808418127
>
> (good)
> https://github.com/git/git/actions/runs/13867208725/job/38808554478
>
>
> Thanks.
>
> --- >8 ---
> Subject: [PATCH] install meson for Documentation job
>
> Why should we even do this?  Doesn't it run on ubuntu-latest which
> has its own apt--get install for meson in the $distro specific
> set-up before this part?
>
>
> ---
>  ci/install-dependencies.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 0df74610d0..fdeeaabaca 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -123,7 +123,7 @@ sparse)
>  	;;
>  Documentation)
>  	sudo apt-get -q update
> -	sudo apt-get -q -y install asciidoc xmlto docbook-xsl-ns make
> +	sudo apt-get -q -y install asciidoc xmlto docbook-xsl-ns make meson
>  
>  	test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
>  	sudo gem install --version 1.5.8 asciidoctor
