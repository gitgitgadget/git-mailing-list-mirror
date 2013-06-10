From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 0/7] git send-email suppress-cc=self fixes
Date: Mon, 10 Jun 2013 09:53:24 +0300
Message-ID: <20130610065324.GA26501@redhat.com>
References: <1370455737-29986-1-git-send-email-mst@redhat.com>
 <7v8v2o1ho7.fsf@alter.siamese.dyndns.org>
 <20130605201423.GB31143@redhat.com>
 <7vy5ain9yg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 08:53:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlvyW-00063y-IK
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 08:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411Ab3FJGwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 02:52:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:12368 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751372Ab3FJGwt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 02:52:49 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r5A6qlJx021208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 10 Jun 2013 02:52:47 -0400
Received: from redhat.com (vpn1-6-65.ams2.redhat.com [10.36.6.65])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id r5A6qjmS013224;
	Mon, 10 Jun 2013 02:52:46 -0400
Content-Disposition: inline
In-Reply-To: <7vy5ain9yg.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227244>

On Sun, Jun 09, 2013 at 04:25:11PM -0700, Junio C Hamano wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > With respect to this, and a bit off-topic, what's
> > the best way to revise patch series?
> >
> > What I did, given series in patchvN-1/:
> >
> > 	rm -fr patchvN #blow away old directory if there
> > 			# otherwise I get two copies of patches if I renamed any
> 
> Not needed with recent "git format-patch -v4" option.

Unless I rerun with same vX :(
Would it make sense for it to check for vX existance and fail?
Same without -vX, when 000X exists ...
Could be an option.

> > 	git branch|fgrep '*'
> > 	# Figure out on which branch I am, manually specify the correct upstream I'm tracking,
> > 	# otherwise I get a ton of unrelated patches.
> 
> git-prompt with PS1 you do not need this either.

grep serves just as well but
I still need to copy it to the next line manually...

I vaguely remember there was some way to say
"head of the remote I am tracking" - but I could not find it.
Where are all the tricks like foo^{} documented?
I tried fgrep '{}' Documentation/*txt and it only returned
git-show-ref.txt which isn't really informative ...

Additionally, or alternatively, would it make sense for git format-patch
to format the diff against the tracking branch by default?

> > 	git format-patch --cover --subject-prefix='PATCH vN' -o patchvN origin/master..
> 
> Again, "git format-patch -v4 -o mt-send-email" will deposit the new
> ones alongside the older round.
> 
> > 	vi patchvN/0000* patchvN-1/0000*
> 
> Same (i.e. "vi mt-send-email/v*-0000-*.txt).

I still need to copy subject, Cc list and blurb to the next line manually.
Now that there's a concept of revisions,
maybe git format-patch -v4 could copy the text
and subject from v3?

-- 
MST
