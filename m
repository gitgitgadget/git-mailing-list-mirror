Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EDB185B6B
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 12:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724417045; cv=none; b=a7DxnT6G+h/g9MpmR2MMN/a9r+aRgN8QsKLgG2P/89J0jX+mEURGkAIK+jzbfk7VC/+mRCJGmAAZ10bwSFxDlb1U38iOZtSazw6dHJvNsdEjbzl2VA9BQHW9lgISVtJmr76cU1wSsKL4joGhZy6hzCTUl0d0olHGBHqJqsz4o/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724417045; c=relaxed/simple;
	bh=CC9gIYHV1C7qrmQvpRhRnobfoURp8/gELuWPRgGMQ4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pby4Owo5bql1RiqOed/e4/pGP6sRjeFODvfzQ72Zk5mzNObrUsozKsbXw0CUftyeI+LDfJik7UBcjpQi9gPzOQyrPriYWdLmBibFasEIsoQcNsXf/KoraA0e7Y+JaEz2yochnOI/PfXHjhDgbyQ+6JYVlQynY/pe+eilMulbZJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=H8Fe4IaY; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="H8Fe4IaY"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2704d461058so1298126fac.0
        for <git@vger.kernel.org>; Fri, 23 Aug 2024 05:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724417042; x=1725021842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQxyfvTRImXz5LDyD0fMR2i6Hv4oZTPp7ezwhAIpNk4=;
        b=H8Fe4IaYusoeu+GA1Ahgv9fU5i4cYNik4/ZgxZo/Ay0E2Rk2bnY/LQ9rtbLEaQU1On
         aLkTWDA+s9NShQpJhJTgnYYxM/RXYXiZZxocevc9TCeTkUiRdA+zp8CS20eukkX0aDqS
         7D9NM8PyAojQrEsvOA2FjHkpWUAk4YusEkGAPsFBBe/UcEoIT5yjr/c7N5zB5UOY73YL
         Xd6DNXg0qh2KAuxbZE4HILjqbSn5VU1+DMnFnu4LrHKNP56j3VvnBHoiqXeJJYZzdOqY
         nMew17feaS5rzHX7+D98FI0crPLZdmNSjkfE0l5Q7zpDsvEUY/C+kPYrtRqsd5JizFrg
         ogNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724417042; x=1725021842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQxyfvTRImXz5LDyD0fMR2i6Hv4oZTPp7ezwhAIpNk4=;
        b=QDP6xY7K6QUbOklNbBDTgaohUGEznZUGCr2b99jI78USLkiNoH04A/r1SF4uSkV2BH
         FPYh53vm57dLR1HyZC3LWBVvciAmG/q+kaA60CKrAWpcakH/LAcQDJ1T9Dcpua9prAZQ
         LezQF3VSUY22RaeLi3RcIDPpsrtDKWkvwZhbhtfH8S37x1iOxkVUg7JfKEiybUGtYMMo
         Qk6j00oOYGMdjuv3lyKI2KXkm1SMuNb77wWL9j5wKbHT7XTJXsMLA4UpSUJrIlS06EtL
         5MlGWDUInSp5Gi6H4AnOymHNp2IY/kquOYLp7HaJxeDq+J1BJFKOM7d1bj4Kn5X+/6Ym
         tGSQ==
X-Gm-Message-State: AOJu0Yyi2+H7tGObK4SVxtbm7GFALpgH/RjEDq2f8TL0L4OUj2i3dWTP
	i+lTnCPiVrR8pWg84R0Xh66t/Zf5AW/LcSlcH+S2MW2a3MJ4tEs1jgPnEbxLPNhAXKI6Ov5BRYS
	Z
X-Google-Smtp-Source: AGHT+IG9CT1wcMnM+yQotteHHwfqKCKSrSQj74cnfwTUiqSoyPPWM93apPXkD2rb+khwfVbs1UAasg==
X-Received: by 2002:a05:6870:b494:b0:261:1b0f:dc94 with SMTP id 586e51a60fabf-273e66990a5mr2087983fac.45.1724417041871;
        Fri, 23 Aug 2024 05:44:01 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ad56c5esm3068023a12.75.2024.08.23.05.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 05:44:01 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: Han Young <hanyang.tony@bytedance.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Tan <jonathantanmy@google.com>
Subject: [WIP v2 0/4] revision: fix reachable objects being gc'ed in no blob clone repo
Date: Fri, 23 Aug 2024 20:43:50 +0800
Message-ID: <20240823124354.12982-1-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802073143.56731-1-hanyang.tony@bytedance.com>
References: <20240802073143.56731-1-hanyang.tony@bytedance.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following Jonathan and Junio's suggestion, I tried to filter promisor
objects in get_revision(). Initially I got ride of the
for_each_packed_object() loop, but that way promisor trees and blobs are
not filtered.

I kept the for_each_packed_object() loop, but only mark non-commit objects
as UNINTERESTING, that way we ensure all the promisor objects are filtered,
and UNINTERESTING bit is not passed down in process_parent() call.

But this isn't enough solve the 'reachable objects being gc'ed' problem,
as promisor projects is defined as "objects in promisor pack or referenced".
git repack only packs objects in promisor pack and non promisor objects.
Meaning objects who are promisor objects but not in promisor pack are discarded.
So I added a new option to list-objects, '--exclude-promisor-pack-objects'.
Which only exclude objects in promisor packs, this way when we run git repack,
no reachable objects will be discarded. This seems to fix the problem, but I
still don't feel the approach is elegant.

Another way to fix this problem I come up with is to pack everything into
a promisor packfile, if it is a partial clone repo. This would make pruning
unreachable objects impossible, but that is already the case with promisor
objects. Packing everything into one packfile will simplify code by a lot.

Han Young (4):
  packfile: split promisor objects oidset into two
  revision: add exclude-promisor-pack-objects option
  revision: don't mark commit as UNINTERESTING if
    --exclude-promisor-objects is set
  repack: use new exclude promisor pack objects option

 builtin/pack-objects.c |  8 ++++----
 builtin/repack.c       |  2 +-
 list-objects.c         |  3 ++-
 packfile.c             | 25 ++++++++++++++++---------
 packfile.h             |  7 ++++++-
 revision.c             | 17 +++++++++++++++--
 revision.h             |  3 ++-
 7 files changed, 46 insertions(+), 19 deletions(-)

-- 
2.45.2

