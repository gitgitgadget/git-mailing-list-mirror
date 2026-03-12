Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AF13BE626
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 21:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773351725; cv=none; b=Wr58T6g7a3j82X82bUKUxiOXn6Gihs0apHfAEuBc8nyEuWMHl8Poddb6mFOJiqS624tQnWVYuw1LnKjWIbwleD+v8KKRN2YJfzsMF7E7FQ5cQrU2hW+O5kAiXZFbBksE84I+alS99HoVbwpJvtXkjCqwUh1plqQURg0zmYn3RQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773351725; c=relaxed/simple;
	bh=XnVtMJHwkUF+QMwe38ZiV8ytdNd9SkXKOlOwzJiCoW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B7xvquTpqGJtbpaYjqNoee4LQBCNNLBSMttTATygbDBqFqVWgF2U8bqx/h9hD/OoPNrpV+mbrFyeWESkOrJjJ+2OTmfTM40K8tdiKaW6yyCsIv1Mcr3LhLPcbT1zHMVDBatEJ1AI+0LYCACmzJE2KGYry7k/S92v0AuiY5z5cPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPY9A+wH; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPY9A+wH"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48557c8ad47so1355805e9.0
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 14:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773351723; x=1773956523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjWWzgnGTs7hulKesQsUxOOTN5v6oDkObmZky9ZKq3c=;
        b=JPY9A+wH0wsQJYKqPZMnnoMV0ni9Q8KhCyOdFusspWccWiSeutLmYhMsQV/B5vOTzr
         oqkW3RMhgEcaXUT+Xe+vF9Yu6L7GXhqhvr4OFO2Hipm2icsCCeshPK/J3Z+cg2rH0QgU
         hPoM09z02Yk4+WXQFZawhup3X21DZhnlBgH3XFavnhEcuZi0nKwtIUGaVc9CruJhdA/t
         6DWgHn9Ss7+HPyi5PuKzoLVnYnqeBfy9V0DokcPb695Fd1EqzIRa4Z6gD4yiMwAMDniq
         BZVN0Oie58CyZXvYjk894jZMpcglghX/yr5Y+SqxaLbtOxRe3qVq2AUlrcBSLzKiiTq/
         4UpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773351723; x=1773956523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zjWWzgnGTs7hulKesQsUxOOTN5v6oDkObmZky9ZKq3c=;
        b=NMnIvVzr3ORoZbwnV629vAYa2akMd9/jb+/Pybi2kRTs1eH//P75IHSBvHsWGuhLwH
         hWmph8CWcU8BYMiaTtQYUSdVoHBsK9GShnotAH18ntW5R39EFK1gvlBC+IQ+iNUe0j6Y
         G6lwOyt2aKq949qX+x2e87qJZQ4jS/LEMv5aYsTxDuzBLBWAFoYJ1/XekstOyoEhZEWd
         uACO6qTZh3z/UGv9BFKoUqDfYS+EoSVWRqcqT5ltI5rEMAKcmy341h+VrERfS01NX0zl
         zCdE4oguqNJaL8uRnke8CR1EAsWzTwWt0u31Kwdc5b94BUtZUQ1hx4Y2maL5ECOw0xz0
         zhkw==
X-Gm-Message-State: AOJu0YzK96PCKmO78CiD75jjXJTU3fYnaq6NR6SyNeebI7lDSR9hQQVo
	q1Xb9tqdprYArqYxa/d9HfESmSiaitUx0LiwhMpQ/ssJKfZuMP0azw8g
X-Gm-Gg: ATEYQzyLWjtT+F6/eiDcoIK/FAdhsCE6CyQp2FLw24bCH7mWV7e3iPBPzCAr3TOfJwg
	GIVaBVqSTay8A3/m/2yykttj49y2yKfyiwz7kkAGEJOL3ehGXfBYnfaOowRmY45qLQ9D4VyzFP2
	fTi0QNPE6qr2rKY1sTG7Dz5b+ZOg8OHYjYd7eZFzfQ6VfHiMaCau5npyDEvqYOi6oOY5x3brLT1
	HuzABN4FjzGUSGYAwbaxsszJn7rcIBRbDL44WkC1XAenA8D/JqlVhXaSlMZnY7cKsS0dPlKv1eR
	3fzevYTI6OpbrbJ1dVdib0nCSbUKE8khVuphRlNJaWkSuJo7lz9GoO4/ic7vYCZCgV8+llWAHxn
	0etkP76Z5qk4xyP1A5VkM2TH2xXPbr/viO3ObQrlBIudDUwH3sgKviG15DykxrbKd9junq6hU8e
	RoRRwBp3Dc4uMC/+xg8lwR6o5iP63JHE3SY1v/W4fEofV129MhGe6B5XtrQtwf1dq7qBRKsqIxe
	afH7zeKgXc6hpWuwUKNQ23wiFNHqLP0JGESeuln+4yBevmI2dcgwCue6ew=
X-Received: by 2002:a05:600c:1f8b:b0:485:3c66:e21d with SMTP id 5b1f17b1804b1-485566d2fa1mr15956815e9.2.1773351722466;
        Thu, 12 Mar 2026 14:42:02 -0700 (PDT)
Received: from farblopa.localdomain ([84.126.0.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48556414295sm9326305e9.3.2026.03.12.14.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 14:42:02 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: peff@peff.net
Cc: git@vger.kernel.org,
	calvinwan@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	jonathantanmy@google.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	chandrapratap3519@gmail.com,
	=?UTF-8?q?Pablo=20Sabater=20Jim=C3=A9nez?= <pabloosabaterr@gmail.com>
Subject: [GSoC] Re: [PATCH v11 8/8] cat-file: add remote-object-info to batch-command
Date: Thu, 12 Mar 2026 22:41:54 +0100
Message-ID: <20260312214154.89120-1-pabloosabaterr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250324033922.GB690093@coredump.intra.peff.net>
References: <20250324033922.GB690093@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pablo Sabater Jiménez <pabloosabaterr@gmail.com>

Jeff King <peff@peff.net> wrote:

> In similar situations for the ref-filter printer, I think we use the
> empty string for unsupported cases. E.g.:
> 
>   git for-each-ref --format='%(refname) %(tagger)'
> 
> will show the empty string for %(tagger) of non-tags.

while playing with Eric's v11 for my proposal I tested some of the mentioned
cases.

I tested this, and for-each-ref dies on unknown atoms:

  $ git for-each-ref --format='%(test)'
  fatal: unknown field name: test

So the empty string behavior is just for known atoms but not applicable to
a given ref type, like %(tagger) on a non-tag. For remote-object-info,
the atoms are known to expand_atom() but the remote can't provide data
for them, returning an empty string would be the closest match.

> No, I meant that --batch-command takes a single format string, but you
> can issue both local and remote requests to it. So for example:
> 
>   git cat-file --batch-command='%(objectname) %(objecttype) %(objectsize)' <<\EOF
>   info 683c54c999c301c2cd6f715c411407c413b1d84e
>   remote-object-info c9d3534de317f31915f37e9d9c0d52d4cf901482
>   EOF

While testing Eric's v11 on this case, I found a bug beyond the segfault:
when a local info query runs before remote-object-info in the same session,
data->type retains stale data from the local query, and remote-object-info
silently returns the wrong type.

To reproduce, query a commit locally then a blob remotely:

  git cat-file --batch-command='%(objectname) %(objectsize) %(objecttype)' <<-EOF
  info <commit-oid>
  remote-object-info origin <blob-oid>
  EOF

example for my test case:
  git cat-file --batch-command='%(objectname) %(objectsize) %(objecttype)' <<EOF
  info fede5cd8e8da0ee5d984753286c77f80339ec832
  remote-object-info file:///home/blopa/tests/CPU16-remote.git 9a455a4325cc0b0ba839f2414395257511ab6213
  EOF
  fede5cd8e8da0ee5d984753286c77f80339ec832 237 commit
  9a455a4325cc0b0ba839f2414395257511ab6213 256 commit

  git cat-file -t 9a455a4325cc0b0ba839f2414395257511ab6213
  blob

The blob is being reported as "commit" because data->type isnt being cleared
between commands. The size is correct (provided by the
server) but the type is wrong.

This is even worse because user wouldn't even receive any signal that
there is an error.

To reproduce it, this is what I did:
Server repo needs `transfer.advertiseobjectinfo true`, and both client
and server must run Eric's v11, I used file://.

In the meantime I'll keep testing
Eric's v11 and report any issues I find.

Pablo
