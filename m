Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4DA19CD0A
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 01:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772502365; cv=none; b=MjKUkDCkbvOiG7CctT7FR1+w74U20k4f811T89hSb9zD5IMM6OoagGrbUe6yz2Fj76IFqc3nOPX6AqpomzheceifcYH/2E3ftrIZ9Y916KZi2G1IViAVoMsOpdEjvEyHDnSs7hwkjp/DD5UZ6kZaFIskCDCMQVrhGk+r4rXmGuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772502365; c=relaxed/simple;
	bh=jKMCcbPf+ZnYcPAUvGVCiegb2J1txfwMBfGGSYfT+14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dff3ag5SEWoyVyM+KPGjCeZDwmeibrmYvhs35ribx60k/WG4MVz9Qfk07ZXMg8zyklNzLdoulhxzF3wWZBhIAm5P9sstfNJs0FRfVK+F9AEQBp7tgcDAMw/lMZpohzN/OFch2aqt4dO3Zw+JxFpQowY3udU92LzhUYkSfGxKXgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhS328wX; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhS328wX"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4806bf39419so44856485e9.1
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 17:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772502362; x=1773107162; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L45csCIdgk+pONsGWqywJCvf1w9HGgY8wwhSLSgRFv8=;
        b=nhS328wXvQYeXfHkdem7uqLI3QZFwsYIzTR8ufxAjN8fXBUs3sw9tCDMrFEHy/rr4b
         E0tTUkDBT01AdEUCvte/GMmEplk0qtVb7cTC2h0DR/QWiMzzX6E4h9jz4JtlpVGmeMrS
         lQX6M/vZK76ILynoGLvyWpvRRNZOiKtR6k8aZB8Mxko3WTyOfoMtnRUNW7karggmBFFW
         AEhSXxIfbAqbqdurUUQNdqErMar4skvjnZ9GCkjBbceg34QZnXICBdf47vIWnQxSrVYH
         D16KKH33E0pHSCsRaAOGoO1tYeaWayapo/xXDogHIiRa1AlB2wtNRMXyDpmKXMmt2WY9
         dBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772502362; x=1773107162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L45csCIdgk+pONsGWqywJCvf1w9HGgY8wwhSLSgRFv8=;
        b=DB5tafGc9FzvcdB+3KEgXzoWy2Yw+kTFIODeNvy8F7r7FpwbI0Oyauey8mOgYUYb6u
         41FFIMKz5Gid6SBHgY8PTfmgOznbHYhAiAYpfgP5l3WP3Z+79bDs1EhV18vLCVsKpt9w
         mMyAUYwF9ZVvoUw9dgIXa1EDSvBdQu5VPO31VARS3MjohF7bkWePxmoMb2luSNhUSIRS
         cnOb1xOkwchDd9rZ1k1Sefei4xNf1rqG2scL8A84VO1k6iT/5ckDn57KpduTzSEI7Kf1
         8BwpVZGmRWKPCBed8Xv5wU3YZUisAroODcR5rus4EFmLasG43IRMoNUhEfHpu4uELJcQ
         hZ4A==
X-Gm-Message-State: AOJu0YyztWIvcVe3uHfAIkSULsNaHD/9L7efC0k1/PMRKF5nNdOS77PL
	2ehvso2tVjIKp/VjXRKinlyFOgTXlbsh25bazT+YqJo4qiFKqBByt9fsqKGqKw==
X-Gm-Gg: ATEYQzwXe+OXdUk8ioyudMjYwwi70o0SZo2szQTWv59pCodXXvgXJEuAgiPmb/Kh/wc
	V2FXNK2O0B++93hsO6YghppTJaPLmDXscRr916kxLsCoqbYR4sEGYjnaqkuabETDzJsdXxO0jLF
	6k566KocMCCn/NsZDVBcn0pM1ZwN2VBgnA515hQEN1VFrtVsZ6/oW3XArplhEz0edSOCgDpi7+2
	bwbJgIh/KazN1t0zWBnAxJkgB8gdpGSw2ELnQXPxyclGpxILbwxY4KOfnLixar8sOD++fwqOTli
	EMUkFXh33ESB70rVC2SG8u9IhFjpci+wb3sS/svDWQsKnaQFPRdfZz+08MnEkoeaDkoNYqIih/v
	In0kklO74raseBr9JB7Z1r+uzY+JwOAGa6cVy0Ge8HFJd+paZ25arKOhkfJ6xh3hEewY+2E5AKh
	fi80ybGXdeYcVTl+ZHwyGJCk9q7c6Tl5kO8jfB7GvArA0gLw==
X-Received: by 2002:a05:600c:474d:b0:479:1348:c63e with SMTP id 5b1f17b1804b1-48513a75f86mr5579635e9.9.1772502362465;
        Mon, 02 Mar 2026 17:46:02 -0800 (PST)
Received: from lorenzo-VM ([84.33.161.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851335e1f9sm4373415e9.7.2026.03.02.17.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 17:46:02 -0800 (PST)
Date: Tue, 3 Mar 2026 02:45:59 +0100
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [GSoC PATCH v3 1/3] doc: gitprotocol-pack: fix pronoun-antecedent
 agreement
Message-ID: <0d679e5eb514f33aed92f7fba4843efc53e6c461.1772502209.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1772500189.git.lorenzo.pegorari2002@gmail.com>
 <cover.1772502209.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1772502209.git.lorenzo.pegorari2002@gmail.com>

Fix "pronoun-antecedent agreement" errors.

Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 Documentation/gitprotocol-pack.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitprotocol-pack.adoc b/Documentation/gitprotocol-pack.adoc
index 837b691c89..9952fac188 100644
--- a/Documentation/gitprotocol-pack.adoc
+++ b/Documentation/gitprotocol-pack.adoc
@@ -65,7 +65,7 @@ Extra Parameters
 ----------------
 
 The protocol provides a mechanism in which clients can send additional
-information in its first message to the server. These are called "Extra
+information in their first message to the server. These are called "Extra
 Parameters", and are supported by the Git, SSH, and HTTP protocols.
 
 Each Extra Parameter takes the form of `<key>=<value>` or `<key>`.
@@ -277,7 +277,7 @@ out of what the server said it could do with the first 'want' line.
   filter-request    =  PKT-LINE("filter" SP filter-spec)
 ----
 
-Clients MUST send all the obj-ids it wants from the reference
+Clients MUST send all the obj-ids they want from the reference
 discovery phase as 'want' lines. Clients MUST send at least one
 'want' command in the request body. Clients MUST NOT mention an
 obj-id in a 'want' command which did not appear in the response
-- 
2.43.0

