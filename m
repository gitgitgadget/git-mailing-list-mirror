From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] teach update-index --refresh about --data-unchanged
Date: Wed, 3 Nov 2010 18:02:43 -0400
Message-ID: <20101103220243.GA6777@arf.padd.com>
References: <20101031174430.GA30236@arf.padd.com>
 <20101031195933.GA21240@burratino>
 <20101031222644.GA31257@arf.padd.com>
 <20101031222805.GB31257@arf.padd.com>
 <7vzktqwbob.fsf@alter.siamese.dyndns.org>
 <20101103183621.GA14019@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 03 23:02:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDlPy-0001Jz-Ky
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 23:02:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752605Ab0KCWCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 18:02:50 -0400
Received: from honk.padd.com ([74.3.171.149]:56966 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751587Ab0KCWCs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 18:02:48 -0400
Received: from arf.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id A34F2EE;
	Wed,  3 Nov 2010 15:02:47 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 4267A319E9; Wed,  3 Nov 2010 18:02:43 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20101103183621.GA14019@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160642>

jrnieder@gmail.com wrote on Wed, 03 Nov 2010 13:36 -0500:
> On Wed, Nov 03, 2010 at 10:37:40AM -0700, Junio C Hamano wrote:
> > Pete Wyckoff <pw@padd.com> writes:
> 
> >> When a repository has been copied with rsync, or cloned using
> >> a volume manager, the index can be incorrect even though the
> >> data is unchanged.  This new flag tells update-index --refresh
> >> that it is not necessary to reread the data contents.
> >
> > I know our traditional attitude towards the plumbing commands have been
> > "give them long enough rope and let users hang themselves", but this
> > particular rope feels a bit too long for my taste.
> 
> Pete, I think you mentioned the possibility of a special-case tool for
> contrib/ that just updates the inode, device number, and ctime fields?
> That sounds a little less worrying to use, as plumbing.

Yes, I'd been discussing with Jonathan offlist that I too agree
this is a bit bizarre for general use.  Especially when thinking
about how to explain the new flag in the manpage, and how
interactions with other command-line options should work.

I wrote a short C program to use existing functions from cache.h
to read and write the index, updating the entries by hand.  Once
I figure out how to build it nicely, I'll submit for contrib/.  I
haven't figured out how to include the useful bits of the
top-level Makefile (like SSL setting, which SHA1, -lpthread,
etc.).

		-- Pete
