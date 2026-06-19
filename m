Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66F640D57F
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 05:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781848014; cv=none; b=VOW6K6GE3y9MfsUwN5n19Yw67sMz+HTsFS4D2fUoq7daarI/+cAANkTfmTXPXyEtWlthowdnFsNKupSWOfO3DIH2j+vskF//ar++EWq+feQ6L3DGn7FQfBnX46fugIEqPYjnlTpshz9ZTCjtPYBotK0tzF6F5NYGC1LXFgbAd/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781848014; c=relaxed/simple;
	bh=4WsavjvGaxAmiL5H4llSOMkhkB2hKC1SpQ/5Ik0uA8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UWJQa8v0Gt720lwabOnRpCC6kCjChzdmKpLBsbLIUk5pT9eNwGGIDEV4ZO/MngEe6NMKlJQOycpE8xbA26zfswGPCBDN3Il4XrWSO5+d7/mHlRoi/1ZCssNMmYS5uQ0MTZZFhCSPUVDP2PcHP/haMFt5ft6onjL+pVC8iJJuj+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=NLsIEL4j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R2TmkfW4; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="NLsIEL4j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R2TmkfW4"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 188D714000CB;
	Fri, 19 Jun 2026 01:46:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 19 Jun 2026 01:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781848012;
	 x=1781934412; bh=fLA5TqgubUnwIpiu4uBZn0DCginutGd/GQ/YMsZlwGo=; b=
	NLsIEL4jY72PKB0o534muECT1CQIn1H7L8SHPxNtPVJZmMEfBNeHpR9oY7vBugTq
	8koc6lTYdS2fatg+L74mmxEuTFAsjCIBQnXjHkVMK3d93czJyJ0tDtwFnQ8c3rA9
	b2eYkcB8zLFUugTDyEmLaPLRZFvIqLBKAZB/Zqu8PZbp/wLHEkAobku44NuaxXLw
	3bcYf3N9zVX0mYw8lY50NgAegWrVVl9qU2RonaVgM4Lg3DReOQ+qSrDSYYvxYGSw
	bbo6L5bPuElPvsZwwoSCub0EIbikeUr6jvkGPJEpDhkRaLpJxnDi4Uovtr4eOAFh
	K1izYt71KAAbanulbbMEYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781848012; x=
	1781934412; bh=fLA5TqgubUnwIpiu4uBZn0DCginutGd/GQ/YMsZlwGo=; b=R
	2TmkfW4OvipM8Fx0Gs2IPwCABHvYc8J42qKFxB6kc4ZfY8FIT3OZrcJtdN7BugWd
	nugXdLM/hlTa/iciUC1E6Zte9ISRFdOTLWbRVmreJ3gpRLpLImtpNZ+DqieROomD
	Q1HxJh1KCA7Dtfh1tUgbKmGNQ1yYvrR33iFRE7veYOlApPAlOKHmwi4Z7HS4ie6k
	x3FWbMM9SmbrLv5rzLNMr1uYz4skZb9b46le766ytLf0yH5bBi1wPDS1ApUK+yBF
	qaWikAow+sY2t+C7i8jjr7DiXPPokz9qqcrzJrTPEm9sZmkyV0KXElm4eC2/ZhcK
	1boUxs2KQZ5t8MK0HvgMQ==
X-ME-Sender: <xms:y9c0aj9rTQdXyGcx27cXy8i7Zxh46__TN7Ki1XJu_YwyzTHNcLsykR8>
    <xme:y9c0anI7N9wiscUpyB8YALDIQzJIPQn3B61rfodBMPA8q3l2kAj4xrk-J3doCAQrb
    WdtXTrEjzJmO5XRL8T428hzX4wgTSZZiDYpHA5-6mnOVivAJHw6-w>
X-ME-Received: <xmr:y9c0aubDgkBUtcyFK-EoLoa-ffbIs4WqIRL_apjoUz1-V-Mj48OqiGz47ddHlJqZg39n1nfHdKvWsw8zQofANbWqZqwxWFVVofMLdN9WX3V5fIM>
X-ME-Proxy-Cause: dmFkZTGHoFWzPPxx8KNlIZtQg3yx1OcrjiS/yWi0b5t2m7kHng2nrltyVprt+QbEGUQ7w+
    IBP1fWT8Ty5TMMxBkyFWch2n+E0GLERFClCfpf84A1z6NjcoNuNASxZo7b5z574hBxatET
    S5L7qe7oLenrPvIIaC4JbEeQRtdQ5MFLrbNACkckUDIoeWeEk/hkP1MjkMIIyB3p6VOBUf
    WOdHjIjhy9sxt/suER6H8+lT6hb7n42mND/oJ4cK/oLQYuLp22JDjvM9LT6aiJM86ikI/v
    ybErKitZxwR0yQoVSyv95YtoObihs1yY80wevMZ0fpOaH3A0BiUKytJQPrcOhALGE7yYGU
    oNHBUzpQ4DB7jGLZ2d7bjYjSHAb0OWP4kC0scsQKZh4JkOpuiQVjn8vHe/6TO04POdqEor
    UO5WldSctE110d5NY76K4HOGsWP5AD5ryEGfCES3240a2Clj7QctmpmEN0vRUWlYO6mo4J
    BIe6YPSyQd6PYu78hNNBt9lGJWvCiPickAPeXzb/gsxlxUslqIqouNe9VWOtlTaWeF7P0U
    spzyusLClrlJrJS8rvVQWXVT9q5BAtZKMfnjVPMohNSTYKWrzeBuGMhPoIWb8HHt6ZtimF
    cw8OkRTu3bdTbR8yzM471DBp4SQls48385hTLtOlsaPXfyEL2RPEEElMjiow
X-ME-Proxy: <xmx:y9c0apKQgOiXaIz3ERv4KJhNKkEt03Xopxx8URiuErnkSDuecxHfnQ>
    <xmx:y9c0asA1ms35LpUQnDPNCZUZ_LvbE9Sq0QqQROoQ7YHWz1RWi9ktqA>
    <xmx:y9c0aurjhC6hevj22JpqggcewdGxiDR36RgmYfbNf10sUInb6DBCyw>
    <xmx:y9c0anhQ5KhU_lXpADkTVYLsAyoBEuYF_S8aD8ioYOLHCO7-UgG-mA>
    <xmx:zNc0at95BZACfHLeT9F7E7-PwINphY3f68ZYQyojy83m9jnUicFmfrNY>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jun 2026 01:46:50 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 4/5] SubmittingPatches: be consistent with trailer markup
Date: Fri, 19 Jun 2026 07:44:53 +0200
Message-ID: <V3_just_trailer_markup.9f0@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V3_CV_SubPatches_trailers.9ec@msgid.xyz>
References: <CV_SubPatches_trailers.8f3@msgid.xyz> <V3_CV_SubPatches_trailers.9ec@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The rest of this section and (most importantly) the list has decided to
use `<key>:`. So let’s use backticks (`) and a colon (:) throughout the
document.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/SubmittingPatches | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 5b4ab93543c..125bc0a2d63 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -374,7 +374,7 @@ or, on an older version of Git without support for --pretty=reference:
 ....
 
 [[sign-off]]
-=== Certify your work by adding your `Signed-off-by` trailer
+=== Certify your work by adding your `Signed-off-by:` trailer
 
 To improve tracking of who did what, we ask you to certify that you
 wrote the patch or have the right to pass it on under the same license
@@ -411,7 +411,7 @@ d. I understand and agree that this project and the contribution
    this project or the open source license(s) involved.
 ____
 
-you add a "Signed-off-by" trailer to your commit, that looks like
+you add a `Signed-off-by:` trailer to your commit, that looks like
 this:
 
 ....
@@ -421,7 +421,7 @@ this:
 This line can be added by Git if you run the git-commit command with
 the -s option.
 
-Notice that you can place your own `Signed-off-by` trailer when
+Notice that you can place your own `Signed-off-by:` trailer when
 forwarding somebody else's patch with the above rules for
 D-C-O.  Indeed you are encouraged to do so.  Do not forget to
 place an in-body "From: " line at the beginning to properly attribute
@@ -433,7 +433,7 @@ your patch differs from project to project, so it may be different
 from that of the project you are accustomed to.
 
 [[real-name]]
-Please use a known identity in the `Signed-off-by` trailer, since we cannot
+Please use a known identity in the `Signed-off-by:` trailer, since we cannot
 accept anonymous contributions. It is common, but not required, to use some form
 of your real name. We realize that some contributors are not comfortable doing
 so or prefer to contribute under a pseudonym or preferred name and we can accept
@@ -485,7 +485,7 @@ Other projects might regularly refer to other kinds of data, like
 particular are not used in this project.
 
 Only capitalize the very first letter of the trailer, i.e. favor
-"Signed-off-by" over "Signed-Off-By" and "Acked-by:" over "Acked-By".
+`Signed-off-by:` over `Signed-Off-By:` and `Acked-by:` over `Acked-By:`.
 
 [[ai]]
 === Use of Artificial Intelligence (AI)
@@ -607,7 +607,7 @@ Here is a link:MyFirstContribution.html#v2-git-send-email[step-by-step guide] on
 how to submit updated versions of a patch series.
 
 If your log message (including your name on the
-`Signed-off-by` trailer) is not writable in ASCII, make sure that
+`Signed-off-by:` trailer) is not writable in ASCII, make sure that
 you send off a message in the correct encoding.
 
 WARNING: Be wary of your MUAs word-wrap
@@ -627,7 +627,7 @@ previously sent.
 The `git format-patch` command follows the best current practice to
 format the body of an e-mail message.  At the beginning of the
 patch should come your commit message, ending with the
-`Signed-off-by` trailers, and a line that consists of three dashes,
+`Signed-off-by:` trailers, and a line that consists of three dashes,
 followed by the diffstat information and the patch itself.  If
 you are forwarding a patch from somebody else, optionally, at
 the beginning of the e-mail message just before the commit
-- 
2.54.0.22.g9e26862b904

