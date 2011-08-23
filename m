From: "Nathan W. Panike" <nathan.panike@gmail.com>
Subject: Looking for a way to turn off/modify ref disambiguation
Date: Tue, 23 Aug 2011 14:26:48 -0500
Message-ID: <CAPRoxBXjL3Y3KRd8R2guX9Ar374sw-pBhz1bCzNZxn1vC6XNPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 23 21:26:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qvwcg-0004Is-Iu
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 21:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755665Ab1HWT0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 15:26:49 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37698 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755304Ab1HWT0t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 15:26:49 -0400
Received: by ywf7 with SMTP id 7so339073ywf.19
        for <git@vger.kernel.org>; Tue, 23 Aug 2011 12:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=jsOXxAVud4rR6xYpKyzDqc8wzfNO0xRs9AqWD0rZw/0=;
        b=vFgSdpIxyhPilwYkto+ISQZNrGwvfb4K7jbZm00ihRocUNgDERiFuWALo6YmM+VB30
         b5ARWUJLd+r/xcgZ1jvdWDTeqv94cxN17c+ZA1037eqrV5naPbCoC8gBmiSvKx51DNQy
         7wMHajx3NmjK55R+TytEV0a7BoxE/L77szd1o=
Received: by 10.142.214.12 with SMTP id m12mr2347041wfg.73.1314127608221; Tue,
 23 Aug 2011 12:26:48 -0700 (PDT)
Received: by 10.142.72.16 with HTTP; Tue, 23 Aug 2011 12:26:48 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179962>

A colleague at $dayjob recently caused corruption in our git
repository by accidentally running the command

git rebase origin stable

where they meant to run

git rebase origin/stable

The git-rev-parse(1) man page says:

...
<refname>, e.g. master, heads/master, refs/heads/master

    A symbolic ref name. E.g. master typically means the commit object
referenced by refs/heads/master. If you happen to have both
heads/master and tags/master, you can explicitly say heads/master to
tell git which one you mean. When ambiguous, a <name> is disambiguated
by taking the first match in the following rules:

       1.          If $GIT_DIR/<name> exists, that is what you mean
(this is usually useful only for HEAD, FETCH_HEAD, ORIG_HEAD,
MERGE_HEAD and CHERRY_PICK_HEAD);
       2.          otherwise, refs/<name> if it exists;
       3.          otherwise, refs/tags/<refname> if it exists;
       4.          otherwise, refs/heads/<name> if it exists;
       5.          otherwise, refs/remotes/<name> if it exists;
       6.          otherwise, refs/remotes/<name>/HEAD if it exists.
...

Is there any way to change this behavior, e.g., so that rule 6 becomes
an error? Say, by setting a config option?

==========
Nathan Panike
