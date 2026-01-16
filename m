Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C5E36164F
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 11:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768561591; cv=none; b=G0+XnYWECym6GFQLeoPT/6lHDNxwjex3GBbIcAWJ7bLCW6IfEDqHMwukwLgFSFUwl6Xe0erd2CmQESMVXLwjh8n8W5PVpGf+exqGtX2TLpFHidcvkmVJMgjBTyml46nZQ8UmSPGhu/D9h0/ehF/CBELAJ1JX/MElly0J5XSjj4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768561591; c=relaxed/simple;
	bh=lcMQ03iVGJ3c5u+SwMzrDKs/Auzvgr3DpyJwAPK1lgA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=lK5Iz2d0g/3IFm36M5sFZzuWe7yk8hHewq0ZfLsqotOrgVUFFX7BSyYD73sjO2ikKQ9oAdRVCh+sIMUmSDxXj/ua65xcRZCBdmKGUjseZZvcd5b0W4Ds1AW096l1wJU6pZnrohtlH+SpvZUVgoew2DKMch+Vcn3e9J653rX8RDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gH37JGy+; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gH37JGy+"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12332910300so4631638c88.0
        for <git@vger.kernel.org>; Fri, 16 Jan 2026 03:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768561586; x=1769166386; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lcMQ03iVGJ3c5u+SwMzrDKs/Auzvgr3DpyJwAPK1lgA=;
        b=gH37JGy+B5pHMf/qDKStVz9+Ll3QdEiUacvV1xIaij4/VaiZiKAAD1lzamKNf/08ME
         1OeO1aa6FKOXUzZGZq+3qheh+QjAfWswvJDPHbSZ4QOwc4PFxW6kz83P/1JHooitxqMQ
         Hs0KHwtPMBvKQb761YdpEilCKXnGw+S6AxO/EksJjZ+Xh2dEnYnAflPn7o+CC4qo0Dij
         wB1HlfJrGwUre3DNZ8wr6ltA9OXRYOHEEWdntqs+Owy9I0Dz6wjCUii5BJ+NSd2WlJ7D
         H15Hzy7dZ+i+8XK073lH6Y0++79UMZvrpfMrvf6impmlKdkKGCSdX7aGf4a3LxbRSzgR
         aoPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768561586; x=1769166386;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lcMQ03iVGJ3c5u+SwMzrDKs/Auzvgr3DpyJwAPK1lgA=;
        b=xSk17NN+8DBS4msPbc1ua9ilCddhBvAYzCnZvmXIs8mkDiFu7CWRR9S898dOlyW17X
         EwNifdx5hAEiowLZRYnZCXr5AE/+/0fgYc/epbC8chPHeyRUR+YlGdTos/edp1OcCWvS
         i3uft1Lgf5TJSzvsEexknexPtyphUmxUigY9MNqLzrMxM6BQc8h6O6PChe7Mr8+a8zeT
         Vr9qhmtI3vkI1eBCqwK7an+kDST4XF5TBl54uH7KWlJoP9P2/5WcF/l3iUB37Q0GDPPy
         tRq83npmVyVAwKeexzm7VmdlSl4EvgLvc1CmPybvXeANt8nGbSEPo7kjsA/HbsK57ou+
         10/w==
X-Gm-Message-State: AOJu0YxrgIGsxnZJ+So6qN91D1aX+WDkgwEvG+XZ3x+z1cZsIBv1AyAL
	1LLNtNCQRZBQZzuR/lK7Fl42N+/YX/lSsEDV2RUqN43GZOAEc8iOabMsXjUh7JsLw9WpJ+QGsPY
	i1J0NhFY1MzWJZyBax9Sn38k2XixKv6rPdPI1
X-Gm-Gg: AY/fxX7lIaU+z3iZ/HedhOKW2IAXtTVv31uiyNabhRf6h+7I/TQAcAmuCOQ2eGQLqfP
	YadgzArsMDVo16PVwOffWv2oYnHsy64F9sPy2e1MhlCT4wEF9r1HnYZIpIgSAMvyHB424uHZ45P
	NmFIMsjtfzzG0sWLB8wBY38bf6uf+Vel1NSxjircdO3xq/p3lVXCRuw4kh8Ri8NyWAW7QOCTR1Y
	1LijVA/IkMDCl/VkCBCDDW3szfmKt9Ti4LhT4eFWA5OuXrYlsCJRGILEtvz839MfukIrhmJHU2y
	I1I2pS7qPCNrEWG/P5MsOIln+3jKKn66U3Dsfci23LTkKWToEyZRHYkwa8ctq4putUJGivkf5IJ
	HZstacLRUJjnm7sf0PMW0Hak=
X-Received: by 2002:a05:7022:e03:b0:119:e569:fb91 with SMTP id
 a92af1059eb24-1244a6592d5mr2899808c88.0.1768561585491; Fri, 16 Jan 2026
 03:06:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 16 Jan 2026 12:06:13 +0100
X-Gm-Features: AZwV_QhNjwpud-vV755dtTYlhqnLecZPraDq_6gbUAXT8-B9Q5cNRs_FCqN1FZs
Message-ID: <CAP8UFD11txMWSfMTvDtcBJuuZA5mKffo6XUyR9LWk2d_N0RRtA@mail.gmail.com>
Subject: Git project and GSoC 2026
To: git <git@vger.kernel.org>
Cc: karthik nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, 
	Junio C Hamano <gitster@pobox.com>, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Justin Tobler <jltobler@gmail.com>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Meet Soni <meetsoni3017@gmail.com>, 
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, Bello Olamide <belkid98@gmail.com>, 
	Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

The application period for mentoring organizations to participate in
GSoC 2026 is from January 19 to February 3. Let's try to anticipate a
bit and decide soon if the Git project wants to participate.

If we want to participate, we need (co-)mentors, org-admins, projects
and micro-projects ideas, and we need to update existing pages or
create new ones on the Git Developer Pages (git.github.io) website (or
on git-scm.org if we want to switch this to it now). Please chime in
if you are interested.

About (co-)mentors and org-admins, Karthik, Justin, Siddharth and me
have already expressed their interest in (co-)mentoring in internal
GitLab discussions. I am willing to be an org-admin too.

The Git team at GitLab is also willing to manage Slack discussions
channels for (co-)mentors, org-admins and helpers, and then for
accepted contributors too, in the same way as for GSoC 2025.

Thanks,
Christian.
