From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Aborting cherry-pick
Date: Wed, 16 Feb 2011 10:16:28 +0100
Message-ID: <AANLkTingcnvm6rLnWdweAKdeOWAVjh+F+6BMWzfJxhKi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 16 10:16:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpdUy-0004TA-OL
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 10:16:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758754Ab1BPJQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 04:16:31 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:38134 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754167Ab1BPJQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 04:16:29 -0500
Received: by qyk12 with SMTP id 12so1180380qyk.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 01:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=8rwAk7mzu1uWiY1KL+gWQGZeB5AE2VAGUvTItpXkkHM=;
        b=OWXsaHKwLitoC2W82gXkca20PPSudpzR1L9lHHmJhgIar+UJ8kdS9tzSZS9tA4hLnU
         fkbdoz5vpnvAGMRFwILenyW+r53eJPBZEwwKG56UX0KQLniPvGgUYDbm6Q0QTu7Y2UN2
         H/sZ+Zu0CjBEZGR2wbQqQiIGY2I7M84eflpzo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=aS/YWWy2JXAxTF+wBAZJLb6fKF+rn/Ff07DW87hvYK5o7NuRj57Xwp99QBwp4gOVJ/
         CadE8U2WdTcdHUKarE/v43Ab6oYJ+2xxOrdwVf55htF8T/XKQGgMbD7h5vcj2yOD6PQD
         BiTX4p1ufAqwd5rp7JOLwTzOSMuOheOchSFSA=
Received: by 10.224.74.10 with SMTP id s10mr423850qaj.291.1297847788578; Wed,
 16 Feb 2011 01:16:28 -0800 (PST)
Received: by 10.220.195.132 with HTTP; Wed, 16 Feb 2011 01:16:28 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166935>

Hi,

I'd like to suggest improving cherry-pick messages/documentation
in case of conflicts.

Example of cherry-pick conflict:

   $ git cherry-pick  c64e8caa56fd76577bbaea37592f4a9df10ab1b8
   error: could not apply c64e8ca... <<commit message>>
   hint: after resolving the conflicts, mark the corrected paths
   hint: with 'git add <paths>' or 'git rm <paths>'

   $ git status
   # On branch master
   # Unmerged paths:
   #   (use "git reset HEAD <file>..." to unstage)
   #   (use "git add/rm <file>..." as appropriate to mark resolution)
   #
   #	both modified:      <<file>>
   #
   no changes added to commit (use "git add" and/or "git commit -a")

I see following possibilities:

1. add hint to cherry-pick how to abort merge, for example:
   hint: use 'git reset --merge ORIG_HEAD' to abort merge

2. add hint to status how to abort merge, for example:
   #   (use 'git reset --merge ORIG_HEAD' to abort merge)

3. add "--abort" to cherry-pick (same option as for git-merge)

The ORIG_HEAD is specified in man page example. There is also
a possibility of omitting ORIG_HEAD in which case local changes
are retained. Maybe this is a better suggesting for the user?
Or maybe describe both cases somewhere and point user to this
documentation in status/cherry-pick output?

git-cherry-pick uses word "cancel" in man page (in example) and
git-merge uses word "abort" for (as I understand) the same action.

I would suggest using either same word for both cases, or using both
words in both cases. Otherwise it's confusing if you read about "aborting"
merges and when you want to abort cherry-pick you don't find it - because
it's called "canceling".


What is your opinion on this?


-- 
Piotrek
