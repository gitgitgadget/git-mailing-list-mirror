Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A591957F8
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 16:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731083106; cv=none; b=jmuAfPFCdYhX4JHWPIVdNLUmatc31EVXFxsdrFycjCqDcvcXcq5vEgm3Sqge03rTcOQ2Qr9MeXg1keV8laUmRx4OmXa7tBXN0/UBAYNcxyOgAaYPBvjjxRgRXDBV/1JYtTaV2SYW8HAalyzYQQnZxTvxlhq29OAgOptQUMKNfuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731083106; c=relaxed/simple;
	bh=yjyz+Vz840lW2No3gACSbRZE3MV5qia5BFfczHhmR5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EUVbjtcE9KLa9lTXuDQQuQxSyK+C6eDSnDflj0WWbzEpfb1tmzvwXTixtwlp9WZzBrYPKuhtAZ0BiYxWaFpdFxGB3WR8KH7K8sKPYIlChEEj37IvKlJw0ZhaVnqe5yUU1cAMCfFQNkHImZh8U83o0pavWOWDTGIBnpuu6caE0Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eE3IBcSA; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eE3IBcSA"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-46101120e70so14672741cf.1
        for <git@vger.kernel.org>; Fri, 08 Nov 2024 08:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731083104; x=1731687904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0cpGIf3Q2e9lMZFbZTS9wWeKcb2Sr6a33QDERJUPy1w=;
        b=eE3IBcSASqfANpTHf8knhpMZFLzoHdt5qWt6bQyO60wI48t5iWrmNsPykseLddf2u+
         QssjSM2kLcSGHxSPO+UOQRYWNh1zf5zYcpuup6SHRzq4e0x8JJqvalWCKRsA+qDBqYOE
         NECINLVIBkMIhdXdYswBoVRqNWnQ3cAJNssWWjxPh4BXuQ9t6MeYmJL1D1fDvbhqHY2A
         ReDhShWlMBKslEGY5PPbj0vq+lrYOFjZ9BRLZviFsoDvElYgjScg6Q+SIykTAykYhGhV
         qeglYeY54kQUV4a9anNSNClrFPqPVxCS7mFWR2RYj/Q2w7fVJYs8T4nlzy+TMv9f51n9
         goMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731083104; x=1731687904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0cpGIf3Q2e9lMZFbZTS9wWeKcb2Sr6a33QDERJUPy1w=;
        b=vYggfzEqCe9Sa8ZnAXxPDtOY89C4Vppwg3tuNWfx9EthbRPGDMQ/nhtZE+TtaFuvGv
         X9Ya10b6IwlP2ZnLQHYnY93bFgMcd1fX5Q4ylWIUAsy0mCREnkwL1VDxR1E32pxGhHDn
         ChwkwZVwyqBB4WZ5aAxXFkRF4bfs293bNDKkcmLa/75SuL7ZlC8GGnYI1Vta4wvndNye
         +FNUdiXyFIRFub50haFXzu+bA350aJg8N73oHEp6iVxLHh6Kebn8HtgjC/WHivkaai5T
         MiJ4mTadASTdoxk4aFwtLEgLUXltsl5WUSFITkqPt6kCETLwPBe1kFzqjU7s7btAX+8u
         l93w==
X-Gm-Message-State: AOJu0Yy5/rjxo2wcB6fGbMwv0NGfYShy4qeknbHApeo47oU/+8jM0VEW
	6+D8LD0tMnlpEIaxmC3r+dhgX6n52P1gmvFMRwnNlIGgqtGrvgFAHH8dy9UU
X-Google-Smtp-Source: AGHT+IGNCrOBmerExvATZoYzEuXISECQmtE90+14QU/XvG+2ehkq5aZBcMX9x0JbB5cxbwMpv6FuqA==
X-Received: by 2002:a05:622a:1aa8:b0:461:41cb:823c with SMTP id d75a77b69052e-4630920d355mr43308701cf.0.1731083102182;
        Fri, 08 Nov 2024 08:25:02 -0800 (PST)
Received: from localhost.localdomain ([174.95.142.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff3ef11esm21928711cf.15.2024.11.08.08.25.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 08 Nov 2024 08:25:01 -0800 (PST)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v6 4/6] serve: advertise object-info feature
Date: Fri,  8 Nov 2024 11:24:39 -0500
Message-ID: <20241108162441.50736-5-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108162441.50736-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241108162441.50736-1-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Calvin Wan <calvinwan@google.com>

In order for a client to know what object-info components a server can
provide, advertise supported object-info features. This will allow a
client to decide whether to query the server for object-info or fetch
as a fallback.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju  <eric.peijian@gmail.com>
---
 serve.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/serve.c b/serve.c
index d674764a25..c3d8098642 100644
--- a/serve.c
+++ b/serve.c
@@ -70,7 +70,7 @@ static void session_id_receive(struct repository *r UNUSED,
 	trace2_data_string("transfer", NULL, "client-sid", client_sid);
 }
 
-static int object_info_advertise(struct repository *r, struct strbuf *value UNUSED)
+static int object_info_advertise(struct repository *r, struct strbuf *value)
 {
 	if (advertise_object_info == -1 &&
 	    repo_config_get_bool(r, "transfer.advertiseobjectinfo",
@@ -78,6 +78,8 @@ static int object_info_advertise(struct repository *r, struct strbuf *value UNUS
 		/* disabled by default */
 		advertise_object_info = 0;
 	}
+	if (value && advertise_object_info)
+		strbuf_addstr(value, "size");
 	return advertise_object_info;
 }
 
-- 
2.47.0

