From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: GSoC idea: allow "git rebase --interactive" todo lines to take options
Date: Wed, 26 Feb 2014 09:04:30 +0100
Message-ID: <530DA00E.4090402@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 26 09:04:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIZTr-0002OV-Ke
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 09:04:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864AbaBZIEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 03:04:35 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:54638 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751017AbaBZIEe (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Feb 2014 03:04:34 -0500
X-AuditID: 1207440f-f79326d000003c9f-73-530da0118f0e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id D6.20.15519.110AD035; Wed, 26 Feb 2014 03:04:33 -0500 (EST)
Received: from [192.168.69.148] (p57A2498D.dip0.t-ipconnect.de [87.162.73.141])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s1Q84VSY020285
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 26 Feb 2014 03:04:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsUixO6iqCu4gDfYoO+rnEXXlW4mi/7lXWwW
	E+43MDswe+ycdZfd48PHOI/Pm+QCmKO4bZISS8qCM9Pz9O0SuDPuLioomCpa0bRzE0sD4wmB
	LkZODgkBE4kFnUuZIWwxiQv31rN1MXJxCAlcZpRYveQjO0hCSOA8k8SNz2kgNq+AtsTyl8uY
	QGwWAVWJyy3rwZrZBHQlFvU0g8VFBYIlVl9+wAJRLyhxcuYTMFsEqGbXs6tsIDazQJnE9/5r
	YL3CAv4S/7pXAtVwAB0hLtHTGARRoiPxru8BM4QtL7H97RzmCYz8s5BMnYWkbBaSsgWMzKsY
	5RJzSnN1cxMzc4pTk3WLkxPz8lKLdE30cjNL9FJTSjcxQsKTfwdj13qZQ4wCHIxKPLwBLLzB
	QqyJZcWVuYcYJTmYlER5i2YDhfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nwvq4AyvGmJFZWpRbl
	w6SkOViUxHnVl6j7CQmkJ5akZqemFqQWwWRlODiUJHjZ5wM1ChalpqdWpGXmlCCkmTg4QYZz
	SYkUp+alpBYllpZkxIOiMb4YGI8gKR6gvRzzQPYWFyTmAkUhWk8xGnPcbvv1iZHj6vZ/nxiF
	WPLy81KlxHm9QUoFQEozSvPgFsES0ytGcaC/hXkFQe7hASY1uHmvgFYxAa06Ks0DsqokESEl
	1cC4TXxGzAe3iS5/t38PYgwM9Iw8+EWZT9/R8YFxQdGtgqMnT3kf7Nu2Z5NE0MzYr2Lzb6td
	nxv4302uaoPopSdCDMwu2usmZfQF2XN++6lukGVz5E/uJMMKA+uFvatu61//o7Fv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242701>

I just submitted the idea below as a pull request [1] to the GSoC ideas
page, but I'd like to get some mailing list feedback first that the idea
is sensible...

And, is there anybody else willing to volunteer as a mentor for this
project?  (There should be at least two.)

Michael

[1] https://github.com/git/git.github.io/pull/5


## Line options for `git rebase --interactive`

One of the more powerful features in Git is the command `git rebase
--interactive`, which allows recent commits to be reordered, squashed
together, or even revised completely.  The command creates a todo list
and opens it in an editor.  The original todo list might look like:

    pick deadbee Implement feature XXX
    pick c0ffeee The oneline of the next commit
    pick 01a01a0 This change is questionable
    pick f1a5c00 Fix to feature XXX
    pick deadbab The oneline of the commit after

The user can edit the list to make changes to the history, for example
to

    pick deadbee Implement feature XXX
    squash f1a5c00 Fix to feature XXX
    exec make
    edit c0ffeee The oneline of the next commit
    pick deadbab The oneline of the commit after

This would cause commits `deadbee` and `f1a5c00` to be squashed
together into one commit followed by running `make` to test-compile
the results, delete commit `01a01a0` altogether, and stop after
committing commit `c0ffeee` to allow the user to make changes.

It would be nice to support more flexibility in the todo-list commands
by allowing the commands to take options.  Maybe

* Convert a commit into a merge commit:

      pick -p c0ffeee -p e1ee712 deadbab The oneline of the commit after

* After squashing two commits, add a "Signed-off-by" line to the
  commit log message:

    pick deadbee Implement feature XXX
    squash --signoff f1a5c00 Fix to feature XXX

  or GPG-sign a commit:

    pick --gpg-sign=<keyid> deadbee Implement feature XXX

* Reset the author of the commit to the current user or a specified
  user:

    pick --reset-author deadbee Implement feature XXX
    pick --author="A U Thor <author@example.com>" deadbab The oneline of
the commit after

The goal of this project would be (1) to add the infrastructure for
handling options on todo-list lines, and (2) implement some concrete
options.  A big part of the difficulty of this project is that `git
rebase --interactive` is implemented via a sparsely-commented shell
script.  Adding comments and cleaning up the script as you go would be
very welcome.

 - Language: sh
 - Difficulty: medium
 - Possible mentors: Michael Haggerty

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
