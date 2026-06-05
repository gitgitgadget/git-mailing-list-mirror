Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DB43B47E2
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 04:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780635467; cv=none; b=ZyVg5KgLhhz//5QBMf/da/WwKEvJuSMNNMMIbDMh/QPHytdL6jv0ns3TExghC69t05Xz4OgLqLgA7gJelG3oikSYyKl/aAqNbUif9p0CQVooC/8p9dGIdcHuJ3kMx2cmoqHxH68wt2iEJI+Jm7Y5MZz6vOEnaSvsfnVQOjhJvcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780635467; c=relaxed/simple;
	bh=wp7tQvtXhzmZXlCCCtxvUz3iIc+BHFumm5slSIMx5e0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=izfIs4Le7xE//KsP11TQjfl450jzi1F+Wrfmg6wks4Xs5yHxodisgUgTrQVaeFI8qZ1VZgiqAmcEmu31z9jKiVfulmOW8FUgEtBLiXpyUzoisOlVQAjBtET9fAAANTDT/qsfN0Caw2RzmlNlODNOuJtl2j7ehJ4NVjjUGCz+Ays=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emailplus.org; spf=pass smtp.mailfrom=emailplus.org; dkim=pass (2048-bit key) header.d=emailplus.org header.i=@emailplus.org header.b=VepSxDUs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CWhWDBmm; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emailplus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emailplus.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emailplus.org header.i=@emailplus.org header.b="VepSxDUs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CWhWDBmm"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 00FC1140010C;
	Fri,  5 Jun 2026 00:57:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 05 Jun 2026 00:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emailplus.org;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1780635464; x=
	1780721864; bh=xpe7y37hBuNDRfD57Az0ux+DkSKaEDmPnfFE9LQ2V+A=; b=V
	epSxDUsMNDA6fBktYB1EN0Zqty90elKQuIkycyvh6FRK5kiaeVQkNXr05OeTBdMk
	TkFVeZXosRTYYlZmkvFsLtNoFAVElyduS2R1RD1N0SIUN26/2MouwqYqYPzL2eCo
	NyfbmLmedKuCP4mi8Z2m3SrlY1Z5X3e5dcrBtyZ1p6RtYkjObbuTjK0cl/NguxBb
	YodbY261I/WdXAWtaKg+hmaeqmfzVBJGlqcgKi2YIW6SvMepEr+0jkstwCJVOJoM
	hucku6m68iGIxVIvb85ScDKbKDTw2MqEM0AiZ0NR1CMn2yXf+szTXZL+1Tyl1xc7
	ppbxzZo0LdboYQ7GDW4ZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780635464; x=1780721864; bh=xpe7y37hBuNDRfD57Az0ux+DkSKaEDmPnfF
	E9LQ2V+A=; b=CWhWDBmmBVGHDQzxF0B7kWm9+Ru5R9yh2Wxuqy1Y09NRYYJyrb1
	ImEbAX2tHYtWgw5rh43TC23lkiWbkjfN0EPXTgqCoBAahz3e2UsbxGOtdvRXo2aT
	NlmR9z9RwOTcsmQnFHfdldW+JKzDyxBALZhIJeriWfAC8MKMY8cpEzZKBeAc9yF3
	LgylcNJ5xzArYY5uOmc4gOluhgXpkATEkmZCJAaxCwruZd9l6WN34HIaKgImM54l
	ZEXPyxdLDKjpTHktlpiLUAPSoa6dZ5TeBtUh2QGh0bz/Xm/PXF+5Znz1GMVsEYN4
	KlG7jZH7xitMo4nCwMB73OgSjExO8B5LbHQ==
X-ME-Sender: <xms:SFciah4w89CU_xO2O4UlGp0cqWGnwU90JBHJ2Hf5T-wZiQN7LOY9Yg>
    <xme:SFciak4QAq3YMs5Mi9JhbOceILgqaiwqKPQ9kPb61P6T_a1JGkXJ54wcIDPyv75wG
    JdjefoBcYfAdoUtsRAu29c3WsLx9zlpQOw57wTqWZwX9fyUAm3ehg>
X-ME-Received: <xmr:SFciamH7t2Tc4Q9cTAYrZET_MRvd-JfDxpoRhyU1lPdhA4Q9ZkfW58g>
X-ME-Proxy-Cause: dmFkZTEKVcy2zCbc9Ay8htQHXz+6y4oThgRQ8zTTIF7bsscIIrK5BX3JBhkduICyjRzfxu
    M4Ve3MeSun+e+L85z4YPMVcvKdKs660njCblwB/Xx/gU02eH+Nb5rpYG5NX/8IqtmxTOfP
    sKzbSrlphMOC9tvgMXkyDF6USKHlKaW7pEhy3YyEjQBI3HESiChPsmSNvGyjsGo3t4Snsh
    0tkBiDKGSMGonspN4RcCT+TqKcPS0XnYK8nE0wUIHBD8pFs10rl2KlrTLcprvd8R3KrpU0
    gqJ1dN3b7oh3RswDFjDRhQv8je42pnCnHujwLnm9r7L/Hz1DOat3FmSVawAged0VaxFOUD
    ixGk0rugqKnty2bpPpLjZKPPTwz2EuYfgyASBXHgCx8OVRcf4A1ly8SpgzcKBG4p8SZR8X
    ss21ZWvuo6QmgwCfKDSq8B9u3nkP6udHV99brsFfYcindPj4ZpyGzKlNbje8S6Aox0P3P5
    xs22S9r6pmPv7tfy9X74gBbvX1006WlnoO1HE+IMIu3gGXt1OEKHzx1WE80X1oRzkM5yYs
    w083eAt/kHBDud6+mIxlFVUYt46KKqDHU/cvYjJwQo6B+pCBTSDQ5ge7Ip9usMIGllQ/6t
    6tmO4sMjv9GGZigVGdZcdNPqYbw7K20vrI75gAOK2D3lHZCk68Wmd7l6PQTg
X-ME-Proxy: <xmx:SFcialR3dTGukFX9P2K4XlCie-D56XWo7o2NsguWQwvW04XlxuNUMQ>
    <xmx:SFcianvEb1u86yhRIMAFnnnvIAXkVbSGLyXOvBkSEEvLu9iaSNIqlw>
    <xmx:SFciaswVGcIAIDIljmUQDkltJ5yMOhzAwK2ABjGaa0AxDOY5AXSl4w>
    <xmx:SFciap5C6AnkNFPE00TCEO-GdVo0ve1FpT0VyMpt8Nmqrjtlz1b1Tw>
    <xmx:SFcialSlaChz7OaVIVovY3qxibMh2Df2CMvR4uo5rce3yD-NW7NZMQOT>
Feedback-ID: ic1e8415a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 00:57:43 -0400 (EDT)
From: Benson Muite <benson_muite@emailplus.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org 
Subject: Re: Mirror repositories for submodules
In-Reply-To: <xmqqcxy7qfgk.fsf@gitster.g>
References: <875x42vlgv.fsf@emailplus.org> <xmqqcxy7qfgk.fsf@gitster.g>
Date: Fri, 05 Jun 2026 07:57:41 +0300
Message-ID: <87jysdr3cq.fsf@emailplus.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Benson Muite <benson_muite@emailplus.org> writes:
>
>> Would a contribution to add mirror repositories as alternate submodule
>> sources be considered for inclusion?  Some projects have mirror
>> repositories on other hosting services, and may have bandwidth limits on
>> their primary hosting service.  Being able to indicate mirror
>> repositories for where to check for updates and sources for submodules
>> when doing `git clone --recurse-submodules https://my.repo ` or `git
>> submodule update --init --recursive` would be helpful when there is a
>> timeout.
>
> I do not see why such a "oh, the repository at $URL1 seems to be
> down, but we know $URL2 serves the equivalent information, so let's
> go there instead" feature has to be limited to submodule use case.
>
> So, no, I do not think a contribution to add mirror repositories as
> alternate submodule sources should be considered for inclusion, as
> it artificially limits usefulness of the feature.  A feature to add
> mirror repositories as alternate sources might be worth considering,
> though.

Thanks for the feedback. This was motivated by problems when trying to
recursively clone, but a more general solution is also fine.
