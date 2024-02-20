Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E969B153BF4
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 22:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708468382; cv=none; b=bzAzLc1wb7dAos8VNmeXJe3OEYKfIrV0399FvXOoLRbohwg+6C2HTlRPxKm1w8jCETVuMajwY6GP5/kH2+klExEjPxOhpJMxEC3MN7xqNaH8A5l7NH9BuW5GKNt4eIKVBKhySQLZ1wR/llHC52cRsc89CLFY5fYY6pXJHr4hGdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708468382; c=relaxed/simple;
	bh=9SjOSqFawUqCg3BwrWEDNagw/wYe2QiY2OZHtexRmZs=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=lx+4SQFURWNNaDZVWl7qzZEp09hRf6EsSpm9IqFKgyUizkY4VDdBGwb+SyUGD7doqf7qPQSVnv2P5wkRhA3ouJaLJFovFQCdNXkR/01pqlJarQBWKtGwzF1o4Gr/FkOLTSY5dxHXlvzzAf7my/rC5Uri0wBn8kvhtv6wb3TLjZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sk0S1wsg; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sk0S1wsg"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33d066f8239so2965576f8f.1
        for <git@vger.kernel.org>; Tue, 20 Feb 2024 14:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708468379; x=1709073179; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnsvQplFB0vSwe+VbQhBxfBD+3Qjfu4LtoO7OqjMw+U=;
        b=Sk0S1wsg3yOYgPslTMRzBcEzNa0trjXuZu9dvFHCQq1d1fB2FD2cJQznVcClR+j9q6
         q3U4Md0FUij8wljtDwjF7d/uX+MVvKqv1U6dfP+7fX7yaK2DA0h38JOWavXsUMHzhq+H
         n9a4vT+/1pS+/gK8Xfn4yyYIzsf74vgxN1h0AYYfDylECTKmuxOfy0/vad2zvE0mlEDg
         VllhYx0Ze3D3oHl8pnl6IpHCk0IvD88gOJTuWxx8++ekn0ZRZ19DlcduJeU88xFSw46z
         jmk7SIGY4FjNKOciPq1H9tZmP58LPu+9//50mPogNdhCqA4GJLRGlD9FAZFSI1TNAK36
         TTFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708468379; x=1709073179;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tnsvQplFB0vSwe+VbQhBxfBD+3Qjfu4LtoO7OqjMw+U=;
        b=Jo1VEWH0MJdFvs1YuQm21O1RaScm4LYMp7tjwzhvu+OC5gTel9/47uk3N276dDW733
         ZxFsvCYPIvXyfQOuaMPLdBjcw6tWxdpOtcW5//rWBSIUvXHTG0TMrAwkQU9U2Ektkp5B
         12fa0kzqyz+hR1ppGay2QPrOTiUig2pReJV730pwEvmvhPWSBART2ARgrwrRJceONZIE
         X3VAGXEYofcjMIiFkPZtCg5EWxVxp46g0RBUFML/OE615s5W2kVPs+6NuL27wupF2vYT
         hMKhnv5usv9QKaubuHDv1VkYc6XxLghYjyWMn4DxdY6hxws6pxkP9j3URBGRPFLmuH0v
         nLzA==
X-Gm-Message-State: AOJu0YyrWX8IzSDt28x5iznwgkvM3P7StEWr2MMVpHS95A+wSOTmd7Ty
	W4mnwXnocDNuuQRjtjUPyFJokfxWaG/9QgBZF2Dk+uhDbRxuGezXSmbjSGkN
X-Google-Smtp-Source: AGHT+IHBzvmoEW8X5oLOYjqLWuj6iFO4XrJk+eu8MUSzOnls+MUjaI8JEDzYE2i+VcbvZ77NHTPmEA==
X-Received: by 2002:adf:e789:0:b0:33d:3490:6e08 with SMTP id n9-20020adfe789000000b0033d34906e08mr6924657wrm.11.1708468378477;
        Tue, 20 Feb 2024 14:32:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g16-20020adfa490000000b00337d6f0013esm14800373wrb.107.2024.02.20.14.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 14:32:57 -0800 (PST)
Message-ID: <1faa934a152d2eedc8949c1e17aff787614770e2.1708468374.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1670.git.1708468374.gitgitgadget@gmail.com>
References: <pull.1670.git.1708468374.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 20 Feb 2024 22:32:54 +0000
Subject: [PATCH 3/3] doc: add some missing sentence dots.
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/config/diff.txt     | 4 ++--
 Documentation/git-fast-export.txt | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
index bd5ae0c3378..6c7e09a1ef5 100644
--- a/Documentation/config/diff.txt
+++ b/Documentation/config/diff.txt
@@ -223,5 +223,5 @@ diff.colorMoved::
 
 diff.colorMovedWS::
 	When moved lines are colored using e.g. the `diff.colorMoved` setting,
-	this option controls the `<mode>` how spaces are treated
-	for details of valid modes see '--color-moved-ws' in linkgit:git-diff[1].
+	this option controls the `<mode>` how spaces are treated.
+	For details of valid modes see '--color-moved-ws' in linkgit:git-diff[1].
diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 4643ddbe68f..752e4b9b01d 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -48,7 +48,7 @@ When asking to 'abort' (which is the default), this program will die
 when encountering such a tag.  With 'drop' it will omit such tags from
 the output.  With 'rewrite', if the tagged object is a commit, it will
 rewrite the tag to tag an ancestor commit (via parent rewriting; see
-linkgit:git-rev-list[1])
+linkgit:git-rev-list[1]).
 
 -M::
 -C::
-- 
gitgitgadget
