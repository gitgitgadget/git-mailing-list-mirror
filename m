Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B1B1D5AA3
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 20:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730492093; cv=none; b=Zun9LuaWoPc18lf056Z7HNnL4058OYE+WBdDpUNBdWvXvFVHs9ZwBUiw8JMZNZ6/A5TiE1uRNPkBYYPrFDMWGlu2kerKc+QbmSJM7CTsPHLllSQVjKol+rwQI38Y0LjGY/3v9G5HX0vw4pSKcDUsd85OW1oPnt7GyOiNEvun0xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730492093; c=relaxed/simple;
	bh=PlvqU25bnfGHvPfEvqlQCAsWncRsvfzH9ENreq629Zk=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=XpuGQfMQNFBazye1seWLHrH6AAgBaf3Iq5Rw8dd6KtsjXZkcbcX1zuc2+8i8NrVAHmW13knVFoR9nYKQXleNdwnSKnLrGMrcAx5Wr200/zRq4u7JZzOgQehzqq3urI6ECXacTlT+0WjTAHM/kAfp0KQ0Jh0rnYvMY7jy1Nih6cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VU0qUbCy; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VU0qUbCy"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e30d7b4205eso4575882276.2
        for <git@vger.kernel.org>; Fri, 01 Nov 2024 13:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730492090; x=1731096890; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=csUdHPcOb6QLjRS5+OVynyP0JABv56paUDkRtmPGPvY=;
        b=VU0qUbCymIwkM5q0YJ1wYBDKFls3AR0MPdfOPew69Ai9h/3mze+j768Xxec/nzvRY8
         U1Aw/KKAuEOBRJLhytn9q2iKExUCV2USbJM3WM1s951bpfvtJiIlMD9CqBARlBeARB6G
         /NrA4WL0OD1jG0SFuvCcxI3HAPdaPsM9hdXi+19vFHsbw2Qnjoy1AV8YXEHQCmIuka9n
         6YkycMqsnw7oLEcL/D72Q6zQeEgya7vklVsLMUFuAprTLT63HJcE5sdlWZGJP13dULOp
         ZOLdYN4TXdsrSRKSUXLLHRbPdfRQo9Ur7DqAeDSlC6znsVUcDBka433jmWIePqUaNVwy
         T1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730492090; x=1731096890;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=csUdHPcOb6QLjRS5+OVynyP0JABv56paUDkRtmPGPvY=;
        b=dRvELokbmAX3FEIHY4H4iKenUIqOgVLp8bKw99EYEGyT+KYeN/fOAbAPM1jGy62pwF
         GDtoqRMCVPwIFEHIXGDnTGbJDBC0ZDA4frvvWU4L1qDtH0WVVCXzekUHIt6ZYlefgX2h
         ZRGoMAghkL7IW3wAJuQausjvZxdKsT0JHQ8KFnpyrpIpKspJSizHD5JvfhRQ/SP0nETK
         2+kvzrBONnO4uR6cg1aJmRSdBfuY1xbc16RLDS/12qSmCS9SUAZE/EFxec7rEW1sMCof
         zdcNQDndHtIHvNyfTfTtDKlkTGXm5F0KxQh3rn/waKl5S55RS8kTvqJkmXbeDyNqI0SR
         fsvg==
X-Forwarded-Encrypted: i=1; AJvYcCWa/SICI09+1swcnzZEkxNuw/2ovqCAuM4J+IZJF2SbqoZ4SXtb9pjc2taVfnjHWsq65t0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeUkwpO9tGbUY9irCClYM6Uk7/gzguWKjp/zG0k1iaWfzmqF2Z
	Ryti5eNlKBYF8CU+LZ1gwWBxgcQNtwSXSl+iuEW24LhvLHa/p+shuKNuvNUHNdwOE0uTHM5veEZ
	pvrCTGXjpOYGW4cpdJn7pQMqtBieWKA==
X-Google-Smtp-Source: AGHT+IGoo2J/kIvheC9YnFJnjGuHwOXa9RIG7CWo8GHQiPuIOqxAQyVgJFX8IF+tP7DrWCuZVcjal3KxGFDsHJzLN9y2
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:87c0:a56e:d0ff:807f])
 (user=jonathantanmy job=sendgmr) by 2002:a25:8241:0:b0:e29:7cfa:9fbc with
 SMTP id 3f1490d57ef6-e30e5b678ffmr4567276.11.1730492090604; Fri, 01 Nov 2024
 13:14:50 -0700 (PDT)
Date: Fri,  1 Nov 2024 13:14:48 -0700
In-Reply-To: <radxsrv6sjemdzl2mw5zzkieyim6xfikrevwggjmzi774g2sob@4nx7fwcjfk32>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241101201448.1695516-1-jonathantanmy@google.com>
Subject: Re: [PATCH 5/5] index-pack: repack local links into promisor packs
From: Jonathan Tan <jonathantanmy@google.com>
To: Josh Steadmon <steadmon@google.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org, calvinwan@google.com, 
	hanyang.tony@bytedance.com
Content-Type: text/plain; charset="UTF-8"

Josh Steadmon <steadmon@google.com> writes:
> > @@ -1719,6 +1772,57 @@ static void show_pack_info(int stat_only)
> >  	free(chain_histogram);
> >  }
> >  
> > +static void repack_local_links(void)
> > +{
> > +	struct child_process cmd = CHILD_PROCESS_INIT;
> > +	FILE *out;
> > +	struct strbuf line = STRBUF_INIT;
> > +	struct oidset_iter iter;
> > +	struct object_id *oid;
> > +	char *base_name;
> > +
> > +	if (!oidset_size(&local_links))
> > +		return;
> > +
> > +	base_name = mkpathdup("%s/pack/pack", repo_get_object_directory(the_repository));
> > +
> > +	strvec_push(&cmd.args, "pack-objects");
> > +	strvec_push(&cmd.args, "--exclude-promisor-objects-best-effort");
> > +	strvec_push(&cmd.args, base_name);
> > +	cmd.git_cmd = 1;
> > +	cmd.in = -1;
> > +	cmd.out = -1;
> > +	if (start_command(&cmd))
> > +		die(_("could not start pack-objects to repack local links"));
> > +
> > +	oidset_iter_init(&local_links, &iter);
> > +	while ((oid = oidset_iter_next(&iter))) {
> > +		if (write_in_full(cmd.in, oid_to_hex(oid), the_hash_algo->hexsz) < 0 ||
> > +		    write_in_full(cmd.in, "\n", 1) < 0)
> > +			die(_("failed to feed local object to pack-objects"));
> > +	}
> > +	close(cmd.in);
> > +
> > +	out = xfdopen(cmd.out, "r");
> > +	while (strbuf_getline_lf(&line, out) != EOF) {
> > +		unsigned char binary[GIT_MAX_RAWSZ];
> > +		if (line.len != the_hash_algo->hexsz ||
> > +		    !hex_to_bytes(binary, line.buf, line.len))
> > +			die(_("index-pack: Expecting full hex object ID lines only from pack-objects."));
> 
> I'm not sure why we check the pack-objects output here, is this just to
> detect errors? Could we instead just check the exit status of
> pack-objects, and discard the output?

The output is a hex object ID that tells us what we need to name
the .promisor file. (Later in this function, "binary" is used.) So we
can't discard it.

> > diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> > index e15fbaeb21..a565ab9b40 100644
> > --- a/builtin/pack-objects.c
> > +++ b/builtin/pack-objects.c
> > @@ -4310,6 +4310,18 @@ static int option_parse_cruft_expiration(const struct option *opt UNUSED,
> >  	return 0;
> >  }
> >  
> > +static int should_include_obj(struct object *obj, void *data UNUSED)
> > +{
> > +	struct object_info info = OBJECT_INFO_INIT;
> > +	if (oid_object_info_extended(the_repository, &obj->oid, &info, 0))
> > +		BUG("should_include_obj should only be called on existing objects");
> > +	return info.whence != OI_PACKED || !info.u.packed.pack->pack_promisor;
> > +}
> > +
> > +static int should_include(struct commit *commit, void *data) {
> > +	return should_include_obj((struct object *) commit, data);
> > +}
> > +
> 
> Nit: these two functions could be named a bit more descriptively.

OK, done.
