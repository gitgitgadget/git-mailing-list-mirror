From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Branch merge bug
Date: Tue, 19 Jan 2010 13:07:28 +0100
Message-ID: <4B55A080.7010705@drmicha.warpmail.net>
References: <f3271551001182322p86a02d8p8b9ceb49e930d333@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 13:09:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXCtn-0001NX-KG
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 13:09:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752915Ab0ASMJW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 07:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752578Ab0ASMJV
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 07:09:21 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:54129 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752130Ab0ASMJV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jan 2010 07:09:21 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1B557CDC82;
	Tue, 19 Jan 2010 07:09:20 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 19 Jan 2010 07:09:20 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=q3uIzdJM9s4vVk59uSXUSxviSpw=; b=eW7QRUAb8LRno0/+lIE9uVG2ss5Ev/tIXXjWghM+GXA20IjsLjpqMKn0lyWLWa2WBGq6rs5Heo4RZ7k0huiM1Ek2Od6zoRfo6vxYLtG81aNlWdO8AFRE+Tf3O2e5fJpENU8cCMRozAFVUSE+afSaKvGVEj/6kWc3trae5GdBTV4=
X-Sasl-enc: +ZBE7LniZDFhKpmXGOGRyGVM5tRV8tdbpXRfTPsvlMNp 1263902957
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3C87DE866;
	Tue, 19 Jan 2010 07:09:17 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7pre) Gecko/20091209 Lightning/1.0b2pre Shredder/3.0.1pre
In-Reply-To: <f3271551001182322p86a02d8p8b9ceb49e930d333@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137450>

Ramkumar Ramachandra venit, vidit, dixit 19.01.2010 08:22:
> A friend showed me this reduced test case. It seems to work fine with
> bzr and hg. Is this a git bug?

It's not a bug, it's a feature. Git does not track renames. It tracks
content and detects renames when necessary. Knowing that it is easy to
construct examples on which git merge "fails", such as the one you present.

A file which is changed completely is not a renamed file, it's a new one
under the same name. Whether the committer meant to create a new file
(using the same name by accident or on purpose) or whether it is really
a heavily modified and renamed version - who knows? Git doesn't, and
cannot, and it leaves that decision up to you.

If you really mean to modify and rename an existing file, then tell Git so:

git mv fil fila
git commit -m 'we need a new name'

instead of your 'git rm fil' will record your intentions (not only for
Git, but also for everyone else reading your log, such as you a year
from now) and will make the merge succeed.

Michael
