Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB5A84E0B
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 23:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713308524; cv=none; b=pgG9gAWFsq58DmAMj11EC61VgjaPKABj09+DlcFJVJZ/06CZXN0KdVLf60QQSDcNVaSCMNMeyqnGe1CwY0RlZWU4AVOhjGNsZMQSZe2aJ4F8i1wofxDJcooAnbWzzPBHBy8OaHUZEE3wUwlcdmnR2dTp4kiGPaqnU4SoiUZUZzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713308524; c=relaxed/simple;
	bh=qM7qk1SrHG4k7tqRZoG4ohaYTrUzYevJI8EiM0kbQ4s=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Yqtb5DXcr+zQYN9u/eXieNiSi85zEluQFbzqtr6D1FKcN1zMdCsuZPcUpyNQUVvlCFq2U2SkQH6xpu8iFMd8Bexd8JXojAkKACopx/DAHarkTyetVYRvT4xgDeTlc5TTX4AEAmt+F90WiGRz/tc7/3T7aAfqj8X8d3NIGHgdGDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMv+mHRq; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMv+mHRq"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-343b7c015a8so3980691f8f.1
        for <git@vger.kernel.org>; Tue, 16 Apr 2024 16:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713308521; x=1713913321; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6iXzajJXvNCHbN9kIrXvJadshJjhNqLOyZvoeEKSOmk=;
        b=eMv+mHRq6DUodyOrp6Dz3hItDurifjWr7hVJ4AQZS3lOfMGaCj6agv0yBmNOgkcwz4
         JJMIkpUbEkTiRcN2Ngr6fyFn43WeKPb6Fbb66npSZl65B62KGc2PYap8wuR9REO9P7mh
         6ycTnCqiWUomd6oyqQVHAghPJYFUpcydFq28KCwn2kW1/R3JINY5zkzdL+XiDUrIP4f1
         dCI6gLoUOpECMglANoYnOyHO0sVIAq0XLEiC/o/lGwvSz2IIyJ08hk9uqcjlt53U1cUM
         9s4cUyJ6q5B/eZYdXZ/UXgW9nSo33A9ggfLOjU6M3yGosvQoesHN3FdnOk9yo5oNjVxe
         awKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713308521; x=1713913321;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6iXzajJXvNCHbN9kIrXvJadshJjhNqLOyZvoeEKSOmk=;
        b=VauQJeIybtX17pXQj+jkcz/SAICyEXsNZg3jCy62qPh0YFsST2kaQskDKkNF6Xbppp
         3nKiH59KiVMliwxecTs+79vB6DuhadatvXatDq843mtX3C8yBPNi8mMpXF7Ewq3UP6NZ
         cm40PU8VsxaorKpq795HSaE3mNUbbr65OIMz7kIMozpjUm3n5QSKCQOMuVEGXiAJoKa/
         4naqdyy7liyBsAmEYok6C075h7xtpF/UIZDaa268GnE6wjj6BpbPyviZOF+lEHx15lFm
         jvaT7qbVQVXc3gMjFiuJG0i9ck8vS0gl7H7Ds8sh/CSWq6nSManX8tqHbZ7e70wstrwq
         BnuQ==
X-Gm-Message-State: AOJu0YzibcAKc5vyVeELUaXz7c4rkgJSh4M4rY/GHuCorfi98P0LHPtY
	BNvqKkZd3bCTlF9FqS8rpiJuRkHrpXgi0M4Y1aw3sYjckHWOinsGM7taVA==
X-Google-Smtp-Source: AGHT+IFRq4TChBv3V/gQxtKjUJi2PXk5XbrzB4pNN+aynPf1CG2ADyIC0X9MKK+tvf5YFVfnT4RIkA==
X-Received: by 2002:a5d:4104:0:b0:346:9903:d10f with SMTP id l4-20020a5d4104000000b003469903d10fmr9618363wrp.12.1713308520551;
        Tue, 16 Apr 2024 16:02:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a16-20020adfed10000000b00349ac818326sm646851wro.43.2024.04.16.16.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 16:02:00 -0700 (PDT)
Message-Id: <d2c9551ee0e8b35eb9d4ff5a8eea06f7f0df9cf3.1713308518.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1704.v5.git.1713308518.gitgitgadget@gmail.com>
References: <pull.1704.v4.git.1712878339.gitgitgadget@gmail.com>
	<pull.1704.v5.git.1713308518.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 16 Apr 2024 23:01:50 +0000
Subject: [PATCH v5 1/8] MyFirstContribution: mention
 contrib/contacts/git-contacts
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Jonathan Tan <jonathantanmy@google.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Patrick Steinhardt <ps@pks.im>,
    Matthieu Moy <git@matthieu-moy.fr>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Kipras Melnikovas <kipras@kipras.org>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Although we've had this script since 4d06402b1b (contrib: add
git-contacts helper, 2013-07-21), we don't mention it in our
introductory docs. Do so now.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/MyFirstContribution.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index f06563e9817..9665951aeb5 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -1116,6 +1116,16 @@ $ git send-email --to=target@example.com psuh/*.patch
 NOTE: Check `git help send-email` for some other options which you may find
 valuable, such as changing the Reply-to address or adding more CC and BCC lines.
 
+:contrib-scripts: footnoteref:[contrib-scripts,Scripts under `contrib/` are +
+not part of the core `git` binary and must be called directly. Clone the Git +
+codebase and run `contrib/contacts/git-contacts` (you must have Perl installed +
+in your system).]
+
+NOTE: If you're not sure whom to CC, running `contrib/contacts/git-contacts` can
+list potential reviewers. In addition, you can do `git send-email
+--cc-cmd='contrib/contacts/git-contacts' feature/*.patch`{contrib-scripts} to
+automatically pass this list of emails to `send-email`.
+
 NOTE: When you are sending a real patch, it will go to git@vger.kernel.org - but
 please don't send your patchset from the tutorial to the real mailing list! For
 now, you can send it to yourself, to make sure you understand how it will look.
-- 
gitgitgadget

