From: =?ISO-8859-1?Q?Sebastian_D=F6rner?= 
	<sebastian@sebastian-doerner.de>
Subject: Gitk commit order leads to unnecessarily long lines
Date: Tue, 18 Sep 2012 02:41:18 +0100
Message-ID: <CA+_kBjAWM1XHVsRa4WfDZXvtf8eJGweJhi3Rz7Sfhv390hA7WA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 18 03:41:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDmoa-0003IJ-Lk
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 03:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756425Ab2IRBlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 21:41:20 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:54374 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755744Ab2IRBlT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 21:41:19 -0400
Received: by oago6 with SMTP id o6so5481428oag.19
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 18:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        bh=8e8hfbEQl2W7Fnou4xIfoV7RvtwmgTipLrTFZA9HNa4=;
        b=LurAs0DLL8JeoHk8FP6FljCM96rdmjxwejFvun0UTvyf25qJTrOr8rAQ9154S6mqaL
         3JHBJeu0nWYc0BJCxBiGFedsQtB/j6+CbF+K2QcfDrU9i/aFPh07CrWbL26P4zXBi1aM
         +B19mmLbv5iOzlH+VPvREUC6R9kUBcktRFMAES1XA0h0A3O6MR61njcIrfFRqMpt8p72
         tP4X7MY/TmKbDYVhgJYHBtifqnYulP8F/inV5D1kvAch9IYiRh6O3K83XoQWoC00fSQO
         f3vP3P7A7GAxNNjaA2zbTFSARrft2Ft78mZPYu3SvaUypRvesHqsiVBlE8fJlheKWH5E
         EIPA==
Received: by 10.60.20.165 with SMTP id o5mr13416868oee.135.1347932478626; Mon,
 17 Sep 2012 18:41:18 -0700 (PDT)
Received: by 10.182.39.132 with HTTP; Mon, 17 Sep 2012 18:41:18 -0700 (PDT)
X-Google-Sender-Auth: Sy9X0Y3E1uC7V7iEbtkEcMUa9kc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205778>

Hi,
It seems like the order gitk uses for the commits sometimes leads to
overly long lines. My use case is this repository (note that this
svn-conversion is still WIP):
http://www.sebastian-doerner.de/kompare.tgz

Looking at this with "gitk --all" looks partly like this:
http://i.imgur.com/oewTq.png
Almost all the commits are in one branch. Rendering the merges at the
top much earlier would avoid this line chaos. Interestingly, if you
just render the relevant commits, it looks fine:
gitk 768493d381aceffc90f132b6accb1536af8a3cc3..0ef520d910208c4d53bdd915964107b5a98cdc08
The problem for the current algorithm is probably the single non-merge
commit before the merges.

Another instance in the same repo (again gitk --all) is this part:
http://i.imgur.com/0i2fF.png
Both the pink and right orange line merge from trunk into that kde4
branch. However, this is not obvious from the way it is drawn. I see
this problem is a bit "softly expressed", but I hope you see what I
mean. I think making the merge edges shorter would also make the
actual structure more obvious.

I have no good idea how to easily fix these problems, but I don't know
that much about how it works currently. I see it might involve some
more "intelligence" of the rendering algorithm (forward-looking of
some sort). So never mind if you don't have a fast fix. But I still
wanted to point out that the problem exists.

This might be related to this issue:
http://thread.gmane.org/gmane.comp.version-control.git/18097/focus=18103
git version 1.7.12

Thank you!

Regards

Sebastian
