From: "Klas Lindberg" <klas.lindberg@gmail.com>
Subject: Re: git-fetch remote tag to local branch fails
Date: Wed, 25 Jun 2008 10:50:06 +0200
Message-ID: <33f4f4d70806250150q41f09764m4ae0cc1cd6e15e30@mail.gmail.com>
References: <33f4f4d70806240517h5e3ae420h263dd0c2d6bae459@mail.gmail.com>
	 <8aa486160806240638o221b01d2i2f46cc8f0f3760a3@mail.gmail.com>
	 <33f4f4d70806240701o1c00cef2g688a188970964b0f@mail.gmail.com>
	 <8aa486160806240727r6fc6de6doec8300700293a3a7@mail.gmail.com>
	 <33f4f4d70806240831q14caacddp66645e1bcfb6d14b@mail.gmail.com>
	 <8aa486160806240911p49d7bcb8q82a8d68c51206543@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 10:51:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBQiZ-0004U1-R3
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 10:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753906AbYFYIuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 04:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753844AbYFYIuK
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 04:50:10 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:64518 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753884AbYFYIuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 04:50:09 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1331636fgg.17
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 01:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=vsbzy3nJFtnV3z9fQajWTS/Y/Lmb2t1sQY9Zu3KGI38=;
        b=Y+n6nm04T4U0qL3OaL3fM6RlbZYn305oYHPkLUj/0CcuN5y4vLec5BsfKId9tF9s3q
         WgvJy+aPQwnhwKqloJb4qrKihl90MBesGzkfovXthiSZvuO9KpjQt7SM8mW3qmG1uTXV
         wyB2PjC1DThf7vjUT0jrVj36WFhpnv1qS0Jpg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=pcAiDhyR9dvvQKiKxusj7zY42cgAm1It5mTfWPDH1XtVSRRoqPvuIPgKUuTDdRrBeN
         3sdLNxSTxzPIx0H49YWyyP3vybs9XjDsp6x4ixJ/8oUJJfB/+bRbzKfq/HyAyPUErPjK
         osUOr1PKf8BDXppYbWixG8x+hcXEk+dnEBM8s=
Received: by 10.86.80.5 with SMTP id d5mr10085601fgb.11.1214383806806;
        Wed, 25 Jun 2008 01:50:06 -0700 (PDT)
Received: by 10.86.68.16 with HTTP; Wed, 25 Jun 2008 01:50:06 -0700 (PDT)
In-Reply-To: <8aa486160806240911p49d7bcb8q82a8d68c51206543@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86255>

>> I am looking into the possibility of writing a tool that handles
>> configurations of trees.
>
> Maybe you should be using the plumbing commands.

Yes. It looks like it.

>> For instance, I want the tool to be able to
>> consume some version of a configuration and create, update or reset
>> branches in other trees accordingly.
>
> What are the "other trees"?

One tree tracks a configuration file that just contains specs for
other trees. The idea is something like this: Given a refspec on the
configuration tree, git-view the configuration file and use the
contained refspecs to clone/pull/fetch/reset/whatever a bunch of other
trees.

Note that I'm not trying to solve the problem addressed by the
submodules system in git; I need configuration management.

> Maybe you want to keep your local branches up to date with respect
> their tracking branch?

Well yes, but that is only half of it. One of the scenarios I'm
pondering is this: A user wants to take an old configuration based on
tags and try some use case that breaks a newer configuration. After
the checkout, the working trees will not be "on" any branches (what's
the word for that?). Unfortunately, most people seem to think that
everything in a VCS happens on a branch. A lot of people will
incorrectly assume that they are still on their "working branch"
because they didn't check out a different branch! They checked out a
tag and, like myself, have muddy ideas about what that actually means
in relation to branches. I'd prefer to not have to tell them to try
git-lost-found on a 40 different trees to recover commits that they
made on non-branches.

I'll have to think more about this. It's not a functionality
shortcoming, but a UI one.

> I don't see the point updating a branch with a tag, but you can make a
> tool to update a branch with a tag, see for example
> contrib/examples/git-fetch.sh.

Thank you. I'll have a look at that, but after our conversation I
think I was mentally stuck in the land of some other VCS. I know
perfectly well that a tag is not just a marker along some branch, but
I realize now that I was thinking of it as if it was.

/Klas
