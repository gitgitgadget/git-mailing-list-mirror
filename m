From: Zenaan Harkness <zen@freedbms.net>
Subject: contrib/git-normal-to-bare.sh
Date: Mon, 27 May 2013 14:54:35 +1000
Message-ID: <CAOsGNST8X+crMQz1ynJQxctCMUnBw3T3K5HiMH8B_GFP63yX1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 27 06:54:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgpSO-0006cP-Ui
	for gcvg-git-2@plane.gmane.org; Mon, 27 May 2013 06:54:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510Ab3E0Eyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 May 2013 00:54:37 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:51042 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841Ab3E0Eyg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 May 2013 00:54:36 -0400
Received: by mail-qc0-f174.google.com with SMTP id m16so3357581qcq.33
        for <git@vger.kernel.org>; Sun, 26 May 2013 21:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        bh=H9nwi9eXjEmsO39lsuWVCaqJMBBwv/T4jExQoNspDwo=;
        b=at32lDSfPc/Q1+3pJu6etM5gJu5ZkKpbxx0DC0ZbbscIZXl+U9p7TM3NQ7+AG4Eqmw
         qG6WB/4vexTMouGoJUczmSG0UWIi2h6qRhbnzAFyk62PrnAfMEmGFKBt+hSGN+mubQW0
         3dB71tcG6LLiQjlGeZ+Ng77SmE+1Ob/V3uLnGKJ6G9l9jS2+trZm2xt2dQXCCrzhaGPO
         q9cf7zhAr7E3LoYYSYRPqo+4N/2p17o9HmOdqQ0OauOkrvpJpQzyefYr5T3P0/HT/+3m
         Yg8xQ/mlHJF7ns1PZ5D7zMljr3JyoqA5/4H0/sm5+icp0T9/pas9dyHNsQAuA8pOMxte
         UjFg==
X-Received: by 10.224.208.68 with SMTP id gb4mr25487193qab.25.1369630475939;
 Sun, 26 May 2013 21:54:35 -0700 (PDT)
Received: by 10.49.103.201 with HTTP; Sun, 26 May 2013 21:54:35 -0700 (PDT)
X-Google-Sender-Auth: 1Ely2jqaNajmxumRKRHvpc71ExI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225576>

I needed this quite a bit in the last few days, basic script but
serves my need. I think it would be useful for other beginners if in
$git/contrib/ source dir.

Just a start to a basic script. Needs more tests etc, but it's enough
to get newbies (like me) off to a reasonable start. Handles multiple
input dirs.

PLEASE CC me, as I am not subscribed.

(some SMTP server rejected attachment, so pasting below instead)

Thanks,
Zenaan


#!/bin/bash

# Change one or more normal repos into bare repos:
# See also https://git.wiki.kernel.org/index.php/GitFaq#How_do_I_make_existing_non-bare_repository_bare.3F

for i in "$@"; do
   echo; echo "----------------------"
   echo Processing $i

   repo="$i"
   repo="`basename $i`"
   tmp_repo="${repo}.git"

   # Insert here: may be exit if any spaces in repo fqn
   # Insert here: check for non-existent repo/.git dir
   # Insert here: check that we are not inside the repo
   # Insert here: add exit/do-nothing if fail to mv dirs etc

   mv $repo/.git $tmp_repo
   git --git-dir=$tmp_repo config core.bare true
   mv $repo ${repo}.bak
   mv $tmp_repo $repo
done
