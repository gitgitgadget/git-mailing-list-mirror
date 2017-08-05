Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1183A2047F
	for <e@80x24.org>; Sat,  5 Aug 2017 00:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751988AbdHEAVm (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Aug 2017 20:21:42 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35914 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751268AbdHEAVl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2017 20:21:41 -0400
Received: by mail-pf0-f179.google.com with SMTP id c28so12678812pfe.3
        for <git@vger.kernel.org>; Fri, 04 Aug 2017 17:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NwVnZOkrs/1ez0ORj3daUoDSDA/PS/JbA4CgjMWN0C8=;
        b=vRGOGwc+ET5dFWwu9p4WUwO3HWQA3zx6c4tu8fSrGBcaRe1nguNvbLlWycbeUOHTNt
         D0IsC90Sk5AXZPmEXifp86awxXLKkHs2Pg72TI6U0Vt2DkAsU0DGEjw49bLATre3N8BO
         PEW5VX8R0UddP+LhWqLZplc9TVJocAaH9ek2oo6IlFIdyvbxkwD4e1H5OKCxGMXkygEU
         MJyne1vWaOuRJeZ1glkJ9FtUg2GfUK8g+6JQEtbIWRIE+PlyoBLcTlDKqekQZdIzdjs3
         OVw7xorygb6kez4M2DglVT3gcWMK8h9W1TZ/b658QlRpl+NeBUgzwB9iQ0QlOtr5HaOs
         JKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NwVnZOkrs/1ez0ORj3daUoDSDA/PS/JbA4CgjMWN0C8=;
        b=gnkGFrQJcZ4lyXy0jUAaLzNBEus/MyUde6+u27GT0vmn7nyQukeyBwhhdlfxSHbAqN
         RcALx0WMD4obmRuoGW0Gf29kwDDa4d5XY0KYAGvSInQ0UkszkIIBY/Iwp1TVK3GxdjoN
         ildak1d9iadUaDZjgl7kXE4OGSNA8fl4IbJ0wzvWPrPr6M4NhQNErc8dKGqSNZHuwK6W
         6XQC0cWLkjP8Ey6dS6UwWP1mVihpvCMcjpbEodWocwoZ/d7BVjflKg6Ki98RDZYZ0OvT
         Op9DjP/94DN638IgcKGZmQOU1rGf/+KEyWAPvgX3NjEloF/V64pUAHAyGF/djHNjkATg
         RW0g==
X-Gm-Message-State: AIVw111KyYOTLwDsJlwdHA3OH4NlLY2lOeJzxMwMxbu1JqHvW0nCV1SS
        iavDeC/PfhPT9nzw
X-Received: by 10.84.217.94 with SMTP id e30mr4817303plj.408.1501892501100;
        Fri, 04 Aug 2017 17:21:41 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:f576:9845:f54c:2038])
        by smtp.gmail.com with ESMTPSA id d69sm4850824pfl.142.2017.08.04.17.21.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 04 Aug 2017 17:21:40 -0700 (PDT)
Date:   Fri, 4 Aug 2017 17:21:37 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        peartben@gmail.com, christian.couder@gmail.com
Subject: Re: Partial clone design (with connectivity check for
 locally-created objects)
Message-ID: <20170804172137.42f27653@twelve2.svl.corp.google.com>
In-Reply-To: <xmqqtw1nrlpf.fsf@gitster.mtv.corp.google.com>
References: <20170804145113.5ceafafa@twelve2.svl.corp.google.com>
        <xmqqtw1nrlpf.fsf@gitster.mtv.corp.google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 04 Aug 2017 15:51:08 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > "Imported" objects must be in a packfile that has a "<pack name>.remote"
> > file with arbitrary text (similar to the ".keep" file). They come from
> > clones, fetches, and the object loader (see below).
> > ...
> > A "homegrown" object is valid if each object it references:
> >  1. is a "homegrown" object,
> >  2. is an "imported" object, or
> >  3. is referenced by an "imported" object.
> 
> Overall it captures what was discussed, and I think it is a good
> start.
> 
> I doubt you want to treat all fetches/clones the same way as the
> "lazy object" loading, though.  You may be critically rely on the
> corporate central server that will give the objects it "promised"
> when you cloned from it lazily (i.e. it may have given you a commit,
> but not its parents or objects contained in its tree--you still know
> that the parents and the tree and its contents will later be
> available and rely on that fact).  You trust that and build on top,
> so the packfile you obtained when you cloned from such a server
> should count as "imported".  But if you exchanged wip changes with
> your colleages by fetching or pushing peer-to-peer, without the
> corporate central server knowing, you would want to treat objects in
> packs (or loose objects) you obtained that way as "not imported".

That's true. I discussed this with a teammate and we might need to make
extensions.lazyObject be the name of the "corporate central server"
remote instead, and have a "loader" setting within that remote, so that
we can distinguish that objects from this server are "imported" but
objects from other servers are not.

The connectivity check shouldn't be slow in this case because fetches
are usually onto tips that we have (so we don't hit case 3).

> Also I think "imported" vs "homegrown" may be a bit misnomer; the
> idea to split objects into two camps sounds like a good idea, and
> "imported" probably is an OK name to use for the category that is a
> group of objects to which you know/trust are backed by your lazy
> loader.  But the other one does not have to be "home"-grown.
> 
> Well, the names are not that important, but I think the line between
> the two classes should not be "everything that came from clone and
> fetch is imported", which is a more important point I am trying to
> make.
> 
> Thanks.

Maybe "imported" vs "non-imported" would be better. I agree that the
objects in the non-"imported" group could still be obtained from
elsewhere.

Thanks for your comments.
