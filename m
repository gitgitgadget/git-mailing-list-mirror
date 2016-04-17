From: Santiago Torres <santiago@nyu.edu>
Subject: Re: [PATCH v5 0/6] tag: move PGP verification code to tag.c
Date: Sun, 17 Apr 2016 13:34:06 -0400
Message-ID: <20160417173406.GB1014@LykOS>
References: <1459872449-7537-1-git-send-email-santiago@nyu.edu>
 <CAPig+cQ4n5j4Q-WF-0cd=2+5eSAaimh3A7La+8Fe9Ox4anjtBQ@mail.gmail.com>
 <20160407034007.GC17848@LykOS>
 <CAPig+cQxmovGckrbwuEoeA=hW1idukj3qKTfjmr8B+AM7E2J0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Apr 17 19:34:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arqaL-000628-TT
	for gcvg-git-2@plane.gmane.org; Sun, 17 Apr 2016 19:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbcDQReJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2016 13:34:09 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:33799 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696AbcDQReI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2016 13:34:08 -0400
Received: by mail-qg0-f51.google.com with SMTP id c6so105628217qga.1
        for <git@vger.kernel.org>; Sun, 17 Apr 2016 10:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dMnY7+zKTfe7GWuKFZ2m5GpWZSo5ub3Vvv0/Jy67mTk=;
        b=gJ+HbTIsF0DYZ7CVOhCKu5QSdHQRmctkHr7hcNo5aGYuSngzLa0GrQ49rRQE7lmDuj
         LVdQ2MYf7GJGFvgXSyJ2e7JEZFGo3heFHIM38A/8f4KEKz6K/k//lxYP5esaNz+7WZpV
         WpjSibUwUY+bPK2y7JtRBvgYQ9DV5WjiF+1XMfAhjWaUUhunj/ZoKpW3qC8Rk/onuwXA
         b8/L/9K+4zRlaTKdeg4rGURxnjZHwTtGjAmHY0mNMg1B+sH8oCv3c/QQ0QzkZHyrDIqp
         2TASp2Z7hf2MJDfGTcTDOUufbnbb9v0unat7ptrwjJ/aLfdrsRCklj6dCHqovYscLG/M
         jnGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dMnY7+zKTfe7GWuKFZ2m5GpWZSo5ub3Vvv0/Jy67mTk=;
        b=Gqoto6xS+tq1dRDLqliTOtVe8N5mPnygZcZFA4DV1opcUyr29bpNn/x2voP+5u3IZP
         CUxFYF8ZzL8GUdSzQeBMJ+CAi5scTlBLx5YcT0YgkW5yDD0YFGt7T9Ahme529zhbjiVd
         Oi3KNPTvtsaEFiVqiUZTE8gn8N2o4oiaef9hy5JMyIoLS7HIvNVJ509si+aJVBC7g9T0
         IRDYOZ1rYbRwaR/gcUPptgsz2P7ApzS6Q3lANd0pYJ0JGBOnoH5+2Fhd6EeTlH8Qpmdn
         GCIh7rWg5AE0R8G8OaRcUC7YSNgrVxW4ZK8HpHIJdmFCnlqG/FBSE+i55t15z4DBTbQ8
         LflQ==
X-Gm-Message-State: AOPr4FUmr8nddYFHifuwa/iQdu/u4qv5I9pAkDVYzQG6rlkA5WAVc4zhkCFV8g3IHfrx7o50
X-Received: by 10.140.179.15 with SMTP id z15mr39376660qhz.79.1460914447233;
        Sun, 17 Apr 2016 10:34:07 -0700 (PDT)
Received: from LykOS (NYUFWA-WLESSAUTHCLIENTS-19.NATPOOL.NYU.EDU. [216.165.95.8])
        by smtp.gmail.com with ESMTPSA id h34sm24746891qge.30.2016.04.17.10.34.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 17 Apr 2016 10:34:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPig+cQxmovGckrbwuEoeA=hW1idukj3qKTfjmr8B+AM7E2J0A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291767>

On Thu, Apr 07, 2016 at 12:19:37PM -0400, Eric Sunshine wrote:
> On Wed, Apr 6, 2016 at 11:40 PM, Santiago Torres <santiago@nyu.edu> wrote:
> >> > v5 (this):
> >> > Added helpful feedback by Eric
> >> >
> >> >  * Reordering of the patches, to avoid temporal inclusion of a regression
> >> >  * Fix typos here and there.
> >> >  * Review commit messages, as some weren't representative of what the patches
> >> >    were doing anymore.
> >> >  * Updated t7030 to include Peff's suggestion, and added a helped-by line here
> >> >    as it was mostly Peff's code.
> >> >  * Updated the error-handling/printing issues that were introduced when.
> >> >    libifying the verify_tag function.
> >>
> >> This version is a more pleasant read, easier to digest and understand.
> >> All of my review comments were minor; nothing demanding a re-roll. As
> >> such, this version is:
> >>
> >>     Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
> >>
> >> If you do happen to re-roll based upon the review comments, feel free
> >> to add my Reviewed-by: (but not if you make larger changes).
> >
> > Thanks! I'll add your and Junio's in another re-roll.
> 
> I don't think Junio explicitly gave his Reviewed-by: (indicating his
> approval of the patches as-is), so you wouldn't want to include his
> Reviewed-by:.

Yeah, I didn't mean to imply that. I'm rewriting the commit messages and
testing out patches 3+/6, so I'm not going to assume there's any
reviewed-by.

> 
> If you make any changes beyond the minor ones mentioned in my reviews
> or beyond plagiarizing commit message enhancements offered by my or
> Junio's reviews, then you'd also probably want to hold off adding my
> Reviewed-by: since I wouldn't yet have reviewed whatever new changes
> you're making.

Speaking of which, would it make sense to add "helped-by" to the patches
in which I'm plagiarizing the commit messages?

> (And, if you do make changes beyond ones I mentioned, and if I review
> them and consider them issue-free, I can always re-extend my
> Reviewed-by:.)

Thanks!
-Santiago.
