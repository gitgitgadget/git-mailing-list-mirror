Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E81718C332
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 02:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725935365; cv=none; b=pmkE4i0pp1hpahmviA+l5+3NpOPG8BzE7j40QRL/Qir0vTjgIUwpjLrlt04usEmn1B5ZLneZ6KlblaRAyUPujQDJ7UfWkcrZQWiU1N/to9Tz6oda0Q/xchkX1givfuUc6gBxImBsatIr33PQ6K16aB6XF7FJzOjbMzxzyU68kqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725935365; c=relaxed/simple;
	bh=FEbFCfu0Lem4aWuaEg+LyD4WhLIyFEgd5J2X+vx5X+A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YyVxLxnSjNMgGlYafTlwdLcebPgmCJ2ToQ0mMqjSX1dhJUJgUva0iodZkhHs7G7jpL26WCd5mAkgl8p37Wfxk5yldG+au0Vqu2E2V1uO+9X0biePzczeV31PCXa3SGuLwaNE5R9np4sHIEiukzEflQnwQaWgWuDroRpDIEUTTO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLJrLwY3; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLJrLwY3"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c3c3b63135so5309538a12.3
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 19:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725935361; x=1726540161; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXDDuTS9csZ2ExwxQm0idy1D51Hxq7R4RWCbzOYPOj4=;
        b=JLJrLwY3GKgaccXX4ZkJnPedcHQi0XW2PB03XdRaX9bwn83Dd8A2y7Trsw+6Bp/rMi
         EHr8P0jkNGzIXtgYRrO4O0g8BqKhilajM045xypsU4YUWBkDg8LuDn8W3gOSEWjquo5G
         TFnjm3vgIbtOox+y1fZ6MUkPodVbVSy9Ne5wi5rRmpAvyDPhP4fAX70lHzt6NO/dnMyp
         EmELz+UnkMhLGpnl35SXt00JSktKpIvhzop3j0VE+WTpLHB2ILv3Xo6HfMAFrjLKrR+C
         qiaePKBcfLE3ArU2FTwRoq2oEOB7PhTCwA/qHXVJuGBm2MsqY8YwJ/Iy3foEnxt8ykdt
         uBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725935361; x=1726540161;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXDDuTS9csZ2ExwxQm0idy1D51Hxq7R4RWCbzOYPOj4=;
        b=QZwoCHESqFAdqkPYsbTNaAZhuHCXcfHKS5brimLTZn8yfp1xEdAjw0BU+2HSXBb/9Z
         A7GEy2xT1RyykmTs7F1H660rKoAckRkftpk0ITz/LDYgZS5wgJQvzPJac9Md3Bs2iUno
         jQGetB3vrDhoGqpsCrPX+Yf8FlSc/1NYNbLoQtjrmrWkJA7tWuHDr7Z7nbaRXwR8Wby1
         AY4zxBpdXvRyNwb3eVA/VU+Hg3leg3kMBje2+HC9Zi8bBHoIEUDRp316Duh4e4wOyhg1
         ZZ80mwjuZs9te+UT6PhawDRreaq2HF+ooDKqsofawoVBfj918Y+3S/9osmocCQuMIj08
         YeOA==
X-Gm-Message-State: AOJu0YzhkIuEDZh7kARiT01XDwwr46YSiGuseCONWwbTzltfMVHGney+
	6dED/DhzqoANKUBLITcfa1SBUXojHdGm8xcomc0HLGkYWtX4HdmrIF1Jkg==
X-Google-Smtp-Source: AGHT+IGtf/COV7OSlEfl28d9L6lmGSgDLiAn2Tk3jiSfi1SJhD1FxvNkupjBqIuHZMInbuh8IoAmwA==
X-Received: by 2002:a05:6402:40c3:b0:5c2:5cc8:353f with SMTP id 4fb4d7f45d1cf-5c3dc7bd5ddmr9774838a12.22.1725935361430;
        Mon, 09 Sep 2024 19:29:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd52167sm3688875a12.55.2024.09.09.19.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 19:29:21 -0700 (PDT)
Message-Id: <4c10f859c8dcc42c4d0470a1f295fba979aca336.1725935335.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
References: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Sep 2024 02:28:51 +0000
Subject: [PATCH 26/30] scalar: enable path-walk during push via config
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
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Repositories registered with Scalar are expected to be client-only
repositories that are rather large. This means that they are more likely to
be good candidates for using the --path-walk option when running 'git
pack-objects', especially under the hood of 'git push'. Enable this config
in Scalar repositories.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 scalar.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scalar.c b/scalar.c
index 6166a8dd4c8..031d1ac179f 100644
--- a/scalar.c
+++ b/scalar.c
@@ -170,6 +170,7 @@ static int set_recommended_config(int reconfigure)
 		{ "core.autoCRLF", "false" },
 		{ "core.safeCRLF", "false" },
 		{ "fetch.showForcedUpdates", "false" },
+		{ "push.usePathWalk", "true" },
 		{ NULL, NULL },
 	};
 	int i;
-- 
gitgitgadget

