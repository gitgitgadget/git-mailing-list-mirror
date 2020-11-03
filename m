Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1840C2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 13:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 551AC21D91
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 13:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RC73QJoB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbgKCNyX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 08:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729421AbgKCNxK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 08:53:10 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED02DC0613D1
        for <git@vger.kernel.org>; Tue,  3 Nov 2020 05:53:09 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id h12so11569890qtc.9
        for <git@vger.kernel.org>; Tue, 03 Nov 2020 05:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=u6nUCbZAiJMTxmdJ7AdhXUP75hkVVIXd0t+5aKgP+W0=;
        b=RC73QJoBh2RAD/FCe6EVDhJBdz4LlQkF21eBJxZ5hJNmoIZC+SRX/ErbNNiZsm9QER
         Qii6RVKqY4XtSPnCWMg4bLSw66e+M5sbqNW8dFxZX0XxFCZvqI1uYme/cYi5d+DxDLgn
         1roaEhKflbLqliSZbdSmlZuUVRMpsX//PYo8FBoz2fgKxvF8MXzms72dBkno3uqZjSWk
         6smD4pdhugKwCZBtz8IBjAzYdccZR8WTrEWdGG99E7U9w/1hZoqgf+1aQ1V3u2FR6Md/
         7SrCfy6jdOELSmIYy6COdr+FTVmxMuH41S/tQb10mrOxRZo7eaGyDs754QPZaWVwdpL5
         X4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u6nUCbZAiJMTxmdJ7AdhXUP75hkVVIXd0t+5aKgP+W0=;
        b=OVGb4NL9aMDr2v7irkquc4v7PppcTKsPLbPTgyO1LbHQW4Z2skDu0SDtXhd7qI+ihd
         IS4d4OcG/KiB/Ba95NLi9zas2P0YYvJs9B80Cm6fVzT1Ib9LF2FRlEikcj2zVAB4DqCc
         RPLG0+zUg2OwcH88rKhUq5tj2GaNvUTW2Qa8OEJiNCXa3Ae/N2NtJPaabj1R+1SI2Hlz
         oT8QL1IKFP2nYLU32Wo0NFye2D7/Q1emnlr7KqoSu2xqi1bRpOEQw049NPJpdANRTdSK
         LT8S9EoUX0FkvP86fAJAwTCw2TlalrhwP0NjeJB/FgdN4deQetxrn1g/0A/PaLy8UEet
         FO6Q==
X-Gm-Message-State: AOAM530ORsf6kSiCsfpBTMAYHuZBYl/vt44eMdszjKYTdMRLNF6H//Zg
        o87LqRXPNpUOhz2tEKepr7X0hJ0dVfuGOQ==
X-Google-Smtp-Source: ABdhPJyK7YxCtxTJMaQM2mvllJWnQpmH7Mfwe+ROq+1bjaCCCdfed/3dI5ZfdGNKwbmXlKaOLJAibA==
X-Received: by 2002:ac8:1289:: with SMTP id y9mr17982164qti.330.1604411588746;
        Tue, 03 Nov 2020 05:53:08 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id z26sm9983112qki.40.2020.11.03.05.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 05:53:08 -0800 (PST)
Subject: Re: [PATCH 4/4] Doc: push with --base
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <cover.1604362701.git.jonathantanmy@google.com>
 <6250c13897e3cc01f247d80c148cf8dc5e7f3ad0.1604362701.git.jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ee98ed69-dc49-af18-71e3-7c6168b5a464@gmail.com>
Date:   Tue, 3 Nov 2020 08:53:06 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <6250c13897e3cc01f247d80c148cf8dc5e7f3ad0.1604362701.git.jonathantanmy@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/2/2020 7:26 PM, Jonathan Tan wrote:
> Includes protocol documentation and a design document.

>  Servers that receive any such Extra Parameters MUST ignore all
> -unrecognized keys. Currently, the only Extra Parameter recognized is
> -"version" with a value of '1' or '2'.  See protocol-v2.txt for more
> -information on protocol version 2.
> +unrecognized keys. Currently, the only Extra Parameters recognized are
> +"version" with a value of '1' or '2' and, for push, "base" with an OID.  See
> +protocol-v2.txt for more information on protocol version 2.
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

nit: no comma before "and the server recognizes" as these are both
conditions of the "if". My preference is also to include a "then"
before the result, especially with compound conditions like this.
Perhaps also make it more active voice while we are here?

+ If the client sent a "base=<oid>" Extra Parameter and the server
+ recognizes that object, then the server MAY send "<oid> .have" in
+ lieu of all the reference object ids and names.

> +Push with base design notes
> +===========================

Perhaps start with a brief problem statement?

+ If a client wishes to push data to a server without first running
+ `git fetch`, then they might not have local copies of the objects
+ at the server's ref tips. The client cannot compute an adequate
+ common base and will send more objects than necessary.

Then,

+ The "push with base" feature allows...

> +This feature allows clients, when pushing, to indicate that a
> +certain object is an ancestor of all pushed commits and that they
> +believe that the server knows of this object. This in turn allows
> +servers to send an abbreviated ref advertisement containing only that
> +object.

Why only one base? Could there be value in sending multiple possible
bases and the server can report the subset that they know about?

> +Besides bandwidth savings,

It seems you are underselling the bandwidth savings here, because
we save in both the ref advertisement and the push pack size. It
might be good to call out both metrics so we can see that the ref
improvement works even for cases where the client recently fetched
and can figure out the proper base on its own!

> this also ensures that the ref
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

I'm not familiar enough with the extra parameter logic to know if we
allow multi-valued extra parameters. It would be good to relax the
"base" parameter to either allow multiple instances of the parameter
or to have something like a comma-separated list of OIDs be allowed.

This might be particularly important for multiple refs being pushed
at the same time.

> +The remote helper protocol has been extended to support the
> +"push-base" capability and an option of the same name. When a remote
> +helper advertises this capability, it thus indicates that it supports
> +this option. Git then will send "option push-base" if the user
> +specifies it when invoking "git push".
> +
> +The remote-curl remote helper bundled with Git has been updated to
> +support this capability and option.> +
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

It is appropriate to separate the protocol ability from the automatic
computation on the client. It would be nice to know how you expect that
to work.

For the single-ref push case, my default instinct would be to find a
merge-base between that ref and all of the remote refs matching the
remote we are pushing to. Bonus points if we find _all_ (maximal)
merge-bases!

The equivalent for the multi-ref push might be to find the boundary
commits from something like the following command:

	git rev-list --boundary \
		--not refs/remotes/origin/A \
		--not refs/remotes/origin/B \
		--not refs/remotes/origin/C \
		refs/heads/toPush/1 \
		refs/heads/toPush/2 \
		refs/heads/toPush/3

But you might have something better in mind.

> +
> +
> +Alternatives
> +------------

Odd to have a single bullet in a bulleted list.

> +- Making a more substantial protocol change like "fetch" protocol v2.

This isn't a full sentence.

Perhaps: "One considered approach was to introduce a multi-phase
negotiation step similar to how 'git fetch' operates."

> +  This would eliminate the need for some of the remote helper updates;
> +  as part of the protocol change, the protocol could be made to
> +  support "stateless-connect" and thus no remote helper updates (like
> +  "push-base") would be needed. For "fetch", the protocol change has
> +  enabled features like wanted-refs and packfile-uris, but I do not
> +  have any similar ideas in mind for "push".

I think that you should mention that a negotiation phase here would
use significantly more bandwidth to do the ref advertisements on both
ends with only a rare case that the negotiated bases are better than
the locally-computed bases. Everything is about tradeoffs here!

I'm generally excited about the opportunities here. I'd love to see
some measurements for reduced ref advertisements and reduced object
counts in the pushed pack.

Thanks,
-Stolee
