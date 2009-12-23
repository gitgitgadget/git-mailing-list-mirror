From: Greg Price <price@ksplice.com>
Subject: Re: [PATCH RFC 4/4] rebase -i: add --refs option to rewrite heads 
	within branch
Date: Wed, 23 Dec 2009 12:34:29 -0500
Message-ID: <1ac2d430912230934h600575e4h17e2ee84f53de1a0@mail.gmail.com>
References: <20091222222032.GU30538@dr-wily.mit.edu>
	 <20091222222316.GY30538@dr-wily.mit.edu>
	 <7vzl5awpf1.fsf@alter.siamese.dyndns.org>
	 <1ac2d430912222303k6180baa6j291bb4d18c7a4968@mail.gmail.com>
	 <4B31DA96.1050608@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Dec 23 18:34:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNV6e-0003Xf-1Y
	for gcvg-git-2@lo.gmane.org; Wed, 23 Dec 2009 18:34:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755770AbZLWRed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2009 12:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754574AbZLWRed
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Dec 2009 12:34:33 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:24746 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754468AbZLWReb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2009 12:34:31 -0500
Received: by ey-out-2122.google.com with SMTP id 25so544170eya.19
        for <git@vger.kernel.org>; Wed, 23 Dec 2009 09:34:30 -0800 (PST)
Received: by 10.216.87.9 with SMTP id x9mr1583767wee.0.1261589669790; Wed, 23 
	Dec 2009 09:34:29 -0800 (PST)
In-Reply-To: <4B31DA96.1050608@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135625>

On Wed, Dec 23, 2009 at 3:53 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> If I may jump in: I imagine this to be the more common use case, i.e.:
> You have a part of the DAG which you want to rebase, with all kinds of
> refs (branches, tags) pointing to commits in that part of the DAG. If
> you rebase that part of the DAG you typically want some refs rewritten
> (such as the head of the branch you're rebasing) but maybe not others
> (say a release tag or branch). remote refs should never be rebased. So,
> one would need an easy way to specify one ref, all or anything in between...

I see the interactive aspect as the backstop that gives the user total
flexibility, whatever command-line interface we choose.  So, for
example, a user might find it easiest to pass --rewrite-heads so that
all heads on the given part of the DAG are inserted as "ref" commands
in the appropriate places, and then go through and remove from the
TODO file any exceptions.

But I agree it is worth making convenient shortcuts by which the user
can specify their intention precisely on the command line itself.  And
in any case, if we are to satisfy this latter use case we need a way
of specifying a part of the DAG to rebase that is not only ancestors
of a single commit.  What do you think of the
"--rewrite-refs=refs/heads/,refs/tags/" and "git rebase -i master
topic side" proposals in my reply to Junio?

Greg
