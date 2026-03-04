Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4D03DFC8D
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 18:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648270; cv=none; b=RQUGVFpcOxOWSYWVqtdQeSxbRRhTpfKtywV5wB8Bqx7MaRG5pqcV1+g8cpZG++Yc7jbR4okveaIiUtmkzaY2DWODJv8iF3PNYA+1ah/4+O667jyji57Mz0kGRozEky9WmkgECaYkV5RI5VI33MXedM063u/I3M29EbhVJCPfGiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648270; c=relaxed/simple;
	bh=YGDGAE52YAZwSK73NhX+YXzahA1SS58sF7UZ7eM2cas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=svdS7urDsAlUM8FlnLiYNyGO9qpsW6YgRBFcEb4VRc/tH1WOWXFNGxy76QE1jBIgSf7R8YjKlroB3X2Lrhr17wTMr5sI7oQbyDUbxL/GueNiBOc1jOUQNP4rzyCvaXaoQ77Q/pDfc7faUIGBaN4Q+OSwbEb58TKawcbhSUneMIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kecdx9hB; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kecdx9hB"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-824af5e5c81so7262626b3a.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 10:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772648269; x=1773253069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGDGAE52YAZwSK73NhX+YXzahA1SS58sF7UZ7eM2cas=;
        b=kecdx9hBhPGWW1qWWIhFdFT0HUVN1x+n/ZbBuzNM+uiPy/S5Uh4bejiSF4KCaSaNda
         m4KlRdN4Qn9F48jm6yO9bwlMGOrMAHO77+hQ1szweLXSuMV4m1YfX0kiK6u5cwZpHodB
         YdlVdTitGBq+0HGv13kAgcHQX2+n1ehvoKIxauL/scEy1FBVa+5x9inpNCizeILfxNp1
         0KtwFUG68JJtGgD3L21Ad9a3wIIItZxjd9hBtwRxhUu/fMrPOhbcn6hukVT7rBlRSsTi
         d6gd0BIJZkH7LHtTwdUvaOl3TDpzKhq+tMrMQIll4BOoXNe9IAiaIu+9UBuJ5H2KI1nB
         aIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772648269; x=1773253069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YGDGAE52YAZwSK73NhX+YXzahA1SS58sF7UZ7eM2cas=;
        b=gz+NzHnx78BOisZBVgmzhlpn3OlmndzWDBslycdrVEMa0xBa+mWmdg0xLFWlGv+5f5
         q+ZRAHjBmEdaM9+zL2inXWmeUYexfqLzsYFY/gjA9zNJyVQ4/m3WBs/TZTUCM7tIpSLb
         Jz7EgOi5wmmDBZ9dZYrl04bAEE80S3T80jldlFwYNNZSpmFerhJezyqEycpdk4bEAzVO
         Z/VnJwL1YLLUM6fISHcSnnl3DffPPxyhl6mqAaYn7OiUUEewWODbhEld/kf88zyAy+LI
         GDSr0KvGpGta8+p2UN4Tpl3oTZb48HCkpnAaftImYWh85GsHZv1YqL/ZopjoOzGVcOoR
         IHOw==
X-Gm-Message-State: AOJu0YwdXkuD99r4ejuA8Li9q+I6kM5u7Qla1ocY5j+Tcees3NTlL9O4
	Mnz8tGs7PXMvRFmnEHCw/0QuCDAGJJUvEtEe7jrBwrJbmC+2+GAwrT3lLWGlDQ==
X-Gm-Gg: ATEYQzzJECHh5WjC2ZGg7ctRtJcKKjRLZvT77pKic/3D1rEvg/cTY4aM1pos4Jmsb00
	dvnFPYf0VL4l6V8p0kUgFQWREvm4ZFwd2EB7NZG8+sBlPwcKnvOc3EBTBBLBN6LwFjvrhEicIKJ
	iZRTQHasIdoAQ364/vtuC/C+L8xOo2A5tdGtBUtbbvTLuHwknaNS8qGxYGTEtWgD4pjaBRO1rdL
	LQpxM2b7oxmHiFa0BKuIFFJJKKjSRiHskMvUl6bOWfKZ/v6dycrkBz5QTgZyTYfjX6neICDIbLk
	JCrlMbLh7HmZ5VJq3UPAX3yYemF9Aj7lGKKxuno17kG4/0Ac8loGru9FuFoSwowmBms9lVVtAXl
	vbOInaOG/pY+/4WIB3E7uvkGCh9semh5j+mOghGBGvtZq2ul0vxXvpULzMax1ZPD9yeu5WfT2I7
	SAAv3KyTROuMeL7Dh4DZwqWP4/Omn5LR6YIMvOXKuwp3sHHbE0eC8lWJCJKbfrEgIgsCRdF0ou4
	ns4TYro9Q==
X-Received: by 2002:a05:6a00:35c7:b0:827:447f:7dbd with SMTP id d2e1a72fcca58-82972ca717emr2222120b3a.46.1772648268920;
        Wed, 04 Mar 2026 10:17:48 -0800 (PST)
Received: from localhost.localdomain (d75-158-111-22.abhsia.telus.net. [75.158.111.22])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739ff1a69sm18333166b3a.34.2026.03.04.10.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 10:17:48 -0800 (PST)
Sender: Paul Tarjan <ptarjan@gmail.com>
From: Paul Tarjan <paul@paultarjan.com>
X-Google-Original-From: Paul Tarjan <github@paulisageek.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	paul@paultarjan.com
Subject: Re: [PATCH v7 05/10] fsmonitor: deduplicate IPC path logic for Unix platforms
Date: Wed,  4 Mar 2026 11:17:47 -0700
Message-ID: <20260304181747.25692-1-github@paulisageek.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aafigc1QiysIByhM@pks.im>
References: <aafigc1QiysIByhM@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Mar 4, 2026, Patrick Steinhardt wrote:
> Nit: we're not exactly deduplicating just yet, but are rather preparing
> for that as there is no second implementation using this yet.

Fair, renamed the commit to "fsmonitor: rename fsm-ipc-darwin.c to
fsm-ipc-unix.c".

> I think these while-at-it changes should be removed from this commit.

Done, the rename is now 100% content-identical (the BUG guard and
blank line removal are gone).
