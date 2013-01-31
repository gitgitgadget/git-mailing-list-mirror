From: Tomas Carnecky <tomas.carnecky@gmail.com>
Subject: Re: How to identify the users?
Date: Thu, 31 Jan 2013 06:08:01 +0000
Message-ID: <1359612481-ner-5936@calvin>
References: <CACkbei+Jby13B7rsEb3iLQM2ZSFDgrkgvrYC5M7u4yatppvLxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: Scott Yan <scottyan19@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 31 07:08:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0nK6-0005nC-DD
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 07:08:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754191Ab3AaGII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 01:08:08 -0500
Received: from mail-ee0-f50.google.com ([74.125.83.50]:43358 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772Ab3AaGIH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 01:08:07 -0500
Received: by mail-ee0-f50.google.com with SMTP id e51so1274232eek.37
        for <git@vger.kernel.org>; Wed, 30 Jan 2013 22:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:subject:to:references:in-reply-to:mime-version:date
         :message-id:content-type;
        bh=xeGNSGbf7/O4g/CiVKCnmfm6adkQ3hyYqEHAKR/xX08=;
        b=Vvz53QyIo5HW7jP0ePBC8aJTMx8U58D0xiRZ4u56xxOPoyj/mqRuQFutfABMNPfHR/
         3Tz1ua8L8jxpIR3sa/FykCLV4CQwbSOYHhitFO2zqoUMI5xg1hL3UyTPJ8SsYIPag2j+
         a5mnjTR3e36UXkpF/XdTU9Trfir4ZFZ1pI8uXdjtW2gev/VG6EOlopEBt/eM7kjg3Ofc
         Sxa2yV4PFesUdGeYHtgJmOo17sICFGNSzJxU4eambi5l3Jm0e2fjCqZQTPMfSEzxr6ux
         LmnFxeanFh8na+tiO3htcu27CqS4ZMWeUVZdQFy9ohKtX+HI95VOzo6TP5IT3u3cIqRM
         WW1A==
X-Received: by 10.14.225.133 with SMTP id z5mr23683041eep.15.1359612485769;
        Wed, 30 Jan 2013 22:08:05 -0800 (PST)
Received: from calvin.caurea.org (cust.static.46-14-151-191.swisscomdata.ch. [46.14.151.191])
        by mx.google.com with ESMTPS id 44sm5696556eek.5.2013.01.30.22.08.03
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 30 Jan 2013 22:08:04 -0800 (PST)
Received: by calvin.caurea.org (Postfix, from userid 3301)
	id 1B87A16C9C7; Thu, 31 Jan 2013 06:08:01 +0000 (UTC)
In-Reply-To: <CACkbei+Jby13B7rsEb3iLQM2ZSFDgrkgvrYC5M7u4yatppvLxA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215094>

On Thu, 31 Jan 2013 13:52:32 +0800, Scott Yan <scottyan19@gmail.com> wrote:
> Hello everyone:
> 
> The user info of git client (user name and email) is set by the users
> themselves, so , how to avoid userA pretend to be userB?
> 
> Git server could authentication the user, but it do nothing about the
> user info of commit message.
> 
> For example:
> There are 20 people of my team, and everyone can push to the public
> repository(git server),
> If I found some backdoor code in my project, and the commit record
> shows it was committed by userA, so I ask userA: why do you do this?
> but he told me: no, this is not my code, I have never committed such
> thing.  ----and yes, everyone could change his user info to userA very
> easily .
> 
> so... what should I do to avoid such situations?

gitolite keeps a log of which SSH user pushed which commits. The smart-http
backend does the same if you have reflog enabled on the server (see the
ENVIRONMENT section in man git-http-backend). So unless someone can steal
userA's credentials (http password, ssh key) you'll be able to detect who it
really was.
