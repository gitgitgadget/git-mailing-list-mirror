Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CD851FAFB
	for <e@80x24.org>; Mon,  3 Apr 2017 21:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752335AbdDCVem (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Apr 2017 17:34:42 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:43972 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751628AbdDCVel (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 17:34:41 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id A1E3E1FAFB;
        Mon,  3 Apr 2017 21:34:40 +0000 (UTC)
Date:   Mon, 3 Apr 2017 21:34:40 +0000
From:   Eric Wong <e@80x24.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] gitperformance: add new documentation about git
 performance tuning
Message-ID: <20170403213440.GA1409@whir>
References: <20170403211644.26814-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170403211644.26814-1-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> Add a new manpage that gives an overview of how to tweak git's
> performance.
> 
> There's currently no good single resource for things a git site
> administrator might want to look into to improve performance for his
> site & his users. This unfinished documentation aims to be the first
> thing someone might want to look at when investigating ways to improve
> git performance.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> 
> I've been wanting to get something like this started for a while. It's
> obviously woefully incomplete. Pointers about what to include would be
> great & whether including something like this makes sense.

Thanks for doing this.  I hope something like this can give
server operators more confidence to host their own git servers.

> Things I have on my TODO list:

<snip>

>  - Should we be covering good practices for your repo going forward to
>    maintain good performance? E.g. don't have some huge tree all in
>    one directory (use subdirs), don't add binary (rather
>    un-delta-able) content if you can help it etc.

Yes, I think so.

I think avoiding ever growing ChangeLog-type files should also
be added to things to avoid.

> --- /dev/null
> +++ b/Documentation/gitperformance.txt
> @@ -0,0 +1,107 @@
> +giteveryday(7)

gitperformance(7)

> +Server options to help clients
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +These features can be enabled on git servers, they won't help the
> +performance of the servers themselves,

Is that true for bitmaps?  I thought they reduced CPU usage on
the server side...

A sidenote: I wonder if bitmaps should be the default for bare
repos, since bare repos are likely used on servers.

> but will help clients that need
> +to talk to those servers.
> +
> +- config: "repack.writeBitmaps=true" (see
> +  linkgit:git-config[1]). Spend more time during repack to produce
> +  bitmap index, helps clients with "fetch" & "clone" performance.
