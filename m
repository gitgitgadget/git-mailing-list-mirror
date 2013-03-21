From: Kirill Likhodedov <kirill.likhodedov@gmail.com>
Subject: Re: Bug? git show behaves incorrectly when called on a stash object
Date: Thu, 21 Mar 2013 12:10:34 +0400
Message-ID: <813B5421-0876-40B3-8152-9DCA5D234FD7@gmail.com>
References: <AF060B6D-27F7-45BE-9BC3-85FAF3487481@gmail.com> <vpqsj3qoyj2.fsf@grenoble-inp.fr>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Mar 21 09:11:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIaag-0004AZ-KI
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 09:11:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757857Ab3CUIKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 04:10:43 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:54341 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757434Ab3CUIKk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Mar 2013 04:10:40 -0400
Received: by mail-la0-f54.google.com with SMTP id gw10so4644103lab.13
        for <git@vger.kernel.org>; Thu, 21 Mar 2013 01:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:subject:mime-version:content-type:from:in-reply-to:date
         :cc:content-transfer-encoding:message-id:references:to:x-mailer;
        bh=wW/zVRFtUYr4qmu0/fp2dosLOm9UlagN32BbBCi3h6w=;
        b=MqGJO57nxmBeWqPmrMc2NlNB5cs1sA/UmpH+0BP8QaEl6L8DCiYD3L+6lLsulFDdQ0
         JwnAFw+6+Il45hz96zz8rYlCx0jOPQbCtr6EUxyYEXwxPQmfsn9MAwvFbQZkpEpemn6O
         IIO96TBAx0xOqAwrMXOM0JKDMqwqrQg8hx46Xecep9DJ550wpaXANviGrTOj1AnMZf6K
         PAScsuhJCtmZ2I4Idi0usU36P24nWz+e3sCW3S0YfR4ySG5zA7swPx939TlPQZ5TSQBM
         2UBL4+zOf1siq82BvAWkqlc5W4WgAE9tAhPv4ofY/fgTZErxUqRpYa5CdVgG3zpMO3yB
         e07A==
X-Received: by 10.112.104.103 with SMTP id gd7mr11068458lbb.54.1363853438591;
        Thu, 21 Mar 2013 01:10:38 -0700 (PDT)
Received: from loki.labs.intellij.net (gw.intellij.net. [195.5.138.42])
        by mx.google.com with ESMTPS id m1sm1681546lbh.5.2013.03.21.01.10.35
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 21 Mar 2013 01:10:36 -0700 (PDT)
In-Reply-To: <vpqsj3qoyj2.fsf@grenoble-inp.fr>
X-Mailer: Apple Mail (2.1283)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218704>


On 20.03.2013, at 19:56, Matthieu Moy wrote:

> stash objects are commits with 2 parents (ie. merge commits). One commit
> is the HEAD you stashed from, and the other is the saved state of the
> index.
...
> Use git show --first-parent --name-status, it should do what you expect

Thanks a lot for clarifying that. It is actually mentioned in git help stash, but I've missed this.
With "--first-parent" I get the expected result. Thanks for your help.

> I'm not sure from the doc what the semantics of --name-status is
> for merge commits, but it seems it shows only files modified in both
> parents.

I think I've found the reason of this behavior.
git help show mentiones that:
> It also presents the merge commit in a special
> format as produced by git diff-tree --cc.
And git help diff-tree says that --cc implies -c, while -c "lists only files which were modified from all parents".

-- Kirill.
