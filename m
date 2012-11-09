From: John Szakmeister <john@szakmeister.net>
Subject: Rename edge case...
Date: Fri, 9 Nov 2012 04:10:31 -0500
Message-ID: <CAEBDL5U+OSTCAqgWoApE_m21Nef24Wqvt78oB6qqV4oEvU0vXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 09 10:11:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWkcA-00057X-8S
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 10:11:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109Ab2KIJKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2012 04:10:42 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34663 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083Ab2KIJKd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 04:10:33 -0500
Received: by mail-lb0-f174.google.com with SMTP id n3so2864833lbo.19
        for <git@vger.kernel.org>; Fri, 09 Nov 2012 01:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        bh=rIXFGWP6a+Kff2tx0uLzGOSec5hAUsOCOxzelhLhQiI=;
        b=zGbCQ1bSIqd1zE2IxQrFZG59yTuSP2+CwD9MTjHpmQ24Dsu90JEKycAkQCzmtu9Nsp
         GPb5jD41ENXFgkuCE11axJez+yM6srPGjvsT1ALg682mexO7SPYSDpsavQPnAsJ3sciQ
         3OrZpvObLOq1INjogn6gOGNuE2rsTlh2TBS4yyjskhl5P+m4e/YnuLl+/r28jgulzXw1
         z41R3fgNPTTUl0nDvg4blvFqTLgqD/+zV1P679stUpnLQpHRkTRpm3EDOW2BA1nVVGHR
         2EwJlgPOV0VJyTL8nsQMKcHyWLo3k06foGig7Q8Whbvln9k4flJJAnAnNo2jYCpKMAgj
         9AuA==
Received: by 10.112.99.8 with SMTP id em8mr4330633lbb.13.1352452231482; Fri,
 09 Nov 2012 01:10:31 -0800 (PST)
Received: by 10.112.162.39 with HTTP; Fri, 9 Nov 2012 01:10:31 -0800 (PST)
X-Google-Sender-Auth: XDJen4hSbd-iSs_Xaco5bpHzYvE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209208>

I've been browsing StackOverflow answering git-related questions, and
ran across this one:
    <http://stackoverflow.com/questions/13300675/git-merge-rename-conflict>

It's a bit of an interesting situation.  The user did a couple of
renames in a branch:
    foo.txt => fooOld.txt
    fooNew.txt => foo.txt

Meanwhile, master had an update to fooNew.txt.  When the user tried to
merge master to the branch, it gave a merge conflict saying fooNew.txt
was deleted, but master tried to update it.

I was a bit surprised that git didn't follow the rename here, though I
do understand why: git only sees it as a rename if the source
disappears completely.  So I played locally with a few ideas, and was
surprised to find out that even breaking up the two renames into two
separate commits git still didn't follow it.

I'm just curious--I don't run into this often myself--but is there a
good strategy for dealing with this that avoids the conflict?

Thanks!

-John
