Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47936210FB
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 22:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706740237; cv=none; b=QGMvBuuPo442D8ZHj0UMzv2eJpp4AVkHXJvpEmANr9Jyy7WXB0gkoiHKTotUSuuxvs0qbYD+gJx2Hm3P7pqBKjRLtd3xIuUa9A65xU0MNRa3ZK0egE6RMuyfMuwSsfLgtAYr9ioaOs8lR3E7zZ35AzI0co2298Mz/4Ddxwk0zTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706740237; c=relaxed/simple;
	bh=6t4ydiyF73WCVjeLe7XfL259eTpo4lsEZi2pb7uzZ3o=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=BgHXhzu78Pi4adqf46gFr7BTQVsNqBXJIzgFvPutvTwH2wdFfygq6BCmVnEj1jCfUtwn0JNRUP1hJUT/lDik3gDGfZI2PmOGVtJbu1M0jsZaTf4KZJ25sERAJx5nfmxr3ekopKznxveBATpNG7gx9iADiIjVJdNEmmtEpw+FWNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K1lYXlhj; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K1lYXlhj"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc64b659a9cso431221276.3
        for <git@vger.kernel.org>; Wed, 31 Jan 2024 14:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706740235; x=1707345035; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RwXEprFT/o4Gek0/OA3u3TaXA4PcUCYAGJu1zLAL4qw=;
        b=K1lYXlhjoxw+48JWBlpfNp/HRPMGsSCAWn6CCTMnarNO8GmVjyUOiFRBJlzJsMhw3V
         91+uzYmaAtogpl7DsV2v28baR6LVR35T/Oldgqr5dnWETK+H8kn01NciKy942udUi3qv
         YbtdqHaEWGpihIjIxlIK3TAXgJjV2PxMaR4rk4q0Qk+zqu/0T3gGLqE1okpENiab8cOf
         2ymice0smyT7kglWHHyBohIDTKFEnUQzC+5+dIokIgowPBdCGmpHaxC84XyF/irFgcy8
         JBAEBAQmZEoIXkhyrdc8zFSoTZdyuTFpZD08SHLAJto1Rx8cmXHqU7UNkxImKKcPDtZ7
         oF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706740235; x=1707345035;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RwXEprFT/o4Gek0/OA3u3TaXA4PcUCYAGJu1zLAL4qw=;
        b=DmC5h8BHyf9iv54oBZzEBev1DDHcCE/INVVehgVxmqA9sA+47upd/izI7Ft3afIWh5
         bBJFT+TDSnH0wK1MXeG+mTD8zsc49dWlOTb+eE9UKiBPErssJFK2devlSF8fTzfIyB3K
         ZzI9oWATyYyol7yFVJBJv8o3vXGyGZDUpAIYWh6pAbwgLNNOeP1uoUj61+bWAMrmEsNz
         i3Q5wtpZsEuqiSmGrueZsJk9ilUe7s0x6n4JDPKtdmLyWjcyB/8ExjZSzU5sCyQC7RyC
         3hMkZhqt+AdjZfHkutnRTmlJNyi3S1SQcdtUHidGEgHNCv72mF54Z1C2jnl1w04ENW6t
         1V0w==
X-Gm-Message-State: AOJu0YzwRXN1TH0pwlYAaav4WOICIP9YE7L5qyDbL5V6u2CBmM87U4sR
	foF2XSUa8cds1jY7ClaC8Ag+HZks7zUNODEIsFjXxv5MmK6YidNkK7ViumgwU1YIez85Z7uCK0q
	aYGIma1xjZh25lQ2f9GKQEzyORVlwJA==
X-Google-Smtp-Source: AGHT+IHYcvi3ZjLdjlk/B2KEc/7bh90eGjPrKb0INKzU3jSjprBPaTXRO4gE1QIYqZdE2EqHgmABU3Sqr+3DVa9gGgzn
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:d86b:9ec7:6d77:7d3d])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:2513:b0:dbe:642c:2124 with
 SMTP id dt19-20020a056902251300b00dbe642c2124mr809555ybb.0.1706740235118;
 Wed, 31 Jan 2024 14:30:35 -0800 (PST)
Date: Wed, 31 Jan 2024 14:30:32 -0800
In-Reply-To: <BE30DB47-1488-40A3-BD0C-804F97DE0C88@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240131223032.4065897-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 0/2] index-pack: fsck honor checks
From: Jonathan Tan <jonathantanmy@google.com>
To: John Cai <johncai86@gmail.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, Junio C Hamano <gitster@pobox.com>, 
	John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

John Cai <johncai86@gmail.com> writes:
> Hi Jonathan,
> 
> On 26 Jan 2024, at 17:13, Jonathan Tan wrote:
> 
> > Junio C Hamano <gitster@pobox.com> writes:
> >>>      ++--fsck-objects[=<msg-id>=<severity>...]::
> >>>      ++	Die if the pack contains broken objects. If the pack contains a tree
> >>>      ++	pointing to a .gitmodules blob that does not exist, prints the hash of
> >>>      ++	that blob (for the caller to check) after the hash that goes into the
> >>>      ++	name of the pack/idx file (see "Notes").

> Thanks for clarifying! Would you mind providing a patch to revise the wording
> here to make it clearer? I would try but I feel like I might get the wording
> wrong.

I think the wording there is already mostly correct, except maybe make
everything plural (a tree -> trees, a .gitmodules blob -> .gitmodules
blobs, hash of that blob -> hashes of those blobs). We might also need
to modify a test to show that the current code indeed handles the plural
situation correctly. I don't have time right now to get to this, so
hopefully someone could pick this up.
