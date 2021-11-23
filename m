Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B61C433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 10:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbhKWKnQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 05:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234403AbhKWKnO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 05:43:14 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F82C061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 02:40:06 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id y13so89955460edd.13
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 02:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=AkPtBYh75NU3jrOPVhkhyIEz/2YT1rkshrRObpYn0r4=;
        b=TbMYTDNY65de/zCCZaf3wnLhLf7eZ94D4C5uJFdS0HaeyPFLlka6mz5N2mK3io3gMq
         n9NtoJHJEWlvT0qhyHtOQQDJZQrke+LdUXQw4oW125WCfyWlXfsBmE3uIwY+WX2RMtCu
         eldW0Xh4JOleIt6ZgFf+s+aKa0ZYX1Z4U75eOS+B+CGR3ava5VCWJG5y3ZSnp1StQvwE
         Sw83KTitPKmkRhmjiDXBDRqy2MLLMXMmy9/eRkK1HhvOjbEdyxCDGC1GncUH6+lmlxG1
         HKHcsB64ywOfIgpN0ClufQUDFVWTeHMxCJVx1TQ9jFiqPrBa8acvMVPHMnfq00rmaz+7
         IMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=AkPtBYh75NU3jrOPVhkhyIEz/2YT1rkshrRObpYn0r4=;
        b=4HeIQGs3p5wVaLMEz8f/7kCroDZ2IPSY6ceNdTZU0GoEsz8pzvI05/6+WPUAk628Mj
         00BqchDD46mjRGwjJrkdDuP4Q8vIa+9IwdgwnvO8N/67PSPl1SfyWqzleERAnhLQ98m/
         k86FYx2iA2EJYwsJFJZ8Kejvzv1KscCgHKIszjzAv6QQ4kFl5xU2ygktLoupzsFUmYS9
         mz3si/2o75GyJxIlv1ffUNhtktTlEbYEoCnqzUnSwzkDXq+UJ4nA8nG5k7KuhpSD8NId
         wVs5u9gx6PdB5Ti5+mR95hDn39A3tfDG67iO6COGhgF7G4KZg8KSTXteQLmKdmiQWr9Q
         afeQ==
X-Gm-Message-State: AOAM5313+4aEpU4p0xYN4xjEG1lCfjbyoWsa1F6bv/S+5sf06ImXmI/T
        dvLNI9fCRTqVQakkAE1MXhscW+iWiNaPTw==
X-Google-Smtp-Source: ABdhPJxsBUmxqZxIQFpF/48w7tKdIhHn87/WuFM/zAZ8lhDCK0AoqJ9phTeNoiLImmajRqkmq3jWTQ==
X-Received: by 2002:a17:907:1c81:: with SMTP id nb1mr6330323ejc.9.1637664005025;
        Tue, 23 Nov 2021 02:40:05 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id f16sm5914301edd.37.2021.11.23.02.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 02:40:03 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mpTDX-001Jo8-Bi;
        Tue, 23 Nov 2021 11:40:03 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] refs: trim newline from reflog message
Date:   Tue, 23 Nov 2021 11:24:12 +0100
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
 <dfb639373234a6b8d5f9110380a66ffccbe0b1d6.1637590855.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <dfb639373234a6b8d5f9110380a66ffccbe0b1d6.1637590855.git.gitgitgadget@gmail.com>
Message-ID: <211123.864k83w3y4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 22 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
> [...]
> @@ -3059,18 +3059,18 @@ static int expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
>  	if ((*cb->should_prune_fn)(ooid, noid, email, timestamp, tz,
>  				   message, policy_cb)) {
>  		if (!cb->newlog)
> -			printf("would prune %s", message);
> +			printf("would prune %s\n", message);
>  		else if (cb->flags & EXPIRE_REFLOGS_VERBOSE)
> -			printf("prune %s", message);
> +			printf("prune %s\n", message);
>  	} else {
>  		if (cb->newlog) {
> -			fprintf(cb->newlog, "%s %s %s %"PRItime" %+05d\t%s",
> -				oid_to_hex(ooid), oid_to_hex(noid),
> -				email, timestamp, tz, message);
> +			fprintf(cb->newlog, "%s %s %s %" PRItime " %+05d\t%s\n",
> +				oid_to_hex(ooid), oid_to_hex(noid), email,
> +				timestamp, tz, message);
>  			oidcpy(&cb->last_kept_oid, noid);
>  		}
>  		if (cb->flags & EXPIRE_REFLOGS_VERBOSE)
> -			printf("keep %s", message);
> +			printf("keep %s\n", message);
>  	}
>  	return 0;
>  }

I haven't looked deeply into this topic as a whole, but FWIW this
conflicts with a topic I've got locally and was going to submit sometime
after the current batch of my own ref fixes in "next".

That we've got verbose output at all in file-backend.c is a wart, and it
should just be moved out if it entirely, this commit (stacked on top of
various other fixes I've got in the area) does that:
https://github.com/avar/git/commit/eff40d2d81b

With that change the reftable code will need to handle far less of this,
as it'll be handled in builtin/reflog.c, it just needs to behave
properly in the appropriate "expire reflog?" callback. I.e. the backend
tells us "does this expire?", the builtin/reflog.c code consumes that
and does any verbose or non-verbose (or progress etc.) output.

Now, the merge conflict between that and this looks rather trivial, but
I can't help but wonder if we're going in the wrong direction here
API-wise, or maybe "wrong direction" is too strong, but "sticking with
the wrong patterN?".

I think your cleanup works, but wouldn't a better thing be to move this
to callbacks rather than tweaking the fprintf formats?

I.e. in my version the whole body of this function has become:
	
	static int expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
				     const char *email, timestamp_t timestamp, int tz,
				     const char *message, void *cb_data)
	{
		struct expire_reflog_cb *cb = cb_data;
		reflog_expiry_should_prune_fn *fn = cb->should_prune_fn;
	
		if (cb->rewrite)
			ooid = &cb->last_kept_oid;
	
		if (fn(ooid, noid, email, timestamp, tz, message, cb->policy_cb))
			return 0;
	
		if (cb->dry_run)
			return 0; /* --dry-run */
	
		fprintf(cb->newlog, "%s %s %s %"PRItime" %+05d\t%s", oid_to_hex(ooid),
			oid_to_hex(noid), email, timestamp, tz, message);
		oidcpy(&cb->last_kept_oid, noid);
	
		return 0;
	}

The only file-backend specific part of it is that fprintf(). If we moved
towards making that part of it be:

	write_reflog_entry_cb(oid_to_hex(ooid), oid_to_hex(noid), email, timestamp, tz, message);

Then we could lift the whole of this API to a level that makes more
sense for a backed to implement.

The refs/files-backend.c shouldn't need to have one function calll the
"should_prune_fn" *and* write out the data. Instead some code common to
all backends should call the "should prune?", and then call the
backend's "here's an entry for you to write" callback.

But maybe I'm overthinking this whole thing. I'm just wondering if we
have say a sqlite reflog backend as opposed to the file/reftable backend
that wants to store this data in a schema. Such a a backend would need
to unpack the data, as we're sprintf() formatting function parameters
before it gets passed to the backends.
