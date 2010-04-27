From: Nick <oinksocket@letterboxes.org>
Subject: Re: Git and cvsimport
Date: Tue, 27 Apr 2010 12:57:28 +0100
Message-ID: <4BD6D128.7030403@letterboxes.org>
References: <i2l717f7a3e1004260727wd87900a5tcfb61a3142d0ba@mail.gmail.com>	 <4BD69450.8040608@drmicha.warpmail.net> <l2w717f7a3e1004270341lea6cfe2aqdf8d2b490b1ec067@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Marin Atanasov <dnaeon@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 27 14:36:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6k1i-0002r1-E6
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 14:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755461Ab0D0Mg2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 08:36:28 -0400
Received: from udon.noodlefactory.co.uk ([80.68.88.167]:59757 "EHLO
	udon.noodlefactory.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755434Ab0D0Mg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 08:36:27 -0400
X-Greylist: delayed 2354 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Apr 2010 08:36:27 EDT
Received: from 87-194-154-6.bethere.co.uk ([87.194.154.6] helo=[192.168.0.100])
	by udon.noodlefactory.co.uk with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <oinksocket@letterboxes.org>)
	id 1O6jPc-0004Aw-2Q; Tue, 27 Apr 2010 12:57:12 +0100
User-Agent: Thunderbird 2.0.0.24 (X11/20100317)
In-Reply-To: <l2w717f7a3e1004270341lea6cfe2aqdf8d2b490b1ec067@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145901>

Marin Atanasov wrote:
> I want to convert CVS repo to a Git one.

If you don't care about incrementally updating the Git repo from the CVS one, I
suggest you don't use git-cvsimport. It can make mistakes in the translation,
especially with large and old repositories.  On the other hand, git-cvsimport is
currently the only tool which can incrementally import changes from CVS, i.e.
co-exist with it.

cvs2git is a tool which worked more reliably for me, but it can only make a
one-off conversion.  Also, you might need to tidy up the result afterwards -
removing crufty tags, unrelated directories, correcting committer identities,
etc.  git-filter-branch may be useful here.

If you do care about co-existing with CVS, I find it gets to be hard work,
especially if your CVS repo has branches you have to follow - so really I'd
suggest you reconsider and only try it if you really have no choice.

In that case you may want to write a wrapper script for
git-cvsimport/exportcommit commands to reduce the complexity of using them.
I've attempted this, and it sort of works for me, but the result is not really
satisfactory, I find it's still liable to break on encountering random things
cvsimport/cvsexportcommit can't handle, and then you need to fix things manually
(although usually this can be done in Git).  Ask me if you want to know more.

git-cvssever may be another option, if your CVS users agree, but I've no
experience with it.

My preferred strategy is to persuade my colleagues to abandon CVS entirely.


Cheers,

N
