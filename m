From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: [BUG?] "git rebase --interactive" forces me to edit message.
Date: Thu, 05 Jun 2008 12:58:20 +0900
Message-ID: <200806050358.m553wgK9013230@mi0.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 05 06:00:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K46dz-0001wI-8n
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 06:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753613AbYFED6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 23:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754546AbYFED6n
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 23:58:43 -0400
Received: from mi0.bluebottle.com ([206.188.25.15]:51698 "EHLO
	mi0.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753613AbYFED6n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 23:58:43 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi0.bluebottle.com (8.13.1/8.13.1) with ESMTP id m553wgK9013230
	for <git@vger.kernel.org>; Wed, 4 Jun 2008 20:58:42 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:subject:date:mime-version:
	content-type:content-transfer-encoding:x-trusted-delivery;
	b=dgxAPmlN9uHUv010OeYINEr6VVfrT7pybjFClo6mykIOIoYDjPTgy8VHuRWbdqCvd
	A+JNwlSwnVfkso3GoGh/h+GzmETIrTo52EBDnuKcRiZRCwGIgzauI3kEagNYOw5
Received: from nanako3.mail.bluebottle.com ([212.62.97.21])
	(authenticated bits=0)
	by fe0.bluebottle.com (8.13.1/8.13.1) with ESMTP id m553wZpT001908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 4 Jun 2008 20:58:40 -0700
X-Trusted-Delivery: <7d3e8dea5c172930b5a7daf8923e0a8b>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83850>

When an interactive rebase stops because of conflicts in a commit marked with pick, the user must edit the file to resolve them, run "git add", and run "git rebase --continue".  It then opens vi and asks the user to edit the message.  If I told the command to edit, I think it is OK to start vi, but when I am just picking the commit, I should be able to use the message from the original commit without having to view nor edit nor save it first. Is this a bug?

To reproduce this, first prepare a file with five lines and create an initial commit:

% git init
% cat file
1
2
3
4
5
% git add file
% git commit -m 'initial'
% git tag initial

Then edit the second line and replace "2" with "two", and commit.
Then edit the third line and replace "3" with "three", and commit.

Then say:

% git rebase --interactive initial

and reverse the first two lines.  It stops at the first commit that changes "3" to "three".

Resolve the conflicts by editing it so that it has "1 2 three 4 5", and say:
% git add file
% git rebase --continue

At this point, git opens vi and asks me to edit the message.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Finally - A spam blocker that actually works.
http://www.bluebottle.com/tag/4
