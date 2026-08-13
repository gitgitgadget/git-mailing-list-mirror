Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A239E43F4B3
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 09:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786615114; cv=none; b=apSK9a+qc6gejS2v4u1dZZUNu82abV9QTXLXEGrzhz921uWdcf07MwhOe7TcJP0RISFAvtxxB1chO94cuD9ZsBcft9fZZEzhFCX7j+W12pyKXIwVAaX1L+Tj6ri9SWNHbWyOoNEExd7CjKkn5OXNghr8GKcasUKOYU/BXRLTaRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786615114; c=relaxed/simple;
	bh=W+dEAXB6/1+4y6zR9OkF3GHcogDer/IhbUSjaIZ9KXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SXxEnAh+w7ZTz4JJJxrEKciLyQSJUBFdD93OzYP5Tx7ptMeG31B+igYi1veQVxLzjOE2N9/E+Dcu6ZopQe72ia5uptl8AuPpJfJHPDWVWmJBzHr0Lx/ReHhFb+SX57ht0nNdYy3dYKPFniaF8UlY0me5VH1vbmSppQh6d5kZsB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=fldx0V5b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AyFcAJs+; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="fldx0V5b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AyFcAJs+"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id BE7041D000CC;
	Thu, 13 Aug 2026 05:58:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 13 Aug 2026 05:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786615111;
	 x=1786701511; bh=2DxWBJI/g4OVFuOzQ+vn3FiWR14TI7G6+WkLU0tO7H0=; b=
	fldx0V5brI00sVdmgpCCNVtzXP+3/7A70Myxzg/H+rd3Xxh1cMNhv2Fro25WX6rs
	UmiRlqqT5qUu05TsZYNllb7O/PJlOHHbuv8OonzIENhBhNVZ44qrjAaXN5skVOVQ
	lvyqz97gN9htPYVFVHuhGFbfBmUZs94uJ0j89fL+/qZWugDF8poevhYKR0HuedN4
	4G/ETZkjWr1AtvX6C/AJbcUUsNqMnx9mzBtGH/hFosg0fvIWVX7RnwBP5GwKJPDD
	wzmcIPf5SeTzWAnz5FeqJaawJ8H4DXvrX98ZurgkRK89nUBDTIjpOlJmrsJJIlYK
	oMuoKe/7cYnBD0cecMCcCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786615111; x=
	1786701511; bh=2DxWBJI/g4OVFuOzQ+vn3FiWR14TI7G6+WkLU0tO7H0=; b=A
	yFcAJs+EKMAFwoM8KSw5iuoYWRQBOVW/J/bcGMWYXBAaQ8YvGYkjb1nv5lPZC17i
	hLiRNZpxThmNNeXA8bbgv5WFwW8jCfCUSiD4uh63D04o+Hfc0vOwTNoJXSyFP9Rx
	DC4Eo/vzHasQmMlALAK3gc/Yo+4lAXSJQWPKhuke7kqhyqsbxMRpUm9txAGsjBmp
	IPJ62D4EoH8Lq6m4d1aemW9HGVBLivncTcVBh1LzsVCRzAUhiyht0dvQBg0KHBys
	CA8FLN/mzkPirXSJQUIt/R7u1TTtMYHFhZPb1JaYE3j8TIsLyhHdaeGFAmvVZNl5
	amnXV+EaIFWgK41l6AekQ==
X-ME-Sender: <xms:R5V9ardVvIsUJN4KTnvPNjC9XptXkQSJMsPAVEg13-IgGwrBz6iWIWM>
    <xme:R5V9aoOpFc4949VUt4kPhPsfHs9RJ724kXz6rY-HHctflFjVrQLC9-QZ2Pux5-879
    a3u-nnAVw5Fo-_ixtlIcUjHbJynMXy0YB5FTKvxsMQcId20CKHb5Q>
X-ME-Received: <xmr:R5V9apjsMoIT3E0Adss1Yvx9V0DIjuFQP-ouVGDpJyc7T7CzUQjX3Y5WbZ1qGW8zWAbPCc8Njp4Pd5V8bAwcy41vcVdF36cmQNf-dio>
X-ME-Proxy-Cause: dmFkZTEB6ZnIp8K5u+ZHg79f5VGN0v6Xyr7YwESrQVj8tfGHQX7/VJN8N9ssagmFQf0meo
    lFMaOK2he87snGZgWGFW7oS4mdn6Td+cNYiOwOF+jvd/U5MpqSDgnrgjxDpk/tLLrL45Co
    bnrpr9WzPn62K05OUcIrOTv/RiikbG39prGvuC+1nJigHEyGrhtuIXhmuCa8QhZshindsC
    tvmjEuLk4apZZQQMawEociz+OoXd1epfr3ygCLFhGPG+TLLe8u12vewnOqCMFP74BquhCY
    hi4LWCj8K6lR2kigwP6+kayWdOA98tbDHCyFgETBK+S8Flw8BJ2n7/rApNje0SpWDaN3Eb
    KZjN5/pWCNc9No69yOoAMgQxY7IS0nT3ItOSVD6OpQGpW4l+XrptQHPQSBEe8n50cyHAqs
    UxAA9ekjIwOJPipPLWsCqKVjZAf0Hc4ISIZd6pK+TaR7URKTNzLHtkcBXunrKdiIcV5mxd
    j2GFA3GjA2/AhxkZBG788Fh50gfgUhTPHwi5cLYrKTERjnT55RENdaIjfQvyf0CuMqAuKs
    0IfwCHBtGq5NDZnYIzHkujmC3Z1iouiYUtTbCf7CnF99V34M615vntidYxKrXqn7O+irmJ
    TWoX0IZbQDqHl2ULXr8zAEh5blUWthc43kIBEjvwJEMUbQ/B6M0FPqY6PsRg
X-ME-Proxy: <xmx:R5V9ar1af_VtofD0OjVfdu2gJ3S0F5Ptk0rFxu6zVUucYbhyKp5Xow>
    <xmx:R5V9ajimPCxiWGEiau-qHVUcAnONsqSNRt1RYWYM40pF83iMMqRLVw>
    <xmx:R5V9ardjX23LT7CLFk7V-at__G-XaTCDqAlxpNTpAU8lt7HHeOgxXQ>
    <xmx:R5V9amny0mtZkukZGKlFtegWdYMjSTKZLuKjyg-SnD66d090j1vrGA>
    <xmx:R5V9amdf6Sm6OB1X7eieJjRFGv5KRu8zzcwJCOvvzv10ml3Q0vpCxy1Q>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 05:58:30 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH v2 2/2] doc: format-rev: use [synopsis] on code block
Date: Thu, 13 Aug 2026 11:57:36 +0200
Message-ID: <V2_synopsis_block.b4c@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V2_CV_synopsis_block.b4a@msgid.xyz>
References: <synopsis_block.af9@msgid.xyz> <V2_CV_synopsis_block.b4a@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

This code block uses the placeholder `<subject>`. Let’s highlight this
placeholder properly by using the `synopsis` block definition which was
introduced in a34d1d53 (doc: convert git-show to synopsis style,
2026-02-06).

Yes, note that code blocks since commit a34d1d53 can, on synopsis-style
docs like this one, be immediately preceded by `[synopsis]`, just like
the command synopsis is:

    [synopsis]
    (EXPERIMENTAL!) git format-rev - [...]

Cf. verse-style:

    [verse]
    'git name-rev' [...]

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • Add a paragraph to contrast synopsis code blocks with synopsis
      command description after talk with Patrick on v1[1]
    
      🔗 1: https://lore.kernel.org/git/ansWZxZ6lB0tYIJD@pks.im/

 Documentation/git-format-rev.adoc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/git-format-rev.adoc b/Documentation/git-format-rev.adoc
index 19241837345..d6c2e4aec1a 100644
--- a/Documentation/git-format-rev.adoc
+++ b/Documentation/git-format-rev.adoc
@@ -96,6 +96,7 @@ The mode `--stdin-mode=text` replaces each object name with the
 formatted commit, i.e. the format `"%s"` would transform some commit
 object name to `"<subject>"` without any termination. Like this:
 
+[synopsis]
 ----
 Did we not fix this in "<subject>"?
 ----
-- 
2.54.0.22.g9e26862b904

