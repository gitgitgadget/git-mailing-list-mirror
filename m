From: Nazri Ramliy <ayiehere@gmail.com>
Subject: "git grep --no-index" doesn't do what it says on the tin?
Date: Wed, 15 May 2013 13:32:51 +0800
Message-ID: <CAEY4ZpP8txhCCmw-Ck7_rQL+Xn4bJw-RgVa7iDaHzQ6mcS5oLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 15 07:32:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcUKg-0007v6-6R
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 07:32:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031Ab3EOFcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 01:32:54 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:52044 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420Ab3EOFcx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 01:32:53 -0400
Received: by mail-lb0-f171.google.com with SMTP id v20so1460429lbc.2
        for <git@vger.kernel.org>; Tue, 14 May 2013 22:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=oHmIFBvkRVKQxIZh8yP9EypHCHtncwhwo7giy35dpbA=;
        b=nx7AjiLQUvM0PlP0amjmlWtx+fuPVAsijmpGEYAbvGTCy7Ux1LdFlg1tW3ioRQTY4r
         /Ee/bc0I8JA3IhuDOdisvexStvwRH2m3XIYHcwIcjcdKsUHRa6OTRdUH4DPX3ggwz8ny
         CY4MCCd79eS34OyGGc83Fg0/+uyAj2t9msbgmuPVIeHHMxLqSOAWfjrCLP/lzY+TECxQ
         kAPRNkDJh+KL8GpDH4AdWv1mlZDjIhGcsQ55g4Q4y/O1VgVUsLvDkwbaPTFsdO0HeNil
         JEI+65XxfIF+OzA40xauaMloD6lZeDl/jTaVw0NhpBXT1fI6M2IyPmTLjfA/ZM8WWwwi
         futw==
X-Received: by 10.112.21.234 with SMTP id y10mr2099262lbe.53.1368595971665;
 Tue, 14 May 2013 22:32:51 -0700 (PDT)
Received: by 10.112.162.200 with HTTP; Tue, 14 May 2013 22:32:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224380>

Hi,

>From "git help grep":

      --no-index
           Search files in the current directory that is not managed by Git.

       --untracked
           In addition to searching in the tracked files in the working tree,
           search also in untracked files.

>From the description above I would think that "git grep --no-index"
and "git grep --untracked" would behave differently, but it seems like
their behavior is the same:

        $ cd ~/src/git
        $ echo superman >> git.c
        $ echo superman >> foo.txt
        $ git grep --no-index superman
        foo.txt:1:superman
        git.c:588:superman
        $ git grep --untracked superman
        foo.txt:1:superman
        git.c:588:superman

I would expect the following behavior for "git grep --no-index":

        $ git grep --no-index superman
        foo.txt:1:superman
        $

That is, it won't search inside files that are managed by git.

nazri
