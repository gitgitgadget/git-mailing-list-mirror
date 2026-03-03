Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C132638BC
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 01:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772501655; cv=none; b=S7nG/exhb1JyYoGhXfDVgqLoc8/RKhREfSOJwdHdoTiu8ltqkMaLrWTkgSk4Z9aKfk+FLD6iLDdogk6sfJAsYQvPnU3INfbAE9L+Sf+psvEQ/2UJTRm/Qpuqyzjby0WfAx5xsMiOviXHDXO/jBtHk341SlaIEIHKDBwBDg4vlXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772501655; c=relaxed/simple;
	bh=XGgmbUaGAkCqwKG9eOeKfROgeYDQBBiViNBKmVdOmHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiVdPKCynVr17Z0cF33DfWiYLA+hzPNrQsZMa03msB8unokmJ2scp/yOU0e908u/Kx/iXMinE1aTeLYHgXzcABOXVuetRzs95PXSuavDN7oPUC9kZFqHG8TjPz8fVvl4d6thgHcQK1R0kgAoHUnx2Num8jX6yuRa9GKYQXu9kpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VN6aH/iN; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VN6aH/iN"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4837907f535so44216535e9.3
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 17:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772501652; x=1773106452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T6EVb4sPmbJVfDJV6ImjnbCoeff2NKmqo/BdoEja3Ko=;
        b=VN6aH/iNgXkikh/9AbLZhrKFj/KtDU9upzx2mWivtEfKFhaTKHyo8FoV9fORK+xTBs
         2vejGjUc6jJnZv2VtxfuzZZ5iEpRyCtnRJgHCYVLXIJWBCsSYuP+b7gidyFaH4t6x8XQ
         rfFnHVRd5ljP2hKBQK4+sckj8GkR4nSFtfxI7y0FNRqnLRBrx6rf7zFo537EM94ZAXcp
         EtSA7eMPDDAVw7jCnJhHwxBozDf1d8jsu2KmiGGM3w2gPbG9Gcft9gtJ3rE+KQQrFtjm
         OwILMV7wWyz9Y2ylOeHlY8gAwkmLxwV8hJPzf/2hPsvuyi5HUV0ijAnY/PXYns0O5n1Y
         Uzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772501652; x=1773106452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6EVb4sPmbJVfDJV6ImjnbCoeff2NKmqo/BdoEja3Ko=;
        b=M5WqbINPlXCFke3Caoqbeh58P23i81Emi9jkQPN41LHIGljYiYcsY4N+e8HP5vo3aV
         Ki9l1VVp+3DDZn7SWgiVNPoq8aUXY6jSMULW3xOcFrQOrHzWFK+hlpLwm5Vf9W3SnI6E
         ApWBuHqM9T/Nmj5Xd77xNMr7T4MTg1AxOvoPopPC35TemUXD1MbCXfBxRqqDm7874nBy
         SzhW/BsAfJJVlVpuf03ZViEVPzFceCHWDmCwVpEN3Cw7UCOh/kCs/zWwQpHRM9YHWAXH
         7bJlV3pLE0GMtAlhsKm/kljxVR76V4jVkSL883lp3TGOxH4C66T1tLMqy/AOJS85+/3r
         v7jA==
X-Gm-Message-State: AOJu0YxwyJCfie7l54tAaactRn5h/DbY7ubGcTV6cbRr7E7icgvbRCUm
	3bCCgu44Hx7NZwGXWgJOqBTpCT96p/EhNmJGPjubAMyza+/UKKglRa7uJFrLAg==
X-Gm-Gg: ATEYQzzuRu1M7g6hJa8qbn6RtLa5Pg65BMV/x3QWaFUBL2M+aC9UhnBJbGX7hJ0PDpY
	MiHUxIFreL/oy2anhf+s5N6cFw7PptjxCqqzw7XSd80cxkVGJQbtzaQU2G2bDMl5pIl9BMSCD2L
	l1Lpw0o1Nr9v0WaLruur0WXi4Pa33yyYfjVPgnJwMgANuFd2rm/ZQ01W1R91XLiGOxDwWhuKQSF
	5sp/SIjqdyiILPZz/WZa4+Yuuh3UcfpFvOuwe4KZgLoLSe9SoBx801HmD8jgmCiY/lDpPmyHkWR
	bb8PwGy0zpgllbfpRblfVJnDmXTn3nkf8MIO1K7i8cRFdcDxr+xXzSXpbh5OUo18BAdZd9Linfh
	EhTJtHg0bVdqS0K4YT2NpOF8rBQ92cETafu31hxlB0T/BUISYn0r9gLMSpPAFjWFXlkvmL3Mjy0
	NRqj2eYfBprVjEaZrkjeQflntJ6WNcTOloAQo=
X-Received: by 2002:a05:600c:458b:b0:483:6d4a:7e6d with SMTP id 5b1f17b1804b1-483c9bdb6a8mr225323145e9.30.1772501652292;
        Mon, 02 Mar 2026 17:34:12 -0800 (PST)
Received: from lorenzo-VM ([84.33.161.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485135d8870sm2978435e9.32.2026.03.02.17.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 17:34:11 -0800 (PST)
Date: Tue, 3 Mar 2026 02:34:10 +0100
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [GSoC PATCH v2 0/3] doc: improve gitprotocol-pack
Message-ID: <cover.1772500189.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1772467050.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1772467050.git.lorenzo.pegorari2002@gmail.com>

While studying the `gitprotocol-pack` documentation, I found various
small style inconsistencies.

These patches are just tiny, simple improvements, mostly to improve the
clarity of the documentation.

V2 DIFF:
 * Fixed final patch to properly conform command and process names to
   italic format, instead of the inline code format

LorenzoPegorari (3):
  doc: gitprotocol-pack: fix pronoun-antecedent agreement
  doc: gitprotocol-pack: improve paragraphs structure
  doc: gitprotocol-pack: normalize italic formatting

 Documentation/gitprotocol-pack.adoc | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

Range-diff against v1:
1:  0d679e5eb5 = 1:  0d679e5eb5 doc: gitprotocol-pack: fix pronoun-antecedent agreement
2:  8a6b5d4c98 = 2:  8a6b5d4c98 doc: gitprotocol-pack: improve paragraphs structure
3:  e0e4ea3d22 ! 3:  6410967d65 doc: gitprotocol-pack: normalize inline code formatting
    @@ Metadata
     Author: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
     
      ## Commit message ##
    -    doc: gitprotocol-pack: normalize inline code formatting
    +    doc: gitprotocol-pack: normalize italic formatting
     
    -    Uniform inline code usage for command and process names.
    +    Uniform italic style usage for command and process names.
     
         Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
     
    @@ Documentation/gitprotocol-pack.adoc: supports passing environment variables as a
      A few things to remember here:
      
     -- The "command name" is spelled with dash (e.g. git-upload-pack), but
    -+- The "command name" is spelled with dash (e.g. `git-upload-pack`), but
    ++- The "command name" is spelled with dash (e.g. 'git-upload-pack'), but
        this can be overridden by the client;
      
      - The repository path is always quoted with single quotes.
    @@ Documentation/gitprotocol-pack.adoc: In multi_ack_detailed mode:
      Without either multi_ack or multi_ack_detailed:
      
     - * upload-pack sends "ACK obj-id" on the first common object it finds.
    -+ * `upload-pack` sends "ACK obj-id" on the first common object it finds.
    ++ * 'upload-pack' sends "ACK obj-id" on the first common object it finds.
         After that it says nothing until the client gives it a "done".
      
     - * upload-pack sends "NAK" on a flush-pkt if no common object
    -+ * `upload-pack` sends "NAK" on a flush-pkt if no common object
    ++ * 'upload-pack' sends "NAK" on a flush-pkt if no common object
         has been found yet.  If one has been found, and thus an ACK
         was already sent, it's silent on the flush-pkt.
      
-- 
2.43.0

