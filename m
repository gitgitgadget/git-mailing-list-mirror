Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE012033A
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 17:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723569492; cv=none; b=d3O8B5fgSHeH2KNx2HNyNY6nChOo6oPBl62ee6IIZCXXGqVEVU3dxrPKINzUnv79n6kpD89jC2s+3PQzb5VGHnR5+neg7dHhiBQY1Kj4xvJ/oUXGgsDhX5AIXzclfqh0BYkKecacc9eQQ3rIgJpT3/I2Ry9y/uHllFr5W+/bDIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723569492; c=relaxed/simple;
	bh=2SdlnKJhuWf6PzxzZseYk5NuQUcgz1QjYNDeCJrpvRA=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Ft89+qrrxPCOF6VjUlM6Ni0u9RPsH8zWtH3jGbYUDv1qPwZmknXAi225hZhZKUwQFJV17Oql1pAvPWt8olADxFKhc3JsTQ0LtRoiB7jTEdw4thy16JZE9Ws8jFR5sFBFW6wLQjA8J9ntFNEJMK+CJZp2h8iwBwyAH4ockH7v7SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yFMB60uH; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yFMB60uH"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-664fc7c4e51so116348027b3.3
        for <git@vger.kernel.org>; Tue, 13 Aug 2024 10:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723569490; x=1724174290; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aEJaNbQzlBnOLdx0V2SNQk2FxHnxnbdoYeUu2IlqSTw=;
        b=yFMB60uH2syoGWi+eU/5mSb0JfMhSdXvF4gqb559uG3E5lAtsSg6waai1RFjdWML4M
         mi1Lij3/YHDgR8kBoVI6NxZK7RxjhurqqU09ESDih9dq9VSEChUMaLI4gYNnzgYWtTKw
         cDIE1evuxTqZQXhC3KIWLaG6jhTeUnWAP1hGb5B8wHViMQMtTAe1EOu55/A/tangcNOQ
         P2RyY7uXIgSTe/ySBk0yPctRRqvm0SBYEwMk/c1iPlNqIYIOBz0sgi8lMGqcGgw9wjVt
         HoZsg/x2KRevcgygRCD+d5nsr8sHt3CficmWVzXiRU1Z0kfF4gFQamc+BCBWnVnYgK70
         0gJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723569490; x=1724174290;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aEJaNbQzlBnOLdx0V2SNQk2FxHnxnbdoYeUu2IlqSTw=;
        b=Ow4Z9r+oaflfI8Y0tnRb2jQylqWAqJzKtqsUOpuE4/4NWYlN/YcuDPMejR1v3liDEC
         3iSgo6jR0G8t567haoAdfaB1YTep6jWBzhqfY32vsgAfzfyd0tQUAUHM0EooRITJ9+Vn
         WsXdtcSvELNoLRzVnyGrSJ+ydJQXPpOOys2WcrTFzt5cBoGoDmf3rFm7A8uW2CmA/2p3
         NS2hEH7EGJld0jWcnhYdVIzaPVbT/kfrQBkglbyF06zUOgzJ148ABYasOMN+BmQtNP8T
         hS7KerX7eT4AIdEokMrbG0236dE0gB+myXPl7WZ+9T6JRELMB4myaDsk8EbijGpsosUB
         Zosw==
X-Forwarded-Encrypted: i=1; AJvYcCVjhqx0VG5R8fW3tQ9O+AXlCmQThD/v92c+tPiVbphF+0I6mw0JuJZpbx15ixWNaAl1LkJPIy60P1elJFbV7MzOQi6l
X-Gm-Message-State: AOJu0Yzs3PGTTMHWKAesL9VhijMBJpPFSldWJNYuFiNeprJelRKYU4cM
	x+tN15pgRQ+sLaq2frjanJCuCFw9J3MOGBhdQfi4dhAysMpxQe9injbsukxF31P33MYsHJT6O0W
	+tyoQodGJX++VG2QvZcKhBoHzfceJHw==
X-Google-Smtp-Source: AGHT+IHX0PIdwbJnUx4qT3+8VrjIFV3nrl5qC0fFGJINKQDcN64PFxBBIsTRr2e6grHbN9SJpqFYxfDZq/JNSPWyqhyp
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:4744:ebb2:c01c:8a34])
 (user=jonathantanmy job=sendgmr) by 2002:a81:eb06:0:b0:68f:dfc2:98ee with
 SMTP id 00721157ae682-6ac9a479123mr6367b3.5.1723569490380; Tue, 13 Aug 2024
 10:18:10 -0700 (PDT)
Date: Tue, 13 Aug 2024 10:18:08 -0700
In-Reply-To: <20240813004508.2768102-1-jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240813171808.504427-1-jonathantanmy@google.com>
Subject: Re: [PATCH 0/1] revision: fix reachable objects being gc'ed in no
 blob clone repo
From: Jonathan Tan <jonathantanmy@google.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: Han Young <hanyang.tony@bytedance.com>, git@vger.kernel.org, gitster@pobox.com, 
	xingxin.xx@bytedance.com, jeffhostetler@github.com
Content-Type: text/plain; charset="UTF-8"

Jonathan Tan <jonathantanmy@google.com> writes:
> Solutions I can think of:

One more thing that I just thought of regarding the solution in this
patch. It seems to be to have a different separation of packs: all
objects currently in promisor packs and all objects currently not
in promisor packs. And the way it is done is to only exclude (in
this patch, mark UNINTERESTING, although it might be better to have
a separate flag for it) objects in promisor packs, but not their
ancestors. There are two ways we can go from here:

 - Do not iterate past this object, just like for UNINTERESTING. This
   would end up not packing objects that we need to pack (e.g. {C,T,B}2
   below, if we only have a ref pointing to C3).

  commit  tree  blob
   C3 ---- T3 -- B3 (fetched from remote, in promisor pack)
   |
   C2 ---- T2 -- B2 (created locally, in non-promisor pack)
   |
   C1 ---- T1 -- B1 (fetched from remote, in promisor pack)

 - Iterate past this object (I think this is the path this patch took,
   but I didn't look at it closely). This works, but seems to be very
   slow. We would need to walk through all reachable objects (promisor
   object or not), unlike currently in which we stop once we have
   reached a promisor object.

