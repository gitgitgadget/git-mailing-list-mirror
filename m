Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CAB17C8D
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 18:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pzqdvIcg"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbeac1f5045so8250356276.1
        for <git@vger.kernel.org>; Fri, 12 Jan 2024 10:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705082684; x=1705687484; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7L+nGtSpR1VdWC6tzxL/aVzSpMg7iZZQ2gGs2OmRVcA=;
        b=pzqdvIcgpImMcejwLoIEF6sV427S9phkD8pOiE3v2HIG+6Q1aUezfWU7bHTtIm/cNq
         hD+AXIswzRpVLppasOrTLWBjxrnVXUHIB/Aq0x1GJ2XkcUK8hLSzdHITDcGaikbK5WFO
         GdYdXj00oPJ/9r3K3uD+7zQib5A2u/PAU2Hr4lzLwg/cJz+rAYlxSK0852bg3U+U4Nes
         7sO4j7E8xb2wA/7CpvGMAwS0W6RNE7YmPOkbNesZaukehHj63EPv1hUgeXYBfvEskz1i
         7/ruNdC558YmuPQvwDCgC+EMEtdX5n9GrRfP3dw8nvrj8ogPubfnOyoYFILegnrAnfIw
         pebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705082684; x=1705687484;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7L+nGtSpR1VdWC6tzxL/aVzSpMg7iZZQ2gGs2OmRVcA=;
        b=TwE7PclTfVXNBWnwcU5UnmCOuejDcbmepT1p42zvh3iQaIy5wX/NIUjbLt3PHR+HRP
         2NtjO8UpT6XXOw4a2BubrZLxwiHqH81wbwn2sbhdyGsns5dnXm2Sn7eO0R5qAGlc81/y
         6EP1zm2LIfM3bAcV1dvn5sKrlitVWXYW0KKKuD/UglmaxoTyVGbNDCsX1XiGJmKQvhZd
         +9q9Yi61I47xOWVbvfARDgt5T75yY9n9measA6cdBnLIK1C9jNzGGubfVsvmCrTsKuFV
         eWRB3zFTrWIWI7nqZx/P66FfuH3DsAokVmXW1CuvE7Cwr/JD9H5BsRJn5hK9TWuLMpNR
         v5PA==
X-Gm-Message-State: AOJu0YzTVDXJM8KvQknFIJJ9keZDaGGjQ1F/yVTayLkgdTVBzK1fxQSz
	X1z2Cf+dANfEPzXMyRtdZg66yOw9ia5fReXwUg==
X-Google-Smtp-Source: AGHT+IGW2eQO/LfzQHhUGeMST3vV6U2Ldecc66mL87hHblWGoVhDhKBNlGc4BtOQL5AW+lkHZMQtV7bjYI0=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:2681:b0:dbd:ee44:8908 with SMTP id
 dx1-20020a056902268100b00dbdee448908mr510939ybb.0.1705082684642; Fri, 12 Jan
 2024 10:04:44 -0800 (PST)
Date: Fri, 12 Jan 2024 10:04:43 -0800
In-Reply-To: <20240112074138.GH618729@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1640.git.1705043195997.gitgitgadget@gmail.com> <20240112074138.GH618729@coredump.intra.peff.net>
Message-ID: <owlyo7dqig1w.fsf@fine.c.googlers.com>
Subject: Re: [PATCH] strvec: use correct member name in comments
From: Linus Arver <linusa@google.com>
To: Jeff King <peff@peff.net>, Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> The source of the problem is that the patch originally used
> "items" in the struct, too

Ah, that makes sense.

> As you note, we still call use "items" for the vector passed in to
> pushv. I think that is OK, and there is no real need to use the terse
> "v" there (it is also purely internal; the declaration in strvec.h does
> not name it at all).

Indeed. Perhaps I should have included this in my commit message.

Side note: should we start naming the parameters in strvec.h? I would
think that it wouldn't hurt at this point (as the API is pretty stable).
If you think that's worth it, I could reroll to include that in this
series (and also improve my commit message for this patch).
