Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407E846AEFC
	for <git@vger.kernel.org>; Wed, 27 May 2026 18:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905917; cv=none; b=H0a4VyFwX1T80LClTwHOlelAwFT1GLNwCp0a/JxqxZuqVz19jayv26aksc2hsUgRfYDsKPrCIBuLee5q9zQ/SsnAntULoPJJBEgAYPHh3u/LEqm8+e760LizgGvgrLFPHHbIAjlJM+Ym9ActZmPw1ot3VjgCiiGptgeENjHg1CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905917; c=relaxed/simple;
	bh=ibo5E6hS6Z8RzS6e/C98f64QZg4vj/RQmA68t2CjalI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CmJyqvpLEJjUkNULj2oQmeoa7Sjvnse/JBd3JdralSheNcbAVnvKCkJOShZPFFBlXUhiTtqoqRM4bTxfOVx/9XVV2bYm3ibnKWfeJdfn2XU1QT3CDZVSnm3fabcqBiI9C6LwpYPCw41Mh1KjBohJsanZPbYVE22K2HxjO7wIhPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkaabxGN; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkaabxGN"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1334825de43so10626137c88.0
        for <git@vger.kernel.org>; Wed, 27 May 2026 11:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779905915; x=1780510715; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCanl2UTdnJmm5I1wrST2Zf4CXnElEoaku2wr4IvBUQ=;
        b=nkaabxGNXteIxvibLqwnznQS+eIIazcJenuG8jfWJPc4zvwlk8GvrRDnjZPVQIkXZR
         HBKSXjJ8oH6ZExA39l/lNIByYwmYjP4sXfCd6Z/N7G4L9Fzhzza3OlzzHS3zwhGvpS9u
         771UkvYaGL/1lZfuSXINEOCo4KHQV/MJaWg/EBHMp2G1B/j795Ahp03npO1kmjoATPnv
         cXK4OZVggkC6UM1wTWQvfCFy2kvlsLSCXQqS6Wip7Jndn+wV20cBwARwRZVQsajwCKx+
         AmC7D74kY6C4UV+kb+PBfrDo8QnXNzjWVCZJC8zsM+qQMEQBtymrkwcfsT2WMaFV21Sr
         gWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779905915; x=1780510715;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gCanl2UTdnJmm5I1wrST2Zf4CXnElEoaku2wr4IvBUQ=;
        b=qVmnnWZlOfIE1EqsRiKkUlXk71hu7jyPgx3qqB7Ub30I5e155o2bJB4Rzng2FzLJO6
         k7jKEpAduogXxi7zuFmWCvgh8cF4B6AkD3JiC098Hq+4FPRoHkeuTb9CPjnxJqXweKwv
         3936ZKVhJoFM8+cIf8HSL7QBvtaMfar50Kdqp4U+El0XSSxF2VFIL0SgLny2ZYinngpu
         fpOJ+wDp+BikGJXD9OQAiatFdi+lyXHacjSa/XfnMwJs3QdW92x7vSDPyz85GIOFSygl
         w07xRS1FUImru5iKhBABpbA5h967l/HXQYRfMSQpxerPQVWf4NNG8N2DHAUj8Mth8Cit
         UUkA==
X-Gm-Message-State: AOJu0YyFBxlgbyi+rFGe81XBXfIpC5QgoZTLPQMg39PzYkhb/1gTS2Fc
	D3PHNt9rNcHfIMTYSWSEht9sRCXO1xL3DMwSJ6/5Yl0oj3KDDLpYrjgs+pzCJQ==
X-Gm-Gg: Acq92OGqmHj50y8BBBsJy2WJeMH/HdEi3qn7Cp4FcyPbmw1CpgXcHU4ilLfBrFMtj/o
	8Ltn7h9F5mOSLYSjcgKN9fACi0D8aFrerll6+8MHujwzSXL9RUYPkHn3vcdaV3GbooF2mwU2rnt
	xSRDm8vD/ului4TcfnTGHDvPbIcITYbMOvZ1mvQ+WMRne//6bev2oGfMPOEn9QMvombA8gaMKbu
	riLa5t07F/AtbFlphW8r/U37UKeWzlEvM4ECRgf1eLO0nW4hUu4QW7LzDpOrR2VaNq015B2jshy
	seYvoSaMOTiKoUCRPmiv4dE5jzb8O/0QOgb8kS/MdbwO1yAZ2AiFLlc5lITYvkTOazl8bOmQFxG
	ACacR+/cMgHwhA8JK/Sm/JpZCkm6zumxNnqzDeurccLXSZ1d0vLDEb3cJijtNRZ+LupOZGfkTLF
	syGze3l/H7HfR80Zmrk1I8ZjnMWTWm
X-Received: by 2002:a05:7022:fd0a:b0:134:def6:e73f with SMTP id a92af1059eb24-1365fa38920mr8333453c88.21.1779905915083;
        Wed, 27 May 2026 11:18:35 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.212.101])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366aba39d7sm10249707c88.14.2026.05.27.11.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 11:18:34 -0700 (PDT)
Message-Id: <b2d81438117a716417a031c74b678a8f91701af4.1779905911.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2300.v2.git.git.1779905911.gitgitgadget@gmail.com>
References: <pull.2300.git.git.1778773592.gitgitgadget@gmail.com>
	<pull.2300.v2.git.git.1779905911.gitgitgadget@gmail.com>
From: "Sebastien Tardif via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 27 May 2026 18:18:29 +0000
Subject: [PATCH v2 1/3] daemon: fix IPv6 address corruption in
 lookup_hostname()
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Sebastien Tardif <sebtardif@ncf.ca>,
    Sebastien Tardif <sebtardif@ncf.ca>

From: Sebastien Tardif <sebtardif@ncf.ca>

getaddrinfo() is called with AF_UNSPEC hints, so it may return IPv6
results. However, the code unconditionally casts ai_addr to
sockaddr_in and passes AF_INET to inet_ntop(). On IPv6-only hosts,
this reads from the wrong struct offset, producing garbage IP
addresses.

Fix this by checking ai_family and extracting the address pointer
into a local variable before calling inet_ntop() once with the
correct family. Die on unexpected address families.

Signed-off-by: Sebastien Tardif <sebtardif@ncf.ca>
---
 daemon.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/daemon.c b/daemon.c
index 0a7b1aae44..80fa0226d8 100644
--- a/daemon.c
+++ b/daemon.c
@@ -674,9 +674,20 @@ static void lookup_hostname(struct hostinfo *hi)
 
 		gai = getaddrinfo(hi->hostname.buf, NULL, &hints, &ai);
 		if (!gai) {
-			struct sockaddr_in *sin_addr = (void *)ai->ai_addr;
+			void *addr;
+
+			if (ai->ai_family == AF_INET) {
+				struct sockaddr_in *sa = (void *)ai->ai_addr;
+				addr = &sa->sin_addr;
+			} else if (ai->ai_family == AF_INET6) {
+				struct sockaddr_in6 *sa6 = (void *)ai->ai_addr;
+				addr = &sa6->sin6_addr;
+			} else {
+				die("unexpected address family: %d",
+				    ai->ai_family);
+			}
 
-			inet_ntop(AF_INET, &sin_addr->sin_addr,
+			inet_ntop(ai->ai_family, addr,
 				  addrbuf, sizeof(addrbuf));
 			strbuf_addstr(&hi->ip_address, addrbuf);
 
-- 
gitgitgadget

