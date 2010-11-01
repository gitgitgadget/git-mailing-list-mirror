From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Bugs in Gitosis
Date: Mon, 1 Nov 2010 10:32:02 -0700
Message-ID: <20101101173202.GA22725@spearce.org>
References: <26E9B811E137AB4B95200FD4C950886BA9665D70@orsmsx507.amr.corp.intel.com> <vpq8w1if0yy.fsf@bauges.imag.fr> <26E9B811E137AB4B95200FD4C950886BA9665E50@orsmsx507.amr.corp.intel.com> <AANLkTik+CcuAtB=t5GgP9C-WrJRZt-LDNs3wUChhKTuz@mail.gmail.com> <26E9B811E137AB4B95200FD4C950886BA96667EA@orsmsx507.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Olsen, Alan R" <alan.r.olsen@intel.com>
X-From: git-owner@vger.kernel.org Mon Nov 01 18:32:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCyEu-00068o-P4
	for gcvg-git-2@lo.gmane.org; Mon, 01 Nov 2010 18:32:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197Ab0KARcH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Nov 2010 13:32:07 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:59753 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828Ab0KARcF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Nov 2010 13:32:05 -0400
Received: by pvb32 with SMTP id 32so545902pvb.19
        for <git@vger.kernel.org>; Mon, 01 Nov 2010 10:32:05 -0700 (PDT)
Received: by 10.142.141.12 with SMTP id o12mr4411833wfd.280.1288632725427;
        Mon, 01 Nov 2010 10:32:05 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.74.25])
        by mx.google.com with ESMTPS id x35sm9221454wfd.13.2010.11.01.10.32.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Nov 2010 10:32:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <26E9B811E137AB4B95200FD4C950886BA96667EA@orsmsx507.amr.corp.intel.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160489>

"Olsen, Alan R" <alan.r.olsen@intel.com> wrote:
> 
> Gerrit does not add existing projects well. Pushing the kernel
> project into Gerrit causes one entry to approve per commit. That
> swamps the server.

Don't push to refs/for/master.  Grant yourself Push Branch +1
(or +2 if you need to create the branch) and push directly to
refs/heads/master like you would with Gitolite, Gitosis or any
other Git repository.  Gerrit won't create a change record, and
thus won't be swamped.

> Gerrit does not have a way of handling rebases
> very well.  (We have projects that have a regular consolidation on
> the end of the development trees.)

I think it handles rebases about as well as any other Git tool, you
need to enable Push +3 to permit force push/rewind of the relevant
branches, and then actually do the force push.  Any pending commit
will need to be rebased.  Which is also true for just about any
workflow except the classic Linux kernel "format-patch and email"
model.  Switching to gitolite probably won't easy the rebase pain.

FWIW, the Google kernel developers have their Gerrit instance
configured to use the cherry-pick submit type on their kernel
repositories, which makes changes submittable across rebases,
because its emulating the format-patch->email->am workflow that
is traditionally used for kernel development.

> There are also some people (me for example) who loath the Repo
> command and prefer to work using git.

I'm also among those people, as are many of Google's kernel
developers.  We just use git push to talk to Gerrit... and
that is one of the primary reasons it embeds its own SSHD.

-- 
Shawn.
