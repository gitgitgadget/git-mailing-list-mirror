From: Levin Du <zslevin@gmail.com>
Subject: Questions about git-push for huge repositories
Date: Sun, 6 Sep 2015 16:16:31 +0800
Message-ID: <CAN6cQGPcGpaXUGu_7aaeJtMbruMocte-5po97vG5r39f=YdTZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Levin Du <zslevin@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 06 10:16:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYV7v-00078d-CP
	for gcvg-git-2@plane.gmane.org; Sun, 06 Sep 2015 10:16:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076AbbIFIQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2015 04:16:35 -0400
Received: from mail-vk0-f44.google.com ([209.85.213.44]:35839 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbbIFIQc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2015 04:16:32 -0400
Received: by vkaw128 with SMTP id w128so30111562vka.2
        for <git@vger.kernel.org>; Sun, 06 Sep 2015 01:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=x2Voy3RSHDPnHBeSqheWtuwU2X0ro0MWyLyeYY2LrXQ=;
        b=T4AjAuC6X8lspGYZmPplsE6XKh4jwbrbeGrM+l7kJh4IzPqcIziZMp6KfQotPYQ8XC
         gKaDyNwgVw0uUJfuPrKTI+5qrvxZ2aN0povSSncILnpDu+MFe9luU4v1EjoUoF/JgObT
         x6mGD2/YA4kSUyNx8EaR9F5ctPuVInzxH6ZvQ6kZUDKj0OP0ULK4NfA1sQmuo5irQj10
         obY3J+/X4qb9bscmvzwU4MKu2OB2RJ5Zr+9x8lGdL455jKnXkk7w9ymSh0t8NCkjUmyj
         xwPNm5kkSz08s1lQ49I6g9pQeuK7Q3Tx0Nt71xd2f3RJ+3cxREzKHmiEQXZBqWfdHXvu
         Vn5w==
X-Received: by 10.52.229.8 with SMTP id sm8mr17525851vdc.26.1441527391977;
 Sun, 06 Sep 2015 01:16:31 -0700 (PDT)
Received: by 10.103.85.138 with HTTP; Sun, 6 Sep 2015 01:16:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277417>

Hi all,

I meet with a strange problem:

I've two repositories, with sizes:
  - A:  6.1G
  - B:  6G

Both A & B have been 'git gc' with:
  git reflog expire --expire=now --all
  git gc --prune=now --aggressive

Since A & B share many common files, to save disk space, I'd like to merge them:
(note: branch of A & B are independent, i.e. have no common ancestor.)
   git clone --bare A  C
   (cd B; git push ../C master:master_b)

Repo C's size has grown to 12G. Doing a 'git gc' again, it drops to 6.2G.

I expect that 'git push' push only new files and commits, which will
save lots of space.
Yet it turns out I'm wrong. Since Repo A has been published, pushing branch of B
will double the repo size, which is impossible for the storage limit.

Any suggestions? Thanks in advance.

Best Regards,
Levin Du
