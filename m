Return-Path: <SRS0=/qQH=ZU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E782CC432C0
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 07:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C181206BF
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 07:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=deltaq.org header.i=@deltaq.org header.b="AtVbctph"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfK1Hek (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Nov 2019 02:34:40 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46395 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfK1Hek (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Nov 2019 02:34:40 -0500
Received: by mail-lj1-f196.google.com with SMTP id e9so27319072ljp.13
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 23:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deltaq.org; s=deltaq;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4JcDwX+KJmeyp2xW144pvKRfoK19splzmSi2C0nQW0E=;
        b=AtVbctph8uL9keupo40HckoZC2nQWncF1L+5fVFKtjNHuxZBZwL1LiLOuTSKuXEGR5
         jscekWeKlNZOkA+2d1f+U+p0ea4f5RdTJ2vJVTnoNBbUi96tdrszVIP38MxTlXakXNjL
         mlfLasGg8SWQ3qvU+cr5WEo4K1PdqSD7HSdpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4JcDwX+KJmeyp2xW144pvKRfoK19splzmSi2C0nQW0E=;
        b=qiOtlWJ2g8L3fQhm4qpDlSBUnqoSJntHSQ42iQ1pFs7W70gwuTekUO1EkrUi0pjbJc
         2sMYjUyzFzRWy2s+Y6T2VzU7aApOa5zyYydSBIDAlYAj/nFNbKrdP8+HjwHMgAoMr932
         W/nqawAg7A3FqJZei9dzxs256i8A8304/L2rkxJCmD0eGu6CF+I+F8t8t6HBZ/dbyjBh
         juWfoykiZja2UTzZX9FVjk+I7r0NF4GLty93rjK42e64Vd6J35kg4Pv1H9nMR30enc/x
         CJI+0Mz1Y7VV0myt9LRoBh1hBnxVEreQZe5Rd73Uc+MRhQnADQs3LBDJ/g97it65bWwP
         SIPA==
X-Gm-Message-State: APjAAAU8jJEOxoKWpbhCZUy09xTmez8ua9K6fM01snN5Ay1ne3W+Ptv0
        qhZH3pXNkvOgAik5fXa3fx3QHdqBNod8ZjamWXdstA==
X-Google-Smtp-Source: APXvYqx29eV4fm7YAias7Q0Hw6eGQrKXaba1ydQO0lHVSaKQw90xnk1scpUYgodrgfVXtEd6Zip54FbL12TkAujM7vc=
X-Received: by 2002:a2e:818e:: with SMTP id e14mr19017433ljg.245.1574926475140;
 Wed, 27 Nov 2019 23:34:35 -0800 (PST)
MIME-Version: 1.0
References: <pull.436.v4.git.1573973770.gitgitgadget@gmail.com>
 <pull.436.v5.git.1574627876.gitgitgadget@gmail.com> <aa05a78d285dd9c5f4897b03467f1d43d7a5ad83.1574627876.git.gitgitgadget@gmail.com>
 <20191127215503.x2lt2b3nce7q4yj2@yadavpratyush.com>
In-Reply-To: <20191127215503.x2lt2b3nce7q4yj2@yadavpratyush.com>
From:   Jonathan Gilbert <logic@deltaq.org>
Date:   Thu, 28 Nov 2019 01:34:21 -0600
Message-ID: <CAPSOpYvv+QZORJoGSNPisE=S_bAtS5tFtodnK9sHZVuTqVVxFg@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] git-gui: update status bar to track operations
To:     "Pratyush Yadav me-at-yadavpratyush.com |GitHub Public/Example Allow|" 
        <172q77k4bxwj0zt@sneakemail.com>
Cc:     Jonathan Gilbert via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>,
        Jonathan Gilbert <JonathanG@iqmetrix.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 27, 2019 at 3:59 PM Pratyush Yadav me-at-yadavpratyush.com
|GitHub Public/Example Allow| <172q77k4bxwj0zt@sneakemail.com> wrote:
> On 24/11/19 08:37PM, Jonathan Gilbert via GitGitGadget wrote:
> > -proc ui_ready {{test {}}} {
> > +proc ui_ready {} {
>
> This is not quite correct. There is one user of 'ui_ready' that uses
> 'test'. It is in git-gui.sh:2211. It is used when starting gitk. This
> change breaks that call. 10 seconds after opening gitk via the
> "Visualise master's history" option, I get the following error:
>
>   wrong # args: should be "ui_ready"
>       while executing
>   "ui_ready $starting_gitk_msg"
>       ("after" script)
[..]
> I'm not sure if this heuristic/hack is really needed, and that we need
> to keep the "Starting gitk..." message around for 10 seconds.
[..]
> So, I vote for just getting rid of this hack.

Oh geeze, I can't believe I missed this. This looks like it ought to
be relatively straightforward to port to the new operations, though,
which is a more isolated approach (keeping this change's fingers where
they belong), and then the operation provides segregation that means
it can just be ended after X seconds without caring what anything else
might be doing with the status bar. We can independently figure out if
we want to restructure that part. Given that computers are faster now
and that the status bar could end up doing something else in the
meantime (well let's be realistic, probably not, but who knows :-) ),
I'd vote for reducing the time the message is shown from 10 seconds
to, I dunno, 3 or 4 seconds.

One other thing I note is that both `do_gitk` and `do_git_gui` use
`$starting_gitk_msg`, which means that when `do_git_gui` is invoked to
launch a Git Gui child process for a submodule, it will be setting the
status bar text to say that it is launching Gitk.

Speaking of things that are out of scope for this PR, I did notice
this in the code:

> # -- Always start git gui through whatever we were loaded with.  This
> #    lets us bypass using shell process on Windows systems.
> #
> set exe [list [_which git]]

As far as I can tell, there's virtually no connection between the
comment and what the code is actually doing. I haven't yet figured out
what exactly it is or where it comes from, but on my Windows systems,
`git-gui` is actually an EXE file `git-gui.exe`, and I _think_ what it
is doing is running `wish.exe`, which I'm guessing has something to do
with hosting a Tcl interpreter with Win32 support for Tk GUI.

I'm not sure whether the code is doing the right thing here or not,
but I'm pretty sure what it's _not_ doing is figuring out how the
current `git-gui` process was started/is being hosted. :-P

> >  field finder     ; # find mini-dialog frame
> >  field gotoline   ; # line goto mini-dialog frame
> >  field status     ; # status mega-widget instance
> > +field status_operation ; # status operation
>
> Nitpick: The comment doesn't give any information the field name doesn't
> already give. Either remove it or replace it with something more
> descriptive.

Hmm, okay. I didn't want something that felt wildly imbalanced with
respect to the other lines, but you're right that this particular line
is literally just repeating the variable name. :-P

> > +     if {$status_operation == {}} {
> > +             set status_operation [$status start \
> > +                     $cur_s \
> > +                     [mc "lines annotated"]]
>
> The call to this method from '_read_blame' specifies a different $cur_s.
> So shouldn't we be destroying $status_operation (after stopping it), and
> creating a new one?

We can change the text by calling `$status_operation show`.

> >  method _read_blame {fd cur_w cur_d} {
>
> You did not update 'lib/choose_repository.tcl'. It still uses the old
> version of the status bar. Other than that, the rest of the patch looks
> good. Thanks.

Ugh, I can't believe I overlooked this. I was aware of the file using
the status bar, because it's the one place that uses the `two_line`
constructor, but then I forgot to actually make it create and use the
(single concurrent) operation that a `two_line`-er is allowed.

The code in there seems to overload the purpose of the `o_cons`
variable, so that sometimes it is pointing at a status bar and
sometimes it is pointing at whatever `console::embed` returns. I will
change this.

This code also depends heavily on `update` to keep the UI active,
which as I understand it is problematic because it could potentially
result in re-entrance since the user can interact with the UI in the
middle of the operation. I will not make any attempt to change this,
though. :-)

> [0]:
>   Curiously, if I do 'git log -L 2208,+5:git-gui.sh' to find the origins
>   of the line, it leads me to the commit 25476c6. And looking at the
>   commit, it does indeed appear to be the origin of the line since the
>   line is in the post-image, and not the pre-image. But I accidentally
>   noticed the line in a parent of that commit. Looking further, it turns
>   out the line originated in e210e67. Probably a bug in some really old
>   versions of git. Interesting nonetheless.

In e210e67, I see this:

set starting_gitk_msg {Please wait... Starting gitk...}
proc do_gitk {} {
        global tcl_platform ui_status_value starting_gitk_msg

        set ui_status_value $starting_gitk_msg
        after 5000 {
                if {$ui_status_value == $starting_gitk_msg} {
                        set ui_status_value {Ready.}
                }
        }
        ...

In 043f7011, all string comparisons were changed from ==/!= to eq/ne.
The commit message explains that when you use == and !=, Tcl will
attempt to convert either side to numeric if one of the two sides
looks like a numeric. Guess I should review my commit for this error
:-P

-                if {$ui_status_value == $starting_gitk_msg} {
+                if {$ui_status_value eq $starting_gitk_msg} {

In 699d5601 "Refactor our ui_status_value update technique", this became:

set starting_gitk_msg [mc "Starting gitk... please wait..."]
...
        global ... starting_gitk_msg
...
        ui_status $starting_gitk_msg
        after 10000 {
                ui_ready $starting_gitk_msg
        }

Finally it became this in 02efd48f, apparently an unrelated
refactoring removed the global variable declaration:

set starting_gitk_msg [mc "Starting gitk... please wait..."]
...
        ui_status $::starting_gitk_msg
        after 10000 {
                ui_ready $starting_gitk_msg
        }

I gathered this information using Git Gui's blame function, which I
guess is a good demonstration that my latest blame.tcl revision
corrects the problems in the earlier submission :-D

Next revision coming soon.

Jonathan Gilbert
