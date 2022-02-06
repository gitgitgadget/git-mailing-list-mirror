Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534EDC433EF
	for <git@archiver.kernel.org>; Sun,  6 Feb 2022 21:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242659AbiBFVka (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Feb 2022 16:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbiBFVk3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Feb 2022 16:40:29 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9FEC06173B
        for <git@vger.kernel.org>; Sun,  6 Feb 2022 13:40:28 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id h7so36489170ejf.1
        for <git@vger.kernel.org>; Sun, 06 Feb 2022 13:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lGqZH3dH/+16/+hqLC7k517LBa6T97vbm3aks93KyGk=;
        b=V8+VufkSD7fqXJE3NCgnFJLXgtXijn5z1aDugtjrpOyGfMfDHs3Au4jdusW2lvLGO9
         K3o/H/NsrgwDKg6qN2yj/EcwV66uSbWBfk1JUnA7RtaSyrcaduOlgeRXuZc1wIsjrHwx
         bgpXNgEGJmV2BUEvOmTlKRjkYe+WD4uTfNaw6uWszoZC0IB4inXN25tu+n+YKkSGqrv2
         HaNjAB1K83miqP5u3yra2G488cVz/PnmtNGbOanKf7/ryBqMnh2QJRQ33+GCZT2c4ADz
         LaCJMY092tNbqWWK3vorgM5n9gCG+PzhUqRnsDnb+aasNXjv10CS9e7wsv3MIi9sKore
         Kg8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lGqZH3dH/+16/+hqLC7k517LBa6T97vbm3aks93KyGk=;
        b=yl/GHhL4AqWz4PDVyekeK6BhvOULILkRxxi+nHgoQ3gyJ42jIdCwL18CW08Q4xeGQY
         erFmtYFFchUGYN5iL3BeqlRP4PUH4gRjfikqg0L1iPabFZckfUXYl6sCIh03afPIckG9
         DYbceJGZtpXPvYRBbMk+x9C9iWYkAvogelDZuVDKvHyC/5kNBeq7LNSDj95n2Sqadc/D
         iwjKjRjzQ9NckU9DeKBFOyen12SMPq0PTua1qslTw7uOz6Z2zKkOWRRdht1dvP4++vbI
         IK/7W2+bNdY1S4F6LuHAA5x4J0Hn9gfgegsOIRoic5mHO56AoYHa5gznLf6tG1Pj8AWG
         /VVw==
X-Gm-Message-State: AOAM5301JJFg2zSXRw55AQ3UzDYJ7UVf6lafkjqP/X1TjrffVmVI6DI3
        gUMna12SVeU0cSCtxDiiXo8=
X-Google-Smtp-Source: ABdhPJzAddokAuNdpv9kjWk/27CauhdaLYbkSsFq3BBH5GItpYUSeB0H8YNve5mWwXmplKr7kGDQxQ==
X-Received: by 2002:a17:907:e9f:: with SMTP id ho31mr7563812ejc.646.1644183627404;
        Sun, 06 Feb 2022 13:40:27 -0800 (PST)
Received: from szeder.dev (94-21-146-211.pool.digikabel.hu. [94.21.146.211])
        by smtp.gmail.com with ESMTPSA id qb30sm2941169ejc.27.2022.02.06.13.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 13:40:26 -0800 (PST)
Date:   Sun, 6 Feb 2022 22:40:24 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 1/2] t1510: remove need for "test_untraceable", retain
 coverage
Message-ID: <20220206214024.GC1936@szeder.dev>
References: <patch-1.1-9f735bd0d49-20211129T200950Z-avarab@gmail.com>
 <cover-v2-0.2-00000000000-20211201T200801Z-avarab@gmail.com>
 <patch-v2-1.2-91402624777-20211201T200801Z-avarab@gmail.com>
 <20211202191635.GB1991@szeder.dev>
 <YbMiK1wHzBfYvK2a@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YbMiK1wHzBfYvK2a@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 10, 2021 at 04:47:23AM -0500, Jeff King wrote:
> On Thu, Dec 02, 2021 at 08:16:35PM +0100, SZEDER Gábor wrote:
> 
> > > @@ -62,7 +59,7 @@ test_repo () {
> > >  			export GIT_WORK_TREE
> > >  		fi &&
> > >  		rm -f trace &&
> > > -		GIT_TRACE_SETUP="$(pwd)/trace" git symbolic-ref HEAD >/dev/null &&
> > > +		GIT_TRACE_SETUP="$(pwd)/trace" git symbolic-ref HEAD >/dev/null 2>>stderr &&
> > 
> > I suspect that it's lines like this that make Peff argue for
> > BASH_XTRACEFD :)
> > 
> > While this is not a compound command, it does contain a command
> > substitution, and the trace generated when executing the command in
> > that command substitution goes to the command's stderr, and then,
> > because of the redirection, to the 'stderr' file.
> 
> Better still, the behavior varies between shells:

Indeed, although POSIX seems to be quite clear about what should
happen in this case: the specs for simple commands [1] state that
redirections should be performed before variable assignments are
expanded for, among other things, command substitution.

>   $ bash -c 'set -x; FOO=$(echo foo) echo main >stdout 2>stderr; set +x; grep . stdout stderr'
>   ++ echo foo
>   + FOO=foo
>   + echo main
>   + set +x
>   stdout:main
> 
>   $ dash -c 'set -x; FOO=$(echo foo) echo main >stdout 2>stderr; set +x; grep . stdout stderr'
>   + FOO=foo echo main
>   + set +x
>   stdout:main
>   stderr:+ echo foo

So in case of these commands the shell should first redirect stdout
and stderr, then expand the command substitution, thus it should write
the trace for the 'echo foo' within to stderr _while_ stderr is
redirected.  It seems that dash, for once, does conform to POSIX.

Although the standard-conform behavior is potentially more problematic
for us, because it would cause test failure with tracing enabled when
used like this:

  GIT_TRACE="$(pwd)/trace" git cmd --opts 2>actual.err &&
  test_cmp expected.err actual.err

because the "+ pwd" trace output from the command substitution would
go to 'err.actual'; 9b2ac68f27 (t5526: use $TRASH_DIRECTORY to specify
the path of GIT_TRACE log file, 2018-02-24) fixed a case like this.


[1] https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_09_01

