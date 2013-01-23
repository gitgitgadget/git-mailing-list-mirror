From: John Keeping <john@keeping.me.uk>
Subject: Re: What's cooking in git.git (Jan 2013, #08; Tue, 22)
Date: Wed, 23 Jan 2013 13:55:10 +0000
Message-ID: <20130123135510.GN7498@serenity.lan>
References: <7va9s0n8gv.fsf@alter.siamese.dyndns.org>
 <20130122234554.GI7498@serenity.lan>
 <7vobgglpv4.fsf@alter.siamese.dyndns.org>
 <20130123092858.GJ7498@serenity.lan>
 <CAEUsAPaUy5ug0_HPjWDTSnAG0kURhP-1-9nOu9_Tpn5nEv6N_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Eric S. Raymond" <esr@thyrsus.com>
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 14:55:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty0nq-0001cb-KC
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 14:55:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755439Ab3AWNzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 08:55:22 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:34020 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755144Ab3AWNzV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 08:55:21 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 7D2C3CDA666;
	Wed, 23 Jan 2013 13:55:20 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bopHIGg-pTqh; Wed, 23 Jan 2013 13:55:19 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id CA89DCDA5EA;
	Wed, 23 Jan 2013 13:55:18 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id E64D1161E5E4;
	Wed, 23 Jan 2013 13:55:18 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wcPJYM7elyLa; Wed, 23 Jan 2013 13:55:18 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id EC15E161E5E3;
	Wed, 23 Jan 2013 13:55:12 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CAEUsAPaUy5ug0_HPjWDTSnAG0kURhP-1-9nOu9_Tpn5nEv6N_Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214319>

On Wed, Jan 23, 2013 at 07:26:24AM -0600, Chris Rorvick wrote:
> On Wed, Jan 23, 2013 at 3:28 AM, John Keeping <john@keeping.me.uk> wrote:
> > In my opinion the incremental import support really is substantially
> > worse in cvsimport-3 than cvsimport-2.  cvsimport-2 looks at the output
> > of git-for-each-ref to calculate the dates from which to continue each
> > branch.  cvsps cannot be told this information and so the cvsimport-3
> > script just takes the date of the last commit on the current branch.
> 
> Do you really need a timestamp per branch, though?  If you have
> branches A and B, and B has a commit timestamp 5 minutes after A, you
> can infer that nothing happened on A for those five minutes, right?
> So maybe a single timestamp is sufficient, it just may not be picking
> the right one.  Instead cvsimport-3 should compute the latest
> timestamp across all import branches.

The problem is telling which is an import branch, since it currently
just used "refs/heads/<branch>".

I do have a change to write the timestamp to a file, which takes the
newest commit across all of the branches that have changed during an
import.  That may well be good enough but doesn't let you incrementally
update a repository that has been cloned from elsewhere.


John
