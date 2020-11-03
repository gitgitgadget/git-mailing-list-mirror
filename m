Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3121FC388F2
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 05:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9D1F2225E
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 05:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4ZugssV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbgKCFf6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 00:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgKCFf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 00:35:58 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1879BC0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 21:35:58 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id w11so8026202pll.8
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 21:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PgZF4TFF1DMU7mNoRzs+zEWUqS3qfgUOgAnFy2vmh0g=;
        b=R4ZugssVh9z4YYfkEz2Gm3JYkZ09+JxHDJ7uq0Owl6iVIUsSkiwcbsfKXCMZN3UqZB
         CDBnHeuTBYqkvIZDilFeRzQSiI48QbzNgATUtyspJltDCZ584iZm4XE+FKtuPwcUD1qk
         Dq5N3kGq+sCEMgb+3qF2WSrVLAPGzmHPViHKzIfPb8UFfaL/kWo9EYH2I0SaR9tKputx
         wnNvtcyQenhMkMGsifdqWWvC0Ihjm5KOYJ56BhSzA0X2l1Bki6bCezW8yLFZaRBr9hsx
         B8zgvgRnaf4HiPnmFFnnhJv7SJ/4kUI38+npcorJGAyjHlAy1xd7IGxp3Xerv5mOMr+/
         GLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PgZF4TFF1DMU7mNoRzs+zEWUqS3qfgUOgAnFy2vmh0g=;
        b=j9PWYAAbBP4BoshlLjQ7um3KVh2bHv7L2yeAI02V0YJ5dFZxV2U47t543WXpDoUigF
         f1T6L1TVFc4cMBbR4IEKumrQ35aImL8rcK0Z+NVPL/vtIDNKOr4Do41YoJPRjsh7gqwY
         DFI3r7iWTWBQOy7/3+LdEo4a+90EVteSaaogMRaGQrHYwzfiYbTkzGSTG0naYApnkEs/
         kr60MtHRkn8StCKB4xc4v8JbhjgA/Hkc4HywoKcA5iXu+3TfHlkpEB0AUuzb5KzScRy4
         SrHiQ8BPfJv5w5377u6h7f9f6B6k7++ucxRFQBQr3eTM60z5UJMH8TbGkv3vsLe/CbB3
         iOzA==
X-Gm-Message-State: AOAM531Um/lGtDfS/k7UHHdLzHtoxJpu4NDtGt5PX9jKf7xjsSqzgvvU
        Dx6u0jFAtzY6Fy8XCvN3O6E=
X-Google-Smtp-Source: ABdhPJyBxnnaSsRHuneee6RbHKeGx94y8xa47+Uh8TcCLJlKCfDNInxmxW/SJBysAhT3SizTnnmsXA==
X-Received: by 2002:a17:902:6803:b029:d6:cf9d:2cfb with SMTP id h3-20020a1709026803b02900d6cf9d2cfbmr7298501plk.55.1604381757521;
        Mon, 02 Nov 2020 21:35:57 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id x18sm16551620pfj.90.2020.11.02.21.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 21:35:56 -0800 (PST)
Date:   Mon, 2 Nov 2020 21:35:54 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 4/4] Doc: push with --base
Message-ID: <20201103053554.GC948115@google.com>
References: <cover.1604362701.git.jonathantanmy@google.com>
 <6250c13897e3cc01f247d80c148cf8dc5e7f3ad0.1604362701.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6250c13897e3cc01f247d80c148cf8dc5e7f3ad0.1604362701.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(+cc: Elijah Newren and Derrick Stolee because of [1])
Hi,

Jonathan Tan wrote:

> Includes protocol documentation and a design document.

Thanks for writing this.

> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  Documentation/technical/pack-protocol.txt  | 10 ++--
>  Documentation/technical/push-with-base.txt | 61 ++++++++++++++++++++++
>  2 files changed, 68 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/technical/push-with-base.txt
> 
> diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
> index e13a2c064d..0485616701 100644
> --- a/Documentation/technical/pack-protocol.txt
> +++ b/Documentation/technical/pack-protocol.txt
> @@ -59,9 +59,9 @@ Parameters", and are supported by the Git, SSH, and HTTP protocols.
>  Each Extra Parameter takes the form of `<key>=<value>` or `<key>`.
>  
>  Servers that receive any such Extra Parameters MUST ignore all
> -unrecognized keys. Currently, the only Extra Parameter recognized is
> -"version" with a value of '1' or '2'.  See protocol-v2.txt for more
> -information on protocol version 2.
> +unrecognized keys. Currently, the only Extra Parameters recognized are
> +"version" with a value of '1' or '2' and, for push, "base" with an OID.  See
> +protocol-v2.txt for more information on protocol version 2.

It's nice to see an example of extra parameters being useful in
protocol v0 as well. :)

>  
>  Git Transport
>  -------------
> @@ -506,6 +506,10 @@ real difference is that the capability listing is different - the only
>  possible values are 'report-status', 'report-status-v2', 'delete-refs',
>  'ofs-delta', 'atomic' and 'push-options'.
>  
> +If a "base=<oid>" Extra Parameter was sent by the client, and the
> +server recognizes that object, the server MAY send "<oid> .have" in
> +lieu of all the reference obj-ids and names.
> +

Can this only appear once, or is it permitted to pass multiple oids
this way?

I'm also curious about what Junio asked about elsewhere in the thread:
for cases that benefit from more complex negotiation than the client
proposing a particular oid, what comes next in this roadmap?  I like
that this is an optional feature so we could clean up later by
removing support for it; do we expect to?  If we do expect to, is
there anything we could do to minimize the impact of the feature later
(e.g. using a less short-and-sweet key name than `base`, maybe)?

>  Reference Update Request and Packfile Transfer
>  ----------------------------------------------
>  
> diff --git a/Documentation/technical/push-with-base.txt b/Documentation/technical/push-with-base.txt
> new file mode 100644
> index 0000000000..d56aa7f900
> --- /dev/null
> +++ b/Documentation/technical/push-with-base.txt
> @@ -0,0 +1,61 @@
> +Push with base design notes
> +===========================
> +
> +This feature allows clients, when pushing, to indicate that a
> +certain object is an ancestor of all pushed commits and that they
> +believe that the server knows of this object. This in turn allows
> +servers to send an abbreviated ref advertisement containing only that
> +object.
> +
> +Besides bandwidth savings, this also ensures that the ref
> +advertisement contains information relevant to the client. For
> +example, at least one project (Gerrit [1]) have included workarounds
> +to send ancestors of refs that move often, even though the ref
> +advertisement is only meant to contain refs.
> +
> +[1] https://gerrit.googlesource.com/gerrit/+/refs/heads/master/java/com/google/gerrit/server/git/receive/HackPushNegotiateHook.java
> +
> +
> +Design overview
> +---------------
> +
> +The "base" being sent is sent as an Extra Parameter, supported in the
> +git://, ssh://, and http(s):// protocols. By sending it as an Extra
> +Parameter, the server is aware of this parameter before it generates
> +the ref advertisement, thus making it able to tailor the ref
> +advertisement accordingly. Sending it as an Extra Parameter also makes
> +this protocol backwards-compatible, as servers will ignore any Extra
> +Parameters they do not understand. (The push will then proceed as if
> +neither party had this feature.)
> +
> +The remote helper protocol has been extended to support the
> +"push-base" capability and an option of the same name. When a remote
> +helper advertises this capability, it thus indicates that it supports
> +this option. Git then will send "option push-base" if the user
> +specifies it when invoking "git push".
> +
> +The remote-curl remote helper bundled with Git has been updated to
> +support this capability and option.

Since this is an optional remote helper capability, it could be
removed later.  Good (but the capability and option names would still
need to be reserved).

> +
> +
> +Future work
> +-----------
> +
> +In the future, we might want a way to automatically determine the base
> +instead of always having the user specify it. However, this does not
> +make obsolete any of the current work - once the base is automatically
> +determined, we still need this protocol to communicate it to the
> +server, and allowing the user to specify the base manually is still
> +useful.

Makes sense.  I think this isn't "might", but "would"; most users
that do not know why their push is slow wouldn't know to use this
feature.

> +
> +
> +Alternatives
> +------------
> +
> +- Making a more substantial protocol change like "fetch" protocol v2.
> +  This would eliminate the need for some of the remote helper updates;
> +  as part of the protocol change, the protocol could be made to
> +  support "stateless-connect" and thus no remote helper updates (like
> +  "push-base") would be needed. For "fetch", the protocol change has
> +  enabled features like wanted-refs and packfile-uris, but I do not
> +  have any similar ideas in mind for "push".

I think you're saying that we don't need a "push" v2 because v0
already has what a user would want.

Git protocol v2 for fetch brought two major changes:

- it changed the response for the initial request, allowing
  abbreviating the ref advertisement at last

- it defined a structure for requests and responses, simplifying the
  addition of later protocol improvements.  In particular, because the
  initial response is a capability advertisement, it allows changing
  the ref advertisement format more in the future.

Both of those changes would be valuable for push.  The ref
advertisements are large, and matching the structure of commands used
by fetchv2 would make debugging easier.

There are some specific applications I'm interested in after that
(e.g., pushing symrefs), but the fundamental extensibility improvement
is larger than any particular application I could think of.

That said, I'm not against experimenting with extra parameters before
we go there, as a way of getting more information about what a
workable negotiation for push looks like.  The push ref advertisement
serves two roles: it advertises commits, to serve as negotiation, and
it tells the client the current values of refs they may want to
update, so they can send an appropriate compare-and-swap command for
a force-push.  If we have a workable replacement negotiation system,
then the other role can be replaced with something simpler.  For
example:

- listing ref updates before the pack, to allow the server to bail
  out early if they would be rejected, and

- allowing an explicit force update of a ref instead of requiring the
  client to compare-and-swap if they don't care about the old value
  (but taking care to still make the client "fetch first" when
  appropriate!)

Thanks,
Jonathan

[1] https://lore.kernel.org/git/CABPp-BEswHLhymQ1_07g3qqu=7kFR3eQyAHR0qMgSvi6THy=zQ@mail.gmail.com/
