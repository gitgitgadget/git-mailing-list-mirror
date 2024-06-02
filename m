Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B00D4F60D
	for <git@vger.kernel.org>; Sun,  2 Jun 2024 17:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717349597; cv=none; b=HqlerVsIsTLOIkVytZ8mbkkiNS+5c0iYHkBAHhGKjg/gQfkiKsbQXc9MVOFd2G75FMgQo+ALyhSeEUT/AaoobVJDZTw1wcWf5L+IxmLR0j1eWK781ohk+bt4Bq64sJmCD1vw2gf/+BvY0oiDF+HEtUoUHPQ84czbXjqTEjC+Tfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717349597; c=relaxed/simple;
	bh=uYYllsu/UiEWmubvI6bwX8wGIXfPS+tj/nSjfP+yVeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RG84keOYYOnPFHgzcln0Vh8jFzEG7J+29sEbpKIKmwyE/8srODhW+AOuA3+MBJh/O4XxGqsJtNMJWNgbwvvsOsAbSdwkk5/6EAuM1EDb/shy+Ht5MNRazBmFOUTuYxsGT2eacwdwj6San2VcZmoTAI/WIa+xeJsHXDmBmURWcFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EybRn5MT; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EybRn5MT"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-35dce610207so1262430f8f.2
        for <git@vger.kernel.org>; Sun, 02 Jun 2024 10:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717349594; x=1717954394; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I3ILuyZNw1p6UrrboGwNSxuV/RDuOdS4AdNaSlSxp7U=;
        b=EybRn5MTb+P6PKnzs55XA9iYh17dMoNmVQ1NdUg6G1466lu/YRPnfuJj0cE1NCLzVB
         xn0Af9GZ+GBKUOiByVkU5LX6jmuEWTNvvjomJ7sxHv+0fGAzZjWwu2Abhor/0qUa+NMT
         tG15IFoklEEq4OJU0sF/XOfJodPjYXqhUdohJgT2T4zRu2Ivah6a202VWswHpDklXnP8
         oso7sbPIpPGmQ3BxqIDjCqvqX4A4gbbrsHUIpUZB3VH9Q8LPYheBOMx/Yanznkm0DLo4
         qdgf/6GPkFtKxPjaDINk++DSla/sgNJmnbGfQpLGlKVp6ekeX/a4CPolVyUurPloOD6g
         aZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717349594; x=1717954394;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I3ILuyZNw1p6UrrboGwNSxuV/RDuOdS4AdNaSlSxp7U=;
        b=Twl8uO0Qafeed1ioj4dRTN5mofY4k/GieUaVvhkKY0d3RW++R6ADWhuDdbSajUZ0AI
         eYFst+ATp0ifUZ8L2quP2xhuIPdPaTobkr5siJINAI4MMWvaEZ7jDn/mc7fTO1HZcyxU
         wcVaEn/RO0w8Mo6/IkdVz5H7K9giDqHj0GFXC9gdJ3Q0uz0M8I/H8TbErrWDjLaU6zcf
         PJhYktmwMTzw6KrckAmfgbxO3Z2vS/jPc2TGYIi65qbEF0Q4HRpSLmpWEyYhkZf2wlbi
         15LvKus5/D3vLTD8BPdyVbcIpGUBCAteT7zW6JZibYVlYI9p8LoAodF/SYh2mvSTsFqt
         vA8w==
X-Gm-Message-State: AOJu0Yy9OeIRituiEN+6DBGXCFU+2Ervueokjea6CoB8xqNxnv8Uytd4
	E7bcliR5N1s6RMSUhPZ2BOXe9v4JMxECVotr2hsRATMUbna3efFt
X-Google-Smtp-Source: AGHT+IG/RkKvqyl6ahOM8h2Dlq7VbQxk/lx32OXVLwmQOWY0d4N7GD34cR+19/LNYtXI0WMIB+7VYQ==
X-Received: by 2002:adf:eed0:0:b0:354:f57f:7bdd with SMTP id ffacd0b85a97d-35e0f325ab8mr5714551f8f.45.1717349593530;
        Sun, 02 Jun 2024 10:33:13 -0700 (PDT)
Received: from gmail.com (35.red-88-14-62.dynamicip.rima-tde.net. [88.14.62.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd062eda6sm6659601f8f.86.2024.06.02.10.33.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jun 2024 10:33:13 -0700 (PDT)
Message-ID: <7ab01cce-ee08-4ee2-8fcc-65324c340aaa@gmail.com>
Date: Sun, 2 Jun 2024 19:33:12 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] use the pager in 'add -p'
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com> <xmqqwmn79u98.fsf@gitster.g>
 <xmqqttib8e22.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqttib8e22.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Sun, Jun 02, 2024 at 10:11:49AM -0700, Junio C Hamano wrote:

> By the way, although I personally do not have much sympathy to those
> who set it, in the presence of interactive.singleKey configuration
> variable, a command that takes optional argument may turn out to be
> a mistake, as the user cannot give the argument even if they wanted
> to, when the configuration variable is set to true.

Well spotted.

Perhaps we can do something like:

diff --git a/add-patch.c b/add-patch.c
index 5a586d1b9b..01525214f9 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1685,8 +1685,17 @@ static int patch_update_file(struct add_p_state *s,
 		} else if (s->answer.buf[0] == 'p') {
 			rendered_hunk_index = -1;
 		} else if (ch == '|') {
+			strbuf_remove(&s->answer, 0, 1);
+			if (s->s.use_single_key && !s->answer.len) {
+				printf("%s", _("program? "));
+				fflush(stdout);
+				strbuf_getline(&s->answer, stdin);
+				strbuf_trim_trailing_newline(&s->answer);
+			}
 			rendered_hunk_index = -1;
-			pager = s->answer.buf + 1;
+			pager = s->answer.buf;
 		} else if (s->answer.buf[0] == '?') {
 			const char *p = _(help_patch_remainder), *eol = p;
 
I agree this needs to be addressed in this series.

I'd prefer to leave the feature of reusing the command, to another
series.
