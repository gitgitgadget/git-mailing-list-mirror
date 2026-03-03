Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CE1282F27
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 01:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772502395; cv=none; b=m/q7l3TqrGAuEFosEyhtDCWA9G4J6caD1baRTH5quuDqUxpUP4kqwi+nri63PpHkM+Xpgj2a6Y7214KcuoJS5szp9ircXolvMbU7W0mNidCvU5C36DBrawxm+M1bCKYP7xinbkG1ztwWlFwdahRnEf1BnVVv1abZUgSYwPArGQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772502395; c=relaxed/simple;
	bh=GL+NE+0neeq8g1MdaNtCpGBt5MwlJTGqCucbqQWpiu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKsqRBs3NSAUGgEvV41PPZdl/5XdChy8r+OpFrGSneTUcyBZz6p32LdKv8fo0wBQXpWue2DUc0/7hFQFzVjyWxHLmTkfPZxF9JLRsyNwBI3w7lQVHOaJWyJYdT/cXfc7Yfl0JWgyUc6YwU1O0Ci+OLr3nHFfggnhd8dvPXDdd8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtGctUHT; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtGctUHT"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-483a233819aso49153175e9.3
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 17:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772502392; x=1773107192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/aDrHkrfX7i1yuYkh+vk0UKCHbmSR7vM6oEcXpNMxLQ=;
        b=LtGctUHTNl0WAQ3TxfGfvgZNrT9xOv7Zno9pTknkeo4lOR4QjQvfgRHXbtBU6SSO26
         HGbWTi+Y8vtQzJf14NykRL1B/3fgGptEjbdjL9ldjoKaFWDtpoGfAc/aHnkr6ju76yDV
         JFXGbu6+FePG8ZuMXALbsrM3GAe6sG9jRTGgWyjtE1yd0c32XtHYKba0hrIZ2+Pfi2LG
         RBPF2GGsFIkRJ7fd5RoJqPeLCZQANaiICUYl8LLi0wFweI+M4eOdDXqSqKZSUH5MjvlV
         szmjHaBG0lEew9OYa+jjKMq2p2TexGVJFUZVeKZMXTUUDiil3vxA+D9dFPPBXIM0sOME
         U0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772502392; x=1773107192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/aDrHkrfX7i1yuYkh+vk0UKCHbmSR7vM6oEcXpNMxLQ=;
        b=j/i4eW04y1qU3nUuCGLZRqeDnCskEVWwm1V8cpRNewuj/FtGpW3sO/ZFHDdT6TYXrm
         8SOIdZGZajJWb8P9ipFRLTvLw+RgPiekSxY3Gmg65K9gRRGcHV7lsBxEtAybypo6HOtD
         2VsUbp49UqnUg/3lsHZdCrYItreF/pSco91qcVqv25X486DmidPNmPyJYt6608Ilo10G
         zgwFHV1HulM/s046M08ijGiDdwaryUonqjF9InLg0USYgtFyhtXWXR67W3ZkRy9JefC7
         UQ2U4+AF6CpBKpQHdyNDyU78zcuV41bNMpCv/tpPuTSDnlg6MXr7c1nxKJ/36T/Qm5Rz
         Tl8g==
X-Gm-Message-State: AOJu0YzPRSC4XK6ZBx5WYXrGIBUW1JHYvv7j/DuzW4YyUz7UboMOlKXb
	z0kH8JKVhrSMESOmFCtB+Ap9vXwVNPbHm2KotClYxf23xH7EQL7IoJtEnJlFnQ==
X-Gm-Gg: ATEYQzyCwfFYgEW6h5G5o9wOf/aOztHpHyDURAcqNzmTY0IqKba+VELcoZTSWI83U/z
	EkWZ1+h5Pcxg3HOyH/vkM6vO8Ek1ifUqOvpuZYWRpOypF4eLsk8fq2Me66GG4+IQkeM0WaogjED
	5p4fR5G5xaebUmXzwRW+jfY6QCk6kqATwmJricxaNJLYWU3Z5+Bl/P3VZGONsnLUhfhvXE+Si2U
	/BHOiF1Ih+7X0hw/5PZX+M/bbiOIGVMIZfR+O6SGYIbIaTcj6WarYWAyAxiyThH1E2lT5oYoF+s
	qLHKOlVa48XnojXq4vnfLqXLkVttgPp+DFKcTcwEFYTvGu4wvsCFmhIQO5TYQl2mWtn7RgPWCra
	zCt1UMXG1d759MdiVxVt/JtjS3bocKh66mZlXpAqPFl2kqq/NFw+RboYX2Z8d5Gdtnv+rzi5SYC
	+8UBCZliKegZQT2dbeSbrxp3qVIGGiWJGSX/s=
X-Received: by 2002:a05:600c:3b02:b0:47e:e57d:404 with SMTP id 5b1f17b1804b1-483c9c0ba4bmr269580785e9.16.1772502391879;
        Mon, 02 Mar 2026 17:46:31 -0800 (PST)
Received: from lorenzo-VM ([84.33.161.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485135d4228sm3932355e9.30.2026.03.02.17.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 17:46:31 -0800 (PST)
Date: Tue, 3 Mar 2026 02:46:29 +0100
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [GSoC PATCH v3 3/3] doc: gitprotocol-pack: normalize italic
 formatting
Message-ID: <2cf8a13eafd7d99d5633da95d62acd0c28af8c68.1772502209.git.lorenzo.pegorari2002@gmail.com>
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

Uniform italic style usage for command and process names.

Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 Documentation/gitprotocol-pack.adoc | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/gitprotocol-pack.adoc b/Documentation/gitprotocol-pack.adoc
index f4c9e024b0..633deecf2d 100644
--- a/Documentation/gitprotocol-pack.adoc
+++ b/Documentation/gitprotocol-pack.adoc
@@ -117,7 +117,7 @@ process on the server side over the Git protocol is this:
 SSH Transport
 -------------
 
-Initiating the upload-pack or receive-pack processes over SSH is
+Initiating the 'upload-pack' or 'receive-pack' processes over SSH is
 executing the binary on the server via SSH remote execution.
 It is basically equivalent to running this:
 
@@ -131,7 +131,7 @@ two commands, or even just one of them.
 
 In an ssh:// format URI, it's absolute in the URI, so the '/' after
 the host name (or port number) is sent as an argument, which is then
-read by the remote git-upload-pack exactly as is, so it's effectively
+read by the remote 'git-upload-pack' exactly as is, so it's effectively
 an absolute path in the remote filesystem.
 
        git clone ssh://user@example.com/project.git
@@ -163,7 +163,7 @@ supports passing environment variables as an argument.
 
 A few things to remember here:
 
-- The "command name" is spelled with dash (e.g. git-upload-pack), but
+- The "command name" is spelled with dash (e.g. 'git-upload-pack'), but
   this can be overridden by the client;
 
 - The repository path is always quoted with single quotes.
@@ -377,10 +377,10 @@ In multi_ack_detailed mode:
 
 Without either multi_ack or multi_ack_detailed:
 
- * upload-pack sends "ACK obj-id" on the first common object it finds.
+ * 'upload-pack' sends "ACK obj-id" on the first common object it finds.
    After that it says nothing until the client gives it a "done".
 
- * upload-pack sends "NAK" on a flush-pkt if no common object
+ * 'upload-pack' sends "NAK" on a flush-pkt if no common object
    has been found yet.  If one has been found, and thus an ACK
    was already sent, it's silent on the flush-pkt.
 
-- 
2.43.0

