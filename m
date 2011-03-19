From: =?UTF-8?B?cnllbnVzIOKXhw==?= <ryenus@gmail.com>
Subject: [PATCH] repack: find -> /usr/bin/find, as for cygwin
Date: Sat, 19 Mar 2011 20:08:04 +0800
Message-ID: <AANLkTimHof_MNSGbU2KGX=7Q3MQpjkzXK+xyGGVjbngR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Mar 19 13:08:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0uxR-0000Q3-Jn
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 13:08:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597Ab1CSMI0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 08:08:26 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:65449 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451Ab1CSMIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 08:08:25 -0400
Received: by gwaa18 with SMTP id a18so1891215gwa.19
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 05:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=7KM93Lv6dkf9wAfrGZmErHJrGoWrtoXtjNrp4RwRQxw=;
        b=Pc2wDHG5UR6gMI24U+5SheZqIrLhiaEhp5HK2A0YdG0YYxFqpoSWZuzgM50UHozGJK
         BWmMXu4dGCAfBkTpAwC9OjJPbFnv2d1SNV1CT6sNei3+hPT00bDJfwSwxdnWcY/6Mb8k
         7tA0TkV8SMnaQEuP/lA2ecN0D6Q0EqnKjkcMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=faQR00rfsrM22aU64+wNpNda7IY4PvkR54PIXX1pRhYfZTCednvAxlQJd6uj/X3JzH
         foiWsIWEHK0iUw/eMZzrTsamG04GYfzd+YmN9PtTBtqYKujPffGEm0GDBD9ObQduqmmY
         c6rJa0hSCy8oFvqoBXXPMmIQlSNvR3q5WSOIc=
Received: by 10.101.42.1 with SMTP id u1mr81871anj.51.1300536504099; Sat, 19
 Mar 2011 05:08:24 -0700 (PDT)
Received: by 10.100.121.3 with HTTP; Sat, 19 Mar 2011 05:08:04 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169426>

If I run Cygwin git directly from cmd.exe instead of from a shell,
e.g. bash, I get the following error when executing git repack

FIND: Parameter format not correct

that's because in git-repack.sh, 'find' is called without its full
path, this patch corrects this

Signed-off-by: ryenus <ryenus@gmail.com>
---
 git-repack.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-repack.sh b/git-repack.sh
index 624feec..212caa7 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -64,7 +64,7 @@ case ",$all_into_one," in
 ,t,)
        args= existing=
        if [ -d "$PACKDIR" ]; then
-               for e in `cd "$PACKDIR" && find . -type f -name '*.pack' \
+               for e in `cd "$PACKDIR" && /usr/bin/find . -type f
-name '*.pack' \
                        | sed -e 's/^\.\///' -e 's/\.pack$//'`
                do
                        if [ -e "$PACKDIR/$e.keep" ]; then
--
1.7.4
