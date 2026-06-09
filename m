Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E7840D597
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 19:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781033423; cv=none; b=cA9CEJPYVev2iWfZM00jGa6apT++tW3zURJUR3nBMJaSui7p05yRoMnba1CL/SL3vRoi399NIsB8KYVkezakykFBL9RcFoUVpy7KgIsCcXs+uKDvuEptVUdQkJrz2ltpIALhsjlyQ1AAknPGnetK3iJ+gTybn2oOjp7xQDYNn8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781033423; c=relaxed/simple;
	bh=xYYCM1cuebcn+LboROtKlguBwxYfwFbhhMFEV43buls=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nqZZsv9Sq4X8SphbzjttRZKNkGb9hZuOcenfKItxRAY5TZlzne9YcMUt7oXQI80yGQLgSE8RLaHkneAY/8rT4dqIzRODZEL6zKR2FKKrXyxT6hbDQ2WtS7phSngMLgbLzhOA7mM/1zmAUYE+Ja6Z1EUZeWNzCjgt6f/bhdyDXnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bGBIgvwX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ARraYmbT; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bGBIgvwX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ARraYmbT"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id A62231D0004D;
	Tue,  9 Jun 2026 15:30:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 09 Jun 2026 15:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781033421; x=1781119821; bh=lwroAf0fyA
	Xm3CtK2UOkRTDFWpPtclFDVmId354767w=; b=bGBIgvwXhea5p386uw2jZc48eM
	f5ppyjLCg8t+tvjEbPKEy7zjNQ2Q+AccXliTKq/BOXdQencD/OpHW29XsQ8kahUe
	cPYNRNwB4ZTIZiC7gPB+42R1+2LGAZn2scwvNSJX4Nm2F4xEZc6IAcIpsK/cF1sq
	qVuqaDnCMS6msZCc4nGovjMpZtyVUsZnnFs0CNB84uKt5xy6BV/MA30WRHPELqnJ
	DFQm29tvZSd7OvgPoriG0hjLxrk2+k4ov2bhSoBYnv+7UCWPeJ6tFHq2XAmho1W9
	7vUlWgOIlCfRWn7xtEynUY86OnRvaQGQ0sUR/sOp3CsDWQlqjQIs+flbIW6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781033421; x=1781119821; bh=lwroAf0fyAXm3CtK2UOkRTDFWpPtclFDVmI
	d354767w=; b=ARraYmbT1oUegaMFD5P5laRXxu1DfZicVdSgD0R1mY9D7om92FP
	hwd0QRcNI4Ch7fA6Em4vnLG1OLThDVJ0uNAeDnpQ3GNcyC5WKaiEpTeQsI2BoGvO
	ydPryVCZVJ9J0LlezwWjT3Cmemi1ysuiv7ETHJUdIRq38LSowyJTbuikM9DTRZcO
	t0NzV6M/zaL6l7twgP7bBsdygVJ4IQgC6lZMu8ip3sO0djVqvzFRufINCxdoyXk7
	Ai7wqH151W4WYO+ODMkGjBAZatMH6EbPBiFpz2kVGUkYQDbfx8pmZ2K2tXlJDzse
	UB0NBW0CN2QmCGlItn55YuVbKaUELafkKmA==
X-ME-Sender: <xms:zWkoaljK_yar8PSZICeQTIj96QnwvHlUNetMo-96EkzLC3kYym_SrQ>
    <xme:zWkoaskXiHZPF8EhmTMX6ZzR-K0TtMuj69T5VpiKhPvRsgHYNwJmXN6OmKizqpsrV
    S_a2qrKp5zgjtGdBb1PiB28oFG24XaIvc_3UY1CP5alTvwqZtv-Eg>
X-ME-Received: <xmr:zWkoaouLun-eQ0ZCybjYGJ_VndDbcfBN05mpWext0tAgUQrzDBc_vXf9GxERFiOuUxw85lyKfpB85UtdBRTOAm7CYGWD7R7LcFZ5>
X-ME-Proxy-Cause: dmFkZTEYo0d46HlowBcY5WT/qw1BKSbsRPwo/WJ6NIhu4TJsgtilUNq1DFR6GtFRLpyk81
    i7TY+FOPF7DMO064LjAzDqn35zv0OQZTSWvxVYbAcoJCZWD6Rj1w2s3LGCMz587ftEShMP
    AaYFUhgC9rbAWfnPjCYuXEMGQ1eeOKE/drpH/+k7ghd1WE3yGO84MW7nfJlQfkGIWweAlT
    gjcULhJfHl2Z2ig6Qyx0KspF07rplp1m25+XfInu9pVS1moi2jgig8O2/uREOxxFtSnfnR
    RC6NbXJCWopmtta9LMAarWt7ho2mdW/9aavhnFhOTXiYmkeoIoRIwxQltFS/11yHDbqSWp
    M2sT6Ami9ECmMOm6Rq+BlF4omtM3Me3LvCaEzyl7gD58pL9Ah3Q1tBL4aHdDJQWv+jJsxg
    bRqkQ2VIJhm89fjnEQ13SpchtqaXNuelmUHuwtKPB1BZ6IGdQJy1FMJJ5vWMdBd7khFlNz
    Cgy9ozJfcLDWv8gWWX/iYNthVuzAkZcUONsk9fG4ocBVTVlpa7pCSx45bw4yORVk5mAIzc
    PXujHxBozH/fW821gAI+ygTGcgt/EM7gn2KDo2RiiHuljzaprpD2Oj/Ytg4sxbgnOJauLP
    ypIQK0ZI3FhyZmX2yfyskicen8yOMJmpwsGZI35wUZxiMOzb6049c2bp6ywg
X-ME-Proxy: <xmx:zWkoaqYBfTf5QynJwFMuy2lBaEUDWhGCaN8udzIEWsTZmnNTZ0NvLA>
    <xmx:zWkoaoAHPeo_mEROZbrLval1NduwIbkNVMrxKAWCH-PCYX4K0UrfMw>
    <xmx:zWkoaq_nWozrA19I6uLLJXnyQd-LJE5PhKqIhvuDQ26FKQZxHCob_g>
    <xmx:zWkoasTbNo-OEzPViuGUUj9FnbbzLOyc94eK8R8HKp-_E6cOCwmN7w>
    <xmx:zWkoalIsenhOhB2p5SnU04sokp0o_ntT4uK45rHlIsGZsrlSycQOBx1d>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 15:30:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  Pablo Sabater
 <pabloosabaterr@gmail.com>,  git@vger.kernel.org,  cat@malon.dev,
  ps@pks.im,  kaartic.sivaraam@gmail.com,  ben.knoble@gmail.com
Subject: Re: [PATCH RFC v2 2/2] builtin/history: abort reword on same message
In-Reply-To: <aihH8ye-r4QuXlRD@denethor> (Justin Tobler's message of "Tue, 9
	Jun 2026 13:02:15 -0500")
References: <20260607-ps-history-reword-v1-0-ba43a3cbb81b@gmail.com>
	<20260609-ps-history-reword-v2-0-a0e6028ca9b4@gmail.com>
	<20260609-ps-history-reword-v2-2-a0e6028ca9b4@gmail.com>
	<54bd36e9-3d21-4f83-86d6-2882a14779de@gmail.com>
	<xmqq4ijbsn2m.fsf@gitster.g> <aihH8ye-r4QuXlRD@denethor>
Date: Tue, 09 Jun 2026 12:30:19 -0700
Message-ID: <xmqq5x3r1ph0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> I can see a situation where a user performs:
>
>   git history reword abcd1234
>
> with the intention to modify a commit message, but then for some reason
> changes their mind and doesn't want history to change. Maybe the wrong
> commit was referenced, or they decide the current message is actually
> fine. From my understanding, there isn't a great way to abort rewording
> a commit during editing and thus the user would have to reset history
> afterwards if they care enough to go back to the previous point.
>
> So I do see some value in a mechanism to abort rewriting a commit
> message.

I think we are saying the same thing in different ways.  I want to
see that command "succeed" either case (normally we create a new
commit object because we record an updated committer timestamp, but
if there is no need to create a new commit object only to record an
updated committer timestamp, we may choose not to and leave the
history intact) and I do not want it to *abort*.

The mechanism to do so may be exactly the same, i.e., accept an
updated log message, then try to "hash-object" (without -w) the
commit object with everything, except for the updated commit log
message, taken from the original commit, plus the updated log
message.  And if the resulting hash is the same as the original, do
not do anything further and return happily.  Aborting sounds more
like complaining loudly "baa, you asked me to reword but you gave me
the same message? is anything wrong with you?" with non-zero exit
status, which I think the user does not deserve in such a case.
