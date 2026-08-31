Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840D53537C7
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 07:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788160788; cv=none; b=I6xRs0IR0kBF+j2SpJvoIW1TddGV+FiRdaphvFx/SB8xvdgIQxmW8B8+AqjFB+Gpvz+h+SqIeV2ZUKcZiFJvBbKMNTbnfpfIl3tHLNSgADbmzevqsKnT0XBelnODOtk3Pl2s6+FnYPiwtiXUGG3FzGyADX3BDcBXtRgPUXDZxWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788160788; c=relaxed/simple;
	bh=v5kboZ07y1n6Ufzp4EXm/7Y3aqlzDyS5GeI64lxUYLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+NWF/iNyF4dtZ+uinyb/MtjWyo6FQvD/BlemmAcR9hdOZV9VbwsUFCRjeN5d6YziGNN7mJwQxVQLZfD5pjDYRGd+QLe4FHIrpEc/74kwrAm7RCTSUP7OjlbkvyhhC5tbxS6SVJMb2vJsFwd5Dpl5BHngoQMhN6B9zllDZtbcME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SFPdA5q8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eEjgqzQ4; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SFPdA5q8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eEjgqzQ4"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F30A27A016B;
	Mon, 31 Aug 2026 03:19:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 31 Aug 2026 03:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788160786;
	 x=1788247186; bh=ZkMT51sZV4RDWLEEDENB0FU9iNtb3pUNuBxRY3BZ8Oc=; b=
	SFPdA5q8ypFrMsNmyG6WVYAoTQ5WKTEYdGDPGoNsFwHqb7chf9E633PVPfU9MILe
	flPgK0xgpIyssfbG+rS/uViOR2u2Wv1W/HjUwWB7vCTADve8MOclo+LmsIqaR5fT
	+I8FqDDH/weuMqXNpqLNznU9XQZsKkkyO4sxz3IuCdDtYQcQzmmYKgYimq8G5xhy
	B2RojbxaZVDvi8om6diGprusuPCFL7FXqhhDgQ0GEVSq7VE3k8a20RM6KW7dYte6
	P+y812/JrF/cKSVi7clAY16m5kV9yf/NZ33e8ZSc6NJHamZw9srhqU5uP4a4roT+
	YVvQpm7ws/D3AylaNo/PAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788160786; x=
	1788247186; bh=ZkMT51sZV4RDWLEEDENB0FU9iNtb3pUNuBxRY3BZ8Oc=; b=e
	EjgqzQ43hOrd0Afx8KGmEfcaI9gn2nGYKs/GlUP/8b9maWMd32hurVByh03Er6ow
	/MHb7QqhmQbLJlBw3n41vef3YZ19zaxSNvyglO6GkhH7AkaKt/Vo2Typ5eiJsyIU
	wl3KNIGc85JRTMTEo3ZYdYUJA2FpB05aD+21e1DygXafUa9Ei/YOknXBRf9J5RGr
	mfzR6piJbGbTogrHT/yBFPEYyOU2QWbnNdCRRkFOWRZNkkF0fyx98ELklseFECHa
	UrcRH9hMRJ0aJfYEQ7wSIU2niUypPFVsVsdsAXG0BvEQYR0J+a/KpaWeR9BMMYhs
	/IexgdT+NiBLRvhxnmtoA==
X-ME-Sender: <xms:EiuVapie7NEta3Q2up7sq0veOgX4bTpl676yR51ewn2EmlfcStLZAg>
    <xme:EiuVaokkRmqUDzwqgWjG7xa74PUcjIK8YF-tKvQWfcgyMFDRJa8NmCp0vw4bq5Ry-
    JaapoBv7PejWZ3id8kd39KWnxedlErtSeAUfsxAcrpkkDU57qoT63k>
X-ME-Received: <xmr:EiuValqyHJp4_TrbbaRlzi6QESO3ZPim8ra6Iiu5mQxSMLN9zYpHr80EUh-gk5RpVLC98Q>
X-ME-Proxy-Cause: dmFkZTGGLnrh/QsGOftfbm7XcNtPpH+we9exai5DlzYxgcsvSTjAiAX8oVlFKMlimo79US
    6N2BwGrbZHEhymaf+doz0nwXIkyAdWwBq69ogCH3+AIkb9w2aXmsX/WHfUQI0gYhGNS8s0
    YWM7bFt8nl17rJ/S1wnrhGJ+aN8RJGK0zVdnaI3RQ1tbwjccae5ECyheHzxlVFuqE8jRUI
    CD3FTTY/6eG/OdASSK/QdNrhYOJ2dMCz4iPlg6qdQD42cgfshEvmlKnrjNVV62JJd8YCNs
    LQ3M34rmdl6zSqNVfNEyivrVbGNsi+oPLCGGSuVeYlAAckVps9lbg1bONT2ywqPUPfPvIf
    lQXOo7lnqig9mfDMpe4dYaljn8icv1vIXuUebD6rx1Pj9hmYPNVR96wSSJwlRC77Exrxaa
    A7KV5VYmdiNmnxceNn+goEqjsNthQ2xUzBPtexTaEoFVPbDGyW7nLOD3ahRQLFIBrH2auo
    AFVYopZcN/0OnEpBGkpcuTZcjluRtcsePXZhRvhQBKc+cRqJO3CFvTaFc/1+pHzLRjKJvD
    HJ6yBhRwaxZaD6kkdO+7vuNQ14kOy5/dXlsedfT3HQDHiK2unUuiXUBSBasWSKXsKfSXfY
    fAaYZE0cRFOFrlPQNNT1S9mI+UaNdS1CQqfdhQMmRvGJmFLsps4SWU437m7g
X-ME-Proxy: <xmx:EiuVahECroqj-aYO3Eu7xxtcz0VlI8st5EVg6qhVeGflUF7D9bnl2w>
    <xmx:EiuVahx1NFapt5-kr-D2S4jSJ0dAP4t760m-bJGx-4SUSG0EKbK2Aw>
    <xmx:EiuVamoYSJvOg21ChZX24xHs6FLnqi0vOFk0cJGunZ6aEGcCWDFMBQ>
    <xmx:EiuVariHhmwRvtoUBMb82h1j9XExXvqsN7EoDH1PquCakgX7ZbJvDw>
    <xmx:EiuVaib2Ea6ojsRR0EC9tRhtyTGjRFniD9cK8e8Q8-3IsztmgN5rSlRd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 03:19:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5a508619 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 07:19:51 +0000 (UTC)
Date: Mon, 31 Aug 2026 09:19:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v2 0/4] doc: advertize gitdatamodel(1)
Message-ID: <apUrC_ROf9lyiuAm@pks.im>
References: <CV_doc_datamodel_advertize.bea@msgid.xyz>
 <V2_CV_doc_datamodel_advertize.c20@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <V2_CV_doc_datamodel_advertize.c20@msgid.xyz>

On Sun, Aug 23, 2026 at 01:32:45PM +0200, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> 
> Topic name (applied): kh/doc-datamodel
> 
> Topic summary: gitdatamodel(7) is not linked to from anywhere. Let’s
> mention it on other documentation pages and add a link to the glossary on
> the data model page.
> 
> § Testing
> 
> Testing done on v1. No tests done for v2.
> 
> § Changes in v2
> 
> Thanks to Patrick for reviewing the first round.
> 
> Correct commit messages for:
> 
> • Patch 1/4, “list gitdatamodel(7) as a concept guide”
> • Patch 2/4, “link to the gitdatamodel(7) tutorial”

Thanks, I'm happy with this version.

Patrick
