From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: Q: workflows when tied back to git-svn
Date: Mon, 10 Mar 2008 14:15:05 +0000
Message-ID: <320075ff0803100715y2675c7aax6548535454083d52@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 10 15:15:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYin6-0002tb-8S
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 15:15:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbYCJOPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 10:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbYCJOPI
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 10:15:08 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:22542 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929AbYCJOPG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 10:15:06 -0400
Received: by wf-out-1314.google.com with SMTP id 28so1898272wff.4
        for <git@vger.kernel.org>; Mon, 10 Mar 2008 07:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=A57FKEMoT2f18rfLjFzQ3JLGL9VERmbDWTQT+xo20jM=;
        b=jUDFE1zP+8dl9d6dss3XIe/bG83IuagG+Wyed/EGvKevVyNY8GgkfAeD/CzDKmqy2IMREiVr3IoBmhhF7YYCFSGcnPnFQWYlBkBlqzuV9wdxCnzoN2slHSBZ5iw6sdCJl0NtI6kkSlJxMw8SzyyW6YdfwpFt30Pu52XNfqxfGgE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=R8Hc0kYrRqPY0X1HJ/iNmmVQtv5D/88shyXyejUNdElZ/zHS6upOipYJLqsguK2bgMgutLRJ+3W/9lgm4/yqVP2YUbifaW8gmFOGuVXbzYR/jkP+CwB1sOgHLXVjpQqK6r+5mFRd6xjcITeHAq3JRtZ6wjCcU57gyp4B2xmmLtk=
Received: by 10.143.168.14 with SMTP id v14mr1653189wfo.210.1205158505857;
        Mon, 10 Mar 2008 07:15:05 -0700 (PDT)
Received: by 10.66.243.3 with HTTP; Mon, 10 Mar 2008 07:15:05 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76728>

Hi list;

We have a number of projects which currently are mastered in a
centralised svn repo, and it makes use of svn:externals. It's becoming
increasingly apparent (finally) that everyone working in the various
project /trunks is not working, and what's really required is a number
of branches. Also that the git submodule approach is superior (for our
needs) to svn:externals.

Now ideally, I could swap us all over to git; I've been using git-svn
for a while and it works very nicely (modulo not noticing the
requirement to merge with --squash, which is obvious once you know!).
How-ev-er.. the natives are revolting.. some people didn't even want
to move to SVN from CVS let alone a new tool. Alas some people just
don't like change.

I'm guessing I can give teams their branches in svn, and manage the
merging back with git and git-svn - that way I'll retain some kind of
sanity in repeated merging. For those devs with the right fu can start
using git directly, and we slowly start deprecating the whole svn
infrastructure a bit at a time.

Anyone got any experiences of doing this (particularly things to note,
like the --squash thing that might trip us up, or workflows)? I've
never tried dcommitting back to anything other than trunk..

Secondly (slightly related) - because of our svn:externals usage, we
tend to have a lot of repeated repo checkouts. I'm *assuming* that If
I've got 2 git modules that have the same submodules (e.g
A
  mod1
  mod2

B
 mod1
 mod2

Then it's 'safe' to make the mod1 and mod2 directories symlinks to the
same directory?
