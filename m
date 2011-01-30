From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: Project- vs. Package-Level Branching in Git
Date: Sun, 30 Jan 2011 20:36:03 +0100
Message-ID: <20110130193603.GA327@nibiru.local>
References: <14F4737F-E8E4-4E4E-A625-16CA63CF9EFF@shaggyfrog.com> <AANLkTinTRgzv0s9MTyM4TaOwVOmhwRckDqMfxrbsKVfm@mail.gmail.com> <15B7CA2E-C584-4563-B9E3-D80861CD9565@shaggyfrog.com> <m3tygt9xmn.fsf@localhost.localdomain> <20110129194258.GE602@nibiru.local> <20110129232848.GC7676@gmail.com>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 30 20:45:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjdDd-0007ao-T2
	for gcvg-git-2@lo.gmane.org; Sun, 30 Jan 2011 20:45:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754253Ab1A3Tpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Jan 2011 14:45:49 -0500
Received: from caprica.metux.de ([82.165.128.25]:46309 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752867Ab1A3Tps (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Jan 2011 14:45:48 -0500
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id p0UJg16p007589
	for <git@vger.kernel.org>; Sun, 30 Jan 2011 20:42:16 +0100
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id p0UJfWt6007546
	for git@vger.kernel.org; Sun, 30 Jan 2011 20:41:32 +0100
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id p0UJa38d023248
	for git@vger.kernel.org; Sun, 30 Jan 2011 20:36:03 +0100
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20110129232848.GC7676@gmail.com>
User-Agent: Mutt/1.4.1i
X-Terror: bin laden, kill bush, Briefbombe, Massenvernichtung, KZ, 
X-Nazi: Weisse Rasse, Hitlers Wiederauferstehung, 42, 
X-Antichrist: weg mit schaeuble, ausrotten, heiliger krieg, al quaida, 
X-Killer: 23, endloesung, Weltuntergang, 
X-Doof: wer das liest ist doof
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165695>

* David Aguilar <davvid@gmail.com> wrote:

Hi,

> This is exactly how we do it at my workplace.  We have literally
> hundreds of individual git repositories.  Naturally, some
> packages depend on others and the only "trick" is building them
> in the correct dependency order.  A simple dependency tree
> handles this for us.

perhaps you'd like to have a look at my Briegel build tool:

    git://pubgit.metux.de/projects/briegel.git
    
;-)

> We use same-named branches across several repos when coordinating
> features across many projects.  e.g. we had an "el6" branch
> when we were gettings things ready for that platform.  It's a
> convention but it helps when writing helper scripts.

Did you have these branches for all packages ?

> We can clone and work on any subset of the entire tree by
> cloning just the repos we are interested in.  Setting
> $LD_LIBRARY_PATH and $PATH helps when testing builds in their
> sandboxes.  You still need to get the compiler/linker to
> construct paths into the sandboxes instead of the standard
> release area.

I'd suggest pushing everything through a sysroot'ed crosscompiler
and only install the absolute required dependencies in the sysroot
on each package build. This tends to show up a lot of programming
errors that otherwise stay unnoticed for a long time.
(Briegel goes exactly that way and handles it automatically ;-p)
 
> This is what the pkg-config command does.  It respects the
> $PKG_CONFIG_PATH environment variable which can be used to
> point to staged installs so that you don't have to deploy the
> package before building against it. 

With sysroot, it's even a bit more cleaner, pkg-config can handle
the path fixups automatically then.

> The idea is so simple that you could write an equivalent command
> in an afternoon and extend it to work however you need in the
> event that pkg-config does not fit.

Actually, I only know of rare cases where pkg-config doesn't
really fit. Mostly due bad software design. Once thing I'm yet
missing is something pkg-config alike which replaces most of
the autofool-tests (eg. whether the target supports some
syscall, stack directions, etc).

> 2. the build must use the pkg-config command when constructing
>    include/library paths.

Still there're lots of packages which dont use pkg-config.
Some of those I'm already fixing in my OSS-QM project.
(Everybody's invited to join in ;-))


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
