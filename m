Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C91C6FD1D
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 14:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjDDOur (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 10:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjDDOuq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 10:50:46 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA9F1708
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 07:50:44 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id ek18so131753971edb.6
        for <git@vger.kernel.org>; Tue, 04 Apr 2023 07:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google; t=1680619843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qp4FrY6rCyrqnadgBP8aRcSERYWlmzfB0zu4LVnQLyk=;
        b=GTFyPUhajltRDfZXTm8pqQ/CEoJPNYW4ytUUxwS5jsELoHHTyRsqmGrrzyEM5hCM4J
         E5p5LcnnCO3igby0h2Jvia6zZYJbTQY+fKMhnD0/Vv42RMRxT2p8WmIVvbPLuxigW/rU
         Vv3ofyDY5c3ZX+JQQPW8tejEC4Wrl5P88JQxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680619843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qp4FrY6rCyrqnadgBP8aRcSERYWlmzfB0zu4LVnQLyk=;
        b=q2iymRTIHDcb9j1A8s2JL54TvQqtCA9HAQHMJASG8rxWM/fMX1ogfLz3lRRwYSWC6s
         5WMQ8WKXvCh14M0nJ3VtgSsXq7jFzW7wOvQ2qZH+oyjweyPO45SUh/xNZeZB/kxXd78Y
         QXNYpfVjpxrxmL0JuWHNoNVC6PNI3ZSm3g+us59OtaM/OiKfhzXABeVCIehnNQBAejFh
         ruwjExIs/dhU5yDO5TAVcppjBXycarC6/qoLE4WBGkL0oisDkOvCwBt/ElqPTG/NVzxH
         8o1gD96G9g6guKfOl3/T/XHxTWrSVE917yp2qVjN4AK7XhtyxbDDYHh3yxCHFqZYxxm4
         cS8g==
X-Gm-Message-State: AAQBX9f9ZwpjVnFyKU19tWzZm/lmIFKqaWBoPdiO/blBS6rGOUzkLPWY
        VBByWtGd7/jySi58sv4qWuhcRaB8eMlIWvuBFyt9KtARMCOxFbhwYUazeQ==
X-Google-Smtp-Source: AKy350YzTS2p9ndCjR7mDZTq5vTzBNRhR+Vaitcx3p6avWMc00NxWJGn7pLo3cVAWDuGRp8h86pczzHCkJqOf/4fGWo=
X-Received: by 2002:a17:906:8683:b0:939:a51a:dc30 with SMTP id
 g3-20020a170906868300b00939a51adc30mr10778296ejx.2.1680619842697; Tue, 04 Apr
 2023 07:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1381.v3.git.1666076086910.gitgitgadget@gmail.com>
 <pull.1381.v4.git.1679153263217.gitgitgadget@gmail.com> <ZCvx/REMF69xkXJg@gmail.com>
In-Reply-To: <ZCvx/REMF69xkXJg@gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 4 Apr 2023 16:50:31 +0200
Message-ID: <CAPMMpohtL2dG_Ody5zALhS5kOuLLTTRw7L0vc6SnpWym+usppg@mail.gmail.com>
Subject: Re: [PATCH v4] mergetool: new config guiDefault supports
 auto-toggling gui by DISPLAY
To:     David Aguilar <davvid@gmail.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

First of all, thank you for reviewing!!

On Tue, Apr 4, 2023 at 11:46=E2=80=AFAM David Aguilar <davvid@gmail.com> wr=
ote:
>
> On Sat, Mar 18, 2023 at 03:27:43PM +0000, Tao Klerks via GitGitGadget wro=
te:
> > From: Tao Klerks <tao@klerks.biz>
> >
> > When no merge.tool or diff.tool is configured or manually selected, the
> > selection of a default tool is sensitive to the DISPLAY variable; in a
> > GUI session a gui-specific tool will be proposed if found, and
> > otherwise a terminal-based one. This "GUI-optimizing" behavior is
> > important because a GUI can make a huge difference to a user's ability
> > to understand and correctly complete a non-trivial conflicting merge.
> >
> > Some time ago the merge.guitool and diff.guitool config options were
> > introduced to enable users to configure both a GUI tool, and a non-GUI
> > tool (with fallback if no GUI tool configured), in the same environment=
.
> >
> > Unfortunately, the --gui argument introduced to support the selection o=
f
> > the guitool is still explicit. When using configured tools, there is no
> > equivalent of the no-tool-configured "propose a GUI tool if we are in a=
 GUI
> > environment" behavior.
>
> I'm not sure what problem this is solving. Please help me understand.
> This commit seems to be talking about the behavior w.r.t. the DISPLAY
> variable and also about automatically enabling `--gui` automatically.

Background: If you don't set a mergetool at all, git defaults one if
it can. The default you get depends on the DISPLAY variable - if it
looks like you're in a gui context (because we detect that DISPLAY is
set), then we propose a gui tool. Otherwise, we propose a cli tool.

This is particularly valuable for contexts where you might access the
same environment, the same workstation, via multiple contexts -
CLI-only, and GUI. For example, sometimes you connect to the desktop,
and sometimes you SSH into it (without X forwarding). You don't need
to tell git "I want a GUI now please", it figures that out.

Point/problem: As soon as you set "merge.tool", you lose that
autoselection. A reasonable user would assume "there is `merge.tool`,
there is `merge.guitool`, and git knows how to autodetect GUI context
based on the DISPLAY variable... so if I set both `merge.tool` and
`merge.guitool`, I'll get the right one based on context, right? Like
I do when I set neither?"
Unfortunately, that is *not* the case. The gui autodetection only
applies when git is choosing a *defaulted* merge tool, not an
explicitly-defined one. As soon as you specify a tool you want to use,
you need to start *explicitly* telling git whether you want to use a
GUI tool or not. If you get it wrong, an inconvenient or even bad
thing happens: If you're in a GUI context and you forget to say
`--gui`, then you get the CLI tool - not the end of the world, you
might argue. If you're in a non-GUI context and you say `--gui`, you
get a (hopefully intelligible) error about not finding a display, or
worst case, you hang - and git doesn't know what happened, the
messaging has to assume you aborted explicitly.

If there were a way to get git to autoselect "--gui" by presence of
the DISPLAY, as it does for the *default* mergetool, then this kind of
flow would be much more intuitive, usable, etc.

I'm not sure whether I'm explaining better, or just repeating myself,
so I'll stop here :)

>
> Regarding `--gui`: Someone that configures `mergetool.guiDefault`
> means that all of their invocations should be as-if they had written
> `--gui` on the command-line.

Correction: Someone that sets `mergetool.guiDefault` to *true* should
get behavior as-if they had written `--gui` on the command-line. They
could also set *false* (current behavior - explicit), or *auto*, and
get different behavior.

>
> So.. if you find that you always use `--gui` then why are
> you not configuring `merge.tool` directly and instead configuring
> `merge.guitool`?

One reason is because you might choose to do something different in a
*specific* invocation, eg by passing `--no-gui`. This is a common
pattern in git - the config allows you to change the default behavior,
but you can override it on a specific invocation by using the positive
or negative version of the argument.

>
> The purpose of `--gui` is to provide an override for use by tools (such
> as Git Cola) to execute an optional, 2nd merge tool separate from that
> which the user might configure for command-line use.

I'm not aware of having read a statement identifying this
*singular*/sole purpose anywhere, but as you state it with authority
(and I see you're the author of a popular git GUI), I'm happy to
accept that this was originally its only purpose. That would certainly
explain the incongruousness of its behavior wrt (lack of)
autodetection of DISPLAY.

That said, this patch does not in any way diminish the validity or
usability of this usecase. If you don't set `mergetool.guiDefault` or
leave it set to false, that purpose will continue to be perfectly
served.

For other users, like me, who prefer to select a GUI mergetool or not
depending on the *availability* of a GUI environment (auto), or
default to gui but allow manually downgrading to a (defaulted or
configured) CLI-only tool, this configuration will allow a simpler,
more coherent, easier UX.

If everything else here makes sense, I will happily update the
abstract/commit message to reflect the proposed broadening of
application / correct my misunderstanding as to the original intended
scope of the setting.

>
> This patch basically makes the `merge.tool` configuration useless,

I don't understand why you say this. Unless I misunderstand something,
this patch does not break, or even change, any existing behavior.

> so I
> don't understand why someone would want to configure this option rather
> than just configuring `merge.tool` directly, leading to an overall
> simpler and easier to understand system.

(see above - the main usecase is a system you access via both GUI and
CLI contexts, and the secondary usecase is having a default GUI
behavior that you can easily override with `--no-gui`.)

>
> If we add this boolean then it becomes harder to understand.
> I'm not sure it really provides any additional value to the user.
>
> From my vantage point, the user is better off configuring `merge.tool`
> directly rather than the tool becoming more complex.
>
> That said, I probably don't understand and I'd be happy to be
> enlightened.

Please let me know if it makes more sense now. You could argue that
the value is too limited to warrant the additional complexity
(obviously I would disagree), but hopefully the concrete value is
clearer now.

>
>
> > As proposed in <xmqqmtb8jsej.fsf@gitster.g>, introduce new configuratio=
n
> > options, difftool.guiDefault and mergetool.guiDefault, supporting a spe=
cial
> > value "auto" which causes the corresponding tool or guitool to be selec=
ted
> > depending on the presence of a non-empty DISPLAY value. Also support "t=
rue"
> > to say "default to the guitool (unless --no-gui is passed on the
> > commandline)", and "false" as the previous default behavior when these =
new
> > configuration options are not specified.
>
> The rationale here is slightly surprising to me as well.
>
> Apparently the user cannot be bothered to configure `merge.tool`
> (because we care about this DISPLAY behavior) yet the user is expected
> to configure `merge.guiDefault` instead?

Umm, no: The user wants `merge.tool` to be set to a specific CLI tool,
they want `merge.guitool` to be set to a specific GUI tool, and they
want the GUI tool to be used in GUI contexts, and the CLI tool to be
used when there is no GUI (eg SSH without X forwarding) - like the
behavior they get if they configure neither `merge.tool` nor
`merge.guitool`.

>
> I think it'd be better to encourage users to go ahead and configure
> `merge.tool`, but again, I'm probably missing context around why.
>
>
> Small patch note below...
>
>
> > diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
> > index 992124cc67c..e4e820e6809 100755
> > --- a/git-difftool--helper.sh
> > +++ b/git-difftool--helper.sh
> > @@ -75,6 +75,11 @@ then
> >               merge_tool=3D"$GIT_DIFF_TOOL"
> >       else
> >               merge_tool=3D"$(get_merge_tool)"
> > +             subshell_exit_status=3D$?
> > +             if test $subshell_exit_status -gt 1
>
> Is exit status 1 special here?
> Should this be "if test $subshell_exit_status !=3D 0" instead?

Yes, it is special: 1 means "mergetool was guessed/defaulted",
anything greater than 1 means "mergetool determination failed;
aborting".

I was not very happy with this way of passing information around when
I implemented, and commented in the previous version of the patch
https://lore.kernel.org/git/pull.1381.v3.git.1666076086910.gitgitgadget@gma=
il.com/
as my last doubt as to the proposed/RFC patch:

       After implementing Junio's recommended "fail if defaulting config is
       consulted and is invalid" flow, there now needs to be a distinction
       between subshell exit code 1, which was used before and indicates
       "tool not found or broken; falling back to default" and other
       (higher) exit codes, which newly mean "something went wrong, stop!".
       The resulting code looks awkward, I can't tell whether I'm missing a
       code or even commenting pattern that would make it clearer.

Unfortunately I didn't get any feedback on this, so I went ahead and
resumitted the change as a non-Draft. I'd be very grateful for any
recommendations on how to handle this better.
