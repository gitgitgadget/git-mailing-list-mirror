From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: update-index --assume-unchanged doesn't make things go fast
Date: Wed, 25 Jun 2008 23:35:03 +0200
Message-ID: <200806252335.05083.jnareb@gmail.com>
References: <32541b130806250944x717cf609x7aa520c77a7c6911@mail.gmail.com> <m33an1josg.fsf@localhost.localdomain> <32541b130806251253t3dcada10nbf94fee9e4aed9ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 23:36:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBcf3-00087P-M4
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 23:36:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736AbYFYVfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 17:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752734AbYFYVfS
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 17:35:18 -0400
Received: from ik-out-1112.google.com ([66.249.90.178]:28627 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752723AbYFYVfR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 17:35:17 -0400
Received: by ik-out-1112.google.com with SMTP id c28so1756638ika.5
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 14:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=fytSUok4RLFxgaTRzSM2nElIiTvFIgmoDsi6/1q8ZEQ=;
        b=VFO1COTB4cwb8F1yyQ6QY/yiKCHbSBulCRXcBwN6SiVRoKWFP3Nr0IMXGA9066Cfy/
         q6dGUBfWvELOJj5yDMeGoFIRrQHdby6uB4A92dOsSF47LVsjktft3nCPiBoUGQXd8rz9
         4SXHnmETuHqSgxkc3mM9ju67FL00ihLNj55v8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=O4PUuyLPURpnt525+LUvsOgO15z89KuB+VE4F0QW6VqmBSZBFuAN1xFuuTQ8py1orH
         X5jb+MxW8cOP/M6y7Y9W/YK0zb2heVc+uNbpaT2wzDu4Y+4irEF1Yl01cOM1ORK17DFZ
         m1c0JGM2pYFEVAU4p1RgiToLp2KDQItf31jJk=
Received: by 10.210.56.10 with SMTP id e10mr2216438eba.20.1214429716100;
        Wed, 25 Jun 2008 14:35:16 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.220.164])
        by mx.google.com with ESMTPS id f7sm12048037nfh.38.2008.06.25.14.35.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Jun 2008 14:35:15 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <32541b130806251253t3dcada10nbf94fee9e4aed9ec@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86354>

On Wed, 25 Jun 2008, Avery Pennarun wrote:
> On 6/25/08, Jakub Narebski <jnareb@gmail.com> wrote:
> >
> > Which git version do you use? Does it have the following configuration
> > variable (also available as command option):
> >
> >   status.showUntrackedFiles::
> > [...]
> 
> Thanks, I didn't know about that one.  Using that definitely makes
> "git status" go much faster (pretty much instantaneous if I've also
> used --assume-unchanged on everything).
> 
> Now the catch is, if I want to implement the daemon I was talking
> about earlier, I'd like to be able to notice untracked files (or
> directories with untracked files) individually.  Ideally, I guess the
> best way would be to just keep a separate list of all existing files
> that aren't in the index, and have git status look at that rather than
> at the actual filesystem.
> 
> Are there any suggestions for how best to do this?

You can try to take a look at how (third-party and Linux only) inotify
extension for Mercurial works.  AFAIK IIRC it uses some kind of daemon
which watches for inotify notices and updates Mercorial's equivalent
of index.

-- 
Jakub Narebski
Poland
