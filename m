From: skillzero@gmail.com
Subject: sparse support in pu
Date: Sun, 16 Aug 2009 23:09:33 -0700
Message-ID: <2729632a0908162309ma6e7d41kc3bafe4575120630@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 17 08:09:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McvPZ-0000l4-Q0
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 08:09:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756813AbZHQGJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 02:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752460AbZHQGJd
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 02:09:33 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:23742 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951AbZHQGJc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 02:09:32 -0400
Received: by qw-out-2122.google.com with SMTP id 8so932682qwh.37
        for <git@vger.kernel.org>; Sun, 16 Aug 2009 23:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=bChwjpq+t+/VS0HRKqKkYZBzqkBKd6wkpoXbrlttAWI=;
        b=YiPSFz66330//CU9n2ug6OicKvUqKG/hpnlFpPJvXmJcBOAsNl0UwoFAKAZg4/L4+/
         DCI45OeW/fxvD0mQ2jPBz31b/LjFQgKSyvQL+SmUt4ZVRaIM3IZn9BNRD3JrxtlEvn/C
         JMvTv5BPTwpoSCUvDlzKXuusKkHUwZIW3VHsI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=vsZh2FnH4MrDAgaf8cQ4ov5I/d3o5mvuMiBg/ePliSCDE9TmtLmYkaeRV4rKGSc/XM
         fCVOhJZPol3xQ2wHnLvcu+hHLNjtUptN1qvkk16hQTet0Fx4ywQiOk0gj1Dv+NEf4+ji
         UzclMTOSAfmjOgYzXBI/LB/FkfYVg2YQDPEyo=
Received: by 10.224.117.8 with SMTP id o8mr3965346qaq.227.1250489373986; Sun, 
	16 Aug 2009 23:09:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126124>

I had a couple comments and questions about the sparse stuff recently
merged into pu. First, I think it's an awesome feature. It's a nice
solution to my problems (1.5 GB tree where most people only need a
small subset, but with a lot of shared pieces).

1. Have people decided whether it should be on by default if you have
a .git/info/sparse file? I'd definitely like it to be on by default.
When I first tried it, I didn't realize I had to use --sparse to git
checkout to get it to use the sparse rules. The same goes for a merge
I did that happened to have a file in the excluded area (it included
it because I didn't use --sparse to git merge).

2. Is it not hooked up to git reset yet? I did a git checkout --sparse
and things look liked I expected then I did a git reset --hard
origin/master and it started checking out all the stuff previously
excluded via .git/info/sparse. I tried --sparse, but it didn't know
about that option.

3. One thing that was confusing is that I needed a trailing slash on
directories in .git/info/sparse to get them excluded. This seems
different than .gitignore, which works for me without the trailing
slash.

BTW...How to people normally try out stuff in pu? Do you just replace
your normal git stuff with the pu build? That's what I did because I
wasn't sure if I did /test/git if the other tools git invokes would
use the release version of git or the ones relative to itself (i.e.
the ones in /test/ for me). It seems like the only way to really test
stuff is to use it for your real work, but I also don't want to
corrupt our production repositories by using an experimental version
of git.
