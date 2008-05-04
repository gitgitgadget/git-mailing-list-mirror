From: "Geoffrey Irving" <irving@naml.us>
Subject: git push won't push to a local branch
Date: Sun, 4 May 2008 11:49:38 -0700
Message-ID: <7f9d599f0805041149w1955138crf269853196391e51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 04 20:50:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsjI4-0007eZ-1l
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 20:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754361AbYEDStj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 14:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754093AbYEDStj
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 14:49:39 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:36304 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754118AbYEDStj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 14:49:39 -0400
Received: by rv-out-0506.google.com with SMTP id l9so808049rvb.1
        for <git@vger.kernel.org>; Sun, 04 May 2008 11:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=X/sSkm/1diYjjhpTtBGoEsRBxc3I7O6+o20LokRbur4=;
        b=noO+3jvY8df28UieEuug2ljAMM3HmVTfe1BIW+V1CTXk41gXUE2tTxNxrR21fD3VfIezafHK3esIQMGzsOaD4TplfpnyTCEBms4dVLgf9N2LX0g0ynQbjsNojX4IbyudKbjZ9BYe10CO8uypQIhvsBCmh2FfkuT/yWF00f55L4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=GIfpYluFr9Slj4wHIqU76JXBWMoOUBWU3OY/LZSsbaLmuyYugJP9To1WipM4C2vHxoKWVzrM9UGkkA7EnBg9CwiyEM/1NncJQZGeDCtlpkcI5z5H7Xsb5zjGVdeQZpw8vmJWBkCTcYgKI+kR2LfzmRmOEHB+ieS3z/XXP50N7ck=
Received: by 10.140.157.1 with SMTP id f1mr2414273rve.220.1209926978449;
        Sun, 04 May 2008 11:49:38 -0700 (PDT)
Received: by 10.140.178.16 with HTTP; Sun, 4 May 2008 11:49:38 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 0a6e3b81f7deb834
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81190>

Hello,

There's an asymmetry between push and pull that seems unnecessary:
pull can pull from local branches, but push can't push to them.  Is
there a reason for this asymmetry?

In more detail, if I have a working copy with two branches, local and
master, I can use git pull to pull changes from master to local:

% git checkout local
% git pull . master
... pulls changes from master to local branch

If I make a change in local and try to do the reverse with git push,
it gives a confusing non-error message and doesn't do anything:

% git checkout local
% git rm scratch/pcomm.h
% git commit
% git push . master
Everything up-to-date

I can simulate the desired effect by switching to master and doing a pull.

% git checkout master
Switched to branch "master"
% git pull . local
Updating 0080774..7e8d678
Fast forward
 scratch/pcomm.h |  146 -------------------------------------------------------
 1 files changed, 0 insertions(+), 146 deletions(-)
 delete mode 100644 scratch/pcomm.h

I'd prefer not to have to switch my checkout to master to accomplish
this, since I'll end up with a corrupted working copy if I push from
somewhere else to master at the same time (I want to avoid multiple
repository copies to save space).

Thanks,
Geoffrey
