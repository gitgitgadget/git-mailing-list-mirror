From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC/PATCH 0/3] use '--bisect-refs' as bisect rev machinery option
Date: Thu, 5 Nov 2009 06:22:27 +0100
Message-ID: <200911050622.27159.chriscool@tuxfamily.org>
References: <20091104034312.4545.2176.chriscool@tuxfamily.org> <200911042226.25599.chriscool@tuxfamily.org> <7vtyxaez4f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 06:20:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5um1-00043E-QI
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 06:20:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753502AbZKEFUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 00:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753454AbZKEFUX
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 00:20:23 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:39928 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752658AbZKEFUT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 00:20:19 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 9723281805A;
	Thu,  5 Nov 2009 06:20:18 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id CE107818042;
	Thu,  5 Nov 2009 06:20:14 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7vtyxaez4f.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132196>

On Wednesday 04 November 2009, Junio C Hamano wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
> > So to do that you would use "git bisect start ..." and then you could
> > use:
> >
> > $ git rev-list --bisect HEAD --not $GOOD_COMMITS
> >
> > to get the commit that you would have to test if the current commit is
> > bad and:
> >
> > $ git rev-list --bisect  $BAD --not $GOOD_COMMITS HEAD
> >
> > to get the commit that you would have to test if the current commit is
> > good.
>
> Even in that case, the problem is still about narrowing the set of the
> current bisection graph.  If --bisect option implicitly grabs good and
> bad defined in the refspace like Linus's patch does, it will give you the
> same behaviour of the above two commands, no?

I think it will probably work when you add a good rev, but in the case where 
you give a different bad (the first command above) it does not work the 
same.

The test case in patch 1/3 shows that. It does:

git bisect start $HASH7 $HASH1 &&
...
rev_list2=$(git rev-list --bisect $HASH3 --not $HASH1) &&
test "$rev_list2" = "$HASH2" 

and that last command fails.

Best regards,
Christian.
