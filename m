From: Brian Gernhardt <benji@silverinsanity.com>
Subject: t9200-git-cvsexportcommit #8 failure on OS X
Date: Tue, 30 Jan 2007 11:32:19 -0500
Message-ID: <20070130163219.GA14431@164.242.249.10.in-addr.arpa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 30 17:32:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBvui-0007iG-Gb
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 17:32:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965565AbXA3Qcd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 11:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965571AbXA3Qcd
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 11:32:33 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:58981 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965565AbXA3QcU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 11:32:20 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by silverinsanity.com (Postfix) with ESMTP id D878B1FFC02B
	for <git@vger.kernel.org>; Tue, 30 Jan 2007 16:32:19 +0000 (UTC)
Received: from Mutt by mutt-smtp-wrapper.pl 1.2  (www.zdo.com/articles/mutt-smtp-wrapper.shtml)
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38167>

* expecting success: mkdir -p ?/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/?/?/? &&
      echo Foo >?/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/?/?/?/g?rdets?g?rdet.txt &&
      git add ?/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/?/?/?/g?rdets?g?rdet.txt &&
      cp ../test9200a.png ?/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/?/?/?/g?rdets?g?rdet.png &&
      git add ?/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/?/?/?/g?rdets?g?rdet.png &&
      git commit -a -m "G?r det s? g?r det" && \
      id=$(git rev-list --max-count=1 HEAD) &&
      (cd "$CVSWORK" &&
      git-cvsexportcommit -v -c $id &&
      test "$(echo $(sort ?/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/?/?/?/CVS/Entries|cut -d/ -f2,3,5))" = "g?rdets?g?rdet.png/1.1/-kb g?rdets?g?rdet.txt/1.1/"
      )
mkdir: ?: Invalid argument

It looks like one of the odd characters that git's using for the test is
an invalid character for HFS+, so the entire test fails.  Perhaps this
should be made a "soft" failure like all of the SVN tests passing
despite me not having SVN installed, or should a different character be
used somewhere?  Git can't possibly be expected to work in a situation
where the FS fails.

~~ Brian
