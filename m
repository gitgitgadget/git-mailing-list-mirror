From: Eugene Sajine <euguess@gmail.com>
Subject: git daemon --access-hook problem
Date: Fri, 31 May 2013 16:22:38 -0400
Message-ID: <CAPZPVFZDHHGyHhzBVVK6jS=XhEd2+JpmBT8ofiGOww8vuLUWWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 31 22:22:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiVqW-00067M-Ix
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 22:22:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754281Ab3EaUWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 May 2013 16:22:40 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:61739 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754054Ab3EaUWi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 16:22:38 -0400
Received: by mail-ie0-f178.google.com with SMTP id f4so5032609iea.23
        for <git@vger.kernel.org>; Fri, 31 May 2013 13:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=oimfKWeOx6t032h27Iy7AM6C6eqBAsyJkjM50Zy0DTY=;
        b=kKvM7cvMF5x3UsyUTC7h7W11JT8DJ05tS6/R/0RRw/psIleAXIGUN/KrwxdV6I6y7E
         RAJwRaW9R0XmRWt7w5aExXR3oqITmWWdRWNFRDboKz1x3jo2+2mBsf+I61GX244EPNPT
         O3x207GytQfhKpiPBQzVZmJtNgTvv7ZLr1BxWsqxWOCK+bOhil/Y5/WyxTtiTo28furE
         Me9gzhndA80u99G3CY2pQJdUFWgBzB9wRjlJaJ3V9LXvNyqNZjlIoTEHht9eWZD7XR2v
         6VsvJ2AMM4lqwWu9qBqvjNyx/ijkspx034Ns8RW3a8VvM1mOCUjkx9HBS3K1xu9XXN9O
         mAoA==
X-Received: by 10.50.80.101 with SMTP id q5mr2578360igx.2.1370031758445; Fri,
 31 May 2013 13:22:38 -0700 (PDT)
Received: by 10.43.85.7 with HTTP; Fri, 31 May 2013 13:22:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226097>

Hi,

I'm trying to test this new feature and having problems getting any
results in the following scenario:

i have a repo in local folder

/home/users/myuser/repos/projectA/.git

i start the daemon with the following:

git daemon --export-all --base-path=/home/users/myuser/repos
--enable=receive-pack --access-hook=/home/users/myuser/test_hook.bash

test_hook.bash has the following:

#!/bin/bash
echo $@ >> test_hook_out.txt
echo $REMOTE_ADDR >> test_hook_out.txt

the hook is set to be executable - otherwise it complains when i do
anything via git protocol, which proves that it seems to or check the
hook:

then i did:

cd ~/tmp/

git clone git://myhost/projectA projectA
cd projectA

and trying to perform some operations like fetch or push. It is cloned
and fetches and pushes successfully.
The problem is that the file test_hook_out.txt doesn't have anything
in it after the execution, So the hook doesn't seem to work.

What might be the issue here?

Thanks,
Eugene
