Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=5.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1119B1FE4C
	for <e@80x24.org>; Thu, 16 Jun 2016 19:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754091AbcFPTsN (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 15:48:13 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:34748 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931AbcFPTsN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 15:48:13 -0400
Received: by mail-qg0-f48.google.com with SMTP id k6so31509944qgk.1
        for <git@vger.kernel.org>; Thu, 16 Jun 2016 12:48:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RiI8FKyvWRrpB75JWwvNjYfJhZnka2mHMhl+ikdJI5I=;
        b=GjEC3jbmPmvdukbidNbUGcp4gXC/EIWBFgZsas3OqcAI3w0gM/GL7kgtHt0NihAVHz
         11+yldIa4GnAJpmYA8aJMJinr0nz9QYUkZXcW41OfuIGO2XaMp0+L0V91ApROfNGeOLf
         OlT/ZIMLAeNx0dAAN3RcqVeRz740Qyoxi90cNwRmlAji5ncWquY6Qdk7280trqUmUWbX
         KB4pHMwNIkMnU96bKJbqi7oofNalswu/xD6mDiE9/7jx5p3yv+pGAhl2P9K9UPfTfw+h
         mAGv6etiQWeTx0QFIyIVmVblP2R2QozVXRTP9WPIJTtDSC394thoJyw9WeaOcDadoRxp
         xw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RiI8FKyvWRrpB75JWwvNjYfJhZnka2mHMhl+ikdJI5I=;
        b=DHPm5r5vmmnqudIK5yz9ItEFFNzExqAFgBfwAIvLzEauXyQlMi6gQCVK/wBMYcFhTe
         f3H8MojXGlVGupi0YOJECk99aYRlAppyLavQIt+gWhyvngUtDEXe7ASTpoaafpnA20mw
         hOKAyaH56EjVlbGx0MqjqqLdyN27Q01VjTWX5d200qmR8D7Cf/GWonHfue0SVE5UEjeL
         RpyBGRuOYUZh7baOhkVuA7trBrLUOWhLZHOOhvkYvb+ZOJC3glEI8GGaAovZs1abNxcz
         jDrOiHjLnhEnwpLN0M1bn2m8X3sX7r6bwaeVM+6uFHAmwnEepVnDbyU0HcLxsofPspId
         ypkA==
X-Gm-Message-State: ALyK8tJ8B4/yWDyX4UADQWiCVyu0PV9z04Y4sRc1IA1T6tUECEe5kM+pPc059S2/qS1l1mnPQxrb2RwyVn76ojY5
X-Received: by 10.140.92.116 with SMTP id a107mr6585311qge.88.1466106491734;
 Thu, 16 Jun 2016 12:48:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.42.226 with HTTP; Thu, 16 Jun 2016 12:48:11 -0700 (PDT)
In-Reply-To: <xmqqbn31581d.fsf@gitster.mtv.corp.google.com>
References: <CAFOYHZDw-P0ST8WKoSVxBpbFCiACZpgiDPMfw5MRtFTMosO0rg@mail.gmail.com>
 <CAFOYHZArnE6vJ0U1zJAxytCBJJU5M-VtHbct6Qq4VPfw7-T-2A@mail.gmail.com> <xmqqbn31581d.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Thu, 16 Jun 2016 12:48:11 -0700
Message-ID: <CAGZ79kZaZCwZ-cesB_voq0s0Qt+ipcgb6TkdzLE+EWSF_qRj7A@mail.gmail.com>
Subject: Re: [bug] assertion in 2.8.4 triggering on old-ish worktree
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Chris Packham <judge.packham@gmail.com>, GIT <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 16, 2016 at 10:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Chris Packham <judge.packham@gmail.com> writes:
>
>> On Thu, Jun 16, 2016 at 4:59 PM, Chris Packham <judge.packham@gmail.com> wrote:
>>> Hi All,
>>>
>>> I have the git-sh-prompt configured in my .bashrc today I visited an
>>> old worktree that I haven't really touched in a few years (sorry can't
>>> remember the git version I was using back then). I received the
>>> following output when changing to the directory
>>>
>>> git: pathspec.c:317: prefix_pathspec: Assertion `item->nowildcard_len
>>> <= item->len && item->prefix <= item->len' failed.
>>>
>>> I assume it's one of the git invocations in git-sh-prompt that's
>>> hitting the assertion. Any thoughts on what might be triggering it?
>>> Any debug I can gather?
>>
>> A bit more info. The directory in question is a uninitialised
>> submodule. It doesn't trigger in the root of the parent project.
>
>
> Sounds like
> http://article.gmane.org/gmane.comp.version-control.git/283549
>

I looked into this. In pathspec.c#prefix_pathspec (the function
that has this assertion at the end), the assertion can only
trigger if PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE
or PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP was given
as these are the only places that reduce item->len.

I converted the example test case to follow our test syntax
(module tab/whitespace issues):

test_expect_success 'remove submodule and add its files' '
    mkdir test &&
    (
        cd test &&
        git init sub &&
        (
            cd sub &&
            touch foo &&
            git add foo &&
            git commit -m "foo"
        ) &&
        git init &&
        git add sub &&
        rm -rf sub/.git &&
        (
            cd sub &&
            git add .
        )
    )
'

And the issue here is that the submodule $GIT_DIR
was removed, so that the "git add ." was called with
the parents $GIT_DIR, and a prefix of sub/
(the slash will be removed in PATHSPEC_STRIP_SUBMODULE_SLASH...)
such that the length will be 3 ("sub") and the other
(prefix, nowildcard_len) are still 4.

One fix would be to adjust prefix and nowildcard_len
as well (in case they were as long as len, and now are
overlength, if they were shorter, no need to cut off one)

However I think that is missleading.

So let's step back a bit and think about what should happen
in the test case above. I think the users intent may be

    "remove the submodule and add the files
    directly to the regular tree".

However this would not happen in case we do the quickfix
of cutting one off prefix and nowildcard_len, because
we have similar thing as a D/F (directory/file) conflict,
just that it is a TREE/SUBMODULE conflict.

In the parent project there is still a submodule recorded for
sub/ but the user wants it to be a tree, so we would have
to rewrite that.

Using "rm -rf sub/.git" is a bad UI for saying " I want this to be
a native tree/blobs instead of a submodule", so I would expect
that we need to have another command there eventually
(git submodule convert-to-subtree ?)

Regarding the assert:
We are sure it's a submodule related thing, so we can
have a quite narrow warning there, roughly:

diff --git a/pathspec.c b/pathspec.c
index c9e9b6c..d0ea87a 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -313,8 +313,11 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
        }

        /* sanity checks, pathspec matchers assume these are sane */
-       assert(item->nowildcard_len <= item->len &&
-              item->prefix         <= item->len);
+       if (item->nowildcard_len <= item->len &&
+           item->prefix         <= item->len)
+               die (_("Path leads inside submodule '%s', but the submodule "
+                      "was not recognized, i.e. not initialized or deleted"),
+                      ce->name);
        return magic;
 }
