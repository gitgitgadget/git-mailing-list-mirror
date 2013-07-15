From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 0/5] Make "git show -s" easier to discover for users
Date: Mon, 15 Jul 2013 15:07:14 +0200
Message-ID: <1373893639-13413-1-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqa9lof2e4.fsf@anie.imag.fr>
Cc: stefanbeller@googlemail.com, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 15 15:12:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyiZb-0006i8-GX
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 15:12:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757136Ab3GONLw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 09:11:52 -0400
Received: from mx1.imag.fr ([129.88.30.5]:40308 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757121Ab3GONLv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 09:11:51 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r6FD7r09019953
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 15 Jul 2013 15:07:53 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1UyiVO-0000YD-Nh; Mon, 15 Jul 2013 15:07:54 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1UyiVO-0003X5-CA; Mon, 15 Jul 2013 15:07:54 +0200
X-Mailer: git-send-email 1.8.3.1.495.g13f33cf.dirty
In-Reply-To: <vpqa9lof2e4.fsf@anie.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 15 Jul 2013 15:07:53 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r6FD7r09019953
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1374498476.4797@mslaFcdqRxDHDbeIxl52rw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230467>

> Stefan Beller <stefanbeller@googlemail.com> writes:
>
>> However I sometimes also get:
>> sb@sb:~/OSS/git$ git show --format="%ad" 0da7a53
>> Fri Jul 12 10:49:34 2013 -0700
>>
>> diff --git a/Documentation/RelNotes/1.8.4.txt
>> b/Documentation/RelNotes/1.8.4.txt
>> index 0e50df8..4250e5a 100644
>> --- a/Documentation/RelNotes/1.8.4.txt
>> +++ b/Documentation/RelNotes/1.8.4.txt
>
> "git show" will show the diff by default. For merge commits, it shows
> the --cc diff which is often empty, hence the behavior you see.
>
> You want to use "git show -s", which suppresses the patch output.

... and this "git show -s" is extraordinarily hard to discover, as it
is only documented in "git log --help". Google has been my friend
here, but we should really improve that.

This patch series does essentially two things:

* Add a --no-patch synonym for -s. I'm actually wondering why the
  option wasn't called this way from the beginning.

* Reorganize the doc so that "git show" actually mentions it.

While we're there, there's a reformatting patch, and one to make "git
log --no-patch --patch" actually show the patch.

(60aa9cf8f3, Documentation: document show -s, Tue Nov 9 11:12:48 2010
actually acknowledged that the documentation wasn't complete and that
something else was needed, this should be it)

Matthieu Moy (5):
  diff: allow --no-patch as synonym for -s
  diff: allow --patch to override -s/--no-patch
  Documentation/git-show.txt: include common diff options, like
    git-log.txt
  Documentation: move description of -s, --no-patch to diff-options.txt
  Documentation/git-log.txt: capitalize section names

 Documentation/diff-options.txt     | 5 +++++
 Documentation/git-log.txt          | 8 ++++----
 Documentation/git-show.txt         | 9 +++++++++
 Documentation/rev-list-options.txt | 3 ---
 diff.c                             | 7 ++++---
 5 files changed, 22 insertions(+), 10 deletions(-)

-- 
1.8.3.1.495.g13f33cf.dirty
