From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Network problems during "git svn dcommit"
Date: Sun, 26 Dec 2010 18:57:39 -0600
Message-ID: <20101227005739.GA32713@burratino>
References: <20101222115008.GA10765@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Josef Wolf <jw@raven.inka.de>
X-From: git-owner@vger.kernel.org Mon Dec 27 01:58:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PX1Pm-0000I6-So
	for gcvg-git-2@lo.gmane.org; Mon, 27 Dec 2010 01:58:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248Ab0L0A6A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Dec 2010 19:58:00 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:48333 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100Ab0L0A6A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Dec 2010 19:58:00 -0500
Received: by yib18 with SMTP id 18so1327737yib.19
        for <git@vger.kernel.org>; Sun, 26 Dec 2010 16:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=IRVe4f5Q63AuP7nj5M0bq1/AbjFoxda03V1w0bDcxN8=;
        b=iVyARbpKo778jSEmM4pyaz0LO/ihJlWwKfbDxCEznqDyMLIgmsPDu9UAk5eRb5dMnB
         +X5Hnz9iUiLNk/tXu7Hl4pJMDKFMBtZ3tTFC2AonLJquOnkE/fAtTyyUhKR3/1CfrzvO
         gSFWgLm/pPoVFg2JGEjtZc5jdT6dam9yDby84=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bSP7vl8XBFPnMwsDVDxXlmxjnwRl/Usa0oZ7/+CMmYzs/Q5t9VkXwZ+TU4+UFcLEEP
         wY656YTB67iOz9JWCz5/BC8eLEbk+hsHk2Gn0rL/fX3v+pSqaLyNsu7q1+dGRYLk+In/
         AIdvowSoXnVHwSehivXlfis08+xX+0J5kOuJo=
Received: by 10.100.216.6 with SMTP id o6mr431550ang.208.1293411477782;
        Sun, 26 Dec 2010 16:57:57 -0800 (PST)
Received: from burratino (c-76-126-174-171.hsd1.ca.comcast.net [76.126.174.171])
        by mx.google.com with ESMTPS id 37sm16980288anr.24.2010.12.26.16.57.55
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 26 Dec 2010 16:57:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101222115008.GA10765@raven.wolf.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164206>

Josef Wolf wrote:

> I am using git-svn to track a subversion repository. This used to work
> fine so far. But today, I got a network outage during a "git svn dcommit"
> operation.
[...]
> Any hints how to fix the situation?

Yes.

To fix your repository:
 1. make backups!
 2. back out the bad commit so it is not visible with "gitk --all"
    (something like

	git reset --keep HEAD^
	git push . HEAD:refs/remotes/svn/Trunk

    )
 3. "rm -fr .git/svn/".  Note: this will delete your unhandled.log!
    Restore it from backup if you consider it precious.
 4. "git svn fetch; git svn rebase"

To fix "git svn", see [1].

Hope that helps,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/136510
