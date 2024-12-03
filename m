Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1132AEE4
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 01:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733189074; cv=none; b=RwxxE2oysoj2T19J7I41e0tsbgB+eBy6T7CTrLAFtCD47pHMO04TudeReTJjP/1JR2OolrJYH+A+rGloG2DsGHYbbeqi//KvjlmWuVr360AsY57k51XlC0bHSGlNwz9tNyQIkzSsySSNgpAZ4HuVGA4OLWBjHTkG0r7N8xFgEyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733189074; c=relaxed/simple;
	bh=hbl286R7/kn/g5jmWUi2iS26Es2HynBQmJoYaQWTgHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQk1qBxAH66o/IbJPSVwo6n/c8jQZ/MDLK/DZVwC/hQBgGRY8eiEUjlMhofmZPzFhATMY3t9iyCfbyKUK343zZhJEnC7j7mZpJsoklwd2xZAAhl+67m0PY+7iEDuLWds/Zfnr6oALPiV3aCqQIfoA9gIMCFGJpFiNeNzfxG1Vjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ieXZc5C3; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieXZc5C3"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-724f41d550cso2947162b3a.2
        for <git@vger.kernel.org>; Mon, 02 Dec 2024 17:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733189072; x=1733793872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=COz/prF1nk+oP7h/5XwBGiPCV2U2C4bLv8zXshkTCgM=;
        b=ieXZc5C3jytvVEl19aIGN+1Zbj1k4Pfr3XnQ7fZkeSB+eEPrJb8/P+jSkflHtZz+ZR
         VSYaoiWUeR/VKHaEQLa4srGmAddA4S66RieIbiv3+/OXA4rg9OfYYBRVvGGyFxROcA8C
         EX195nnpxZzDJIuTgWIpuPo2oUeKRgQK8xWVSpac54KdsCi8l8cVz01Q+moqtKsmic6j
         oktgI4zwKJ3ns/NBfJsJSd8r0P7WaRHUyD0BbtHUo7A47I5RFsvOnl+vjrjWr7BHaOZw
         zGuRWpv02udodWgyb63c/Q8REz/c92l+sX9u6DAXh/i3a4VUs1t2MTita/Ca30+FNo2F
         kD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733189072; x=1733793872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COz/prF1nk+oP7h/5XwBGiPCV2U2C4bLv8zXshkTCgM=;
        b=iwfVsP8vnDGqtiCjHApBPWS209JIGdOuXKufuonctCWb+7Lib35V/lFikNDzLbHOsq
         /EBJBsVChRQNO8wmyDKUAkEZvtjtAxtSW815Icdjdli7YS1DRxp/OlvOCTY7vDC8PfnE
         CQWXkrnHdkTcaLndXJVdqi6+F1Tg/b5Dg47r7/ViJXHSrkHV7WMJIe7IBulQoMT1joKp
         LUIttn8EtuYFhVDqhB+VpyjRJ7eavIeJEOdxg8YIbr8I7XOs7pPPLPPis5zbkvZ1TvlI
         jTO2y3jslCl6cm9Ky6A/oKTHakDQoM3Vno645gVd/jzk9YT5UoaGiqrm4k9DmMBAfUv6
         ze1A==
X-Forwarded-Encrypted: i=1; AJvYcCVW6/UcF1N9eQwtOLsMXh+dyalXIaSsNMWV8DaKBPQ/JiMLvgHyx+oAyiWagqYDOpJ837c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpWAeWJdjxsnQUw8R+pbPql5I+3QLBuoRqfNOhV9YscQRld2Ue
	3YrewQB2Qm08vquXpQWB9x8nopUWsyADaORtoOrF3lKQCQ/Xz7LaArLr8w==
X-Gm-Gg: ASbGncuLqG+ZWU7u8NIUgx9W2llsqe2rIkNKVtWBNlF7xAHk0zlrOvy5LjGrrliT1Um
	Yz8a7dgAo8TtzBueAu+UU4t8kQ/igtQNx3sdql/6QYI7/s+S5jB9B6thlJMI0MWQECjB4pUWAB8
	B8nFTMP2pZC9udZn5ZcI2oK2W/LPJBM2DHCWAjrj7VNtBOKqwicLYK+msFaXGMjvf1zgviflHoG
	b90I0PloAqb7BaN+fZIuDX7+KJ+FWcKnzZhvZkd1NYWFA==
X-Google-Smtp-Source: AGHT+IFdRARm12JMToudUDD86BLv7RI4hMxShmLGMYL53535Nq4ZLms4Euzjnv7uJUYrDYuNiJKmsQ==
X-Received: by 2002:a05:6a00:983:b0:71e:7745:85b8 with SMTP id d2e1a72fcca58-7257fa40e5fmr655622b3a.1.1733189071974;
        Mon, 02 Dec 2024 17:24:31 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541762c0csm9223674b3a.33.2024.12.02.17.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 17:24:31 -0800 (PST)
Date: Tue, 3 Dec 2024 09:24:54 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Caleb White <cdwhite3@pm.me>, git@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Ensure unique worktree ids across repositories
Message-ID: <Z05d5pjvcIyJsAeG@ArchLinux>
References: <20241129-wt_unique_ids-v2-0-ff444e9e625a@pm.me>
 <xmqqed2qkfn0.fsf@gitster.g>
 <Z02eKA8i51QyXgJ-@ArchLinux>
 <xmqqed2pioff.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqed2pioff.fsf@gitster.g>

On Tue, Dec 03, 2024 at 09:46:12AM +0900, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > But cross-ref operations between worktrees must explicitly specify the
> > worktree id, so I am wondering whether we should allow the user do
> > cross-ref operations in the first place:
> >
> >   1. main worktree symref points to linked worktree ref.
> >   2. A linked worktree ref points to another linked worktree ref.
> 
> What is a cross-ref operation?  A worktree is either the primary
> working tree for a (non-bare) repository, or something added with
> "git add worktree" (i.e. whose .git is not the repository but a
> link file into the real repository).  Are you adding another mode
> where a worktree points at another worktree and not the repository?

I am sorry that my words may confuse you here. And the Eric has already
explained what I mean here. At current, we have the ability to mention
a ref another worktree within the current worktree. You also have tole
me that in [1], there is a possibility that the user could create a
symbolic link to some worktree-specific ref in another worktree.

So, if our intention is to deliberately hide the worktree id. Why we
allow such ability? Let me give an example.

If we are in the main-worktree, and we want to access the worktree
specified refs, we must specify the worktree id like the following
(also if we are in the linked-worktree, we want to access another
linked-worktree refs):

    worktrees/<worktree id>/refs/worktree/foo

We do not want to the user know the worktree id. However, we allow
above. This is something I feel really strange during the review
process. To the front-end user, the worktree path is the interface.
However, for above ability, we need the user to explicitly specify the
worktree id.

From my perspective, this is not a good design which is against our
design.

[1] https://lore.kernel.org/git/xmqq5xqn8w6r.fsf@gitster.g/
