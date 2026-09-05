Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E92B3876B7
	for <git@vger.kernel.org>; Sat,  5 Sep 2026 23:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788652626; cv=none; b=Z7/DOXvus/oNGlMrkWe6DQOLAz86c5eXrTYMso+JOWEPZ02O1o/fOXiCtITiaFpofpdBXM5eNHzSGoUivBtWK+H9hD5ZTbZ+0xfoVcdBSaJPNDjHe87DK0QgBdT+Ct7cT3DhFrj+vg8zgiolJQff4CcxGoDqdrl2PJQADVDmwjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788652626; c=relaxed/simple;
	bh=42BC29RWXXODsmQMqT7+Wf9PiEFkG9LWbpliYwagVQg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dlPwOTcJhuiwrUJOrC23kJryJBkHHDj9H0LFx+VxiPTCdDLsl7Uf4gO2ftZt/JunE6RKR44sCI93yGx79rS7W118r6UE7Vj544J0Pk6B60yvnFkL4Ohl/WB2CqCBYYirdNObBkMukPIOHtijk1Qr07h3O0Aa2hp4NlaXXkF+z6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fXLJG9xM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E7E7bWcQ; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fXLJG9xM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E7E7bWcQ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 601167A00FB;
	Sat,  5 Sep 2026 19:57:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sat, 05 Sep 2026 19:57:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788652623;
	 x=1788739023; bh=HdD8ymsvXzvt+9mLfAhYwEpaa+ygmWmdg8zjHCXva9o=; b=
	fXLJG9xM/GFlUM5GkzFpathoy3cysCPmVACU50zen9+S24gbzuZfZMKHzYcTK/TG
	Mi2/5+l6NHeQfwLvBwtxwFlkGDqtNPYzINRwFPNQEspY2gzOP2M5Ey+ZnZZETnRv
	LUzEN+niFp5xgAgqrKdDd+amNSg47EeWftExOpVw/WjIjxbkUwigxeeodC/QgBtD
	Vqza+EgDuFlRxyMKGJAk2m/OPcW2vFolOeDZ7gyDxGMyuAfRbsMXfxR8guyjVosd
	lscAG3oQXMXr1WcIwIOELL0wIfVm/rd0axm01lFYl/3brbW+DKoN5HjU6wTg3H6X
	bk41iBLnfHoC0gcKVezi2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788652623; x=
	1788739023; bh=HdD8ymsvXzvt+9mLfAhYwEpaa+ygmWmdg8zjHCXva9o=; b=E
	7E7bWcQ6E2ZDfrIJ2Rgnijj9w3EZOGkN3NVmAgVH58whrElQZ2ajyx423iCPvjgo
	7EsHgSImHhsndcBoAA0YY4XbaFe80+SjKS32sCWCwGl0PTNEyEPFKixH1cr8cRK/
	yoJW9NjeDZNGoE2uwzLYZfW23K1QFYZDRCXrPwpYQ6blR2NL2VvCEUYoNB8/IPIy
	rMW/VtQn9qTug/TYdNfjbAbguXH7lliKaEqp7nSO3ziEh5yROiPDix7xl09PO9Fs
	oVKsvvgTN2VHarf3LtI4Yl4J19qbTVlIT9KZ7Ps6PmStoORXl7FtOOoujZXY7BEx
	SowWft1Vta1c2HrcodjBA==
X-ME-Sender: <xms:T6ycag04yXfPTBFpQayjzp45N6_VSehZDIdFXDjlvhsOkVInucPi3A>
    <xme:T6ycaiiD1myr6pP9gyEQ_rFZUZjMpwv7vHIoPDqs95Px7oJtzv5Mk_QC3j81dugMY
    9QaXnHwdzRG82PXFDFmypQfXAVxLxYRBz41RWF9J8otzIbeY5eniA>
X-ME-Received: <xmr:T6ycamTQid66FKW-rtetarwoLYudnAj9AF91jWhdHvQLz0C3e1ilwtg_PPQXD4xqOf_NW_z8_hUx8pm1TcZ1spr5gtV-F08Z1tnL>
X-ME-Proxy-Cause: dmFkZTF6/o1VY8UvDHgPp41MjnOvLljSUH0kNgi2VgYAP29LY3Lrdol/wNzOxaj5rdL58k
    c7tgduYto06VuRcUCiVN+M0y+JEcewXcSuq1VCIocp531jvIa34mit6ik4iMS/+Izn0mnE
    uURta5efkcTNSAC0Z3MyV1i+K6iSJj315819JK4MMGJ8zp5s3E9lY/TRFMlrfPcK3EUV8D
    Fx1KfLoKk2HAWyiQ3/D1d+Q7wXlle2vpdEZYJMYOhJJJCEt9+3tKXfjGXkCR0yFrhKGSG3
    nTRxTm3+clMKBH38xyodLJAt9fWTIPWdoB1rDJGz7+mFcvZoprr5UW/SwvThuCavoijUkY
    zG+kiHvTgiZ6MwRHBT6E1jB/8KkRtg+sxzohl1xTTxXDEA47Qty9A23OQBBjv0wQQstGZ7
    SrIbZiN8umc+UixCWk1cmkEji0CD/ftqLyc1jjwbP3m4IGrtK7yU5zE73rZ3Ic6P4s8loR
    njTr2decgT97NXMzjuz9Kgr1uoPfLnVj6H/VVNtVUj14ZrXIaFoQ2teFOx7H2hrYgKpQhJ
    APHVm5PayiRbdV/FIa5Ofn8+yt7aF27zIBMIK++EhSOr/vAdtLeoBXD4s7T2LXyIPFxRGC
    QHkRCGe02k2XrxRFSY8HflccGXXGssINmBMbm2OURLQxu9kBCx60+ndrBrPQ
X-ME-Proxy: <xmx:T6ycajgW4k7yslhzJ9j-5DsN-YaxPABDSaDN0-AJPMsKIjOdul-XTg>
    <xmx:T6ycam5BOyx471lLK9XuJpbfJ2b2OpI0ayrD8dsdI5tj9piJRdKoEQ>
    <xmx:T6ycagAx_dFLWdRBSLFw3l8i8PIJ_jkqjwSfQPPx5yPSjIULOaZQsg>
    <xmx:T6ycatbmpnxfs6xxIAbcPnJn8Nei7gyz9ewgLfs_IaYYi40t8vBy5w>
    <xmx:T6ycamiv8G5UhqXAoaDXf16scm0cQKFyts6kNZrz1Y5v5GYx3o1B2QNg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 5 Sep 2026 19:57:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2026, #02)
In-Reply-To: <CALnO6CBALuJ2DTm3_NSH1=Q4DLEFWO1EKHQeHPCg+Luh9cY_qA@mail.gmail.com>
	(D. Ben Knoble's message of "Sat, 5 Sep 2026 08:07:31 -0400")
References: <xmqq7bl03723.fsf@gitster.g>
	<CALnO6CBALuJ2DTm3_NSH1=Q4DLEFWO1EKHQeHPCg+Luh9cY_qA@mail.gmail.com>
Date: Sat, 05 Sep 2026 16:57:01 -0700
Message-ID: <xmqqa4pv5k1e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> On Fri, Sep 4, 2026 at 8:00 PM Junio C Hamano <gitster@pobox.com> wrote:
>> * dk/use-nsec-runtime (2026-08-31) 3 commits
>>  - core: convert build-time USE_NSEC into runtime core.useNanosec
>>  - environment: align repo_config_values_init with struct declaration
>>  - meson: expose knob for xmlto relative links in manuals
>>
>>  The build-time knob 'USE_NSEC' for nanosecond stat precision has been
>>  converted to a runtime configuration 'core.useNanosec', allowing
>>  distributions to bundle one binary that adapts to filesystem
>>  capabilities dynamically.
>>
>>  Waiting for response.
>>  cf. <xmqqbjaefhwo.fsf@gitster.g>
>>  source: <cover.1788206466.git.ben.knoble@gmail.com>
>
> Reply is at <https://lore.kernel.org/git/D0BA1B32-1CAD-4328-A612-75A648413017@gmail.com/>
> :)

So, is

    A prior reply of mine to Patrick specifically mentioned diff 
    with submodules, I believe. But I agree that positive evidence 
    is probably better than negative evidence.

in that message a sign that we should expect a reroll?

Thanks.
