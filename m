From: "Denis Bueno" <dbueno@gmail.com>
Subject: git-instaweb portability issue (maybe?)
Date: Fri, 13 Jun 2008 09:26:29 -0400
Message-ID: <6dbd4d000806130626pfdb06f2qbfea6f1909710b7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 13 15:27:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K79JN-0006KJ-Oc
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 15:27:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754921AbYFMN0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 09:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754819AbYFMN0b
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 09:26:31 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:37379 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754198AbYFMN0a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 09:26:30 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2758997fgg.17
        for <git@vger.kernel.org>; Fri, 13 Jun 2008 06:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=eeyYAd4Q7ifjaGhX2/nMDTL9juvZHEF3tpwfeh893kc=;
        b=e84Y6gSuscgGewxztilGFIfQSaHqBM3TZLVBuuYrLSI6kig4+RjkUX1tpGsFyHtW7K
         XaJOIFrDullQyk01aAxFvKKP30WfgjN7hA1Xx2Ex+ApZEPvgfKvmaMD60CEojneoltu9
         l212vH4u1ZUIr/3mAGTWmoov/hPnLtG+VHiLI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=ieR2aE5PSgofc1HnPBOFLG0tn3gQLKK69q7lcOIynh58EENI8Iw1QVQTD1mlR1waV3
         sexKBckYYAWtavYLvYMpitGvrZdVssb39OhF6zBQuvJzgNxop2F+K/3c7du6+nXva4yt
         EdBBl1wTNSvdUd33JWChvRsT8Ve0YyGJx8rzY=
Received: by 10.86.80.17 with SMTP id d17mr3978266fgb.24.1213363589317;
        Fri, 13 Jun 2008 06:26:29 -0700 (PDT)
Received: by 10.86.59.7 with HTTP; Fri, 13 Jun 2008 06:26:29 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84873>

Hi,

I'm on OS X 10.4.11 on Intel using git 1.5.5.3.

I'd been trying to use the git-instaweb script (both with and without
arguments) with lighttpd (which I installed through Macports) without
success, seeing the following kind of bizarre error message:

    funsat[290] > git instaweb
    /opt/local/bin/git-instaweb: line 6033: /usr/bin/env perl: No such
file or directory
    2008-06-13 09:09:31: (log.c.75) server started

    funsat[291] > 2008-06-13 09:09:31: (mod_cgi.c.998) CGI failed:
Exec format error /Volumes/work/funsat/.git/gitweb/gitweb.cgi
    mod_cgi.c.1001: aborted
    2008-06-13 09:09:31: (mod_cgi.c.584) cgi died, pid: 23237

"/usr/bin/env perl: No such file or directory"? Huh?  I certainly have
perl installed, so I don't know what that's about.

That line simply calls perl by the $PERL variable, which is set at the
top of the script, like so:

    PERL='/usr/bin/env perl'

If I change this line to point to my perl directly, it works.  On a
hunch, I changed it to:

    PERL="/usr/bin/env perl"  # note the double-quotes

And now it works.  Could this be changed for future releases of git?
Does this in fact increase portability, or is something more sinister
going on?

Thanks.

-- 
 Denis
