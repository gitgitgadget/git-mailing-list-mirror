Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8FD2701CE
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 09:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752658885; cv=none; b=bwFwfMmnRhU5f/u0FgGlRIc4m8NeZ3YziHePEVtT6fP++eNMAFY7Br+k935oZCc7KPMs6/wUa03r5Y7cc7l/711bApd0BCeSrCsFtQFTQddW0kcdSGtFK0T6wejotyRS2gib6i9HYC2Hq7JlQsB6bqV9CyAIK0XIFNZY7baA1NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752658885; c=relaxed/simple;
	bh=uQTTEejRQ9bToccyWiVubNRCgxJOrei13N2vgE+FVl4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nHaYnYw1WWphjKLvRYHuzOYdscPE/7B/acho1qXWD0FDd/YVxexLQXwc0CY3/3UaRYhz7Zyxx6mnUGwTu0A8divb6kbTThRdKUFG2t7Tai6DUyBbIlhFVOe/1jPRLmGow1M8goiltdaB71fkDlTHHaJcS6fUUhVzpxk2GErJwSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9VE2ehM; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9VE2ehM"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a52874d593so5029499f8f.0
        for <git@vger.kernel.org>; Wed, 16 Jul 2025 02:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752658882; x=1753263682; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dzcpXGH/OYDm7Tu28S8YS6oNnk+Av9hoM2Bh6HbOd1k=;
        b=m9VE2ehMACFKVI0xbHWVwLG4l/zgU9Qsqn/gFz2P1KNtaUIaOJ0mMAPqQicLQ9IA4K
         6FyjaueohhBGSmuQYECd15QmpPGvxo3uKYt5AZf6Ox5mXDI8KR3btnQH43SQ3BQxEmNr
         xDw7JXW/fDwo7XBc6Sd7LAjc/gTSe+WCv95SGxAwfSlT7E6MvX/yw+BWpdsm3uBxOxJz
         jB37Yb7NCp0Eq4E8TzcbAJsE0Gsb50KTH2wGTi1fzu0MjT75Idr96BxqKj23TobgUS8W
         aK5uQMWAHk3WDuGhBer9npS+MLqzB46PTjYMI2jcEHcriBJ7M4rZh+ePw9f/SH8tKc1N
         hwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752658882; x=1753263682;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dzcpXGH/OYDm7Tu28S8YS6oNnk+Av9hoM2Bh6HbOd1k=;
        b=iwE3OWWgEpV8Sx6vqgj7tE3R23NiBbrnGMDAshx6s/kItTM3nqb1LeUzZjksPx6v44
         vGSoFrfYprTU8cnNn+D6SZt5CxMvFD5oGc53lr2IGKR/nHTiuZyuHBmyfjeeGho7I4aR
         a3HOtNdpnGFC+nl6CN01HxKPIRkBdbRLbn+Y8FD2+BjtL2HKML64ua3EyDszhoRL8Xjo
         26lHp0eLwbnsxuLThNoowGhDWSR3DJhollWn4S0tAQNh0/gQAY2a+aHOJFqlBNPGWQVt
         2r8fhjuwYtl/VePrdw+QXgAyyo4EN82lyNVGNm8QqdjPIy64Jz907N6EsUSX/LkKB6zY
         hwmQ==
X-Gm-Message-State: AOJu0Yx/R5KgJtXspRHDh7IlQuJLh3DR5Xp3CxmFSRKAEM5EhoJqfXCl
	RoKWZjZttVTimw7pWrE+Usxip0xgSNaqkVFluzXAl8ZhBZY5DxQ1X4g+
X-Gm-Gg: ASbGncuUkCVFzrCpyYFxSaOAr3M/VetX3vnDHhC3QCb7kYJk2Ld1FiRfTEDpguI8fzN
	0xvKmb9aJnsUouYFKbQHwAw+YycDaO3hyFOCD6YFyA/dDAQV6PNuaa2v5ek8PN4uinQ+mk/psTW
	2B9MbQNVjOHK/zwrUx6YFwGCCCMV6B7puK4uMLk0eFKOK/PqhOQBObkrgODFwv/goa3avmk2Ytv
	HYcjsj8i8x6x0/H2zDTN8TAQdMgsGf+tgKVvfNdBVUGV/0noDFCe/y5zW3heSACmrLoVkKaaCJl
	pIdPVu28/El7x+6RaL6kD7PwMbmua5de5vIsfruwxhNi9fYcMX1U/hC83uHH+6Sh5PGJMyYGP5G
	R7khS6/MEXo4zgH8HAxHhSvBT2RzNIZmSmaSLVLCwcQYwMYSxHGO1fT6emq0iMVy132cuDSK3OL
	ao
X-Google-Smtp-Source: AGHT+IGaf3TLcqroGXcqJyT9Rt3G68vE/XSn59tK8xCqVdUm+TVUTFJZG7kMaWIuXwvzmSQrTGGn9w==
X-Received: by 2002:a5d:5d0c:0:b0:3b6:463:d886 with SMTP id ffacd0b85a97d-3b60e4ccea6mr1651272f8f.20.1752658882459;
        Wed, 16 Jul 2025 02:41:22 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e14cfcsm17577819f8f.67.2025.07.16.02.41.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 02:41:22 -0700 (PDT)
Message-ID: <a7aceebe-e2fa-42f2-b36d-0ef692d148e9@gmail.com>
Date: Wed, 16 Jul 2025 10:41:15 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] config: remove unneeded struct field
To: Jeff King <peff@peff.net>, Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org
References: <31724ce432b19088b7c7643654788d8e712b3193.1752588042.git.phillip.wood@dunelm.org.uk>
 <20250716043455.GA1394788@coredump.intra.peff.net>
Content-Language: en-US
In-Reply-To: <20250716043455.GA1394788@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/07/2025 05:34, Jeff King wrote:
> 
> Makes sense, and the patch looks good to me. Thanks for finding it!

Thanks for the review

Phillip

