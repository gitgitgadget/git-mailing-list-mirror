From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: A system administration use case for git
Date: Wed, 22 Apr 2009 12:07:36 +0200
Message-ID: <46a038f90904220307h2ac16881qe29c77c5a0334160@mail.gmail.com>
References: <2cfc40320904220133l5ab567f3q46608793b93f0e1f@mail.gmail.com>
	 <46a038f90904220148i23f1a75n7036d9726870d5f5@mail.gmail.com>
	 <2cfc40320904220208g5acc2200w6144668ba2da5a09@mail.gmail.com>
	 <2cfc40320904220222ub9b95f8o35afcddb0390fe1b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 12:10:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwZP7-0003dn-Id
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 12:10:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756362AbZDVKHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 06:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756244AbZDVKHl
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 06:07:41 -0400
Received: from mail-bw0-f163.google.com ([209.85.218.163]:61360 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756214AbZDVKHk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 06:07:40 -0400
Received: by bwz7 with SMTP id 7so2240583bwz.37
        for <git@vger.kernel.org>; Wed, 22 Apr 2009 03:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zljm2CNB/o1MvnxKN6qby9WivgtBLHE/IMha48Lbwz8=;
        b=sVDFdBqpo/CwUbRjUyK2KQUqZLtFc1Zu35lXfnVHeeeuUn/Tb5Mat5TgjTK3KsdaBb
         CGvogVlIF+wI/gKO1CKRZgblBpAkWf4Wvy+miVlF7fKtHqaDIqR35Vo7flvVCBuShOcI
         nGIWlPKyC87MWl4y1gDODsraz1v4WYHLPB6iQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tq0p5DHhC0TMqtCSGDzIMVyI9DllUgKxvKdLvbkwH4MGqa0a9dyB3mthZSNMEu+liz
         Ua+tskKL9wiCFdKxf5np7zOWeWk5kjPLMEo0WbXg8VE7E6I4wE+5/SCqtzOben15JroB
         X49+gKMt4KkItVKwVQQeuXnV7WbyAi8k4krQ0=
Received: by 10.223.113.136 with SMTP id a8mr2438856faq.76.1240394856605; Wed, 
	22 Apr 2009 03:07:36 -0700 (PDT)
In-Reply-To: <2cfc40320904220222ub9b95f8o35afcddb0390fe1b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117187>

On Wed, Apr 22, 2009 at 11:22 AM, Jon Seymour <jon.seymour@gmail.com> wrote:
> One disadvantage of that approach is if the file system is very large
> and only has a few deltas, then I effectively have to have two copies
> of the reference file system - one in the GIT repo and one that I can

You could minimise the on-disk footprint -- and protect it from
concurrent access (concurrent change) by using a hardlinked tree on
the destination side. rsync knows to break hardlinks, etc.

Currently, you can't "rsync into git" which would save you that step.
It's a ton of work to do that -- if anyone is planning on working on
something like that, perhaps writing directly into the fast-import
protocol is a good shortcut.

I'd like to have something like that for my OLPC School Server, which
could benefit from using git as the backup backend -- it currently
uses hardlinked directories.

> In an ideal world, storage requirements at the other place would be
> those of the reference file system + those of the various deltas, but
> no more.

rsync + hardlinked trees + git gets you quite close to that.

cheers,



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
