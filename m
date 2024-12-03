Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7992F40BF5
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 21:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733262004; cv=none; b=F7y2zVQvcRxiCuQh4zmAnuw4X36iW7+u7+3oQDEFEasClqVKNvXxF4Ydu9ZAOLtmOMXFDcX9JZpGURyRdqty0gxY3kEv3FJrgn/LnQBkZ9REn6raklvBCiIz2DznQlB2dMXhPOTghK6IA93HpW52QPgld5mNA6U5HSPkqC4SopU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733262004; c=relaxed/simple;
	bh=ayWeqC6mTAbT5gpFU1FfmQVYE0nf0f+AT9cLK46tDmU=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=VhK4D1qu0HaozQZtk9t5Lt8Gz2Q/LlteYLuwcFCXeE1bISFEgbfaRzJuRCYcCTqYWpC75a3V1cPQa6Tnsxv86uyOziQ3YyaBUatFCHUHswf9b8Fwz57CEUp2033/7VxPTE8v0yKA5PcZnyNUVo2Sh0Ia73/7NkEZ+xLBHCYjQKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XWYiifQ7; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XWYiifQ7"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-215b45a6e2aso16957615ad.2
        for <git@vger.kernel.org>; Tue, 03 Dec 2024 13:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733262003; x=1733866803; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wdbH14F0F06xYqNBcMZKYn1gLFqtdWUd6cV16LM3pFM=;
        b=XWYiifQ7isN98q+jCeXjgKzcSlksxtVO4YXk3RIJZmHvchr0iWGVYtGLk4kdJMXAfe
         jMAgiJ5Dg21CP+1InukXmmor8U/62M/GI7BcmbO6M5Mo0j58YjTuKsSeAOiPV7dFMuzL
         zb/cFNmdBf7L+lAXMEpyBpQHpeXlolTdDCcmMYsnBUWQjulCITBcs3A9zbEWn/COAe47
         SdDkoe77sE6101myhgkE4vn4Vvdxdj8nwnkve3fN5TimU6YAf3ukil0ewO9mU0EDchzm
         qSiF5tDW6eEEQ6EHcDxMBAxaXZ69j9CGFHLMyachy1DcgPO/EAhs4keh8+2gHysZpPXk
         SDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733262003; x=1733866803;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wdbH14F0F06xYqNBcMZKYn1gLFqtdWUd6cV16LM3pFM=;
        b=qlzXSzyT5YEK9VEPghTTL1MJf3UN0xsujioF2zp7F0U5qFKVba8Hb0AcB+3jhm/hzO
         /VE+BA83eRsFXPejVXcRr3tSd2gIo2gUBIw5P/FYuGbwhrKsXtpZ3ubxX2kytHl9+zA1
         j5RJMjXnroEs9RpjXsjjoLJ+AzsmrP/yjzPxkVCPwz4cSJREEVQ8X803es20R23AmCNN
         KhIHZ0MDiwks36viOQ+pK/v4NeaYlSDYLfpBmxwYXI4bR+6rItOMDuMdAPd1XptSZNxO
         Xk6ymwrAhRY06JRaCoH3ai/5F7dvbGrbDH6Rm+THFvHruV/D+a23F40g+MmF3rXVUA2k
         9MOw==
X-Forwarded-Encrypted: i=1; AJvYcCUE2iPg9ysYStAqiZ/+uyf5Nztkq2bzq7zSDY9eEiRi8552/NiR6ZL9DlFV5hkU83zH1uM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIJ3h93iBu79ZZBwv44sv27F423T0Gi3epeTs/QgD2QqcbWyqu
	3+TWqZLJ+JFMe2I53f3lIPM0o1YZaO48Ri/kzG0fm1QhSdGLT8POFOZbDrWeXwJN9FO31Cohim0
	ktg4gFCIARhe8f5Q0dgdKlsrOs5fwpg==
X-Google-Smtp-Source: AGHT+IFy5dnasu474wzOJas9lFFNPetIUja2o5Li8NkRfmL0oMGm/vKizxh/IbaoOshnhivtG3r3nEM1KzsvLyf6h5fM
X-Received: from pjbsw12.prod.google.com ([2002:a17:90b:2c8c:b0:2ee:55ff:a07b])
 (user=jonathantanmy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2b4f:b0:2ee:c2b5:97a0 with SMTP id 98e67ed59e1d1-2ef0124c3afmr5280875a91.25.1733262002596;
 Tue, 03 Dec 2024 13:40:02 -0800 (PST)
Date: Tue,  3 Dec 2024 13:40:00 -0800
In-Reply-To: <Z06ejDgTnC6gWXgx@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241203214000.2032992-1-jonathantanmy@google.com>
Subject: Re: [PATCH 2/3] index-pack: no blobs during outgoing link check
From: Jonathan Tan <jonathantanmy@google.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org, 
	hanyang.tony@bytedance.com
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:
> > This situation has not been observed yet - we have only noticed missing
> > commits, not missing trees or blobs. (In fact, if it were believed that
> > only missing commits are problematic, one could argue that we should
> > also exclude trees during the outgoing link check; but it is safer to
> > include them.)
> > 
> > Due to the rarity of the situation (it has not been observed to happen
> > in real life), and because the "penalty" in such a situation is merely
> > to refetch the missing blob when it's needed, the tradeoff seems
> > worth it.
> 
> So is this a one-off event that may happen once per blob, or would we
> eventually evict the refetched blob and run into the same situation
> repeatedly?

One-off, since when refetched, the blob is in a promisor pack (and
thus won't be GC-ed). I've added this to the code comment that I added
following your suggestion below.

> > diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> > index 8e7d14c17e..58d24540dc 100644
> > --- a/builtin/index-pack.c
> > +++ b/builtin/index-pack.c
> > @@ -830,8 +830,10 @@ static void do_record_outgoing_links(struct object *obj)
> >  			 * verified, so do not print any here.
> >  			 */
> >  			return;
> > -		while (tree_entry_gently(&desc, &entry))
> > -			record_outgoing_link(&entry.oid);
> > +		while (tree_entry_gently(&desc, &entry)) {
> > +			if (S_ISDIR(entry.mode))
> > +				record_outgoing_link(&entry.oid);
> > +		}
> 
> Without the context of the commit message this code snippet likely would
> not make any sense to a reader. The "correct" logic would be to record
> all objects, regardless of whether they are an object ID or not. But we
> explicitly choose not to as a tradeoff between performance and
> correctness.
> 
> All to say that we should have a comment here that explains what is
> going on.
> 
> Patrick

Makes sense. I had to move almost the entirety of the commit message
into a code comment - I don't think putting merely a part here would be
enough context.
