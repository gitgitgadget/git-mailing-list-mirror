From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Directory renames without breaking git log.
Date: Thu, 04 Sep 2008 13:41:13 -0700 (PDT)
Message-ID: <m3ljy7prtj.fsf@localhost.localdomain>
References: <200809032338.35359.kai@samba.org>
	<905315640809031716j7d74d7a6m51b434f62b011135@mail.gmail.com>
	<200809042145.09573.kai@samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kai Blin <kai@samba.org>
X-From: git-owner@vger.kernel.org Thu Sep 04 22:42:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbLex-0000xk-Ft
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 22:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755385AbYIDUlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 16:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755075AbYIDUlS
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 16:41:18 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:55725 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753979AbYIDUlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 16:41:16 -0400
Received: by fg-out-1718.google.com with SMTP id 19so532055fgg.17
        for <git@vger.kernel.org>; Thu, 04 Sep 2008 13:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=EUVfgemBq8wu8e/v1XeMfqY4rTBejatVm7gF8i9IGwQ=;
        b=l5lNuwroWlxOiM9pY9T71Ap6in82cH/bX9Vp1ZjMVp4zsgP+hTC8SKEv1dfDcPMdRs
         e+JT4vtro9Iknqcy3N7N4qL/vM5oq+PWOU3pv8sER1DMu5Fw8zK9qQfgLNoaYicHgeTj
         aO2fwUEfnZe+MG6mfwy1Jl8bag+JUVS/JykQs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=szxuO+pVq9PX/4i2npFgs3XxlQlBrt/ZVU/5Dz2VVNO76BEIcOomBtGOUBKiP1YNnv
         ELyvob4gejjHEgrWfhsoFexD4NsD5bweu/+War9zAtW5NJluHBLy/Mn8FJStO4Rk3jVg
         MqPnAwwm2ZEntklGkeevwLcRIRbu95W5iiMHo=
Received: by 10.86.90.13 with SMTP id n13mr6501570fgb.3.1220560874794;
        Thu, 04 Sep 2008 13:41:14 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.201.254])
        by mx.google.com with ESMTPS id 4sm72859fge.8.2008.09.04.13.41.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Sep 2008 13:41:14 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m84KfEgE019718;
	Thu, 4 Sep 2008 22:41:14 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m84KfDSr019714;
	Thu, 4 Sep 2008 22:41:13 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <200809042145.09573.kai@samba.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94956>

Kai Blin <kai@samba.org> writes:

> On Thursday 04 September 2008 02:16:24 Tarmigan wrote:
> > On Wed, Sep 3, 2008 at 2:38 PM, Kai Blin <kai@samba.org> wrote:
> > > Unfortunately, the directories are big enough that git log stops to track
> > > the renamed files, so e.g. git log ./samba3 does not show the samba3
> > > history. The history is not lost, of course, but it's way less intuitive
> > > to get it.
> >
> > You can try setting diff.renamelimit to 0 in your ~/.gitconfig.  See
> > Linus's email here for a similar situation in the kernel:
> > http://lwn.net/Articles/292948/
> 
> That doesn't seem to fix "git log path/to/file" cases. The really
> interesting part is that if I try "git log --follow -M -C
> path/to/file", I don't get any history at all. (--follow is the
> culprit, if I remove that I at least get the merge commit)
> 
> git blame still works, and git log --sparse path/to/file works, of 
> course. --sparse makes giving a path a bit pointless, of course, but we 
> probably can live with that for time being. I'm still open for suggestions, 
> of course. :)

Unfortunately "git log --follow <filename>" works correctly only
on relative simple histories.  You are of course welcome to improve
this part of git.

Simple workaround is to use "git log <file>" (optionally using
--diff-filter) to get when file vanished, check using "git show" or
"git whatchanged" on boundary commit, then use 
"git log -C -C -- <old name> <new name>"
-- 
Jakub Narebski
Poland
ShadeHawk on #git
