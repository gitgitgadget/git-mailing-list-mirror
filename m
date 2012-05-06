From: Jon Seymour <jon.seymour@gmail.com>
Subject: How does git now about future renames during a rebase?
Date: Sun, 6 May 2012 09:41:00 +0530
Message-ID: <CAH3Anro6o478A41eXcsFU7guOobQXhqq=DdpNpGWgriRVfqcZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 06 06:11:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQsoz-00086T-7S
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 06:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777Ab2EFELD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 00:11:03 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:34588 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721Ab2EFELB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 00:11:01 -0400
Received: by werb10 with SMTP id b10so638363wer.19
        for <git@vger.kernel.org>; Sat, 05 May 2012 21:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=XYTDbHf7zOQWS7Oq7WCcVu8xQHV9oUcGtcy1XnSYP0U=;
        b=1HUV6UGbOzJ1KQ8lDlq+ohTFIz8DHnLmKn0a5btyNIP6aCL6+loepWxzl5oH0TOYc0
         C2/xwKe4HUsLWjkVAvoxPYiOaYpjqIb+D/FYUCM8pQAUh4N6mEE8rZBFrudMu/Oozl29
         mKli/I56CprqRjDv8YwkX+iqOJkVe8/Sef86zUTJwvE34Q7E0kJHWsHfNOLT8FAQjrp6
         jzY5xP2sPTLg74HArbKzRJxdjuUsY0xrD9NwnswA+Kvyjws+jdxPTj2PulRAK5KzA4P6
         mTNzz2gg/3fM87/n/DqpGVMoxjuwX3gFJj3PaWBBHjhsKoCdZhUX1Yjcp98c6F2rH+hy
         f2kQ==
Received: by 10.216.208.41 with SMTP id p41mr7014149weo.21.1336277460415; Sat,
 05 May 2012 21:11:00 -0700 (PDT)
Received: by 10.180.82.35 with HTTP; Sat, 5 May 2012 21:11:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197146>

I had a history that looked like this:

1. some other commit
2. commit that moves files from one directory to a new directory
3. commit that edits files in the new directory.

I then did an interactive rebase to move the commit 3 before commit 2.

1. some other commit
3a. commit that edits files in the new directory.
2a. commit that moves files from one directory to a new directory

I didn't expect this to work, but somehow git worked out that it
needed to apply the change in 3 to the original location of the files.

How does it do this?

jon.,
