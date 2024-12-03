Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0069A1FCFF5
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 21:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733262134; cv=none; b=sWqsZfhPmk5EgMGFbSG6FFupGgEJx3rjmJQqhm3MaNT3t5LSMSqjPGP4U0bEWrJyFMI4Z2W/qj9xGxhkNOZ4bbmzO7sy7BcZxWfpeex6JJVRLurYoy5IiRE/XEoQy2Cd4HuYi71MTXHDDjmMMHQEVbauIvQPY/m1F7pg2t+Qq5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733262134; c=relaxed/simple;
	bh=5HA0zuYJ+hZ0McrZcqU6UM3mK0RUunlZCt4ROqLTADI=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=QbQE8Jf51uAcqifklFfOQwCouSe/L9p31LWOE3zVU8u/5x7obD23i7QBK/paRzYicQLY9V0p7ZgAzgrtPBR6J2GUgGPmMfy7RLohEu9eTYFr0TYJaY7ynKxEwYxK+oH0eVm5ZM2RiTt/uatldh3eKKA+sgnIa/fvmf8nEORMsU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vA2PGUVC; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vA2PGUVC"
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-29e2ba6ad4eso3336638fac.1
        for <git@vger.kernel.org>; Tue, 03 Dec 2024 13:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733262132; x=1733866932; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ny242v5Izohc9nFG2xVAi+C8dT0oVnd3cINj71JK9+Q=;
        b=vA2PGUVC0+eDT9bKWybMxKQQmkhPtXolR8dM1PjFHnf4g2Hrz20VvM1xT7PUdDj+4V
         Jq4xNxmNN+rZKydwuesc2K2bV8HUDojHy9drQ9L2AUf51ingLA/4FcuWpaILr7hxNJlI
         ltbc1Hq4T/CytUHY4omsrS7ftJFmiOo6w9f8VUR5OfIyxDNK6C8MOZzmb82T3hb/bS8z
         URBs5HTmKEL2vnD6URQttfClOqolz1HX19e3heLureMCGMDdK7pVTBKo0LVziYO/HycT
         IvF+XQBJwUBkV+m8ocrf4qsh06Tq6XvyFGKvv0Lc1WjH4KJScmb43GA0sJ85CrmrzZwQ
         mfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733262132; x=1733866932;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ny242v5Izohc9nFG2xVAi+C8dT0oVnd3cINj71JK9+Q=;
        b=uTnju0lSor6GR3MHaTCyBa/c1tcHv07hHVzcaXQd3UlN4DPxlR0tFpkzergGDbQeZG
         ViyhdbMDvQhWpAvNAriflFdXBNd3p7Lj51tP6LiT7mW8t1/sYAkKMfR5DfVHmP9vvHhN
         WtvpecuQpAMg6Ks6qD4HnxGATBah9JrWYiwt3kn52UxH6d3sHTslLlNoRJFe1g6nyTYL
         sSFrCw0cQI6qTs/OJgYi9Sk4zkAAshtAy/2Mb3Ac0RHGnmLm0Lq33lXuDOj3TUSFzVWp
         aYaO4p1OFkobdc44GmxO/RXkcBjD/+sYb0mnLGA2vj1yfpAs1n1DcKCBgP3G3rRaQg4k
         pNtA==
X-Forwarded-Encrypted: i=1; AJvYcCUn6qN2JSAJlY4bFhbeiM7z2SDt6MkDHXX7Dg2EAiXPo48p6uWGXfOp/85JqJy1K32ZYys=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUEMylZhi5RltHiK64oN46exTUT0gDajUpp3YmBFk0qDVfta3w
	Od1YG+agX1pC34tleKUsyqC4VraRT74RF9PZ3PORcvZ5jiLSOHhWYTjmnjV5f1xPScV4Jr701qG
	r/g28v3o1DENpUIcVYkalVDCKXBKrIQ==
X-Google-Smtp-Source: AGHT+IFigjYbXCIA2YYctUqaSyXvWB+i6OvL8su63Sk/+w1zh3HOK2STux0j3vzSJjqsNIdsCxY/fsCkusamPzDgfLoQ
X-Received: from oabnd10.prod.google.com ([2002:a05:6871:440a:b0:295:ebc2:deb2])
 (user=jonathantanmy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6871:20c:b0:29e:6096:c259 with SMTP id 586e51a60fabf-29e9b1f5ef9mr1393993fac.25.1733262132065;
 Tue, 03 Dec 2024 13:42:12 -0800 (PST)
Date: Tue,  3 Dec 2024 13:42:09 -0800
In-Reply-To: <xmqqa5ddfomb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241203214209.2033773-1-jonathantanmy@google.com>
Subject: Re: [PATCH 3/3] index-pack: commit tree during outgoing link check
From: Jonathan Tan <jonathantanmy@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org, 
	hanyang.tony@bytedance.com
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:
> > The fix slows down a fetch from a certain repo at
> > $DAYJOB from 2m2.127s to 2m45.052s, but in order to make the fetch
> > correct, it seems worth it.
> 
> And "the fix" is not described so a reader is left wondering.  Is
> the fix for an oversight of not checking merely to check it?  IOW,
> is
> 
>     c08589efdc made outgoing links to be checked for commits, but
>     failed to do so for trees.  Make sure we check both
> 
> what is happening?

Yes. I was trying to keep to the character limit and in doing so, made
the commit message title hard to understand. I think the new title
should be easier to understand (and also stated explicitly in the commit
message what is being taught to Git).

> > However, it is also possible for
> > the server to compute that it needs to send S and not O, and proceed
> > from there;
> 
> If O, C, and S have all identical trees, then wouldn't such a test
> work well?  At that point it does not matter which between O and C 
> the server bases its decision to send S but not S's tree on, no?
> 
> In any case, will queue.  Thanks.

O has a different tree from C and S. I will add a note to clarify this.
