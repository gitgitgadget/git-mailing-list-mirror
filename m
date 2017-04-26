Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AAF9207D6
	for <e@80x24.org>; Wed, 26 Apr 2017 08:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1955971AbdDZI45 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 04:56:57 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:34721 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1955961AbdDZI4x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 04:56:53 -0400
Received: by mail-oi0-f45.google.com with SMTP id x184so202186027oia.1
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 01:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YGsYYGtlBptcI4GXbgV7YPhbUs0ykcOS+gnivVRUJfk=;
        b=cm9oZTyGpVXMigZBc4d9htmWz5FDLpuAzNOC16vPMk4B49yrUcJj+7GozYmbC2KTC0
         gD3exj6Pvq0pzZ05hKxxdlEbS++YsIpc+B8HaXqIqlbNuy3458HBpLh72ZIfBdTm5y63
         /LNrqO+HzoLbuMD2wUiNhPybPxgG7nRf74UupdH5A7X4OVzyyKX9aJuC9qbvsyAPUcac
         KLRzzUIIRYvsk8uCiLBh7ml8Tfm6yHbUqxLYSBbVhNC6sN9qLGP9x8dPLDgK+utmKzZB
         iisvd/W5ayE42M2AU0PuXs50rXeDCkBG0OpXBcsDoJj4yy6N9lG7jKsb24+SRVlkJViq
         O6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YGsYYGtlBptcI4GXbgV7YPhbUs0ykcOS+gnivVRUJfk=;
        b=GmsYp6zGo72oYjhSei7UaBJZy0hz1qBxhHED+AXC1h2oNZPFLbb2/KvbjTld5NVbGk
         VsNT+N5jYkN4Iv9DNJXYXgRt57ClKQVliaU2v2viRnGJqzha5+bVTnvKX/EZ132Ud/z+
         BSGuNGWHbfuqcUd07AVF8T5Suj8kk2fC8RU0wWpiD2CD769L36M1h0AoHryNWsCFx30+
         k3SR4u1Oy6BqeFSwekDP4zb/p+WqLK7AtRh1t0f0TkGWoHSLiWfI/suMlMANWrfPb6Fd
         02Z0XM4oH4tuXJWeF+U9k2/K6ZTTBP6m4ELITeGvAshrziZEwTTP2pqj4btayoG/ua6s
         VS5w==
X-Gm-Message-State: AN3rC/51qPbt7I1OCRVBZtjFbff7m1ylqBjR56bvJcArQBcin1Qy8bur
        rYJOz6ayQLkouIYneNy2Zx1VXJJGBg==
X-Received: by 10.157.29.235 with SMTP id w40mr8016641otw.128.1493197012901;
 Wed, 26 Apr 2017 01:56:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Wed, 26 Apr 2017 01:56:22 -0700 (PDT)
In-Reply-To: <CACBZZX5u5fF4fJBJ3CwH0DmLBw4D32jN5o=Om-iqwQdPG93DFg@mail.gmail.com>
References: <CACBZZX5u5fF4fJBJ3CwH0DmLBw4D32jN5o=Om-iqwQdPG93DFg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 26 Apr 2017 15:56:22 +0700
Message-ID: <CACsJy8Ct4VU0XAgJruFECEVxb98MS4P+9Z6D8ag35ySL6OY-0g@mail.gmail.com>
Subject: Re: BUG: wildmatches like foo/**/**/bar don't match properly due to
 internal optimizations
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 26, 2017 at 2:13 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Thought I'd just start another thread for this rather than tack it
> onto the pathalogical case thread.
>
> In commit 4c251e5cb5 ("wildmatch: make /**/ match zero or more
> directories", 2012-10-15) Duy added support for ** in globs.
>
> One test-case for this is:
>
>     match 1 0 'foo/baz/bar' 'foo/**/**/bar'
>
> I.e. foo/**/**/bar matches foo/baz/bar. However due to some
> pre-pruning we do in pathspec/ls-tree we can't ever match it, because
> the first thing we do is peel the first part of the path/pattern off,
> i.e. foo/, and then match baz/bar against **/**/bar.

Yeah. I think the prefix compare trick predated wildmatch. When I
introduced positional wildcards "**/" I failed to spot this. Good
catch.

Ideally this sort of optimization should be contained within wildmatch
(or whatever matching engine we'll be using). It also opens up more
opportunity (like precompile pattern mentioned elsewhere in this
thread).

You need to be careful though, when we do case-insensitive matching,
sometimes we want to match the prefix case _sensitively_ instead. So
we need to pass the "prefix" info in some cases to the matching
engine.

I guess time is now ripe (i.e. somebody volunteers to work on this ;-)
to improve wildmatch. "improve" can also be "rewriting to pcre" if we
really want that route, which I have no opinion because I don't know
pcre availability on other (some obscure) platforms.
--=20
Duy
