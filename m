Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6C8481B4
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 23:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712878345; cv=none; b=aCUONPyiH+jCOvuEDkXmIzV4QNJL6n+xfZ3TnIBfU7W+b2p1uNXpHlqKpAs/5LR6DcmSsrpUEiK1sniCnZyiVcdFF6oGVyugNeOZr/cMlYdvHoBxl5hhGShZbUV4f5QHxQvJVXkN5hADD12Lx/7/eWLIYKLrLY3gXXATp9THzD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712878345; c=relaxed/simple;
	bh=aj1NMeFhA5mefTWVn3dIMc7oAZAyt0TuN3zaUFP3E+I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CVmglgccZcy3N9BxwIhbWrX8NpKqu4HsmjawIPzS43kLCn7UtwtaFwfM/w39liF6tu6FCWAL0rCfaysCd+n0K7IPt2xMtpsRVkEwmYh4oikFSpMfulqH93OfjWyClS7oERyaPRwUC3Sys8tljsPBmU1D+0xMZZSBn6rHuS6yqwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sr1tuTVZ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sr1tuTVZ"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-417f81ef284so1320035e9.3
        for <git@vger.kernel.org>; Thu, 11 Apr 2024 16:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712878342; x=1713483142; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OW6nvzJwMQb+PLM1E/EMaRktSScWXvCfer570OXxv6w=;
        b=Sr1tuTVZo+NY93DQX+6uVJ4m/o4iYfcRetd6iF0qaxuKBs6i7cOnu7DQ98NhOmOuFh
         K/3vqqKr4Egzw+cmr34JqH7Rwr5yAcAxjpYRVsfdP5Vj00Z/PDKJ5TCt/Z3PB55j2Y5d
         CI7uov1am9+Wm/1/dN3bYby7Xn9AoxiyZF3NOOhZiGt7XOnNNi3kT5Gi5sNS0ysaGNpy
         WhLudRlFfkTaEEbWw7YVJMBQVF78LviD3wabKjZCYUNXcR2JEfXNb7Zifj4OiJTguctp
         48v/lkHvmfG4FVrYV76pTOY0KoPcRxTWBhrTpf2yRM3m97TluSfnU/F9F7fSA82jDx7G
         0EMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712878342; x=1713483142;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OW6nvzJwMQb+PLM1E/EMaRktSScWXvCfer570OXxv6w=;
        b=mi6WxMrZ+TSTMr12oP/IjVKm90TjnFVTA36zLKCMkDrbGav9b+5YS/jxc5NMcOR4cI
         nAHcoKvKFB0u//Q4F6ae+1W72cKyu/NcunVCeAj254BeMcWKVc9uy91BTxxnZxrdqouR
         ohleUL4dSzXwDaBevmgH/a4FaTJ68wXiVSjlFSoCWgXFsAqoP40T1D2/oHhFeP3yKH98
         nTu/1C4/1pq4ZB2f5tcybdp2u6AJiueEUak5tJax2OWc8CWOZQJUdlIVMDb64VbDh4mB
         HbC49bvBJDv9x7qa2+LrGQjZoxp5qmOB3gh4AndBQFXg9eL+NtwZArasxm54zwpCAn6n
         wM5g==
X-Gm-Message-State: AOJu0YxwPrtFjIQnVTzyjCLxWeON7h/ks7VLLxn8EEDdKSfH42InNzEa
	GpZnh1PbaRt7SrRpz7nmLd7IP3ouogdhD7cnlrKVgh/r8y7LO8/un7Ti9g==
X-Google-Smtp-Source: AGHT+IEQzZLBrrvLBpv2C8UwaGhbVRtvV0/qxxpGi25S6PuqLhDueWFKo/87LUFRTJ22KMGhni8uQA==
X-Received: by 2002:adf:f74e:0:b0:343:968e:f27c with SMTP id z14-20020adff74e000000b00343968ef27cmr610644wrp.27.1712878341975;
        Thu, 11 Apr 2024 16:32:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s8-20020a5d6a88000000b00343c06d75bfsm2844307wru.61.2024.04.11.16.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 16:32:21 -0700 (PDT)
Message-Id: <ad469e4e6dbea1230b5e8670180f6ecc933bb6c0.1712878339.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1704.v4.git.1712878339.gitgitgadget@gmail.com>
References: <pull.1704.v3.git.1712699815.gitgitgadget@gmail.com>
	<pull.1704.v4.git.1712878339.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 11 Apr 2024 23:32:12 +0000
Subject: [PATCH v4 1/8] MyFirstContribution: mention
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
 Documentation/MyFirstContribution.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index f06563e9817..de60b3a4fa1 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -1116,6 +1116,18 @@ $ git send-email --to=target@example.com psuh/*.patch
 NOTE: Check `git help send-email` for some other options which you may find
 valuable, such as changing the Reply-to address or adding more CC and BCC lines.
 
+:contrib-scripts: footnoteref:[contrib-scripts,Scripts under `contrib/` are not +
+part of the core `git` binary and must be called separately. Consult your +
+package manager to determine where it is located. For example&#44; on Ubuntu-based +
+systems it could be installed under +
+`/usr/share/doc/git/contrib/contacts/git-contacts` and may need to be called +
+with `perl ...` if it does not have the executable bit set.]
+
+NOTE: If you're not sure whom to CC, running `contrib/contacts/git-contacts` can
+list potential reviewers. In addition, you can do `git send-email
+--cc-cmd='/path/to/git-contacts' feature/*.patch`{contrib-scripts} to
+automatically pass this list of emails to `send-email`.
+
 NOTE: When you are sending a real patch, it will go to git@vger.kernel.org - but
 please don't send your patchset from the tutorial to the real mailing list! For
 now, you can send it to yourself, to make sure you understand how it will look.
-- 
gitgitgadget

