From: Janus Troelsen <ysangkok@gmail.com>
Subject: GitWeb caching of snapshots
Date: Fri, 16 Jan 2015 01:13:37 +0100
Message-ID: <CAKBpzh=eW0zejHktsb+YTPnqcqd_KSR3VL0xQ0+-033Q9b2pCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 16 01:14:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBuY4-0008Py-2B
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 01:14:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbbAPANz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 19:13:55 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33528 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932072AbbAPANh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 19:13:37 -0500
Received: by mail-pa0-f46.google.com with SMTP id lf10so20614055pab.5
        for <git@vger.kernel.org>; Thu, 15 Jan 2015 16:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=YwmtgVWS4Obe0/WGflC3lxuHWp9Mj9Wl+/gekUxjZDk=;
        b=YFUCNfCDT4lTOtIXiMscDGQauoU7bkVXTwgjTGVy0pyJbcGrcPXB7SXleKkJBW+Nb1
         e4vxGzsWU6rnFIZRYlVVC28tZDq67XH+1HaI4D0zbckSPXemR463pspVnC53jZkitaNO
         KhLwi2WGE2KmP4hGxGHXET8geP6Aq2/IK/VWP0AE3XkDoHpPHVAIpEH13bF7/YXeDphr
         whG9ut69IAUF96hh82kmZDF9uT/i3aVnzCXMbCl6d4HXzDkbJVvUvmhU4CzSVQdY+XvA
         BWqfsxcx+iFcocgeZaAET4SSD31D2R+0mPKKN8XT9B8IoHvO+uY46tw8tyCWHxm5HvYm
         Z0vw==
X-Received: by 10.70.133.138 with SMTP id pc10mr18042947pdb.47.1421367217286;
 Thu, 15 Jan 2015 16:13:37 -0800 (PST)
Received: by 10.70.46.234 with HTTP; Thu, 15 Jan 2015 16:13:37 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262531>

Hi,

I noticed that GitWeb caches based on the "Last-Modified" header.
Won't this break if somebody force pushes a branch with the new newest
commit being older than the previous? The modification date will be
older, which makes little sense to HTTP clients, and it would probably
break since they use the "If-Modified-Since" header.

Wouldn't it make more sense to use the commit ID as an ETag? This
would avoid this bug. Two different archive types would get the same
ETag even if the HTTP content body is not equal, but I think this is
not in violation of the HTTP standard, since caching is based on URL's
AND ETags.

Here's a link to git_snapshot which is the relevant function:
http://git.kernel.org/cgit/git/git.git/tree/gitweb/gitweb.perl#n7314

Looking forward to your feedback.

Regards,
Janus
