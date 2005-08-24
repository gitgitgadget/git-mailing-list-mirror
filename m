From: Tony Luck <tony.luck@gmail.com>
Subject: Re: baffled again
Date: Tue, 23 Aug 2005 22:33:33 -0700
Message-ID: <12c511ca050823223333c41857@mail.gmail.com>
References: <200508232256.j7NMuR1q027892@agluck-lia64.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 24 07:35:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7nuh-0005rq-E2
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 07:35:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbVHXFdk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Aug 2005 01:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbVHXFdk
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Aug 2005 01:33:40 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:47677 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751467AbVHXFdk convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2005 01:33:40 -0400
Received: by zproxy.gmail.com with SMTP id i11so21075nzh
        for <git@vger.kernel.org>; Tue, 23 Aug 2005 22:33:33 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DLgrRHO+XgwUr3ZQbj3tSQigbHjAzYRH1urKkbhZ31eVoFIeY1VtW+dXa0MP1+juHEw8WxTnRWwV8KYxKfkR9QOhVF4h977theq9DhmwW2NxO3A0iPBChVB20LUPdxLZnUFGFPTqEhbFJO1lTLSTYSERBIFYgZJFosPLoqa8Vt0=
Received: by 10.36.227.59 with SMTP id z59mr152009nzg;
        Tue, 23 Aug 2005 22:33:33 -0700 (PDT)
Received: by 10.36.57.3 with HTTP; Tue, 23 Aug 2005 22:33:33 -0700 (PDT)
To: "tony.luck@intel.com" <tony.luck@intel.com>
In-Reply-To: <200508232256.j7NMuR1q027892@agluck-lia64.sc.intel.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7703>

I'm at home, and too lazy to log in to work to look at my tree.  But I
have a theory
as to what went wrong for me.

At the start I had a file, same contents in test and release branch.

I applied a patch to release, and pulled to test.  So the contents are still
the same, both with the patch applied.

Next, I was given a better patch (the first one just masked the real problem
and happened to make the symptoms go away). This patch touches a
completely different file.  So I applied a patch to revert the change
in release,
and the new patch.

Now ... when I try to merge release into test, my guess is that GIT is
looking at the common ancestor before I touched anything.  So when
it compares the current state of this file it sees that I have the bad patch
in the test tree, and the release tree has the "original" version (which has
had the patch applied and reverted ... so the contents are back at the
original state).

So GIT decides that the test branch has had a patch, and the release
branch hasn't ... and so it merges by keeping the version in test.

Plausible?

-Tony
