Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1115C3E49D9
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 09:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427694; cv=none; b=XwUyGXzicYDkXZXn9RS+GpBvpNQD4K1viOiU5D2T+gJE218T0SpA2iNjMextOXmoqFQZcFF0szh6YerE+Nm9P9PwdGKwgjPMjd0nPO5BI9PVHQQOEkgdOE1XjWCCOTybsNyDnSLSmmx93mTwiTGJNeeaFqC4hl79r76m3z5Uqqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427694; c=relaxed/simple;
	bh=WzOcS1WLXBBuyQwK1MjqFgeB8DwxmNNWao3PG9u3Gmg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JtqmxlpTBJ9rXt9/f+H1118wej6DQvL5fkDmueX98/FhjE4FTWv0QPA1txCwYH91vxrW6+1c0mLbw9Bh7dA8Hq70X9qkbLnR6LxJBNNiTxYEcpUBPcWvJz8vdNQJLOu1lF+iyUd+2VB0j9K6LLTKvTTKSyj6pIwImc5HPmL8Cso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7nGbg+x; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7nGbg+x"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49954b88fffso16400005e9.0
        for <git@vger.kernel.org>; Thu, 03 Sep 2026 02:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788427691; x=1789032491; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AdzVEEGWxrcOHMswh+uTkAA12Wc/DREv0buX+aRLl9k=;
        b=O7nGbg+xHwfHgoURxJFmp2+yMwUiSNFcuNjAuIQn7FQYNpWWG6FeOwQ+qUqN2C2dFi
         aKELztDzI+zD90ggJkdJFPzI/URnNRQuWs8rVORqemg16sLTl64lZAbk3d4RsRnqKbhK
         I0I/C+cM1nF2xCtB4Wss7y+G+vJk5NBZgxj6D/dfNQ4XZV10Zo/UohHSMvrSUcsatkbK
         F3be9FArajWCKzaUKTJ2Iu0os65g+eXdfOLxGWfj/UGPVUphxaUIEGBrTMTZAR2natGs
         79Wnxinkx1Dqii5sZ8AdrRLFXwvAptgtimZ7mXgt9DQDRcDbUMkoOein0u+gDNnFCUnW
         SLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788427691; x=1789032491;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AdzVEEGWxrcOHMswh+uTkAA12Wc/DREv0buX+aRLl9k=;
        b=nbrBgtvTyyoMK6Mn6Px03TyT2YTKQV5vYKAKZFcAmsdP91Gm0wh3X22qNg1ge7JMZl
         9NOBHBIuJOnL4Nx7M+/uC5Ut0obOhraTdmcOm7aKLlR7hmvDUd2HGW4wIl3LapYB4FI/
         OvDXH8cXuuzXkmef90b28d3Y9b8Knc2VFTxUBCdVrllS1RESjfxEQWR6jxnbpc3SMjLE
         j2y8sjIRjNwVgnv3jvUQJ4F4cfh55N9NMsUzjp+MdqzJL0GmoIGDcYjUQVvbPl9QWzDf
         30pUza2wGQ3MgojV7nBKErL6FKxlW2Ii9ruFW4wZHenXXkeV/PIoCyZ760hcT4PwGQZZ
         tv8A==
X-Gm-Message-State: AFuF++kthcBFb4L4c857AU4LA1HCzeAjmwhcUOXWD24jzIRO4rM3rU16
	hkLrnt/63CsHR2LQ1gyBDRY8GQPkY2IvecanpNwiJCeGU1S9AP0oC3Z6
X-Gm-Gg: AYBFou024B+v2OfU246LYgNWG0qZb3B7wbs69vo3slI8XbOdcez1QyTT4tVYGVDkeo8
	rfjSNHoRGRO0GY8k0GjVecssJ8vUfK5H2G3HXYTuRV0sX5+8SLiQQH3Q6dQOB7dh7akz7AIJIUG
	jJ0vZanyNvUTvd3y4ckHe1AXfQMoHy7DeLpuJuscfameOFkbeIL1xDH+Pazd8ZnMS+OWE+g4Uoh
	I2J7PiEgt5P7NnrxnQkZaRFDMtfgqXaYqwDf7eUkGld4zVpQHeSWdM34iYfkIbIciSQlgOvL6al
	XnIKOJXdGaE7XcsbGt4bJkrSEXG4wBCOEnQZY8ly9GisvAwbraLWuY9dbsCImk3jUAJCzhn6CQ7
	BGJUmEfpYH+6wwQYlkBIWm1xLRtElfUfC1mWZvD4jGAMrJufgSJqSEoBloYjKbb2HOySFXpc9Zh
	Tr7GXaCkii2y0w0jiJHM1lHXq9E2+vYeya9RPcc9PHKjuHu4ETOgY10n+agTKIbnOWO/eYiHfjs
	mQZO6h+W3QxgKqoPze1jKRYX+0=
X-Received: by 2002:a05:600c:e557:10b0:49c:e42b:a4ac with SMTP id 5b1f17b1804b1-49ce5822582mr146351855e9.11.1788427690975;
        Thu, 03 Sep 2026 02:28:10 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:56e2:6e6b:ebf7:2587])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee60d8a6sm55553105e9.10.2026.09.03.02.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 02:28:10 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 03 Sep 2026 11:27:58 +0200
Subject: [PATCH v6 1/4] doc: add proc-receive hook info in
 'git-receive-pack.adoc'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-758-introduce-hook-v6-1-6283b1fb9b1c@gmail.com>
References: <20260903-758-introduce-hook-v6-0-6283b1fb9b1c@gmail.com>
In-Reply-To: <20260903-758-introduce-hook-v6-0-6283b1fb9b1c@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, jltobler@gmail.com, 
 kristofferhaugsbakk@fastmail.com, Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1318; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=WzOcS1WLXBBuyQwK1MjqFgeB8DwxmNNWao3PG9u3Gmg=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGqZPacE0lRQn1MzQl8ULG4kTQqNFsJC3zPhq
 7okxSWsE+rXnokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqmT2nAAoJED7VnySO
 Rox/8JgMAKERKtD+RafjG/giuPRLXQzyjCTDMEmfQDMufJQTI75l4JPBBawUSwureV0wyGZaNy7
 kT6TRZEFeTwBOb/4m52cVQrA7oyhtmc6wTJXYYBpxGWelxp3scp8tQJYpzyV0SGbbTqQaiHEvDh
 gxsjSf0UWbqWLPidqH5u7BWQoUxPm5vrjsuzmHkiLCp9TYcC87oX7KM9CaHb+3WgRpDmIwR2R0q
 cgNYXAqIb4fQfpstfwyUBx1D01bTOiwjD2ImX2mUkxqP/I77/FTZJfvTo6wG5Gh89k2/fIYxe3p
 bfrNGBfb9+u4T3ZZAIlM8If0IhyvNCUCt4wQGL82WdccI3jh0BDxTVnRupHGXzVG+ytoK9YRpWn
 IPD7UhomSuYx7Yk2Aj/be8JdYjzCs7RVOmpscN2blGjLrvqhIUkOAEwkaOWBOMg+g3p5EScpwoz
 6UzwNCllVNPkmR6URIlq7nkgLKZKuq/X+P3NnSjc12j2fXMzEiGibj/h4svyWAnqPw3j20MqpP4
 OU=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The manpage of git-receive-pack(1) documents hooks invoked when
receiving a push. The manpage does not mention the 'proc-receive' hook
though, which is also invoked as part of that process. Add a paragraph
about this hook to plug that gap.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-receive-pack.adoc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/git-receive-pack.adoc b/Documentation/git-receive-pack.adoc
index 0956086d61..5806792ba7 100644
--- a/Documentation/git-receive-pack.adoc
+++ b/Documentation/git-receive-pack.adoc
@@ -236,6 +236,14 @@ if the repository is packed and is served via a dumb transport.
 exec git update-server-info
 ----
 
+PROC-RECEIVE HOOK
+-----------------
+This hook is invoked by linkgit:git-receive-pack[1].  If the server has
+set the multi-valued config variable `receive.procReceiveRefs`, and the
+commands sent to 'receive-pack' have matching reference names, these
+commands will be executed by this hook, instead of by the internal
+`execute_commands()` function.  This hook is responsible for updating
+the relevant references and reporting the results back to 'receive-pack'.
 
 QUARANTINE ENVIRONMENT
 ----------------------

-- 
2.55.GIT

