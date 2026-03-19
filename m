Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A813B95FA
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 22:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959058; cv=none; b=FtDmJBtpLqKukXkS2GbA5orKtVJbwjLNYxoAVPXgApvmvy2kzlxzGw++aoURVpbgf5DWiwZ8kyh/fiS1tgTGm3PASxSauLytxfvZJNz5UBC8tMZJU6va3F2yOuYYXQIXQTFpAXk4xTWn2dwAVXHW3qmzu5Ff5eO1dFCcJbhcCK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959058; c=relaxed/simple;
	bh=ZoL0TKgnFvvTvyButtOF1lSoMr0C0KjNJwfQinzf3Jw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Irig6ZVKLzQ0mhBLmKqvra0HEgyo5HwnNYLxBMw3sZt+y+k4hG8OPytyM7M07/MtL7qZyV8MxFM6rkQ5nP6yUQIacWiXCq+WDWsMbTX4TWrLvIsMNCcLeYMb6Vez53N4OvlIu3MCD9GuKlTehmM5MMMNLPQFrMq7ASPB4ZEKO2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=HS4ouQ4G; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="HS4ouQ4G"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64ad46a44easo1205224d50.0
        for <git@vger.kernel.org>; Thu, 19 Mar 2026 15:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1773959054; x=1774563854; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gjo6nMt+pmCJRSOC0abfc0aSDAccTSfactiTKUv6eDQ=;
        b=HS4ouQ4G4QiWA4MIKPMkSYj9l5us+MIwqx/infYZ3dl5Au1z7asW7rU+Up55MGXQ4b
         gqna+iWUJyb4H319JdZLQxsqTfC9cVGA1Sqt2pHu9iwocUww7T6ACxisKk410+jFQGBx
         pnnXsTPgzwyLqQo21nTtIEQe6gljTbsfy8GMKqCWnYQuqClXvyiabuaBAAjOP8VX1RkG
         DV5anlwW6yNgxAN7UxDBxFQ/z7FE1023p/G2GvnIDhKv5RThbnGlHPT6rcesK201Mmtr
         ccXDr6GRvV9ZAaH3Pv3zYfQGil/4KnVpO1Yp5rgpc5XtkcuT2Sxzh6i6CjAVYdWgZqgC
         zzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773959054; x=1774563854;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gjo6nMt+pmCJRSOC0abfc0aSDAccTSfactiTKUv6eDQ=;
        b=g/3LLanWffMC0lQfia/+uP4dFIU23FJMN4kfcHVrhXKxg2m6t50yxp1/MHbRCJG+VP
         VWoilwvAkUgw7J/0ohZQJurU/Eh1FXSXToWSUTyBADz/eiRGT4YUnQRnq53oNi6IR7Fg
         teWgqet6LnenFWeGkRKv/j0S1AgerbnSfXae85wlhtwN5/Uw2LTelAsbJzdYG1TTkVat
         5ED9n5ap9sDaEdrpj+wZeCJX5PgHst9MQ1I+UHKpnQXKapfJ+JGKA/END0BTJmVaERP8
         NLXqJeUMNMPAJqfNn8ZYbvN0QXVfRMlRd7q23rWbspUs62UBU9We+5wcqXy6grPjtQmF
         gD6g==
X-Gm-Message-State: AOJu0Yzyiy0TuEU9uf1UY8sLKdk/74fFqH7FeLDYALQ8w8yEha8iHtv3
	6ybeQN6372S/V4+yK7QF9JC9w2w56hnEaxXDxTOH/33j1ZtbFXVUwjdYWK7MNffm2B2vMyNFYri
	JUI3uj/I6kA==
X-Gm-Gg: ATEYQzxmXi+FTJQE0BNBn5Gssa3VpIHQCmLTMU70nvUPn6pQASgtUnMz3OeOenFHxzu
	HWbwt3zic30tqfOLP7N47KlviodWQZV92YyCcEukm/XPd7QTV5XH3yBubRBUQmU/5PgOJF2h4CD
	Axz9Q/ocIYi6CsLcutdMy7hX9ZkIq161hwFSTo62fti+eYcZIjFxVuCwZcoJDZAorz191kDu0/i
	3VkPNPH6AapyhIM0Ox5B4frtHjuX3WYf0nHvPi7TFVDzpKDy5mNKxkvOPVIio5tcnFbK0AbPVrB
	Lp9dhQiIrx2Y/1Cia1aPW/UMTTuPJQK4tc9+C8nsK9oX8ixFuEnPPRXk10wOPJScyN5itMCm3LF
	0xPe4nlkrm9onYngithFy6ixjT8K+P+0Gq5oShYL6yv8FR4W6XP5NGmfKWvCjoDjeq6YQsWvKIU
	M/8gRrM4WJ1Rdhhxh4Wop5svhM1sUUwZIZJDgBHh+z/j8siqSA7IwVlfl4ECK74B+AuYSGSUl5f
	w1HEkTrJ/bga2M3Gvz9JT1YDoaaTA==
X-Received: by 2002:a05:690e:4285:10b0:64c:a09f:12ab with SMTP id 956f58d0204a3-64eaa6e163dmr1061191d50.30.1773959053910;
        Thu, 19 Mar 2026 15:24:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64eabd944ffsm300922d50.9.2026.03.19.15.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 15:24:13 -0700 (PDT)
Date: Thu, 19 Mar 2026 18:24:12 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/5] pack-objects: handle excluded-but-open packs via
 `--stdin-packs=follow`
Message-ID: <cover.1773959041.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

This series came from an issue I saw in GitHub's infrastructure where a
particular repository was failing to repack with the following in its
log output:

    warning: Failed to write bitmap index. Packfile doesn't have full closure (object XYZ is missing)

This was following a geometric repack that generated a MIDX and
attempted to generate its corresponding MIDX bitmap. Ordinarily, we
should never expect the above when generating MIDX bitmaps, unless:

 - Object XYZ is indeed missing from the repository (though we should
   have seen an earlier failure during the MIDX write itself), or

 - Object XYZ is somehow not included in the MIDX, but is reachable from
   another object which is.

After validating that object XYZ was indeed present at the time the
repack failed, I tried to figure out why we would ever generate a MIDX
whose set of objects was not closed under reachability.

The precise details are laid out in the fourth patch, but the gist is
that:

 1. A pack whose objects are *not* closed under reachability was deemed
    large enough by the geometric repack machinery so as to not need a
    repack.

 2. When generating the new pack with the non-closed pack was marked as
    excluded, some object in an included pack reached an object (XYZ) in
    an unknown pack whose only reachability path involved walking
    through the parents of an object in another excluded pack. That

 3. We wrote a MIDX containing the new pack, along with all of the
    large-enough packs from the previous step

 4. Because XYZ was in an unknown (likely cruft) pack, the resulting
    MIDX does not contain a copy of object XYZ, but does contain a copy
    of an object which reaches it, making it impossible to write
    bitmaps.

This series introduces a special denotation for packs which are excluded
but not guaranteed to be closed under reachability. By marking a pack as
excluded via '!' (as opposed to the traditional '^'), we will now pick
up copies of objects reachable from objects in those pack(s), but
exclude objects which appear in excluded packs (open or closed).

In practice this means that the resulting pack contains:

 1. All objects in the set difference between the included packs vs. the
    excluded ones (open or closed).

 2. All objects reachable from at least one object in either an included
    pack or an excluded-open pack which (a) do not appear in an excluded
    pack (of either kind), and (b) has a reachability path that does not
    involve objects in the excluded-closed packs.

The series contains a couple of minor fixups and some refactoring that I
did along the way to make the substantive changes easier to read. The
first commit is a cleanup, the second is a refactoring, and the
remaining patches demonstrate, explain, and fix the bug.

(As a general side-note, I am somewhat unhappy with the growing number
of ways to mark a pack as "kept", and tried to untangle this by letting
packs hold an arbitrary bitset of flags that is opaque to the object
traversal machinery. This ended up being doable but rather complicated,
so I ended up punting on it for now.)

Thanks in advance for your review!

Taylor Blau (5):
  pack-objects: plug leak in `read_stdin_packs()`
  pack-objects: refactor `read_packs_list_from_stdin()` to use `strmap`
  t7704: demonstrate failure with once-cruft objects above the geometric
    split
  pack-objects: support excluded-open packs with --stdin-packs
  repack: mark non-MIDX packs above the split as excluded-open

 Documentation/git-pack-objects.adoc |  25 ++-
 builtin/pack-objects.c              | 234 ++++++++++++++++++++--------
 builtin/repack.c                    |  19 ++-
 packfile.c                          |   3 +-
 packfile.h                          |   2 +
 t/t5331-pack-objects-stdin.sh       | 105 +++++++++++++
 t/t7704-repack-cruft.sh             |  22 +++
 7 files changed, 332 insertions(+), 78 deletions(-)


base-commit: 7ff1e8dc1e1680510c96e69965b3fa81372c5037
-- 
2.53.0.614.gc4fd52e751a
