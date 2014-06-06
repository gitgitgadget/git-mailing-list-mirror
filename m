From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [RFC PATCH] clone: add clone.recursesubmodules config
	option
Date: Fri, 6 Jun 2014 07:26:01 +0200
Message-ID: <20140606052601.GB77405@book.hvoigt.net>
References: <xmqqoay9wvo6.fsf@gitster.dls.corp.google.com> <1401874256-13332-1-git-send-email-judge.packham@gmail.com> <xmqqvbsgvb9l.fsf@gitster.dls.corp.google.com> <538F6E52.9000009@web.de> <xmqq4mzzte2z.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Chris Packham <judge.packham@gmail.com>, git@vger.kernel.org,
	mara.kim@vanderbilt.edu, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 07:26:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsmfM-0003En-1t
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 07:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbaFFF0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 01:26:07 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.97]:46605 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbaFFF0G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 01:26:06 -0400
Received: from [77.20.146.74] (helo=book.hvoigt.net)
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1WsmfD-0008Lw-SY; Fri, 06 Jun 2014 07:26:03 +0200
Content-Disposition: inline
In-Reply-To: <xmqq4mzzte2z.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250889>

On Thu, Jun 05, 2014 at 11:18:28AM -0700, Junio C Hamano wrote:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> > We had two settings in mind,...
> > So what if clone would just do an "git submodule init" for now when
> > "submodule.autoinit" is set but "submodule.autoupdate" isn't [?]
> > ... and a single "submodule.auto" setting would be what users really want?
> 
> I do not offhand think of a sensible scenario where you want to init
> a submodule once but do not want to update it when the superproject
> changes.  Even if the user uses the mode to detach the submodule
> HEAD, i.e. the branches in submodules do not matter and the whole
> tree is described by the superproject's commit and gitlinks recorded
> in it, the user would want the new objects necessary for the updated
> superproject, which means a submodule that is init'ed (whether it is
> via "git submodule init" or the submodule.autoinit variable) must be
> updated.
> 
> So I am not sure why a user wants to disable autoupdate in the first
> place.  For the same reason, setting submodule.*.update to none
> would not make much sense, either.  Perhaps I am missing something.
> 
> Unless the user is very conservative and suspects that these
> recursive behaviour we are going to bolt on to various commands
> could be buggy and untrustworthy, in which case the user might want
> to manually run "git submodule update", or even run "git fetch"
> after going there while bypassing the whole "git submodule".  But I
> do not think that is healthy in the longer run.

I think autoupdate is mainly there for the transition phase. Since
submodule can e.g. contain a lot of files a checkout would take much
longer. Similar to when Jens implemented the recursive diff, many people
were annoyed by the new files showing up and some with the impact on
performance (thats why we have the --ignore-submodules option).

In case of very big submodules and people already ignore their diff it
might even be necessary that the update is only done manually. E.g. for
a big media repository.

Cheers Heiko
