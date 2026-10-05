Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9FA1C5D72
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 05:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791179624; cv=none; b=Y1FS3GQHzMW6El9DDhL5OQS0HFpLIL6cn7GfdYp//T6DNYJZ/pXvgqx9FDe7SvGKeSb8FdU4RBw4p60VctpgM1DwmyHW7UNfyrvERIIqhNcNR6KVSHsY+UB5FX905puM2PfIuxueWpfqnZhVLdp1TdBsP0pGI82ZicKKVQkPesw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791179624; c=relaxed/simple;
	bh=hIoLrx+9Hr1SWI/OxWL7knCVoWtzMARmIm+48RVLKBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WoHqICvPp/2wh69sMrtS2LYpZCcyKFGu9+7+6CVeQfWxKlKqdgzzRzZnyfWtDEJqENtTjtBYSDCSUl8PUsY65TiDDj692iAbEnKQqj/4rWAPXzZNI97f6vw8aEWtc8BcO95LCIlJG4CFxQm/JzzlOoATM88X8fpR+7JWboUdaNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OeHYUhv/; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeHYUhv/"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48441a2ba1bso716263f8f.1
        for <git@vger.kernel.org>; Sun, 04 Oct 2026 22:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791179621; x=1791784421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Iw8jBt3PR6+Nieiw3qH9mlhpOS1v8+eK3vkDKz2xk/E=;
        b=OeHYUhv/2UYBslSfw6+mJnxAvi6rpDjHS+FlzFLKEm35hcZyNlv+C76tFiBc293plZ
         U0wt2776TfhTZlaUoudNNEYUJptOAvlTID9/KNfPG+lElN3X8WiQdQz9H0bbgEjVKQJg
         KGk5z1VGHKb8yDBxn1ipVx19b+0gBem52sSHvTBs1d/xvEU+FWHYRmeSICcjaq/1OsT5
         VJCW5C5w37SLR0rwkhAOCpBaaJCbgjhOMNOerwW7fjuPcXFVOQlTHOpUXHzFg/XOakKS
         5Uys4krStXi2w0sTXylgEFTP3MI419fgRO1XbxbF7QMpkyiuUbEIzGN9Z7a5Xnj/ilG6
         zhlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791179621; x=1791784421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Iw8jBt3PR6+Nieiw3qH9mlhpOS1v8+eK3vkDKz2xk/E=;
        b=B0q5gKnu3tLhFGTPdYRdMmT+teFWgVnlOAl0E7xzgc7h5z0L0fGM8Q+yFZTkjNfa6D
         GyNlqKPCCueYu2WYqIMDm2TFbIX0Tj3sk8qiQozkZYqXklJUT+7ObVmvTbpwf3gCVtqr
         26/AuTEpRcGAtLQMLYRNVXLag4kjVuRQ4OHWTicdYiDA+7dAvi/aEe1+UfumnonG6DqY
         m7be52jhF8r1m9GZwvHhOn2nG7oad18c4uPqJSsWWYLgXN33ZusBnIh4rpVXALLqZy/5
         ZnFvZEYqoZxtrWnk8dOSCQmU82MQaxz4unBH7kH3DdNVpCYo/3xndLswQq1U8JHKAox+
         L1mA==
X-Gm-Message-State: AFq9FYIGWurCCnI4ctm3vCqJLvyvcPgm+/KS0NqPVIVcmg9D2gCUEncY
	21e831gGxiwYMAP+VTen0GCgij13cvLUMEsKKag7xa7RrFgluIh4eRut8NgeS2vv
X-Gm-Gg: AYBFou0d2325nlR7F+6lkT0LnSaYklEaPREuXA6XrdxHit/L1x6bK31naYOvKvqnEBR
	HgkieMLwTdeqognDS4ypkKP+HtPFSVxrgJE/XEQiwJNXQzBIvVoWsZzNjswaKcYQsHD9trAYXhg
	YjSibvsFLBFjh2U4pfYqnnuyg0YcJ2l0+xJbQaLm5HwOn+m5vd3rPlaZ56jyy+HnwPZvZNqWft3
	Dx3jGeWr8//kvQqJNOmq6Ex8fFBWK9QeoLeWJ94aB6oVdmQw/GwBD4ROFNFQu0h8RTBSzlAzNHl
	tN9q3znPZ+4O+7yhCTg6kdcOdx1/GCocWFDvUgrgkuTLa9Dl5Mv1uZyTcLNFfNnOSx8Ui3KKq4j
	Q0GAfBvdPwmkSWR/M5mUmjjfGKyCBM9BUkdcLHbUsYZbgbNhjJjA8KruZo+0FGId/pFEst/j+w+
	fApvmeaeVMbgi/xuK6HgwcVzWFWpbvYIkRuukazYdJMSrMXfVUal6J1yWa5WzzcEW7RIcSTjAJm
	Yv0pmATOLNIkfxvNrtmZcNuetvh
X-Received: by 2002:a05:6000:40cc:b0:48b:fdd:fbe4 with SMTP id ffacd0b85a97d-48c47fd3ed7mr11692385f8f.21.1791179620958;
        Sun, 04 Oct 2026 22:53:40 -0700 (PDT)
Received: from SSI-H-ARSHAD-LP.ssilhr.com.pk ([182.188.28.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c62289e77sm1316707f8f.21.2026.10.04.22.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 22:53:40 -0700 (PDT)
From: Hanan Arshad <hananarshad619@gmail.com>
To: sandals@crustytoothpaste.net
Cc: git@vger.kernel.org
Subject: Re: [RFC] git stash: add porcelain for sharing stashes through remotes
Date: Mon,  5 Oct 2026 10:53:37 +0500
Message-ID: <20261005055337.7579-1-hananarshad619@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <arw5XxJPNlUxU8TS@fruit.crustytoothpaste.net>
References: <arw5XxJPNlUxU8TS@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Brian,

Thanks for the detailed feedback. I reconsidered the design based on your comments, particularly the point that the appropriate remote namespace depends on the user and environment.

I agree that Git should not impose a fixed namespace such as:

refs/stashes/<author>/<name>

Instead, the remote ref should be explicitly chosen by the user. For example:

refs/stashes/hanan/fix-login
refs/stashes/fix-login
refs/heads/hanan/stash
refs/heads/stash

The tooling would provide the stash transport workflow without standardizing where the remote stores it.

The revised interface I have in mind is:

Publish one stash to a user-selected remote ref:

git stash publish <remote> <remote-ref> [<stash>]

For example:

git stash publish origin refs/stashes/hanan/fix-login stash@{0}

If <stash> is omitted, stash@{0} would be used.

Internally this would reuse the existing stash export mechanism and normal push machinery. The original local stash would remain unchanged.

List matching remote refs without downloading their objects:

git stash list --remote <remote> [<ref-pattern>]

For example:

git stash list --remote origin 'refs/stashes/*'

This would list refs only rather than downloading each stash to obtain its description. As you pointed out, stashes may be large, so fetching their contents merely for listing would be unnecessarily expensive.

Retrieve one or more stashes from remote refs:

git stash get <remote> <remote-ref>
git stash get <remote> <ref-pattern>

A single ref retrieves one stash:

git stash get origin refs/stashes/hanan/fix-login

An explicit pattern could retrieve multiple stashes:

git stash get origin 'refs/stashes/hanan/*'

Each matching ref would be fetched and passed through the existing stash import logic, producing normal local stash entries.

Prefix matching would not be implicit. For example:

git stash get origin refs/stashes/hanan

would refer only to that exact ref. The user would need to specify refs/stashes/hanan/* to retrieve refs below that namespace.

No tracking relationship would be established between the imported local stashes and the remote refs.

Remove one or more shared stashes by deleting their remote refs:

git stash remove <remote> <remote-ref>
git stash remove <remote> <ref-pattern>

A single ref:

git stash remove origin refs/stashes/hanan/fix-login

Multiple refs:

git stash remove origin 'refs/stashes/hanan/*'

Again, wildcard matching would need to be explicit rather than treating a ref prefix as a namespace automatically.

This would use the normal remote ref deletion mechanism. Existing local copies would remain unaffected.

publish would always operate on one stash, while get and remove could operate on either a single remote ref or an explicitly specified set of matching refs.

Human-readable ref names would be used rather than requiring users to work with object IDs.

The overall implementation would remain:

local stash
    -> stash export
    -> push to user-selected remote ref
    -> fetch
    -> stash import
    -> normal local stash

So the proposal would add porcelain around the existing mechanisms without imposing a universal remote stash namespace.

Does this direction address your concern about standardization?

Also, do you think it makes sense to pursue all four operations as porcelain, or would you prefer starting with only git stash publish and leaving listing, retrieval, and removal to existing Git commands?

Thanks,
Hanan Arshad
