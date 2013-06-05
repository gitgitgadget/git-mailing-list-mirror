From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 0/7] git send-email suppress-cc=self fixes
Date: Wed, 5 Jun 2013 23:14:23 +0300
Message-ID: <20130605201423.GB31143@redhat.com>
References: <1370455737-29986-1-git-send-email-mst@redhat.com>
 <7v8v2o1ho7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 05 22:14:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkK5j-0004kx-Iu
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 22:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757461Ab3FEUNv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 16:13:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49917 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757240Ab3FEUNv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jun 2013 16:13:51 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r55KDn3I031186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 5 Jun 2013 16:13:49 -0400
Received: from redhat.com (vpn-203-36.tlv.redhat.com [10.35.203.36])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id r55KDle8024332;
	Wed, 5 Jun 2013 16:13:48 -0400
Content-Disposition: inline
In-Reply-To: <7v8v2o1ho7.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226468>

On Wed, Jun 05, 2013 at 12:28:08PM -0700, Junio C Hamano wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > This includes bugfixes related to handling of --suppress-cc=self
> > flag. Tests are also included.
> >
> > Changes from v3:
> > 	- v3 submission was missing one patch (1/7). Re-add it.
> > Changes from v2:
> > 	- add a new test, split patches differently add code comments
> > 		 to address comments by Junio
> > 	- rename example addresses in tests from redhat.com to example.com
> > Changes from v1:
> >         - tweak coding style in tests to address comments by Junio
> 
> Nice.  This round cleanly applies and the interdiff since v2 looked
> sensible.
> 
> Will replace and merge to 'next' shortly.
> 
> Thanks.

Wellcome.

With respect to this, and a bit off-topic, what's
the best way to revise patch series?

What I did, given series in patchvN-1/:

	rm -fr patchvN #blow away old directory if there
			# otherwise I get two copies of patches if I renamed any
	git branch|fgrep '*'
	# Figure out on which branch I am, manually specify the correct upstream I'm tracking,
	# otherwise I get a ton of unrelated patches.
	git format-patch --cover --subject-prefix='PATCH vN' -o patchvN origin/master..

	vi patchvN/0000* patchvN-1/0000*

	#manually copy subject, Cc list and text from vN-1 to vN cover letter,
	#leave stats intact.

	git log origin/master.. |grep -e Cc: -e Reviewed -e Acked
	# manually Look who reviewed/acked all patches in previous versions -
	# if so copy them on cover letter too.

	git send-email --cc=junio patchvN/*

lots of manual steps here.
Any ways to automate?


> >
> > Michael S. Tsirkin (7):
> >   t/send-email.sh: add test for suppress-cc=self
> >   send-email: fix suppress-cc=self on cccmd
> >   t/send-email: test suppress-cc=self on cccmd
> >   send-email: make --suppress-cc=self sanitize input
> >   t/send-email: add test with quoted sender
> >   t/send-email: test suppress-cc=self with non-ascii
> >   test-send-email: test for pre-sanitized self name
> >
> >  git-send-email.perl   | 23 ++++++++++------
> >  t/t9001-send-email.sh | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 90 insertions(+), 8 deletions(-)
