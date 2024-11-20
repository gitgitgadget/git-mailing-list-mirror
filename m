Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8673A13B7A3
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 18:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732128753; cv=none; b=vArJMDz3UeIijLAY8FbhHO37TvvQ2eWSEa7zVVSgWJ9stIjm1igrbEjP6jm+xuX+M4opwv+Z7CndKqGBQuXupikXtobHlvR1p4yFjuiJZ9Zmhkqf+rSAetQDYDK/aWFQtvopgLCpuBWvwgy5DoomOTpyiV+qYpg7z1aVHNTijXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732128753; c=relaxed/simple;
	bh=Qea17gFmFaf8tZwG/vhADC1ZPnDJ1B2X/fyoFIXtfTY=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=kxaURI5DNwwquoUeBl072+z1lscjHokMNbiTa26aUWw1cKUS3URl5MbQsXsrQtipOZAzzGhClrMQXeV0tdWl4JTNO6K20hV6uJW0RZBHM2PMUaMrofLm3ntfqgGeAIn5XP3mHvNcs/zinc7QAvvL1MOam5RctsZk9y68eJPSzl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pOh/DrQ7; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pOh/DrQ7"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6eeb5ee73f0so35559257b3.3
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 10:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732128750; x=1732733550; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+H5FCFRVafGqTuaYA/8BfIu4jpIcPNGfP0Tye78hqk0=;
        b=pOh/DrQ7vfXvEoYUR1yN7sBmpnN35YnSwnPjgG7QpAOSAwVEcslbHzH2o4skSIMu99
         RqPAYwfmu/MzdiVZ3EVsH0YJ91eGhaPvecKGsZIFeio4105RNKUYvNaTQ9RXxszowMoV
         3+lhciRjucd0aJUKvpb84JCqW1oK9oQkdm72usyq7GypDYngZ0afE6Uy9i65zkotTfK+
         2jcex7bAmYk9KL03Z8FsB6/KMB4vyDSO9mqS2R8ulUnwLuHylHr+Y+kDzC6ycrKZKLan
         sShDMYubGOWd6P29/EZ92lrgExZgfw/DRHrjWthzU2KlrXogtLqKWIeMByxX0fZgA7kz
         c+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732128750; x=1732733550;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+H5FCFRVafGqTuaYA/8BfIu4jpIcPNGfP0Tye78hqk0=;
        b=MvF+4BFKa9TxSk8qflL3yhzLoZFWojK3F8MEee6RyXgYJkS8xgGnMeyfTxiMTLQ8N0
         +5iFSONkFWk74V2hqRMrJFLRTA47BqK9EP7nJS15pyI/MOrApPeNNS6BYPkWcRk671LD
         nCFaia4LlyKvs/J2AjIA+RL+fkcHpF7dU4NFZx/yyGf1J5Yx5mEPLQudrfnLM0pJ3h3A
         Y8nfQLjJ0lTx4YyH9euzu0KBW7spNWn/kFXPi4sgF8HF+RcVS4coO7+385t2UgsjQDbH
         qmorIRv3M0KzukGPP+1c8taJphxN74u7hYRAOn9ibdSME0tW7vu5QszL4jVbOyvy91ER
         Dvaw==
X-Forwarded-Encrypted: i=1; AJvYcCUKBi0o5Rb6aSZY3O8MsQKeEvDlivm9dsS5FfLR6b1BmcMf6EOhNvdXkzscEeuCItSUxM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFtahJ0oBrMi2mJ1X2Djqq5TCthAYQE6IhkUe5odxHm81ITsi/
	4bVP3HWauFr/jHa/4KB0I+vY3tKPiVCkdLqRx94dxXKnSHMDxnJaMVO689nGYdbXnv7oy3ON+HH
	PAJ8qbRswnvGrZ8/SXresGNWqgxwtUg==
X-Google-Smtp-Source: AGHT+IF5c+qgIw/j2cGD97kITMwbeMRaGLe/CiOT+nUZbo9HuGlEB1xs2I4aSMNLZ7Vn7Q8JgaRtKmo/MIgMmEzkZ63v
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:552f:7db1:7724:9fd1])
 (user=jonathantanmy job=sendgmr) by 2002:a05:690c:5781:b0:6ee:a36e:49c2 with
 SMTP id 00721157ae682-6eebd2dd9e8mr17217b3.6.1732128750502; Wed, 20 Nov 2024
 10:52:30 -0800 (PST)
Date: Wed, 20 Nov 2024 10:52:28 -0800
In-Reply-To: <B010051F-B182-4DB8-9469-AA2F53781968@shopify.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241120185228.3204236-1-jonathantanmy@google.com>
Subject: Re: git-blame extremely slow in partial clones due to serial object fetching
From: Jonathan Tan <jonathantanmy@google.com>
To: Burke Libbey <burke.libbey@shopify.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Burke Libbey <burke.libbey@shopify.com> writes:
> The core issue appears to be in fill_origin_blob(), which is called
> individually for each blob needed during the blame process. While the blame
> algorithm does need blob contents to make detailed line-matching decisions,
> it seems like we don't necessarily need the contents just to determine which 
> blobs we'llexamine.

Technically, we do need the contents, because the contents determine
whether we are done with the blame (all lines are accounted for)
and whether we need to start looking at the blob at a different path
(because there was a rename).

> It seems like this could be optimized by batch-fetching the needed objects
> upfront, rather than fetching them one at a time. This would convert O(n)
> round-trips into a small number of batch fetches.

That is one possible way (assuming you mean that whenever "git blame"
notices that a blob is missing, it should walk the commits until a
certain depth, collecting all the object IDs for a given path, and
prefetching all of them). This runs the risk of overfetching, as I
stated above, but perhaps overfetching is an acceptable tradeoff for
speed.

There are other ways:

 - If we can teach the client to collect object IDs for prefetching,
   perhaps it would be just as easy to teach the server. We could
   instead make filter-by-path an acceptable argument to pass to "fetch
   --filter", then teach the lazy fetch to use that argument. This also
   opens the door to future performance improvements - since the server
   has all the objects, it can give us precisely the objects that we
   need, and not just give us a quantity of objects based on a heuristic
   (so the client does not need to say "give me 10, and if I need more,
   I'll ask you again", but can say "give me all I need to complete
   the blame). This, however, relies on server implementers to implement
   and turn on such a feature.

 - We could also teach the server to "blame" a file for us and then
   teach the client to stitch together the server's result with the
   local findings, but this is more complicated.

It may also be possible that even if we fix this issue, the scale of the
repos involved might be such that a user would rather "blame" over the
network (e.g. using a web UI) than download all the relevant blobs (even
if the blobs were batched into one download).

So...there are ideas for solutions, but I don't think anyone has
analyzed them (or tried them) yet.
