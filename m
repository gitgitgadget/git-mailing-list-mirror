From: "Tor Arvid Lund" <torarvid@gmail.com>
Subject: Re: git-p4 and changing p4 depot path
Date: Fri, 5 Sep 2008 20:04:10 +0200
Message-ID: <1a6be5fa0809051104g59e08b2dya37add721483d390@mail.gmail.com>
References: <683a886f0809050947k3b461495u459607dccf891698@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Kevin Williams" <kevwil@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 20:06:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kbfgp-0007jJ-VY
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 20:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbYIESEO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 14:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbYIESEO
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 14:04:14 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:10952 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345AbYIESEM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 14:04:12 -0400
Received: by fg-out-1718.google.com with SMTP id 19so780856fgg.17
        for <git@vger.kernel.org>; Fri, 05 Sep 2008 11:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=AQDZul11ZmFMtmL2QJ8SWv3xbmnn8BcMOq+KbMvYLkw=;
        b=G/c2JraxDkBzvCrZ4aG9lLNXQ49CtkHYryXS371+rrQMMgaR0bbPOLW7fOjlL3Ak6e
         YFGiUCMXlXd0lqsh4x5I98ASdvtwa+ZPwHSQPYFpDB+Beke/awDFGGpKwp/Dc5kIyoek
         8ffASFueeqVI+DpWqpCi7414SR2ZfbsX1xUJg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=gD+iY4Pus/uJ4jiVPVOdmRpvxjvql5JOcLnKaxxk+kdfaKKNJYaAyvfRYwyOH4F7KR
         D6uLypkyJDzl4JXCmWHKDU5aK1s+IxafHe/+get/yPdGBFLByob8fXB7RFCNezsf7mVm
         a9sKvvUpmlckEMSkpb3lZiXvcxRKBmR3Sm3Cw=
Received: by 10.86.93.19 with SMTP id q19mr8989947fgb.76.1220637850877;
        Fri, 05 Sep 2008 11:04:10 -0700 (PDT)
Received: by 10.86.79.9 with HTTP; Fri, 5 Sep 2008 11:04:10 -0700 (PDT)
In-Reply-To: <683a886f0809050947k3b461495u459607dccf891698@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95027>

Hi,

On Fri, Sep 5, 2008 at 6:47 PM, Kevin Williams <kevwil@gmail.com> wrote:
> I've got some code I've been working on in a local git repository that
> I cloned from Perforce using git-p4. Now, I need to commit my changes
> to a *different depot path* within Perforce. Since the p4 depot path
> is stored in the logs rather than config, and logs are immutable
> because commits are immutable, it seems I cannot do this. Is there any
> way to do this? Why isn't the depot path stored in config? Please
> help!

I'm not sure I understand why you want to commit to a different
path... Is is just another branch in p4?

In that case, git-p4 already has some support for working with all
branches of a project, given that they all reside under a common path,
like:

//depot/path/to/project/MAIN
//depot/path/to/project/REL_1_4

... where MAIN and REL_1_4 are branches of 'project'. This can be
cloned by invoking

git p4 clone --detect-branches //depot/path/to/project@all

When you are ready to push your git commits to p4, git-p4 will use the
log message of the nearest parent commit from p4 to determine which
depot path (branch) to use. In this way, you can commit your work to
different p4 branches.

-Tor Arvid Lund-
