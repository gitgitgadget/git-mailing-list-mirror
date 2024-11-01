Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF36484E1C
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730482409; cv=none; b=WdqoneaGKS3paEJiiJC0Wz1VucjL4HOfw72MfvpKE0lNjF3NJBiGat/uSzheNHnm6PXBmhrRpc8wlG0JjoCPbSmbQjUmOp1XMmb7JCo1+I0aXPROJJPYHIzBaO7Ihpjj6JMcQiIBOUvCg/FV6njEPTWUZmI0+I9HB1eP17PDAd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730482409; c=relaxed/simple;
	bh=41N/oLnXfR4vG05s0A7loqaOG3evhIpoxfcEv2mg6C8=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=GgN4l0f8gAVFilFd+geL5ikPGI0K/Z658j/m5t0oIJPyCyK/6xVGZrl5pezzUqjcJVnM3KL2lG9U15Lpm62Y6/hIybvW02+HZLNRPfnW8sWWDL2Lx5y8Hn1CxNBZXmpJO1/SzrxTUGSqEtPi5e7OX/7177W27G7Dx/L8kH9L7nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MsXP/+BO; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MsXP/+BO"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e38562155bso44850417b3.1
        for <git@vger.kernel.org>; Fri, 01 Nov 2024 10:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730482405; x=1731087205; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zLY5CqZ27gWhY2FSWAcGHwvahHQvydwEe4+R1erSJx4=;
        b=MsXP/+BOzYWbkA1iB6eaeBZ1lQyRpER4nDTYrkO9nH1LqqRUVNCk9xBHJUaDpDBd6T
         HSI4YFIdpQ6c9huogYt4/R6r5t3BK4gb+h2t7t8k4J+QYOd8RYmJpTy4PY9MY15sa5OP
         VmedKp71bk5ijyfAItXUiAId43tJZSqRAjzWO18xLro1SQYYXfETKhGgeiWEe242aAuL
         T2rDukKF6fap2YtjMM5sk03zWCTqMUJ0QqSc9lFsz/2BMZrkMprlZrqQzJRRdbRZ9jf4
         QMNeHoOXrCCPf4+8eQZxab1SMW10b3zpDsfYAKxkdPFwE+xhdUZMvgdYzp9hVdsnl+QW
         C3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730482405; x=1731087205;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zLY5CqZ27gWhY2FSWAcGHwvahHQvydwEe4+R1erSJx4=;
        b=coWHXBHHAyq2RtapXVrnQWQFM8ERbmTMJNSG5mOiSK8aYGgrYLGj3FwBC53QHiXfjw
         QPVu9TCI7ubIICrP/f2g9DUFW6SencykwsP1Val+z81jH4Kx1u+hODEabFhcPGZ7T/3T
         UzP+b1vHU6+JyDtXWN9xC/SpIfnym0vedLarQWVZ+2tfIjSLKr0U+rEBRsz4DI0VSLbH
         sofwJ0IwOQ6t7DQZfjC8xsyXKeGyFQOzeIqP8kk5La2jtfDgL27qvo6m6HE6skHWNiQb
         DLR1OvqaU7HGefavyuUBXl8uAZqTz2aoam2WP/6cDeuIZn9/sHnRoFCGQ+zncH2ld9MD
         7n1A==
X-Forwarded-Encrypted: i=1; AJvYcCVk2CkjKj/jAfx4Wq9muCfXOpqEwjH2RFEbYZzF+QR7vl//lwQv+ByUrRiij3HFn5OpkOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN8LMnxPAiPqLGjMn8o1xRe5tRFWxuQEIn7CEgBSNUPsM+7eBS
	yboFWRoN5wJ0HorUDbHkze0KQ8IuqJ55TlwnJv4C8Pa6shDumeFTD7v6qCe7oMRBGYHUiysUjUR
	4qcaTRd97dHDkq/UfL20bc20O2ev8Yg==
X-Google-Smtp-Source: AGHT+IGg3caQjg/jYJShh5F7z4MSS3QATTJg5nRa87PBv2MnP+h1VI/LZPHrzTUShY6g4i8uqZd2nx5P0pY8Jjt6lHpt
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:87c0:a56e:d0ff:807f])
 (user=jonathantanmy job=sendgmr) by 2002:a05:690c:23c8:b0:6e6:38:8567 with
 SMTP id 00721157ae682-6e9d8b296demr2259107b3.8.1730482405618; Fri, 01 Nov
 2024 10:33:25 -0700 (PDT)
Date: Fri,  1 Nov 2024 10:33:23 -0700
In-Reply-To: <ZyTmnDHGdblD3/FU@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241101173323.681359-1-jonathantanmy@google.com>
Subject: Re: [PATCH 2/2] fetch-pack: warn if in commit graph but not obj db
From: Jonathan Tan <jonathantanmy@google.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Taylor Blau <me@ttaylorr.com> writes:
> On Thu, Oct 31, 2024 at 02:43:19PM -0700, Jonathan Tan wrote:
> > > Another thought about this whole thing is that we essentially have a
> > > code path that says: "I found this object from the commit-graph, but
> > > don't know if I actually have it on disk, so mark it to be checked later
> > > via has_object()".
> > >
> > > I wonder if it would be more straightforward to replace the call to
> > > lookup_commit_in_graph() with a direct call to has_object() in the
> > > deref_without_lazy_fetch() function, which I think would both (a)
> > > eliminate the need for a new flag bit to be allocated, and (b) prevent
> > > looking up the object twice.
> > >
> > > Thoughts?
> >
> > This would undo the optimization in 62b5a35a33 (fetch-pack: optimize
> > loading of refs via commit graph, 2021-09-01), and also would not work
> > without changes to the fetch negotiation code - I tried to describe it
> > in the commit message, perhaps not very clearly, but the issue is that
> > even if we emit "want X", the fetch negotiation code would emit "have
> > X" (the X is the same in both), and at least for our JGit server at
> > $DAYJOB, the combination of "want X" and "have X" results in the server
> > sending an empty packfile (reasonable behavior, I think). (And I don't
> > think the changes to the fetch negotiation code are worth it.)
> 
> Thanks for the clarifications above. What I was trying to poke at here
> was... doesn't the change as presented undo that optimization, just in a
> different way?
> 
> In 62b5a35a33 we taught deref_without_lazy_fetch() to lookup commits
> through the commit-graph. But in this patch, we now call has_object()
> on top of that existing check. Am I missing something obvious?
> 
> Thanks,
> Taylor

deref_without_lazy_fetch() is used in these situations:
 (1) to mark things COMPLETE (the 2nd argument is set to 1)
 (2) all other situations (the 2nd argument is set to 0)

62b5a35a33 teaches deref_without_lazy_fetch() to use the commit-graph in
all situations.

The change I have presented in this patch set teaches
deref_without_lazy_fetch() to read both the commit-graph and the object
DB in (1) but not (2). So I'm undoing the optimization, but not for
all situations.

My understanding of your suggestion was to undo the optimization in
all situations.
