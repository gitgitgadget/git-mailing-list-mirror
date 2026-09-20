Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B1E1FC0
	for <git@vger.kernel.org>; Sun, 20 Sep 2026 10:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789900741; cv=none; b=KJ0LDNJzMJZmmGmbk/Jpndpv0C1s2e27Q7470IaCyeCCWACiAgjV+n6WfpZHWjxfA18eCgmkDa47RJIQbCzbAtjRGsHguoCdqiWiUrioDgY/A9i2Nwaha4TeARymRNmRZMxcUTFXls2VnXPLnmitM1CIlxVj/z2FPxDhHOpr6vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789900741; c=relaxed/simple;
	bh=wlYFH8mmbNV4sY8dDvo3Zf2FBPYrqmt2exAT140dpX8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OaL6SFiBRr3HbjZ5gg+UULIDwWMvM1Gw67by/z2Wcx3AriRE000FsU3rIZNxg/hSFrWs3Vv7Uw1g7Mqkdxof+GeLpVXxephX4ASUNvUoYZ8GgE+HsRR7ubAvlsYL7Nb+R7ZaKV2MdAtLjEb8PNohkR8/N8QOM88CaAKpFF3/sfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+i6WbMU; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+i6WbMU"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f9f7dbeso235916466b.0
        for <git@vger.kernel.org>; Sun, 20 Sep 2026 03:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789900738; x=1790505538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wlYFH8mmbNV4sY8dDvo3Zf2FBPYrqmt2exAT140dpX8=;
        b=K+i6WbMUmD/i9SL6CwW1on/NFzcWnwiaiyx/+jgY6ZUFVsAph82Em1naUS81Ib7JsA
         CRuEsncC6YS0/InE1jvoZxo3WT10EeTkPAyvGZYUTCY4tsZiL1rPlRIP4jK+Wlm4dakc
         53IY1ytp0eTgltR5USc6fvIIs449kWuXB8T4lZxdPecawRg9JXy475QL6NIj/NwYR5zF
         4uN7ad2pEikEEAzAIxcxxWajkufPAHZ03y04/8cfQewgD3kmvf6Hrmp++s3juo5PvMRK
         KcDrG2pRdP1abd89WqIgEm46iQZtx0cx8UaLEE0D4SbnAJaYF0KKRp+ArKzDfgF3umk2
         GSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789900738; x=1790505538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wlYFH8mmbNV4sY8dDvo3Zf2FBPYrqmt2exAT140dpX8=;
        b=OguOIaMs3GzL15PkICUhvnINQ9H4w6FlslE1+fHZU0AWdhfYlr8yqZmItyyI/Xzpu4
         +kitsqh9DbjNKhzAi1rjTknHWwXi/HforCd7Ptyq5JGETmWNaK3TpbNo3FXZt/JuFoz+
         kFOMD7uyKewoddLJQ/gXe0KodRAGSRev1OuOYhVxs06076y2N7m70N+IZEkGBWp/6gQP
         Gh9z9Ugei7bOPNqAZtc6ZMis3HTvCL4nfRXm1MwmaCwo9wi/MyUgHEhGbmVnCkZ1pWUt
         5uS1nx9k1i68V64LP8ikGGZ0CYY4wleS5jf4kVtDi1dOoKA2NmIh4TZ9eJKpyJdrtNsH
         tVcg==
X-Forwarded-Encrypted: i=1; AKwUvBxuEF12S1GWMzmtGcZwSLpmu1z4N1RLNnObAzqNptZJHMzRI3GoVfGqkQox1tRUzTlhGhw=@vger.kernel.org
X-Gm-Message-State: AFuF++m0volAdh3F3XrkQiqdGyOC817SctPflBlc72FLLOp9mMUyXxm9
	v9kq+3OTQNRyR3Xcy/JEcFkOaNEANSZ4cuTrDVSh3X4L5ilTerpHEGHF
X-Gm-Gg: AYBFou0gqjF0e2mY5/uwe/ignz4JNYsLsxk83z1YHyqXp3vfs2M9OPGNP42/Bys7SjJ
	CBkpAWmBAEAGihUMUDcj9cuFS9Un2MpmG0OqDPCn9wGF+I5eL7kxp1b1TrSLsISiwnWnOAvb2IP
	uwTiLjU+LsRrYKrHmB88xZw3eIqrwbwcTwguGBhij3QIhr0qvDg6k+hL+6B40/TadkEBfKk2+aE
	sMhGz4Eh64tLdFMwykzzXjY+TcBjPZSo3fq6TBSOR8dDjDcGDdnAtWgqKpLqo6k1pT9Hk8TJCx/
	X1XrYikSYNNVl2qxZXwI5JeLe2wxCyeDKyS6tLu2vLJLV/QvQxdXN9bvlayZxtTL1EO3Joe0714
	EEi4uDKxLxmM53dAfCzQBy5VqcGETjLIpbupoaAIGmb+IgKsNw0aHlvJlEP63etwx/gyGZmz0jv
	UPWKYKTgwybvUBZxzypoDqkU52iw+6HAf2WhxOZ8/W/2bJY/m2+G+/JBGNo6BPgBHhyNeox2JlQ
	15n81NGEgq8aZS2czSQU9jpW+qhRLcZRpMsHylR8Zu/w6im2nI8aJcIvgCsYizguigCYfSWY6RF
	OPSF/TNoXwXJMxkrwSOUJRQhxtat2okBVqOkQYd8KzGbs76qdmkk+WOpBS2i5xnCDx5jMA==
X-Received: by 2002:a17:906:9f91:b0:c29:4970:abec with SMTP id a640c23a62f3a-c2a156ec23cmr607450866b.19.1789900737654;
        Sun, 20 Sep 2026 03:38:57 -0700 (PDT)
Received: from localhost.localdomain (138.54.classcom.pl. [195.150.54.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a35239716sm177477866b.3.2026.09.20.03.38.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Sep 2026 03:38:57 -0700 (PDT)
From: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>,
	git@vger.kernel.org
Cc: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Phil Hord <phil.hord@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH 1/3] refs: allow callers to supply old OIDs for batch deletion
Date: Sun, 20 Sep 2026 12:38:55 +0200
Message-Id: <20260920103855.19874-1-maciej.ciemborowicz@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <CAOLa=ZTWGJZCmZnPLt5az_w-6YkGuQhQUKyJq6X=VFQL1T_6ZQ@mail.gmail.com>
References: <CACQ=SRHthWOLVXmY6wgknOPgpQ+oB1vV-Q0AL=mK9mXb2Xy9Nw@mail.gmail.com> <20260919201158.43415-1-maciej.ciemborowicz@gmail.com> <20260919201158.43415-2-maciej.ciemborowicz@gmail.com> <CAOLa=ZTWGJZCmZnPLt5az_w-6YkGuQhQUKyJq6X=VFQL1T_6ZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks. Yes, supplying old_oid changes these deletions from
unconditional to compare-and-delete, so a concurrent ref change can make
the transaction fail. I should have called that out explicitly.

I think that failure is desirable here: otherwise the command can delete
a value that it never examined. For branch and tag deletion this also
restores the behavior from before 8198907795 (use delete_refs when
deleting tags or branches, 2021-01-21), where delete_ref() was passed the
OID that had been resolved by the caller. That commit batched the deletes
through delete_refs(), but the expected OIDs were lost in the conversion.

I reproduced the race with a reference-transaction hook that updates the
branch during the "preparing" phase, after delete_branches() has collected
its OID. Current Git returns success and deletes the concurrently updated
branch. With this series, the outer transaction fails its old-OID check and
leaves the new value intact. The same check prevents pruning based on a
stale scan from deleting a ref that another process updated meanwhile.

I will make this behavior change explicit in the commit messages and add a
regression test for the concurrent update. Your comment also exposed that
remote prune can print "[pruned]" after such a deletion failure; I will fix
that reporting in v2 as well.

And agreed on using a local item variable for the loop; I will include that
in v2.

Thanks,
Maciej
