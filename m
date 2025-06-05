Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C4CD2FB
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 15:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749137700; cv=none; b=tpdyjCGgxH89U6VEwNSIMvriES7+axwvo2mHMpMp2IjuOeHWoqPPcY8BHrR1BobjE71y5JO/R5ZfaLRzyK4X0iog1ImSj3N2MDj4U8B6o7xZMjF/x0uE+C9Azb4f/HqPokpDd39P56FnBXXldv89HL0JKenF8LadWGkonyan8Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749137700; c=relaxed/simple;
	bh=e78EQgyXpr/vBsVnMEXX/gsY0Rkj3DKDozcwW9JDcao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iwno34gzUHgTSHaZt0XtGZGt8LeTuRNG/1xTaMtOUBb6b2/cwKvggamDYJaBNkoILV2YGyke0hYVYdadSNAjtJ1sg+FFqAaFMcSQcP9dfq3f8+Em0fSJJ7qX1aO74lw+87HZsrEgBOCLG8tlsJPd6DPIPOS2kbcvhmfclNFqz1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdCppOZ9; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdCppOZ9"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a375888297so776515f8f.1
        for <git@vger.kernel.org>; Thu, 05 Jun 2025 08:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749137696; x=1749742496; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0QBXVwj58dnl81vc4tVGO/dxG7WjbyErXY3PWVo1d6o=;
        b=EdCppOZ9JjbFQdcccc1Y7xA1qNg48CKC75PLylXhF+gHX1ynzznmEOVsz6bM5kDuJO
         V5msSTXftWDVILG5GekoRra7r0XEY5BZN1TFLzjkSFu/NXJ4qkwJbrZqeKoKA5JP9+UL
         E33mYoAk/hKoyR1jVdnk8dhm6PBsO91T2EEb8030Pxu4nngZ55sdVeimmqsnBiE3jFa+
         MrHvA29gcdfNUTMUjSzfcF9FV2m0DO/GLxkyyumDU20pUWxwxF97bFJGvLX9Wwz7Q03b
         KHkdsmOtZCucSREayZmnqUqab3rM5nsc+P16KG1Lj+BU7NluXKPJyf2fV2wVuwiFSkFO
         C4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749137696; x=1749742496;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0QBXVwj58dnl81vc4tVGO/dxG7WjbyErXY3PWVo1d6o=;
        b=CDapI/gPI5cgtXev3sAx0jUywRhuwvKkMauKR5TcEf50w3iRv6jqY+nwwctHQFpSoF
         ZmNe5RUW/QVwZMNHcKvxIyZ0ybg5ktKaECODd4Br8z0zBLADV8Awyw2DwWUtfpNXRK/w
         4/vgad8ylde5PGmRnh7jCClSvnyCofcr4QemGMCaoDJutFRyozUtVynphD2z0nMBD5Sc
         vjGK58uUm9HgZSWPnVUAaKicnSHCXhfs0Vphk/exOSltXIHQJ0pTKCdEjddjo4mILXVf
         h26cJIxVyCngmgUND+e8UzD+GjXa3yDuN+R2W2Yofppt28uFQxvcDgGsMnK7l9elec7o
         EL2g==
X-Gm-Message-State: AOJu0YyV5xkHSLd1yI17yEzZzVIwuyvQnPI0UFwwWkWv+LphoTRFWKDI
	K7UAdrpbrh/OB58wdsS9wQaAXbIaOWDD3p61Bh3gCpsFv9jnmwOZPCQLhjZ48Q==
X-Gm-Gg: ASbGncvbbzG/InrGeU7010aXAx9SGweH8bm3+ooCvzxQVAIWdEAfKUffefSmATyDdOg
	urODtgpyyOKkj4SMnKpOvHPJ6V7YbI+upiKXGADy7m578pidd4JgIM5nLELnZQTLMvL5phkbJ9U
	VW/Fv8RyMa5/1QoT24asYKBiMDJ0mZN+eYU6h4UIhIyg+wWckTDC+hpQnBI8+6O5QSmXTuqaeB8
	jap2A2QeaONVEuIgIsr4EXMXo/McK2RLb87VeLxF2AmVILXnApc3NmNhaSDpp9UAIhCeWDoQDb+
	JO3uY+qVnYfrDUdULGW5W5g4ACHN1jTiHD8ZN8hLhe7O+WKhmqCOqsNGJ9V5AbVrZO46YNTFPAA
	EcWtO2ORZY9JL2iYS4CziNG2NaQU=
X-Google-Smtp-Source: AGHT+IF58Wuy9h47oX7pNC5FzbTbXkK2zaOcEZbOQXRwFCxZe8/QKZpjV8ErfJxig6wwCU3huKF+5g==
X-Received: by 2002:a05:6000:240a:b0:3a5:1360:6b34 with SMTP id ffacd0b85a97d-3a526dc524cmr3531974f8f.2.1749137696331;
        Thu, 05 Jun 2025 08:34:56 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f00a13fasm25197780f8f.98.2025.06.05.08.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 08:34:55 -0700 (PDT)
Message-ID: <e9d90ed5-ae59-4e2d-9170-e49c0ec58d2b@gmail.com>
Date: Thu, 5 Jun 2025 16:34:51 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 0/3] diff: add pathspec support to --no-index
To: Junio C Hamano <gitster@pobox.com>,
 Jacob Keller <jacob.e.keller@intel.com>
Cc: git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
References: <20250521232917.2333291-1-jacob.e.keller@intel.com>
 <xmqq1ps0il6k.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqq1ps0il6k.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/06/2025 22:12, Junio C Hamano wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
> 
> Anybody, other than Jacob and I, interested in this series?  We
> haven't seen any support or review and I am considering merging it
> down for the next cycle sometime in coming weeks.

I think this is a useful addition. I've read through the last patch and 
didn't spot any issues. I found the commit message is very helpful. I 
had a quick play with it by building what you have in seen (09fb155f111 
(diff --no-index: support limiting by pathspec, 2025-05-21) is that v3 
or this version?) and it all seemed to work as advertised.

Thanks

Phillip

