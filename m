Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8E413792A
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 19:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713294703; cv=none; b=jfsEjXPA3EBZ37A1xleiqIyWWK6kQrZOWFMn0t43crotxABq58tNXCIKbpH+rDDb3sF1uWIuniIXXiIogCxJDhx8E6vpYXDTJUrPJJMO1yUDeU9qeBXprKskVFPYJa+Kams2uFfSvVMbdDHPKBAPEfaqeD40+QLGS4IFURD1u3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713294703; c=relaxed/simple;
	bh=pW5AWD4xK+CN0wAPBFmC4waWE+frgcwPA+fVeKcQPN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NbnASuFWa5wwHs6AldABMVKiftMEtwxVjrzrCl1MZ6op8U46o21L24yUNGeSVOdy8PmV45l3ASoKZGj0TmgkN56cNBS1rofpFlIRfmQTdHh2b0t01SlD6AKCZU/kWa1uXLXYz0IRCGZsBUcj5IN8h9GYv2AAM9LgFqCcqZ0Bpe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0FG0F8S; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0FG0F8S"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-417f5268b12so42136945e9.1
        for <git@vger.kernel.org>; Tue, 16 Apr 2024 12:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713294700; x=1713899500; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nYH+T9ZBc2mWqNSx0EtPpiCGhqfGwF3dOOxOJlrULiE=;
        b=N0FG0F8SOAwVhrnGpFIfsGGG7QdMawzbbVdOWgrI3/BZHpm2OCGsSiZjxV3M0HnMCb
         Nep2X2IkwR9hksYNn2wlTS38EIoqeW86sdVA/5CDYJcHrfypgrZQlTSdEds114Lf+I6e
         FnTyu4L8xjL6eTnn+ujpPX2nM/RHbI8vxjVBQVcPnhPMnNazCqKLZquD2UV9olV0U3E6
         n3FH9JOjFVsNPgdI3bhvGiqfpfvN287rkJh142v9rcXJ49EwIL4zFMC7mhrxcIaEmRmn
         K19bQyyirWHcwsAkc5Sp3WLLcpkwW4shUtBMcw4sUNFp2OqfS3Uz7Mfj0tSrhD8mjS1M
         Hm+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713294700; x=1713899500;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nYH+T9ZBc2mWqNSx0EtPpiCGhqfGwF3dOOxOJlrULiE=;
        b=lG/31XB5yylwu+5Jk6++XjZwSnirCGq4xsu6qkSXYa9VRFHON++YOQYOn2JmoYBn/r
         oWc5rRixRJfjjDDTAia3TbJnRIAggCkgJCNhbCJylXksnv5xMGomwlnm0R3F0wbddW6Y
         AfsySWDmqL0M3tOaeqhFbS6sBZxAgJGYQ6FArIQLepYflvRRI+oJFDcygj+ma3knyD8p
         klQxbWcpPlkoq7xyP3InCA6GafVKzfMIsNWy8Lglko2DKj83RSHnYLYMOQZ5B6TgXBTD
         VEHYGNZ7g28hnNUnvEV5mn1WHZefRDErvElurm6qDsD4NdpEoeU0H6/Gxv+HqCpphYRy
         2SMg==
X-Gm-Message-State: AOJu0Yy0Tkox2zZ371T2S9ay73/0tQ6qkcvg50gntQzojq/gA3FMGFPA
	eVtgMDmA3jIUBr8YeSiISe1rmPIEE9eqUGSsDO/oxJyhpiB7tuBH54alKQ==
X-Google-Smtp-Source: AGHT+IGmoEjCIpc+RFAWYLM5d9dtoktev/Tmrw/IZ/L1zPJTsLNR6iCuzAvMvM/Ep7rFvzdQFusqCg==
X-Received: by 2002:a05:600c:468a:b0:418:c6a:b6bf with SMTP id p10-20020a05600c468a00b004180c6ab6bfmr11052607wmo.11.1713294700087;
        Tue, 16 Apr 2024 12:11:40 -0700 (PDT)
Received: from gmail.com (91.red-88-14-45.dynamicip.rima-tde.net. [88.14.45.91])
        by smtp.gmail.com with ESMTPSA id l41-20020a05600c1d2900b00418a02674edsm2351054wms.38.2024.04.16.12.11.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 12:11:39 -0700 (PDT)
Message-ID: <6780c9b6-ece6-4bce-b020-d1f828f3fb73@gmail.com>
Date: Tue, 16 Apr 2024 21:11:38 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] add-patch: response to invalid option
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>
Cc: Git List <git@vger.kernel.org>, Phillip Wood
 <phillip.wood@dunelm.org.uk>, Junio C Hamano <gitster@pobox.com>
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
 <Zh4R5yonRLBcunCR@tanuki>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <Zh4R5yonRLBcunCR@tanuki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Tue, Apr 16, 2024 at 07:51:35AM +0200, Patrick Steinhardt wrote:

> I think it would've made sense to describe this change in the commit
> message, as well. Currently, the reader is left wondering whether "?" is
> a new shortcut that you introduce in this patch or whether it is already
> documented as such.

Perhaps, something like?:

	Instead of displaying the long help description, display a short
	error message indicating the incorrectly introduced option with
	a note on how to use the '?' option, to get the help text.

Thanks.
