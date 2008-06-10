From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: Date parsing
Date: Tue, 10 Jun 2008 10:10:33 -0500
Message-ID: <Zx2uvEYSssjj9E0HrmUL8wYASyWX9L9w8LkR-gGRAmnD9isjoEeyKg@cipher.nrlssc.navy.mil>
References: <bd6139dc0806100758xb41d08dh18e3051088b707e5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Tue Jun 10 17:12:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K65Vi-00043A-Jj
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 17:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754562AbYFJPKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 11:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754559AbYFJPKx
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 11:10:53 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:44382 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754551AbYFJPKw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 11:10:52 -0400
Received: by mail.nrlssc.navy.mil id m5AFAY6L023873; Tue, 10 Jun 2008 10:10:34 -0500
In-Reply-To: <bd6139dc0806100758xb41d08dh18e3051088b707e5@mail.gmail.com>
X-OriginalArrivalTime: 10 Jun 2008 15:10:34.0197 (UTC) FILETIME=[217D6050:01C8CB0C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84516>

Sverre Rabbelier wrote:
> Heya,
> 
> I noticed that we parse
> GIT_COMMITTER_DATE="31-05-2008 11:30pm" as "31st of July at 23:30 +0200"
> whereas we parse
> GIT_COMMITTER_DATE="01-06-2008 11:30pm" as "6th of January at 23:30 +0100"
> 
> Not only is it strange that we accept both orders (since apparently we
> don't resort to the latter order unless the first digit > 12),

Take a look at match_multi_number in date.c
European ordering is preferred when the separator is '.'

> but
> it's also weird that the timezone changes based on which option was
> chosen!

The timezone didn't change. One date is in daylight saving time, the other
is not. The offset from GMT is different to reflect this.

> What does the list think about this? Is this "normal"
> behavior? If not, what (if anything) should we do about it?

There will be flaws in any system that tries to automatically guess the
format. If there is not already one, perhaps a statement should be added
to the appropriate documentation describing how to ensure that european
ordering is used to parse the date.

-brandon
