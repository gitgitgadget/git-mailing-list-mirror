From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 1/4] git p4: bring back files in deleted client directory
Date: Mon, 30 Apr 2012 17:56:09 -0400
Message-ID: <20120430215609.GA22615@padd.com>
References: <1335747437-24034-1-git-send-email-pw@padd.com>
 <1335747437-24034-2-git-send-email-pw@padd.com>
 <4F9E376B.1000107@diamand.org>
 <20120430123650.GB25045@padd.com>
 <4F9EDB34.5090103@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Mon Apr 30 23:56:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOyZx-00084e-FC
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 23:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757263Ab2D3V4Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 17:56:16 -0400
Received: from honk.padd.com ([74.3.171.149]:44224 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757162Ab2D3V4O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 17:56:14 -0400
Received: from arf.padd.com (unknown [50.55.155.59])
	by honk.padd.com (Postfix) with ESMTPSA id B84CF309D;
	Mon, 30 Apr 2012 14:56:13 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id C0D54313F8; Mon, 30 Apr 2012 17:56:09 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <4F9EDB34.5090103@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196613>

luke@diamand.org wrote on Mon, 30 Apr 2012 19:34 +0100:
> On 30/04/12 13:36, Pete Wyckoff wrote:
> >luke@diamand.org wrote on Mon, 30 Apr 2012 07:55 +0100:
> >>
> >>Rebasing the current branch onto remotes/p4/master
> >>First, rewinding head to replay your work on top of it...
> >>File file1 doesn't exist. file1
> >>not ok - 3 submit with no client dir
> >
> >I can't figure it out.  Will you help debug a bit?  Something
> >like this maybe.
> 
> User error.
> 
> % cp git-p4.py git-p4
> 
> Then it works fine.

Whew.  I caught myself forgetting to build a couple
of times too.

"make git-p4" is a bit more official.

> Is there a way to get lib-git-p4.sh to check this?

This does seem appealing, but I'm not sure if it will be
attractive to everybody else.

My thought pattern of what to put in lib-git-p4.sh
went like:

    test git-p4.py -nt git-p4 && {
	echo "You must make git-p4" >&2
	exit 1
    }

to

    test git-p4.py -nt git-p4 && {
	echo "Making git-p4" >&2
	make git-p4
    }

to

    make git-p4

to

    make

and that's when I realized that everybody else has
the same problem too.  Somehow they've gotten used
to rebuilding before rerunning the tests.  I suspect
that we should get used to it too.

That said, it would have saved me some head scratching
on a few occasions.

		-- Pete
