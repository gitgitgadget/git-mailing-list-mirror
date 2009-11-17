From: Bill Lear <rael@zopyra.com>
Subject: Script to tie git and Jira
Date: Mon, 16 Nov 2009 19:44:55 -0600
Message-ID: <19202.23.659967.922524@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Patrick Schoenfeld <schoenfeld@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 17 02:45:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAD8A-0005AZ-1o
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 02:45:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754769AbZKQBpD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 20:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755214AbZKQBpC
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 20:45:02 -0500
Received: from 75-27-130-60.lightspeed.austtx.sbcglobal.net ([75.27.130.60]:53503
	"EHLO zopyra.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754365AbZKQBpB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 20:45:01 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id nAH1j6j18448;
	Mon, 16 Nov 2009 19:45:06 -0600
X-Mailer: VM 8.0.11 under Emacs 21.1.1 (i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133051>

I have started a project on github that is essentially a script to tie
git and Jira, at http://github.com/rael/git-jira.  We use it at our
company to help us with release management and it has proven useful.
See the README file for complete details.  Following is a brief
overview.

The script implements a certain convention we use: developers do work
on topic branches that are named after Jira tickets and are created as
branches off of origin/master.

When you first run the script, it will prompt you for connection
parameters to your Jira server.  You will then be able to create new
Jira issues and associated git branches:

% git jira open --summary "Better log filtration method"
git branch PROJ-20 created
% git branch -a
  PROJ-20
* master

You can supply defaults for project, component, and issue type in your
git config file, and you can provide these as arguments to the script
as well (the README shows how to do this).

You can add a suffix when opening an issue if you like, to help you
remember the purpose of the branch:

% git jira open --summary "Better log filtration method" -x "improve_logging"
git branch PROJ-20_improve_logging created
% git branch -a
  PROJ-20_improve_logging
* master

Or, you can rely on the script to tell you details of a git jira
branch (with or without a suffix):

% git jira describe -i PROJ-20_improve_logging
Data for issue: PROJ-20

Issue key . . . . . . . . . . : PROJ-20
Type  . . . . . . . . . . . . : Bug(1)
Status  . . . . . . . . . . . : Open(1)
Priority  . . . . . . . . . . : Major(3)
Assignee  . . . . . . . . . . : rael
Reporter  . . . . . . . . . . : rael
Created . . . . . . . . . . . : 11/16/09 7:30 PM
Updated . . . . . . . . . . . : 11/16/09 7:30 PM
Due date  . . . . . . . . . . :
Summary . . . . . . . . . . . : Better filtration method
Description . . . . . . . . . :
Components  . . . . . . . . . : 'Component1'
Affects versions  . . . . . . :
Fix versions  . . . . . . . . :
Environment . . . . . . . . . :
Resolution  . . . . . . . . . :
Votes . . . . . . . . . . . . : 0

Adding a '-v' or '--verbose' will add all comments to the output.

This will also work implicitly for the current branch:

% git checkout PROJ-20_improve_logging
% git jira describe
Data for issue: PROJ-20

Issue key . . . . . . . . . . : PROJ-20
Type  . . . . . . . . . . . . : Bug(1)
[...]

You can also resolve issues you have completed:

% git jira close -i PROJ-20
Successfully progressed issue: PROJ-20 with step 'Resolve Issue'

Feel free to provide comments, criticize, suggest improvements, etc.


Bill
