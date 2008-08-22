From: "Govind Salinas" <govind@sophiasuchtig.com>
Subject: Problem with --skip and --max-count
Date: Fri, 22 Aug 2008 10:06:46 -0500
Message-ID: <5d46db230808220806j21a81864he77a3b05e298ce2b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 22 17:08:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWYF2-0007qw-KY
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 17:07:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751953AbYHVPGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 11:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751884AbYHVPGx
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 11:06:53 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:39759 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751817AbYHVPGw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 11:06:52 -0400
Received: by gxk9 with SMTP id 9so1229616gxk.13
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 08:06:51 -0700 (PDT)
Received: by 10.151.153.14 with SMTP id f14mr2014511ybo.29.1219417611476;
        Fri, 22 Aug 2008 08:06:51 -0700 (PDT)
Received: by 10.150.12.16 with HTTP; Fri, 22 Aug 2008 08:06:46 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93309>

Hey Folks,

I have been working on my porcelain, trying to get it semi-polished and
I noticed that the behavior of --skip and --max-count is not what I expected
in several cases.

For simple output, it works as I think it should, but whenever you are doing
some kind of filtering or non-standard commit limiting, such as passing
--follow, it does not print out the first X results.  Similarly --skipping the
number of items that you got back does not put get you to where you left
off.

Basically, I am trying to use --skip and --max-count to do paging, but
when I add filters, it doesn't work very well.  For example...

$ git log --pretty=oneline --follow -- pyrite/git/repository.py | wc -l
103

$ git log --pretty=oneline --follow -20 -- pyrite/git/repository.py | wc -l
2

$ git log --pretty=oneline --follow -20 --skip=20 --
pyrite/git/repository.py | wc -l
2

So where I am trying to page by 20, I am only getting a random number of
commits depending on how many fit the criteria in the window.  I understand
this is probably by design, but it is not optimal to work with.  I had to
manually do the skipping and limiting, which would probably have been
more efficient if it had been done by git.  Would it be possible to get
git to limit and skip based on the number of results it had returned rather
than the number of result it had processed?  Even new cmd line args
would work.

I am using 1.6.0 BTW.

Thanks,
Govind
