Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471503ECBEE
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 13:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781531815; cv=none; b=nV/7uor8+XuIf2x/udnv3C/ZpmA2TYYQaU1odtmoenNaqyRLwpmQSs3pcCOgzQ4Bc/9m21y2+TjKv/S5FKiAYAHwV2CsGMLL2PdpAXWk5i089rHMnE+4GTz0EEcy+rnsdeOGxccRsKleIVDWFl3urPXCErYSZyIWOaER/fVtaNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781531815; c=relaxed/simple;
	bh=4UYYrIkyhQOoLdGqjClfoBzg3NzKhtpiMFTaUtwzE5Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=SZLrXlxvxSzh5H10JbWXlXn/aPO6eRgLx2lLRwBEyTO/+fEPj/f1V5KsvHALHFF1C+qGCvwPlhMFzU1/pGtyxYeDYADIFiNtkybfhMOnTPfhGe+Ziqpvv237PwJ3v17mUw9/kfXgLGilA05EONU8/FbRZB1We30kzlvw7wQ9C/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=euzE9Ur/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YHm1pk2e; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="euzE9Ur/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YHm1pk2e"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 799D91400042;
	Mon, 15 Jun 2026 09:56:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 15 Jun 2026 09:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781531813;
	 x=1781618213; bh=xtd0MxdqeOyikSCKwuWW8py2+LahP7vnOOGNag84JNI=; b=
	euzE9Ur/fi+W5izYi4k8ksv0quwKr54CN2JJypdWXf+Xpp8/J76wyHB8r6ZvZcTH
	vrxANpdohOQjtJc11rsukjyiYoNOh/sdfKiJ+xMpYVU6nYF0MmLllExrfYPca+Dv
	KAxqB7za+hLkqv7Yk/PI8xtgbf/BLMxKJvljpR+3+1Qt1+qrMII8yaL3LtdEXQMq
	xxz6vKtI/ibzUcss2WUWySiFHwgMRY3c8Ol/F0gHGM4Wg+j2Zlwif85uR4JZelh3
	Fpxb/W6Zr7Tzva5L2Md2pWddqAuih/a6iBddhIavjOd/4U158F5NCmaR7iiCtd8L
	fGuDl869IMOwPwU4H2exMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781531813; x=
	1781618213; bh=xtd0MxdqeOyikSCKwuWW8py2+LahP7vnOOGNag84JNI=; b=Y
	Hm1pk2eINW6VcwoMs5SDpn3xqzrAjuyhRxqlDmEU8ULkCtJaSRMFWywIZDx5s59i
	9RxSYkWO6iOfHCNN/5kGhg2bLpAvyzzu1t83/059aFzUUjRxD1WXZmhLnGJ1sp4o
	OSrenLYQHj8h2RFHmhsUDXPcutvMvhfrstqVJI6In566g0KKAtoPjFIuT9WQPyAK
	xGGoOaCUB5GcT1M5CC1jmoWsGNNFb1aXxqsFiFgxHOIUtim2yp0ebhTr45tp9Ufj
	Pz0if13J9EDDbI1avbHYzlL0s4kOfgg0g9wtV2Dx4Z+qzBgb+LqkU8EriAcHjgZ+
	CvTReLvTm+b53H1D5jCug==
X-ME-Sender: <xms:pQQwalafPTfxIPcUvy7On1e1emulv3b2UXMleeFU_9-JYf3pzOB1Pw>
    <xme:pQQwaj0TfgvBjjxud1eyDPXalI63ITQWQL-ojqLBwIoumcYjWJp6mzRKFJ_j5guQx
    Pw2npLhMEdNQ6wUGA0jHz6Y2RzYMmM9xshALY2OB3t1qLiq9G7vF2M>
X-ME-Received: <xmr:pQQwalUHsQDmM1NxRUuKlgULDu05hA3rU90LioMMwl9uwM4nBkWsPIlJxhXZyS7luU6PbpEn54uvhTmdZlqfkMzu5B5ePtszv8J_SyAalQ>
X-ME-Proxy-Cause: dmFkZTEDkcJuCitSduo6wJL7XNY0oqYnUw57dVxXUywjFA4+F2Z3OZRhO/GPZZmCfAlWLV
    1yPXrYZNkb+VW26kgljqU9pzsEOpD4HQuDcx6mBw32LGOF1CElGRNh4NWTA7VumSP7pXUf
    uYvqZJrx+3vmD/2eBC+3meMaitKFk9pewGeARbRdhqMRyEfg+dSpe9Xjp6e6iAlDGgbmOv
    sekVojfaA7t/Td9gkdkA9phkWXzsjuwslfWvKYaV4s9w6F1ic9Ht/YDRbkqvQKa2g2+Mkq
    Wn2IIOtCPBzgjxOfmNm9TSSs+KgtaIw+tb4goYlxNBzwB39Z+H/2umubeS6zk0vZLvCgsx
    QgVxGpxvIU9Gg85hUhD/9AfPrNNHd2+yVkKpjo1PrRm2e0Y0cvKyumKbgFlAnyhFlTzSgh
    bADR/prUfv26XPclZzoV3uMFk7mkFw09PXcvsyxwlmNzSQxonfAwo/e0NUC5eZDaw+tN5z
    VqBejhLn5Lox28eRLtyFNj3+dFa6WtWHpaZf9zIPpdL6PHtfZ3H1xT80+9R7IegcIhXtje
    QWianBdP6TDW9L9EYc1tSXc8R7o1/vPpQOPSpM3mNxSDud2UMQ2O+PahvuCrqkpFN0VXJW
    N6Sz34Cecrh3Z+rqsrRLV/ydfHIR1ilVKCd7OYpt9U+3uCTBxsdg7ROhoW4w
X-ME-Proxy: <xmx:pQQwatUAHblcJF8gwuiXip01fBcYy_yjymmzg3oOAAi_7GOtRHgcCg>
    <xmx:pQQwakc01sRk4Hhf17TN2aE0yw0hsA9WOiw87T9ehOoPkdJIlSezSg>
    <xmx:pQQwamWNMRD7NnHc68vd-b5dcxMISvvPQmPXpe-PZEr7163K7ioBCg>
    <xmx:pQQwatf7EMdL5HOTivj_2EHHxqQFJ8ASUbkBgOyUAGfuBCjmVjEo-Q>
    <xmx:pQQwash8XdwA6ULRJ_ADrLlYXBmf99xRy_AR1MDaA6P4B2NSVpKW81oy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 09:56:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 84a6c8c8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jun 2026 13:56:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/8] refs: stop using `chdir_notify_reparent()`
Date: Mon, 15 Jun 2026 15:56:46 +0200
Message-Id: <20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-0-f4854aa99859@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ4EMGoC/42OTQ7CIBCFr2JYOwYqEnXlPUwX/EztaIQGkNg0v
 bu0egCX3+S9983EEkbCxM6biUUslCj4Cs12w2yv/Q2BXGXW8EZxxU9gJAyPBBG7BLoEcmB7RxF
 8yNSN9T7oiD6Dlqg7gc5YbVhdG2qD3qvp2n45vcwdbV7ml0RPKYc4rq8UseR+VsH/thYBHA7KH
 pU0XFi5v9Tajp6snef5A9CFchTtAAAA
X-Change-ID: 20260609-b4-pks-refs-avoid-chdir-notify-reparent-a4eaf1edbcab
In-Reply-To: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im>
References: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.15.2

Hi,

this patch series is a follow-up of the discussion at [1]. It converts
the reference backends to always use absolute paths internally, which
then allows us to drop the calls to `chdir_notify_reparent()`.

Unfortunately, the series has grown quite a bit larger than anticipated.
This is due to a couple of weirdnesses in how the reference database is
constructed with an "onbranch" condition. We essentially construct the
refdb twice and loose one, but we never noticed because the chdir
notification subsystem kept the pointer to it reachable.

Note that the first couple patches that touch "setup.c" aren't strictly
required. They are a remnant of a previous iteration where I tried to
solve the issue in a different way. But I ultimately figured that these
changes are worth it by themselves as they simplify "setup.c" a bit.

This series is built on top of 1ff279f340 (The 13th batch, 2026-06-09)
with ps/setup-centralize-odb-creation at 42b9d3dc9d (setup: construct
object database in `apply_repository_format()`, 2026-06-04) merged into
it.

Changes in v2:
  - Drop the last patch. This seemingly destroys the whole purpose of
    the patch series, but after Peff's hint that this is actually a
    performance optimization I'm less inclined to drop the chdir_notify
    infra. I still think that the remainder of the patches make sense
    standalone, as they simplify "setup.c" and clean memory leaks. Going
    forward I'd like to investigate the idea of introducing a `struct
    fsroot` infrastructure that uses the platform-equivalent of openat
    et al.
  - Improve a couple of commit messages.
  - Link to v1: https://patch.msgid.link/20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im

Thanks!

Patrick

[1]: <aifAVpxanV31KUpC@pks.im>

---
Patrick Steinhardt (8):
      setup: inline `check_and_apply_repository_format()`
      setup: stop applying repository format twice
      setup: don't apply "GIT_REFERENCE_BACKEND" without a repository
      refs: unregister reference stores from "chdir_notify"
      chdir-notify: drop unused `chdir_notify_reparent()`
      repository: free main reference database
      refs: fix recursing `get_main_ref_store()` with "onbranch" config
      refs: drop local buffer in `refs_compute_filesystem_location()`

 chdir-notify.c          | 26 --------------
 chdir-notify.h          |  6 +---
 refs.c                  | 28 ++++++++++-----
 refs/files-backend.c    | 22 ++++++++++--
 refs/packed-backend.c   | 16 ++++++++-
 refs/reftable-backend.c | 16 ++++++++-
 repository.c            |  5 +++
 setup.c                 | 96 ++++++++++++++++++++-----------------------------
 8 files changed, 113 insertions(+), 102 deletions(-)

Range-diff versus v1:

 1:  ef72346c7d =  1:  3902fecdb9 setup: inline `check_and_apply_repository_format()`
 2:  157fc098b3 !  2:  9479ffc370 setup: stop applying repository format twice
    @@ Commit message
         When discovering the repository in "setup.c" we apply the final
         repository format multiple times:
     
    -      - Once via `repository_format_configure()`, where we configure the
    -        repository format for both `struct repository_format` and `struct
    -        repository`.
    +      - Once via `repository_format_configure()`, where we apply the hash
    +        algorithm and ref storage format to both `struct repository_format`
    +        and `struct repository`.
     
    -      - And once via `apply_repository_format()`, where we then apply the
    -        `struct repository_format` to the `struct repository` again.
    +      - And once via `apply_repository_format()`, where we apply these two
    +        settings from `struct repository_format` to `struct repository`.
     
    -    As the format will be applied to the repository when applying the format
    -    it's thus somewhat unnecessary to also apply it to the repository when
    -    adapting the discovered format. The only reason we have to do this is
    -    because we call `repository_format_configure()` after we have already
    -    applied it.
    +    With the current flow both of these are in fact necessary. But this is
    +    only because we call `repository_format_configure()` after we have
    +    called `apply_repository_format()`. Consequently, if we only changed the
    +    repository format in `repository_format_configure()` it would never
    +    propagate to the repository.
     
         Refactor the code so that we first configure the repository format
         before applying it to the repository so that we can stop setting the
 3:  f1429ae8c9 =  3:  09299c488d setup: don't apply "GIT_REFERENCE_BACKEND" without a repository
 4:  4137f0f083 !  4:  dff1bfec7a refs: unregister reference stores from "chdir_notify"
    @@ Commit message
         a subsequent commit.
     
         Note that this requires us to use `chdir_notify_register()` instead of
    -    `chdir_notify_parent()`, as there is no infrastructure to unregister the
    +    `chdir_notify_reparent()`, as there is no infrastructure to unregister the
         latter. It ultimately doesn't matter much though: in a subsequent commit
         we'll drop this infrastructure completely. We merely require this step
         here so that we can fix the memory leaks ahead of time.
 5:  dbda87ab6a =  5:  367806c5ba chdir-notify: drop unused `chdir_notify_reparent()`
 6:  b1d2f39def =  6:  e8eb346876 repository: free main reference database
 7:  f7f5028a10 =  7:  090f80707c refs: fix recursing `get_main_ref_store()` with "onbranch" config
 8:  818c0878f9 =  8:  14b12a8f10 refs: drop local buffer in `refs_compute_filesystem_location()`
 9:  7408f9b69f <  -:  ---------- refs: always use absolute paths for reference stores

---
base-commit: 255322df35357168daefec8523a3cdc849edd6c1
change-id: 20260609-b4-pks-refs-avoid-chdir-notify-reparent-a4eaf1edbcab

