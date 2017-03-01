Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB4B32023D
	for <e@80x24.org>; Wed,  1 Mar 2017 20:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751902AbdCAUWH (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 15:22:07 -0500
Received: from mail-io0-f169.google.com ([209.85.223.169]:34992 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbdCAUWG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 15:22:06 -0500
Received: by mail-io0-f169.google.com with SMTP id j18so39319751ioe.2
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 12:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=WrIiafcWbP7CunbiRcVw4PiYoVeXe7n3Gn7EVOqYcho=;
        b=S9nw26yWAonLvZIqDbSpLBvYhN45d+Vw7cRQS+ofxKmaLqi1ByBIGhjkcuAafIVSLy
         VRa5x/VrjxfBstdURkzLujBphVYCtmKR34W2xrGCpndOlypWUZEyEXmk+yr1H/nxwVOf
         29CxyiQCS3j6YBJBWMbpnjF2/ieS+nm4DteLp7dASlKLpT8SgfOu8XEbRvuWoQHETQ0q
         l6qNSGBBaNJdmuDv1TKBhqoquajFdcW8zjIUFDz/SeroRBA4OIOIkJvN4Pa1oAZhpBBh
         Zb3S1G81fPOnRaTDeutrqDS/3Ul0FzdjtQHGJD9vs0NqCLOsHZyiqGgHyuxAKpfslxYP
         4+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=WrIiafcWbP7CunbiRcVw4PiYoVeXe7n3Gn7EVOqYcho=;
        b=Hr1oqFHh9WXSl16w908ttqu2qaVnJCpmiiQHnHaFX0fAJ3DflNpIEM19o79xA8Flhx
         uXG276tp/CUGHKPZYDLGgc6e0uxs3CBmEZkcPBm/rQd2zorJeT/HjHKiH6RDD9isDASO
         T7MFSEJX6uCMH6V80FsoeN5IlH+LshAg84yuobnKQ0s5LED9gfoiVLR7LLriaPd9qBbA
         tBFCU9csTqltjml4ehQEKtlNqfyumh3WDmh8Iu59p+HNbADw4gCpKxkghWjZXvHndnjF
         cDxs7Vqjtnlj3pSapJ3UxfyAmPU9ZsnwVvPr1fIAfncYVwGxSawdSiFI6gHfLpK5C+vk
         8Wfw==
X-Gm-Message-State: AMke39l6s6HxAm4WxxTqqIJhQ+0NOHHe2fScgfkZRKiw+gzA+0nW3R44VpWhH2G60KhKhsOXKLu8tSbvZe4mMA==
X-Received: by 10.107.178.3 with SMTP id b3mr9603962iof.50.1488393058231; Wed,
 01 Mar 2017 10:30:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.146.131 with HTTP; Wed, 1 Mar 2017 10:30:57 -0800 (PST)
In-Reply-To: <eba83461-34cf-6d64-4013-873b04af9b82@gmail.com>
References: <4d2a1852-8c84-2869-78ad-3c863f6dcaf7@gmail.com>
 <CA+55aFzQ0o2R2kShS=AuKu0TLnfPV-0JCkViqx5J_afCK0Yt5g@mail.gmail.com> <eba83461-34cf-6d64-4013-873b04af9b82@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Mar 2017 10:30:57 -0800
X-Google-Sender-Auth: rxhFhlzW92IgZ5mV0i_OxJT7gIc
Message-ID: <CA+55aFx7QFqrHw4e72vOdM5z0rw1CCkL2-UX8ej5CLSBWjLNLA@mail.gmail.com>
Subject: Re: Delta compression not so effective
To:     Marius Storm-Olsen <mstormo@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 1, 2017 at 9:57 AM, Marius Storm-Olsen <mstormo@gmail.com> wrote:
>
> Indeed, I did do a
>     -c pack.threads=20 --window-memory=6g
> to 'git repack', since the machine is a 20-core (40 threads) machine with
> 126GB of RAM.
>
> So I guess with these sized objects, even at 6GB per thread, it's not enough
> to get a big enough Window for proper delta-packing?

Hmm. The 6GB window should be plenty good enough, unless your blobs
are in the gigabyte range too.

> This repo took >14hr to repack on 20 threads though ("compression" step was
> very fast, but stuck 95% of the time in "writing objects"), so I can only
> imagine how long a pack.threads=1 will take :)

Actually, it's usually the compression phase that should be slow - but
if something is limiting finding deltas (so that we abort early), then
that would certainly tend to speed up compression.

The "writing objects" phase should be mainly about the actual IO.
Which should be much faster *if* you actually find deltas.

> But arent't the blobs sorted by some metric for reasonable delta-pack
> locality, so even with a 6GB window it should have seen ~25 similar objects
> to deltify against?

Yes they are. The sorting for delta packing tries to make sure that
the window is effective. However, the sorting is also just a
heuristic, and it may well be that your repository layout ends up
screwing up the sorting, so that the windows just work very badly.

For example, the sorting code thinks that objects with the same name
across the history are good sources of deltas. But it may be that for
your case, the binary blobs that you have don't tend to actually
change in the history, so that heuristic doesn't end up doing
anything.

The sorting does use the size and the type too, but the "filename
hash" (which isn't really a hash, it's something nasty to give
reasonable results for the case where files get renamed) is the main
sort key.

So you might well want to look at the sorting code too. If filenames
(particularly the end of filenames) for the blobs aren't good hints
for the sorting code, that sort might end up spreading all the blobs
out rather than sort them by size.

And again, if that happens, the "can I delta these two objects" code
will notice that the size of the objects are wildly different and
won't even bother trying. Which speeds up the "compressing" phase, of
course, but then because you don't get any good deltas, the "writing
out" phase sucks donkey balls because it does zlib compression on big
objects and writes them out to disk.

So there are certainly multiple possible reasons for the deltification
to not work well for you.

Hos sensitive is your material? Could you make a smaller repo with
some of the blobs that still show the symptoms? I don't think I want
to download 206GB of data even if my internet access is good.

                    Linus
