Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B1E390991
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 15:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772552033; cv=none; b=qZINtjglaMcs7UxGB7tjMG9oS2OQOfRqIo65wnaAnEPv7KrCJxJ70RrpCs3sz1XehYkY1dUJ6A0NIv6zBpjnFmOdFAHjo6UArB4hGO6izjp4s4rsyvcRwPTMV14bxmk+5Fgg/q0inyCx0/gGRF+PF79QH8cfqYb0N620MGeYTew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772552033; c=relaxed/simple;
	bh=tjSh7wfeXi0W6tstvTIVYmCsqI6efBpi3WgXvEOwFoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=diEb9Zv0SWDLQvEPUpyybvUElnaZX7SKrg7OjgKZGMGZ/d7sclEW5ck5gMzhGBQDG4+ofuKP5HGSnMWsqgsxutRmUgb2i54wfUPvuUZwIIV+3u17cwRq777FRVSQngNeMhVyvkTXpIy5kF/TYledDlr/2Fwqcoe4PlWDDpHjXxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3VslZI4; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3VslZI4"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7985ce90542so58214667b3.0
        for <git@vger.kernel.org>; Tue, 03 Mar 2026 07:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772552031; x=1773156831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbSC/5yBEQbpDV0nS2RfSJBM7RlbQPBJiDupGPkTjtI=;
        b=l3VslZI4Mllb2ZW5pw5UjbTwwjEdgLa/vbFSw8vZ3svJ7U29VQt3dwEwGwTTtmgWr1
         dBZZa5U6dFRIFqZzvYch7hkVCvGXw42rIYEIfmaPhJQuHeOH1jwCS4rffRkFEwWnivz8
         Q3DFyvMcLLLB2PIKI2TDNN8RXp3GVtqmlZFOMOPI0l8h+QNt0Q57cuvRJnCCW4Vbk9ej
         kIQ0djE6j7JrDvRRNvEYRGvgyYBYyAV0kXrqBNQ5Z/dOwOAFJF16o3BqTMHTH/0XRRqQ
         99KyQK/BtHSaHqXwxi2Vjf8EuH6ZOrAcPKNUHYQcfRTsxe/W7Ca5D1syhlafggu3p8Ka
         /EAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772552031; x=1773156831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bbSC/5yBEQbpDV0nS2RfSJBM7RlbQPBJiDupGPkTjtI=;
        b=B1gaD99BLGkV8siCFPQsa8mhfSsd1r6aQFxwTs1f06ZBD4VH+gYmGkh9qfMjO7JOo/
         IyBHIEErQDHNgKyZPRZSIcB3Ns3z9LgJcRtKFTPYhfoFf5a2/S9LMfttwF3i0qQEZqdT
         Ei9n1Ilj7USlPXY36gcE0vhP62tW4ZhdsF2AZGU+GDTAKlugKBImVYYt13XzXV1WvMOu
         vmvZcKhiQT2Ac1Att09Xlh1dP72bxo/Ty9PmmX2mV6bo48E3tbpAZAVhVnwf3MNMDT1B
         LStkmKFq/shxu5NOCYcyBsWWCMnpuCW811VBYtyjUJOrf26u6spOWijAffPZkU3iqG2/
         y/fg==
X-Forwarded-Encrypted: i=1; AJvYcCWpiMm1giBF4M750qM1zHNSQhBNdnEVS37TNhvFFCdwVMkxqo7LzoNzujzU92jxEh1R1NE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLgbiu2cOqybmOkbr3dtVLkstjqPlfATxdP1xrmm0v+TyZpYjo
	UDh2qPda4jHdz6J7SiEC8POVyC4gzcpN2HJX56V9uu/oq1tE2CMeLLFZ
X-Gm-Gg: ATEYQzzCpLMo/nDkuyVH0d6trNpVzjjfWkjYo/WMcET3zrUPpdDb+pOR/ac4NIzthUO
	u5oNUabjOYyOoBhCfjjaQycLxEZXlzV4mkeqcZpDKnwwcgRCXYuwFHY1zq1HAMSZ5/NsyVM/o1g
	RVoG7pcWz7nrTLgoYmzwvc+dILZ7c2XSn5ul8UK3MNDH7mSRZGE++QMlcEpGq6QIB+YIcaYsn8c
	cL/bydUmTlCfSDpbTDpaC/wdeNPPxq2X46ciaxMi3a20fhmNSUuU8dnsCpDMa9kbskQJ8hECp+I
	TIPqytUS0UfVwHAP6boLvQgPgFQB4T+rVKKMGTP1wVOpM887BkK3DsaiJyhfEtd2/IsaPK5KVE6
	ZmIV34FsIlwrU1iEsIgWn8ixim2/voyOf3yv/Sj2teTW1MhY6EM6QZKD6fnPViEySB7HESfKYRG
	zwF89/iBPVtSyQm1WGk2Fc8/8JRuHbkXUXrPuKalnDAYfmQEsJgxWsZIA9VQ9PasnwGTD7WDYd4
	Ij5WiA3QuNJztIqsB5dBrEANUhkOnhtWI5FWCx3/iZrgAr64j8mC0o/bDh17hIqxsXfxuBjxIra
	rEiYvM6Icu1qqvlcD337cA==
X-Received: by 2002:a05:690c:368e:b0:797:ddf2:7cbf with SMTP id 00721157ae682-79885623a25mr146759197b3.66.1772552031319;
        Tue, 03 Mar 2026 07:33:51 -0800 (PST)
Received: from jiangxin-bandwagon-2.localdomain (172.96.255.155.16clouds.com. [172.96.255.155])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79876a8feacsm64364057b3.11.2026.03.03.07.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 07:33:50 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Alexander Shopov <ash@kambanaria.org>,
	Mikel Forcada <mikel.forcada@gmail.com>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Peter Krefting <peter@softwolves.pp.se>,
	Emir SARI <bitigchi@me.com>,
	Arkadii Yakovets <ark@cho.red>,
	=?UTF-8?q?V=C5=A9=20Ti=E1=BA=BFn=20H=C6=B0ng?= <newcomerminecraft@gmail.com>,
	Teng Long <dyroneteng@gmail.com>,
	Yi-Jyun Pan <pan93412@gmail.com>
Subject: [PATCH v2 0/5] docs(l10n): AI agent instructions and workflow improvements
Date: Tue,  3 Mar 2026 23:33:27 +0800
Message-ID: <cover.1772551123.git.worldhello.net@gmail.com>
X-Mailer: git-send-email 2.51.0.rc2
In-Reply-To: <CANYiYbFM9+4xGmeBRNCC6VyW9EzjEFxEWHDNnOVhJNM73Ga_FA@mail.gmail.com>
References: <CANYiYbFM9+4xGmeBRNCC6VyW9EzjEFxEWHDNnOVhJNM73Ga_FA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

## Introduction

This series introduces AI agent instructions for Git localization (l10n) workflows
to help localization contributors quickly complete drafts and use AI to check
translation quality. The changes focus on:

1. Separating agent-specific documentation into po/AGENTS.md for targeted
   optimization of AI-assisted workflows
2. Providing step-by-step instructions for update-pot, update-po, translation,
   and review tasks
3. Simplifying location filtering for PO file commits via .gitattributes

AI-assisted translation is optional; many successful l10n teams work well without
it. When used, AI output serves as reference only—human contributors must review
and approve before submission.

## Performance summary

| Task        | Before        | After        | Improvement                     |
|-------------|---------------|--------------|---------------------------------|
| update-pot  | 17 turns, 34s | 3 turns, 8s  | -82% turns, -76% time           |
| update-po   | 22 turns, 38s | 4 turns, 9s  | -82% turns, -76% time           |
| translate   | 86 turns      | 56 turns     | -35% turns (git-po-helper flow) |
| review      | N/A           | 96/100 score | New workflow documented         |

These improvements reduce API costs and make agent workflows more efficient while
maintaining human oversight of translation quality.

## Testing

All changes have been evaluated with the qwen model via git-po-helper agent-test
and agent-run. The po/AGENTS.md instructions are designed to work with coding
tools that support file references (e.g., "Translate po/zh_CN.po by referring to
@po/AGENTS.md").

## Changes

Jiang Xin (5):
  l10n: add .gitattributes to simplify location filtering
  docs(l10n): add AGENTS.md with optimized update-pot instructions
  docs(l10n): add AI agent instructions for updating po/XX.po files
  docs(l10n): add AI agent instructions for translating PO files
  docs(l10n): add AI agent instructions to review translations

 po/.gitattributes |  36 ++
 po/AGENTS.md      | 941 ++++++++++++++++++++++++++++++++++++++++++++++
 po/README.md      |  70 ++--
 3 files changed, 1015 insertions(+), 32 deletions(-)
 create mode 100644 po/.gitattributes
 create mode 100644 po/AGENTS.md
