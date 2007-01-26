From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] diff --check: use colour
Date: Fri, 26 Jan 2007 16:37:00 +0000
Message-ID: <200701261637.01199.andyparkins@gmail.com>
References: <Pine.LNX.4.63.0701241505260.22628@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.63.0701260034320.22628@wbgn013.biozentrum.uni-wuerzburg.de> <17850.8953.478146.754550@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Bill Lear <rael@zopyra.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 26 17:37:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAU57-0004Lz-4l
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 17:37:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030620AbXAZQhI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 11:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030709AbXAZQhI
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 11:37:08 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:56565 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030620AbXAZQhF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 11:37:05 -0500
Received: by ug-out-1314.google.com with SMTP id 44so759789uga
        for <git@vger.kernel.org>; Fri, 26 Jan 2007 08:37:04 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=oJD+lDtpiNzC6DwR0ZspmyJHrJOB7JX5ThpeGThuWFz9FpR9SpT+8ZTrSi6pAjbo62BvJ+aB99Vy7kLZQ4r8e1PFwnjfqX/EVQ358Ckgdb07gvYbhUzNr5sZBls0wzh/AhK4Qm1VouQyOJXrcAtnmAPmdB/suT/w2OREfyEEQ64=
Received: by 10.67.96.14 with SMTP id y14mr4551611ugl.1169829424363;
        Fri, 26 Jan 2007 08:37:04 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id j1sm4623088ugf.2007.01.26.08.37.03;
        Fri, 26 Jan 2007 08:37:03 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <17850.8953.478146.754550@lisa.zopyra.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37871>

On Friday 2007 January 26 15:49, Bill Lear wrote:

> I presume that I send the patch text to the list with the subject line
> that starts with [PATCH], some sensible topic (e.g., "document --check
> option to diff"), and then a short body of explanation and then,
> following my signature, the patch itself.

git-format-patch will make you an email of the correct form.  Personally I do 
this (this is the IMAP server version, but it's similar for mbox)

 * make myself a branch from current master
 * write patch/patches, test (yeah, right ;-))
 * git-format-patch --stdout HEAD^ to check it looks good
 * git-format-patch --stdout HEAD^ | git-imap-send 
 * Go to Drafts mailbox, open it up, add any additional comments for the
   mailing list only underneath the "---" and before the diffstat.  Make sure
   you turn word wrap off as soon as you open the mail.  Word wrapping will
   ruin the patch.
 * Send.
 * Wait for huge feeling of disappointment because your patch is junk and
   gets savaged by the git-gurus (maybe this step is just for me though).

To make this all easy and automatic I also have the following in 
my .git/config:

[format]
        headers = "To: git@vger.kernel.org\n"

And the following in my ~/.gitconfig:

[imap]
    Folder = "INBOX.Drafts"
    Tunnel = "ssh -q mailhost /usr/bin/imapd ./IMAPmd 2> /dev/null"

And the following in my .git/hooks/commit-msg (make sure you set it 
executable) to automatically add the "Signed-Off-By" line to your commits:

SOB=$(git var GIT_AUTHOR_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-by: \1/p')
grep -qs "^$SOB" "$1" || echo "$SOB" >> "$1"

I've also enabled the .git/hooks/pre-commit hook (chmod a+x) to make git check 
my patches before they get committed.

git-format-patch makes git mailing list friendly patches that match the 
guidelines given in Documentation/SubmittingPatches

Hope that helps.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
