From: Jon Seymour <jon.seymour@gmail.com>
Subject: Is there an agreed protocol for git repo locking?
Date: Sun, 10 May 2009 23:58:02 +1000
Message-ID: <2cfc40320905100658i4d7ef065qe01e35f2929dd2f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 10 15:58:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M39Xh-0003TY-9R
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 15:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509AbZEJN6F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 09:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752315AbZEJN6E
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 09:58:04 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:41809 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbZEJN6C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 09:58:02 -0400
Received: by yx-out-2324.google.com with SMTP id 3so1388491yxj.1
        for <git@vger.kernel.org>; Sun, 10 May 2009 06:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=3l7EpbXlpXX2/T5vePJf/n2Impt8QAbYmCD5IQ6+zP8=;
        b=jPJ036tT7ToCIOq7Da7BqufgR/v/p11r7Pl9KMnEa/jn4pjFYwk7eXj4O9opn46ntP
         Ve2lqgopgfm9WlS1XUIHRnb/ZxYrdgUgNCpJyVEQBb+mvdtbAZuGk0SnQb7Tyzo3wKFQ
         tHRD9AyYUbM2gEYJ2N7F7GNJigWMn7zJFVFa0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=kdT7+BYLtTUXAvX/plJW3aMVood5sdGcVC7YCV/z4dWNAsvujyFilP0fS8jQbK2b7R
         RPQbYGfX5/NyS44PQyFE3yY1YK1O81dXVr6QG/5QMUZKASncoFCokpY3quKSGu2l3a9K
         O5MC4N1jFRF09N/7Od/H4ej4hS5LQgPlXfJTQ=
Received: by 10.151.122.5 with SMTP id z5mr10984124ybm.196.1241963882431; Sun, 
	10 May 2009 06:58:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118719>

As I understand it, the normal use case for git is one in which a
single user performs a number of git operations in sequence on a
private repo.

As such, locking issues don't normally arise - the user is only doing
one thing at once.

I am working on an idea which will imply the need for concurrently
executing processes to modify the repo, in particular refs.  I
specifically don't want to have a repo for each process precisely
because I don't want to incur the costs of repo creation for every
process and, in any case, I need them to share the refs.

In my use case, I may need locks that span several otherwise atomic
operations - therefore relying on atomic locks that each git tool
might employ for safety is not sufficient.

Is there an agreed upon locking protocol for the git repo? Is there
tool support for this locking?

The case for adding it is that locking protocols only work if everyone
agrees on the same protocol. The easiest way to do this would be to
provide tools that enforce the desired locking protocol.

jon.
