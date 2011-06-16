From: Thomas Berg <merlin66b@gmail.com>
Subject: Re: [git-p4] Trouble importing all perforce branches into git repository
Date: Thu, 16 Jun 2011 12:05:38 +0200
Message-ID: <BANLkTikMzxGDqX7FnNFx+fmFuXVi6NncJA@mail.gmail.com>
References: <5A927B4F-7242-48AD-BC1C-BCA490A251C4@gmail.com>
	<20110522114917.GA19927@arf.padd.com>
	<398FA881-E4A1-49AC-80F2-2D46E9F2ABB9@gmail.com>
	<BANLkTi=TCyyS7Q=3BnLcG=yhL_boH=w1XA@mail.gmail.com>
	<34E33A18-B9C4-4CA9-B96C-79B0E2BDCD44@gmail.com>
	<BANLkTik+Zp1Fvi_zABCtAZH0RKA68n5Svw@mail.gmail.com>
	<0AC6DD14-3042-4A18-91AC-1CE77D8B4CD2@gmail.com>
	<1308212906486-6482174.post@n2.nabble.com>
	<BANLkTikTt4vMj+iZMhGEi6JefRUkZGZ8dg@mail.gmail.com>
	<1308216928289-6482333.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: tumik <tumik@tuomisalo.com>
X-From: git-owner@vger.kernel.org Thu Jun 16 12:05:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QX9SL-0002z6-9c
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 12:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757550Ab1FPKFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 06:05:40 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:59588 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757534Ab1FPKFj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2011 06:05:39 -0400
Received: by vxi39 with SMTP id 39so1029401vxi.19
        for <git@vger.kernel.org>; Thu, 16 Jun 2011 03:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=peI5TDxf1UYomJPTPDugM5hkWCmCn0n485CQN9cMAa8=;
        b=tcNRsotRRncAkj65H21ARQ1ERuMw/TwACwXJH9qrPS8JE3xn8YHhGa+1Soe+V0ETi6
         kFoQ1XFQJJ+wHLmgidCiwYF7dZ2nCkOigMh2FZmSaUS4JVS+h7NDg8Ne3Kpa7HtDF5jk
         ggX6v/r9R+h4alfMllCv6PPFcVVfljdXAtWdM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=iTADh/NY7lW/p8yremCpGd3shounFg6aVmhT2idUYSZFV+gTGlE+Mq+ZtknjOWIHyG
         rjTtMUQepmw7M+KesF/I1Izn+tjfBs9CJ4BJSL63UTSWfxerk36DkRZWlkhAWMYWOMK2
         zf9yxY6q0w7h8Xw7HEGyPuKDZZrz85dVMikMc=
Received: by 10.52.179.230 with SMTP id dj6mr979410vdc.130.1308218738581; Thu,
 16 Jun 2011 03:05:38 -0700 (PDT)
Received: by 10.52.167.69 with HTTP; Thu, 16 Jun 2011 03:05:38 -0700 (PDT)
In-Reply-To: <1308216928289-6482333.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175891>

On Thu, Jun 16, 2011 at 11:35 AM, tumik <tumik@tuomisalo.com> wrote:
> Yes, I tried the git-p4raw too. Actually even several forks of it! But I
> wasn't able to get any of those working, as none of them could load the
> perforce database correctly. Maybe the perforce database has changed lately
> or something, as git-p4raw gave errors that it's database tables don't have
> as much columns as perforce's does. Tried also to change the code to add
> those columns but there were so many of them and in many tables so I decided
> it's too hard and time-consuming to start reverse-engineering them..
>
> - tumik

I could maybe mention another approach: if your Perforce history isn't
too large so you can extract the info manually, or if you are able to
create a script to figure out your merges (changelist number, revision
of source and target branch in Perforce) it is easy to modify the git
history with this info afterwards.

You can add merge arrows to your git-p4 imported repository, either by
creating a .git/info/graft file and running git-filter-branch
afterwards (to make it permanent and distributable), or by using
git-replace. I may have a script somewhere that generates the graft
file from p4 changelist numbers and branch names, if you're
interested.

The graft + git-filter-branch is good for a one-time conversion, but
since it rewrites history it may not work well for branches that still
get updated in Perforce.

I have not tested git-replace myself, but it should be possible to use
this to add merge arrows too, without modifying the hashes of commits
later in the history. I'm not sure how well git-replace works with the
rest of git though.

Thomas
