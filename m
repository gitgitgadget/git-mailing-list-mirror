Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EA4C433E1
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 06:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD2BB20759
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 06:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ss5EInmY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbgF3GhN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 02:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730373AbgF3GhL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 02:37:11 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22F0C061755
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 23:37:10 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id s14so8071907plq.6
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 23:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UBNAbrIxr6qyYs0XYZdNxeDeIdDB9L8JXG8O9yNwqMc=;
        b=Ss5EInmYjKWFw+Fwb+3ThEBxEAXpvCsHDhtOPaqwVWPdFQ6EHklJqxOetUcZTOhMhA
         u8tLu4aIN3GZ8SyNH90C1fL1RbzaL/c0z819xsXLrodtJ3RiDY3GJnpe55NTUjRndH+u
         q666Vie5I134TiQoLKWdrIFv7kceAE5le+aS84eYPMhNvFJiHS509N4Sa0GfDYjkHJzp
         tHQSUSFcRiihkM4mkdXeXeiT9rU/G1MnTMYKBgkMuthTDTY/pKImLXqp8vYGSCJLsDDF
         bezE0rIPsh5oRsTJCHT76qbyHYA8395rs2o79dCRNYYOW/O7Us15t46TgM3BcOOW8dKs
         xaiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UBNAbrIxr6qyYs0XYZdNxeDeIdDB9L8JXG8O9yNwqMc=;
        b=WH4sl/OyxN+OBYZyQcbITU7AtS/TJBGfOlFdMj3kd5zaIm3WvrvxTwY7HgtYYiUHH6
         1fByEHdB6pEd6ik4G+M8aEJHl+dghjfoy/uKJCkw4JNkNmUSxitH5QUNI/tHr/rvcqp9
         23nnHmDpsQgJxStcCyjzpIq+vAV1LTBU2P7yPyjS56285Hm5vixctvxRqXPnuAYqp9q+
         kcJ3ysmXHZbDJ8HrV94g5GB0uzGNQXQkpoX4C0MIBH8eQtIHegNEoU61lWCmH/3GSU8b
         2MvkiYPirjuG3EY9VRnbGGrvUweYxLjENLZjhMCdiCxaW8LugDlHkB6XQvqDshdHtxqr
         Zvlg==
X-Gm-Message-State: AOAM5302L4xqlz23o4TdauryZ49lNiJoxy9nFp50Z3fGaB2XAxIJcuHj
        xOMSZqa4gtB0rHAkTqMwODk=
X-Google-Smtp-Source: ABdhPJzeC1RwP/9lKckAHSXfG4rUITy2XTX7Mgvc0d94YgDS8KQ/CMliB3g7jjZdLzgTGs5mKPXVQw==
X-Received: by 2002:a17:902:7689:: with SMTP id m9mr15140918pll.98.1593499030194;
        Mon, 29 Jun 2020 23:37:10 -0700 (PDT)
Received: from gmail.com (108-81-23-119.lightspeed.irvnca.sbcglobal.net. [108.81.23.119])
        by smtp.gmail.com with ESMTPSA id 76sm1525582pfu.139.2020.06.29.23.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 23:37:09 -0700 (PDT)
Date:   Mon, 29 Jun 2020 23:37:06 -0700
From:   David Aguilar <davvid@gmail.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Luigi Cantoni <luigic@fgcint.com>, git@vger.kernel.org
Subject: Re: Auto Rescan - as plain text
Message-ID: <20200630063706.GA1962986@gmail.com>
References: <37bd22ee8bcb9c91969d68cbc5e6852a8a70ab36.camel@fgcint.com>
 <bf895dc550881b35baea45cd269bf9b0518ade35.camel@fgcint.com>
 <816ce248ab1708d41b5233abdb998ff2d4cb3400.camel@fgcint.com>
 <36bd7dc26883017770c28da94a251be2d5019f75.camel@fgcint.com>
 <xmqq3673hj11.fsf@gitster.c.googlers.com>
 <20200610085902.uv7cxl6s5qnlniwm@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200610085902.uv7cxl6s5qnlniwm@yadavpratyush.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 10, 2020 at 02:29:02PM +0530, Pratyush Yadav wrote:
> Hi Junio,
> 
> On 09/06/20 05:16PM, Junio C Hamano wrote:
> > Luigi Cantoni <luigic@fgcint.com> writes:
> > 
> > > Hi All,
> > > I have been using git for several years now and using git-cola.
> > > I just started up git gui and that is quite self explanatory and all
> > > the functions I use with git-cola appear to be there.
> > 
> > We used to see the maintainer of that project around here quite
> > frequently but haven't seen him for a while [jch: David Cc'ed].
> > 
> > By reading https://git-cola.github.io/about.html it seems that they
> > prefer to see problem reports and feature requests at
> > https://github.com/git-cola/git-cola/issues and not on this list.
> 
> The feature request is for git-gui, asking for auto rescan in git-gui 
> like git-cola has. So I think this is the right place for it. Though I 
> think its easy to miss that on a quick read of the email. I had to do a 
> double take too :-)

Hi, I'm glad you like git-cola.

In the OP missed it, the git-gui maintainer's repo is here:

https://github.com/prati0100/git-gui


> > > One thing I liked in git-cola was that it very quickly reflected my
> > > changes in its display window.
> > > I have looked in the options and I cannot see either a flag to set it
> > > to auto rescan or set a time for the auto rescan.
> > >
> > > Have I missed it and there is a way turn this on or give it a shorter
> > > time (if in fact it is does do it).
> > > If it is not offered could it become an option.
> > > I can see that some people may not feel the overhead for distributed
> > > system is worth having this on so they would want if off.
> > > It is not critical (just nice) as I know I can
> > > 1) rescan
> > > or 2) go off the file and back on again.
> > > It then displays the correct diff/updated contents.
> > >
> > > Thanks for any advise or help.
> 
> -- 
> Regards,
> Pratyush Yadav


I'd be happy to explain how we implemented the "live refresh feature
in git-cola.

We have a few different approaches.  First, we integrate with inotify
on Linux.  When we notice that files have been written, we refresh our
state.  That's the happy path.

On Windows someone wrote an equivalent thing using some Windows file
monitoring APIs.

I don't think we currently have a macOS file monitoring part yet, but I
imagine there's probably a way to do it there too.

We're in Python, so we had the flexibility of what Python provides.
Git GUI will have access to anything tcl/tk / wish can do, but I'm
not familiar enough to know what's possible.

One thing we did do for users that don't have native file monitoring, is
that someone requested a preference, eg. "gui.refreshOnFocus", which
would make the GUI refresh whenever it gets focus from the window
manager.  This can be helpful, though it will make it take that extra
hit every time you switch between windows.  That might be something
that's possible to implement if something like inotify is not available,
though, and can be convenient for users that don't mind the hit.

Question for Luigui, how do you refresh the GUI?
Do you click on the "Rescan" button, or do you use the "Ctrl-R" hotkey?

One very nice but subtle detail that is not immediately obvious
from your description of how git-cola works is that if you have a file
selected, and something changes, we refresh the diff and keep the
viewport at the same location so that the changes appear right there,
immediately.  You mentioned:

> or 2) go off the file and back on again.

Which suggests that you have to deselect the file and reselect it to get
git-gui to redo the diff display.  You'll also lose the scrollbar
position if you do that, eg. if you are scrolled in the middle of a
large diff, you're going to lose your place.  That's why we
special-cased this behavior in cola and made it so that the rescan
behavior will redo the diff when a file is selected.

We go through great effort in cola to handle this in the nicest way
possible.  We  retaining the scrollbar/viewport position, redo the
diff, and ensure that if the user had something selected in the
text area, and the diff changes, that we attempt to re-select the text
that they may have selected, even if it changed lines.  The selection is
moreso content-centric than line-centric.

If they had something selected that went away, then their text selection
will be lost, but that's totally expected and natural.

I have a lot of opinions about how that tool should work, whch is really
why git-cola exists.  The diff/index editing part is really the killer
feature.

I ask how you refresh the GUI because cola is designed to be driven
entirely by keyboard shortcuts, and has vim-like hotkeys because I dig
building upon existing conventions and my vim muscle memory.

My main sug for git-gui would be to make it so that you don't have to
use a mouse.  Making it so that it can do the entire partial
staging/unstaging/revert workflow using line selection and keyboard
hotkeys would be my personal sug for feature requests.

If someone adds it, please use the "s" hotkey to stage/unstage selected
lines (or the hunk at the text cursor position, if nothing is selected),
"ctrl-u" to revert changes the same way, and "ctrl-s" to stage/unstage
the entire file, would be my personal sugs.

Parity with git-cola is always a nice goal within reason ;-) that way
folks won't have to re-learn these hotkeys across the tools.
-- 
David
