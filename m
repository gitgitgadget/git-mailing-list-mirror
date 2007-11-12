From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH] tests: git push mirror mode tests V2
Date: Mon, 12 Nov 2007 15:25:41 +0000
Message-ID: <20071112152541.GJ301@shadowen.org>
References: <1194541305.0@pinky> <1194603673.0@pinky> <7vsl3frxpk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 16:25:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrbAY-0003TL-41
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 16:25:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218AbXKLPZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 10:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752092AbXKLPZa
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 10:25:30 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:1350 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325AbXKLPZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 10:25:29 -0500
Received: from localhost ([127.0.0.1] helo=pinky)
	by hellhawk.shadowen.org with esmtp (Exim 4.63)
	(envelope-from <apw@shadowen.org>)
	id 1IrbAG-0006nM-Kg; Mon, 12 Nov 2007 15:25:28 +0000
Content-Disposition: inline
In-Reply-To: <7vsl3frxpk.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64636>

On Fri, Nov 09, 2007 at 12:05:43PM -0800, Junio C Hamano wrote:
> Andy Whitcroft <apw@shadowen.org> writes:
> 
> > +test_expect_success 'push mirror does not create new branches' '
> > +
> > +	mk_repo_pair &&
> > +	(
> > +		cd master &&
> > +		echo one >foo && git add foo && git commit -m one &&
> > +		git push --mirror up
> > +	) &&
> > +	master_master=$(cd master && git show-ref -s --verify refs/heads/master) &&
> > +	mirror_master=$(cd mirror && git show-ref -s --verify refs/heads/master) &&
> > +	test "$master_master" = "$mirror_master"
> > +
> > +'
> 
> I am quite puzzled by this and many other "does not" in the test
> description.  The --mirror option is advertised as
> 
>  - newly created will be pushed;
>  - locally updated will be force pushed;
>  - locally deleted will be removed.
> 
> which makes sense as we do want these things to happen for
> "mirrors".  Indeed the above updates master branch at the master
> repository and makes sure that change is propagated to the
> mirror repository.  The description should read "push mirror
> creates new branches" shouldn't it?

Indeed, I think the problem was a miss-understanding of the example I
copied from.  I think partly I thought that the message was only
displayed on failure.  Which is firstly demonstrably false, and secondly
I am not consistent in applying that false knowledge.

If these are not already fixed up in pu I will check and sort them out.

-apw
