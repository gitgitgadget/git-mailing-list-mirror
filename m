From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: [RFC/PATCH] Force using Tcl/Tk 8.4 on Mac OS X
Date: Tue, 7 Sep 2010 09:19:42 +0200
Message-ID: <1jofybj.1n3hzqy1yd85vfM%lists@haller-berlin.de>
References: <CB6C69E6-7943-49B7-96E7-4C00831C3C9D@users.sourceforge.net>
Cc: git@vger.kernel.org, spearce@spearce.org (Shawn O Pearce),
	dsteffen@apple.com (Daniel A Steffen)
To: das@users.sourceforge.net (Daniel A. Steffen)
X-From: git-owner@vger.kernel.org Tue Sep 07 09:19:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OssTA-0002eY-2M
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 09:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755201Ab0IGHTr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Sep 2010 03:19:47 -0400
Received: from mail.ableton.net ([62.96.12.115]:34765 "EHLO mail.ableton.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752460Ab0IGHTq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 03:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=haller-berlin.de; s=mail_2009081900;
	h=Message-ID:Date:From:Subject:In-Reply-To:Cc:To; bh=i58007Q4nzQDaExbwC0irpqIUyipnj54PyupjOUROZU=;
	b=WBVn9gWyRk/OYlUnXVpDPtsL0ai6y+yvzO2SLn2S+JRSkZtrlDlkFqUQcVktvcGexkSJ7e9C82K8J7rogVBorieg2YWms4AusO+kozjlcz7xUQaPigQ4ZCzrEO5QFh+DhurJnL2c/uXxEu53s2ZZLBvvQ4SsE98JuQBw9z5LF2E=;
Received: from [10.1.15.237]
	by mail.ableton.net with esmtpsa (SSLv3:AES128-SHA:128)
	(Exim 4.72)
	(envelope-from <lists@haller-berlin.de>)
	id 1OssK2-0002ro-SI; Tue, 07 Sep 2010 09:10:27 +0200
In-Reply-To: <CB6C69E6-7943-49B7-96E7-4C00831C3C9D@users.sourceforge.net>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.6.4 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155683>

Daniel A. Steffen <das@users.sourceforge.net> wrote:

> On Sep 6, 2010, at 10:07 AM, Stefan Haller wrote:
> 
> > When using Git Gui.app on a Snow Leopard system with Tcl/Tk 8.5,
> > there are two problems:
> > 
> > 1) Menu commands that open a dialog (e.g. "Push" or "Revert changes")
> >   don't work when invoked via their keyboard shortcuts. You get a
> >   dialog without a title bar, and the application then hangs without
> >   further responding to any user input; you need to kill it. Invoking
> >   the same commands with the mouse by choosing from the menu works fine.
> 
> first time I hear of this (or see this myself, and I use git gui every day
> on Mac OS X); in part this may be due to the fact that many of the menu
> shortcuts assigned by git gui conflict with existing OS X shortcuts and
> don't work anyway e.g. cmd-A (esp if a text widget is in focus)...
> 
> personally I would hate for my git gui to be downgraded to Tk 8.4 and
> Carbon because of this small issue, and I'm unlikely to be alone.

It's not a small issue for me, but I agree that downgrading to 8.4 is
the wrong solution.

> An effective small workaround for the problem appears to be to turn off
> the menu accelerators for the affected commands (the key shortcuts will
> still work, since the actual key bindings are independent of the menu
> accelerators), see below.

This does indeed solve the problem, but at a high price; having the menu
accelerators not visible in the menu is not a satisfactory solution.
(For me personally it's ok, but not for new users.)

Is there no other way to work around this in git gui, like maybe
deferring the command invocation with a one-shot timer or something?

> Is there a complete list of menu shortcuts that bring up a dialog?

As far as I can see, it's

    Branch/Create
    Branch/Checkout
    Commit/Revert Changes
    Merge/Local Merge
    Remote/Push

> Ultimately the right way to address this issue is to fix it in Tk, please
> report this in the Tk bug tracker if you haven't already, a quick glance
> in the debugger shows a hang in recursive event loop invocation such as
> used by tk_dialog when called from a menu accelerator callback.

Will do, thanks.

> > 2) The colored pane headers (red, green, yellow) are all grey.
> 
> this is intentional and triggered by the use of ttk, there is a config
> setting to turn it off (gui.usettk)

I'm not sure I understand. On a Windows system with Tk 8.5 and ttk on,
the pane headers are still colored.  Why is it desirable to have them
grey on Mac?

-Stefan


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
