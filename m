Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A90AC433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 09:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238907AbiBQJ4U (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 04:56:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238911AbiBQJ4T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 04:56:19 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64B51738FD
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 01:56:04 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id d10so5834382eje.10
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 01:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=mH/WH616DswFcMEgVCLTVXT9KyGOZg6SaL70Mfa0mVQ=;
        b=m1hz2TI54zEBNUEZnJtJP0Syd3yghnw/n0iPBschhkA5HHdpwHJyNPJxfca8zXhVDp
         KZ7fe//oZuGD6DXiT9lqKFUf7hWWE9ixlhPz8tgGKD985wXPS9nwn3kzke6oCF/nlhpA
         LFgxoPU91KzvNT6U0Ui921rgBGs5uAm1D1JKKl2WxvH9kFQqdBHhff2aa/gYT+0TAVWc
         bzKy+cqgrTrGlTmEFRg2dcFLXDlSwZXZ/dmYgysNHzUnqEqVYKIrspOxF6IovEhLa21A
         3ReAOJbkvNJZyFw++nqfYvWZTXWhjNYYjsG5s2I5bGgZRba+9h6m5mKwwLJknKmpxd+p
         xd8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=mH/WH616DswFcMEgVCLTVXT9KyGOZg6SaL70Mfa0mVQ=;
        b=wGntB9JzftrGdLekg0hbuc3IHAdj5IP/FJXnXbyOfj2q5OLQan4D0n/q8OOfgBY90d
         iTfoLZBeh3XWRSc0sP4pk/lRYEnaa5nSWfi61svN9mkpZBv2re8Xu2aGoa/T/9vpg1SK
         0cRKzbOV7yauNVmugE77sBfDtn58IuXDoEzJwkkrcIYwF12AAO62yWqoGhachYFg50Uo
         efdyY/DjIWNG97dhHHDboWv4z8JFfms82wmwZIkCilaOUAsTbA1Q+hli2Lmhqm5If+W6
         c9lJrTYlUNSp0/bZwEE/ZBPDZY6+XzlZfdSB6kqqEjmpbYe/ls0hn8mKsriEX134Or14
         dYog==
X-Gm-Message-State: AOAM533QGxKEeir+eLbEcavnw649mqcr8qDwWM9HjH7rNoj9zlTScsgX
        wHkmt8vef4gbMcXsHYSPBg9VIPB9IkcOJw==
X-Google-Smtp-Source: ABdhPJxjJghsenwOg0qnVavDRcFVvw9drH19zcTXHZnH3DPsE5fIWCrlUPiuitiYB/jajKP5mIpkRQ==
X-Received: by 2002:a17:906:2bd7:b0:6ce:698b:7531 with SMTP id n23-20020a1709062bd700b006ce698b7531mr1625765ejg.146.1645091762993;
        Thu, 17 Feb 2022 01:56:02 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id t21sm3169987edd.74.2022.02.17.01.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 01:56:02 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nKdW5-003h8R-Op;
        Thu, 17 Feb 2022 10:56:01 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Edward Thomson <ethomson@edwardthomson.com>
Cc:     "Git ML" <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] xdiff: provide indirection to git functions
Date:   Thu, 17 Feb 2022 10:29:23 +0100
References: <20220209012951.GA7@abe733c6e288>
 <20220209013354.GB7@abe733c6e288>
 <220216.86wnhvvgeh.gmgdl@evledraar.gmail.com>
 <7e6385f8-f25d-69f5-edae-6f5d6f785046@gmail.com>
 <220216.86leybszht.gmgdl@evledraar.gmail.com>
 <20220217012847.GA8@e5e602f6ad40>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220217012847.GA8@e5e602f6ad40>
Message-ID: <220217.86ee41izpq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 17 2022, Edward Thomson wrote:

[I'm assuming that dropping the list from CC was a mistake, re-CC-ing]

> On Wed, Feb 16, 2022 at 02:27:27PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>=20
>> This is current libgit2, which seems to have a version of this patch
>> integrated:
>>=20=20=20=20=20
>>     $ git reference; git -P grep '\bfree\(' src/xdiff
>>     c8450561d (Merge pull request #6216 from libgit2/ethomson/readme, 20=
22-02-13)
>>     src/xdiff/xmerge.c:             free(c);
>>     src/xdiff/xmerge.c:     free(next_m);
>
> Yikes!  A buggy version, in fact.  More on that in a moment.
>
>> I.e. I think instead of having xdl_free(), xdl_regcomp() etc. it makes
>> sense to just slowly go in the other direction and call free(),
>> regcomp() etc. Since it seems we're going to be maintaining an xdiff
>> fork permanently.
>
> Right, and that's explicitly what doesn't work for libgit2, and the goal
> of an abstraction layer that we can both use.  git uses `xmalloc` (for
> example), while libgit2 uses `git__alloc` to allocate memory.  This
> seems sensible enough to replace, but there's not a 1:1 mapping in our
> APIs because git lacks an `xfree`.
>
> If it were just a matter of `#define xmalloc git__alloc` then that might
> be a reasonable strategy for libgit2 to take for code re-use.  But
> `git__alloc` isn't necessarily just a wrapper around `malloc`, it's a
> pluggable allocator that a library user can supply.  So we can't call
> our allocator (`git__alloc`) and then the system's `free` because that
> will most certainly fail.  We supply a `git__free` for this reason.
>
> (I appreciate you pointing out that I missed this in our update to
> libgit2!  The ruby bindings make use of their own allocator and we can
> ship a patch before they update.)

Yes. I understand. I'm saying that for the purposes of a "free()" in the
text of the xdiff code you can have your cake and eat it too. You just
need to adjust the compilation of xdiff within libgit2 so that it
e.g. defines free() to git__free() or whatever before that code is
included, or to do the same at link-time.

The reason I pointed at the PCRE commits in git.git is that's exactly
what we ended up doing by accident with nedmalloc + PCRE. I.e. because
we use free() and malloc() we ended up with nedmalloc due to that shim,
but would then link to libpcre2 which would use the system malloc (not
compiled with those shims).

Since in this case we're talking about someone importing libgit2 into
their tree all of malloc() and free() can end up in the right place for
you.

>>=20
>> >> Of course trivial wrappers would be needed for x*() variants...
>> >>=20
>> >>> +#define xdl_regex_t regex_t
>> >> This is a type that's in POSIX. Why do we need an xdl_* prefix for
>> >> it?
>
> Precisely because it's a type in POSIX.  libgit2 doesn't necessarily
> build on POSIX systems, and a user could - again - supply their own
> regex engine like PCRE even if they do have the POSIX regex engine
> available on their installations.

Sure, but these renames aren't needed for that. In fact PCRE ships with
a POSIX shimmy layer which makes my point for me. See pcre2posix(3),
i.e. it'll redefine regcomp(), regexec(), regex_t etc.

So you're saying you need to renaming so you can get X, but
pcre2posix(3) is a working demonstration of X without that step :)

In this case though we do need the regexec_buf() semantics, but the
right thing to do for xdiff/* compatibility is to just split off the
trivial regexec_buf() shim in git-compat-util.h say a
compat/regexec_buf.c for your convenience, then you could import that
along with xdiff/*.

I haven't checked if pcre2posix supports that non-portable
*BSD-originated trickery in regexec_buf() to make the pmatch variables
carry the length (if not it would be trivial to make it do so), but
everything else above would be easy

> libgit2 could - I suppose - do some magic to ensure that we call it a
> `regex_t` even when it's a `pcre *`.  But any new person to our codebase
> would (rightly) expect a `regex_t` to be ... well, a `regex_t` and might
> (again, rightly) expect to find a `re_nsub` on it.  Hell, even I would
> expect this because I don't interact with the regex code on the regular.

I think if you're expecting shimmying layers for POSIX regexen to be in
play that people would expect it to work like pcre2posix(3). I.e. you
use the POSIX API but drop in a shim for a non-libc implementation.

As for the "new person to our codebase..." I don't think you're wrong
there, but that's an asthetic preference, not something that's required
for the stated aims of this series of dropping in compatibility shims.

The reason I started commenting here was because I was surprised that
this was needed at all for libgit2, since we do exactly that sort of
shimming without the renaming here.

>> We're just talking about sharing code with libgit2, which I agree with
>> as a goal. I just don't see why we'd need to have e.g. XDL_BUG() as
>> opposed to libgit2 just providing a BUG() for its compatibility with our
>> xdiff.
>
> I care very little about `BUG`, but I care very much about allocation
> and regex abstraction.  But now it makes more sense to me to have a
> common prefix for the abstraction rather than piecemeal.
>
> I'll supply a re-roll with the issues that you and Philip pointed out
> and I'm certain that we will continue the discussion.

For the asthetic preference?

If it's XDL_BUG() the primary project (git.git) needs to carry the
XDL_BUG() -> BUG() shim along with libgit2's XDL_BUG() ->
GIT_ASSERT(msg) .

If it's just BUG() we don't need the shim in git.git, but you'll need a
BUG() -> GIT_ASSERT(msg).

I don't see the benefit of requiring two shims instead of one, both in
terms of code, and the readability of the codebase in git.git
(i.e. grepping for "git grep -w BUG" or whatever, then remembering it's
prefixing everything...).

