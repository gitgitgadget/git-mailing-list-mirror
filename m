Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FD41CF282
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 17:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730483348; cv=none; b=NVRnr8fmEeXP90rjEXqjtDmfAN/gB8FuCSRniPuDvfQWHCDXMw/+YVoEJ9SusUKy6504TbDrH8Aqk2ZSQx/BZlOSfl361pHM0SuMPMhdvWES3y0BDNELGiFWvT49d7IKYQrJG+ZvVhjSXLSd9U6LxxpPVYbH2MaHl0uMklS1eVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730483348; c=relaxed/simple;
	bh=BVCby8kRDP6A2oKFo/6nLkqUFnpYjFVslIL7pFQjxRs=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=GVN06/0GoPAakJGJTSvc1MkGXvtaMNLaUdkbv/6xT12jOpXjL3WcNvMvd8vWichlQK50P1Nvy9ATxH6tIx7nXNSwQOT8ZDBfygm55ImCkoD7voyo7UrQWqtEDZWsMiiUgLlmgI8Z4M9IJQ8+Z/aynUBsd0VUYRkUCKNud6vl9Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X+QHvVQI; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X+QHvVQI"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e5bdb9244eso38373507b3.2
        for <git@vger.kernel.org>; Fri, 01 Nov 2024 10:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730483346; x=1731088146; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D5prJnY0RQbNQE6O5yAH+tkenpunzf8pfvdwlQQT8H8=;
        b=X+QHvVQIOtPu+xQREZlc4tnzrbc0+/xcghECGQFr6KuFAee+k/oZkbTrPAMy1kuLKT
         MY7p8FQEdlOW2NzliZhqkXFL06YdWDIMLK0TnjL8AQNZOuxaQ61nfa+l+l3VlHBV+EbU
         VjV5jL5UgDPb6iOHs2z8UU6rxc66sLEmk0PVU/q6AQQeN+bIRgHHV7vZWjbO8NQgzkvR
         aKigN1n39ivEvgoXFmYKZ5GZgIiJY2Y87MmmAt4qpBAdsBjXMT9o0mGscWAj3Bi6V03F
         ubMU+7VdvN4kCI9Gm6F1R8nq8m+CRbxgTETuRu9o0sE/B5R98U/yforSHRAo2nY5Xj9d
         NDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730483346; x=1731088146;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D5prJnY0RQbNQE6O5yAH+tkenpunzf8pfvdwlQQT8H8=;
        b=g/oodgUJhIFoc/gDQEcg/u1AFa4K0EQYpXrkHPqYEQxqylL0VsUm1mY0Ol8tXa6BUj
         TA78jZKAV/kYdwyiAsK4XkIbzIWdO/l0MUcXX4uB4zwOLy/lPRfEF5G2Ny5x2ZOSf0IN
         6Hv14wJh6TnR0GNtamPwfEQVK3MRu/ySR818CDrboV0RuuQZqj6amsZ/UwbpVTE8TGcj
         tHcskyBej570fJn4xtolRNFFogIopzG/TUioXIO7EdBkdkwBPsvagIx4+mpB5jdKiNFh
         wzZSwIQ67dA9UjEFp22R2AjvQAfYbdoHCdwNb7AmtECc0Tg9AAn1mzswCI82HXsowA8H
         DUAA==
X-Forwarded-Encrypted: i=1; AJvYcCUqe2A3dhjka6IjKmoz9rRNbMQMj/vTiCJkHb3vdJ+Qy+4oMaYN/moOUVX/ZVyb0Uuveik=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtFbKJmzERreRqkBYJ6FBHR2hTjPytPjq0s8RfVw0DNy0Wljj/
	8W9GybM25lLIKnKH/t0EhxrMtFiE2OTFxoQUuAecbB7MKRV6m+mw9nKjpptnYdxuIzktXeSNp0X
	O49GAb8to7vHNOdb1QychOwa1zvfsfw==
X-Google-Smtp-Source: AGHT+IEz1euvPZbf7H5/Y5EeJklFo7kCTQ1oDTATJ9BehtEniEgsteYRHBW0pClk9SjSB1X86+6zIn/Bhx3neb46/z/H
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:87c0:a56e:d0ff:807f])
 (user=jonathantanmy job=sendgmr) by 2002:a25:a305:0:b0:e11:639b:6428 with
 SMTP id 3f1490d57ef6-e3087722c24mr62146276.0.1730483345902; Fri, 01 Nov 2024
 10:49:05 -0700 (PDT)
Date: Fri,  1 Nov 2024 10:49:04 -0700
In-Reply-To: <ZyTxNwZgeOy/+05b@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241101174904.686752-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 2/2] fetch-pack: warn if in commit graph but not obj db
From: Jonathan Tan <jonathantanmy@google.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org, steadmon@google.com, 
	hanxin.hx@bytedance.com
Content-Type: text/plain; charset="UTF-8"

Taylor Blau <me@ttaylorr.com> writes:
> On Thu, Oct 31, 2024 at 02:19:01PM -0700, Jonathan Tan wrote:
> > diff --git a/t/t5330-no-lazy-fetch-with-commit-graph.sh b/t/t5330-no-lazy-fetch-with-commit-graph.sh
> > index 5eb28f0512..feccd58324 100755
> > --- a/t/t5330-no-lazy-fetch-with-commit-graph.sh
> > +++ b/t/t5330-no-lazy-fetch-with-commit-graph.sh
> > @@ -39,7 +39,7 @@ test_expect_success 'fetch any commit from promisor with the usage of the commit
> >  	test_commit -C with-commit any-commit &&
> >  	anycommit=$(git -C with-commit rev-parse HEAD) &&
> >  	GIT_TRACE="$(pwd)/trace.txt" \
> > -		git -C with-commit-graph fetch origin $anycommit 2>err &&
> > +		test_must_fail git -C with-commit-graph fetch origin $anycommit 2>err &&
> 
> It appears that this line breaks CI:
> 
>     https://github.com/ttaylorr/git/actions/runs/11631453312/job/32392591229
> 
> because you're using a one-shot environment variable assignment before
> calling a shell function.
> 
> This should instead be:
> 
>     test_must_fail env GIT_TRACE="$(pwd)/trace.txt" \
>       git -C with-commit-graph fetch origin $anycommit 2>err &&
> 
> Thanks,
> Taylor

Ah, thanks. I've made the change locally. There are a few ongoing
conversations about this patch set (thanks everyone for participating)
so I'll wait a while before sending out the next set.
