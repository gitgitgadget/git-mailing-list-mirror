From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 0/9] A natural solution to the @ -> HEAD problem
Date: Thu,  2 May 2013 19:09:25 +0530
Message-ID: <1367501974-6879-1-git-send-email-artagnon@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 02 15:38:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXti8-00020R-O5
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 15:38:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759343Ab3EBNiF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 09:38:05 -0400
Received: from mail-da0-f48.google.com ([209.85.210.48]:33461 "EHLO
	mail-da0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757877Ab3EBNiD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 09:38:03 -0400
Received: by mail-da0-f48.google.com with SMTP id h32so318122dak.35
        for <git@vger.kernel.org>; Thu, 02 May 2013 06:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=EOcEHdFYDMPs2vOea73/oEf8+y1rLt2Bf3FC0kDFhpI=;
        b=yLbZjlMuf8OuURng+joc4fkIabEdODQPkKmLOGrLps+PsQ2tJ7OJpc8gk0wf7zarCr
         /6/e6nrQIapCm1PIKeYDkPxxZMkgvvZ0BFsyI0+lkIwwlpVHU04RZGxWGK8yL6SufnIb
         sQDZmx0iNDJ5v5uldmR5RTx7Btm+5Xibj/cATTqzKFbI1p1h0pGkFagS4foPK8XY+7rY
         kpCY8WBiKXs3k+I0MiiPPdEqJJia/kAfuZgDK2GZH/gI8X+YwsE/3V2fGqbGv6HGLqA3
         8BlyEEZUpwGOMcb3Vzqs2fw8xvCf6ZQm5G2CnJbMZ2YCqJAGNTHj5cmAYsaUHpky+CCA
         DAqw==
X-Received: by 10.68.129.10 with SMTP id ns10mr7391641pbb.13.1367501882188;
        Thu, 02 May 2013 06:38:02 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id wi6sm7392889pbc.22.2013.05.02.06.37.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 02 May 2013 06:38:01 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.40.g09a0447
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223197>

Hi,

So, we're back with v2 of the series.  Six patches add comprehensive
tests to at-combinations, guarding against any future bugs.  [7/9] is
the most important part, where I've fixed branch_get() with a long
justification.  [8/9] and [9/9] are almost trivial.

As Felipe pointed out, [9/9] might require more documentation, but I
don't know where to put it.  Help in the area is appreciated.

I've excluded all @-parsing simplification in this series.  It will
come as a later series based on this one: I'm currently integrating
Felipe's work with mine.

Felipe: can I have your sign-off for the first three parts?

Thanks.

Felipe Contreras (3):
  t1508 (at-combinations): simplify setup
  t1508 (at-combinations): test branches separately
  t1508 (at-combinations): improve nonsense()

Ramkumar Ramachandra (6):
  t1508 (at-combinations): increase coverage
  t1508 (at-combinations): document @{N} versus HEAD@{N}
  t1508 (at-combinations): test with symbolic refs
  remote.c: teach branch_get() to treat symrefs other than HEAD
  sha1_name.c: fix @-parsing bug in interpret_branch_name()
  refs.c: make @ a pseudo-ref alias to HEAD

 Documentation/git-check-ref-format.txt |  2 +
 Documentation/revisions.txt            |  8 +++-
 refs.c                                 | 12 +++++-
 remote.c                               | 23 ++++++++++--
 sha1_name.c                            |  2 +-
 t/t1400-update-ref.sh                  |  3 ++
 t/t1508-at-combinations.sh             | 68 ++++++++++++++++++++++++++--------
 7 files changed, 94 insertions(+), 24 deletions(-)

-- 
1.8.3.rc0.40.g09a0447
