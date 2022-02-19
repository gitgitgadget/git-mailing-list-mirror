Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E77C433EF
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 22:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239019AbiBSWbe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Feb 2022 17:31:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236557AbiBSWbd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Feb 2022 17:31:33 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D3B46B36
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 14:31:13 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a23so23424902eju.3
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 14:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=cQXVrz2uWDao+S7hq4PBEh7EIag3et/FVcKb2dNLOtA=;
        b=ldWh4hD9gBP9zt0mH+jT3dbLLWVjBH/Rc6mgm5YU0ZhZJ5/SvtRwfiuJOY6XBTvk1S
         k/Wnt5T77kuyUB6hWEEKn6OyN6bKF5eP4EhUlb7CExTBbY8aF851p1GhboUrEMJRMHnf
         Fl33Xha9hAnfed75XXcq/mRNsbOMf9ei9ejx1+iQ+GpCO/edQKXEnub/FrHjrhIz8HG4
         Kxmcy1jJBNuyb5uKgw8TNS4bwetk9CiRsFN/sTrS2iAklDuoxMSUFIX4FTbrJzqSSpV2
         GEN8Z7h0JYBkdOyJVBVEkfOIYPm+RdBt2sOZ020rCzCCqd3uqg04IEOoPaE+87pBhz9o
         kEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=cQXVrz2uWDao+S7hq4PBEh7EIag3et/FVcKb2dNLOtA=;
        b=IFJ6Z9RZAq0XFifsQ2QDexyakJh2hhIct4AcpgRjoGjqIqx2NVCcwqUU1xfFKb2fd9
         n+gO2A+XJuBpXw3+ctZYZIJog26FZM8weKXkyMLGRg14wyGvLWaqHn+RHGvFvE1i70lu
         1JUrM6OJ4rfZPwPezPolEPty01A0/yfr8SeUz7QF22J4XF2aNUBewbC8TyQEK7LXPz7O
         rwOMfTDxFvZB2HVd84cnStTRkrb7Pn+nYA7etL1fjrqVERtDnqanOkU4D2hGm7c8a+R6
         BghTPpHlC2HxWcPK8ZAbW5vtbpmsxMndCcSMOh8lnn0Z9EvS8WwlvPm0Ab+Um80LIhFQ
         bB9w==
X-Gm-Message-State: AOAM532meuh9AetGGHvtAErw8FqRThnZDLXQl82HEYsl1eevpXtsBeG4
        Ipo0kAEzaUdd696sUsMrObQeQqRbyfh8+g==
X-Google-Smtp-Source: ABdhPJwIcXAQfqGspMn1qA3e+U9/FRdpU+2GHLEqA9BwDjCW0P2jMpnBlOlIK5MUQBisu4LBna4Pyg==
X-Received: by 2002:a17:906:1e91:b0:6ae:99d9:93b1 with SMTP id e17-20020a1709061e9100b006ae99d993b1mr10971358ejj.111.1645309871373;
        Sat, 19 Feb 2022 14:31:11 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id u4sm3591902ejn.216.2022.02.19.14.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 14:31:10 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nLYFy-005HCb-Ci;
        Sat, 19 Feb 2022 23:31:10 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/2] merge-ort: fix small memory leak in unique_path()
Date:   Sat, 19 Feb 2022 23:22:44 +0100
References: <pull.1152.git.1645290601.gitgitgadget@gmail.com>
 <73bc1e5c5dffbe9c132ea786dd414ef2159967e3.1645290601.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <73bc1e5c5dffbe9c132ea786dd414ef2159967e3.1645290601.git.gitgitgadget@gmail.com>
Message-ID: <220219.86o832cwup.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Feb 19 2022, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> The struct strmap paths member of merge_options_internal is perhaps the
> most central data structure to all of merge-ort.  Because all the paths
> involved in the merge need to be kept until the merge is complete, this
> "paths" data structure traditionally took responsibility for owning all
> the allocated paths.  When the merge is over, those paths were free()d
> as part of free()ing this strmap.
>
> In commit 6697ee01b5d3 (merge-ort: switch our strmaps over to using
> memory pools, 2021-07-30), we changed the allocations for pathnames to
> come from a memory pool.  That meant the ownership changed slightly;
> there were no individual free() calls to make, instead the memory pool
> owned all those paths and they were free()d all at once.
>
> Unfortunately unique_path() was written presuming the pre-memory-pool
> model, and allocated a path on the heap and left it in the strmap for
> later free()ing.  Modify it to return a path allocated from the memory
> pool instead.

This seems like a rather obvious fix to the leak, as the other side
wasn't ready to have the detached strbuf handed to it, and instead is
assuming everything is mempools.

The downside is a bit of heap churn here since you malloc() & use the
strbuf just to ask for that size from the mempool, and then free() the
strbuf (of course we had that before, we just weren't free-ing).

So this is just an aside & I have no idea if it's worth it, but FWIW you
can have your cake & eat it too here memory-allocation wise and avoid
the strbuf allocation entirely, and just use your mem-pool.

Like this:

diff --git a/merge-ort.c b/merge-ort.c
index 40ae4dc4e92..1111916d5cb 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -731,6 +731,16 @@ static char *unique_path(struct merge_options *opt,
 	int suffix = 0;
 	size_t base_len;
 	struct strmap *existing_paths = &opt->priv->paths;
+	/*
+	 * pre-size path + ~ + branch + _%d + "\0". Hopefully 6 digits
+	 * of suffix is enough for everyone?
+	 */
+	const size_t max_suffix = 6;
+	const size_t expected_len = strlen(path) + 1 + strlen(branch) + 1 +
+		max_suffix + 1;
+
+	ret = mem_pool_alloc(&opt->priv->pool, expected_len);
+	strbuf_attach(&newpath, ret, 0, expected_len);
 
 	strbuf_addf(&newpath, "%s~", path);
 	add_flattened_path(&newpath, branch);
@@ -741,10 +751,10 @@ static char *unique_path(struct merge_options *opt,
 		strbuf_addf(&newpath, "_%d", suffix++);
 	}
 
-	/* Track the new path in our memory pool */
-	ret = mem_pool_alloc(&opt->priv->pool, newpath.len + 1);
-	memcpy(ret, newpath.buf, newpath.len + 1);
-	strbuf_release(&newpath);
+	if (newpath.alloc > expected_len)
+		BUG("we assumed too much thinking '%s~%s' would fit in %lu, ended up %lu ('%s')",
+		    path, branch, expected_len, newpath.alloc, newpath.buf);
+
 	return ret;
 }
 

A bit nasty for sure, but if you're willing to BUG() out if we ever go
above 999999 suffix tries or whatever (which would be trivial to add to
the loop there) it's rather straightforward.

I.e. we know the size of the buffer ahead of time, except for that loop
that'll add "_%d" to the end, and that can be made bounded.

Obviously your solution's a lot simpler, so I think this is only
something you should consider if you think it matters for the
performance numbers linked to from 6697ee01b5d3. I'm not familiar enough
with merge-ort.c to know if it is in this case, or if this would be
pointless micro-optimization on a non-hot codepath.

