From: Anand Kumria <akumria@acm.org>
Subject: Is git mktag supposed to accept git cat-file input?
Date: Thu, 25 Oct 2012 00:39:13 +0100
Message-ID: <CAM1C4GneOnyBQyJRbhtuYNDsc4NxXgFcfHrQpziLpp_AY0TjbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 25 01:39:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRAYH-0005jS-A3
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 01:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758880Ab2JXXjo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Oct 2012 19:39:44 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61175 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757762Ab2JXXjn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Oct 2012 19:39:43 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so1563474pbb.19
        for <git@vger.kernel.org>; Wed, 24 Oct 2012 16:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type:content-transfer-encoding;
        bh=qmrrY7A4IaSHkwSzAG717LzoZX660cDdxtunyvbPipg=;
        b=ttQi5frngXrID2HEiqo06wV5a6Wqz+Ahr3P9Ifyww57nKNs/dh74aOWtK4PVnT/WAZ
         BdwhqkaOuT0aJ8IpzDomI3R92nwODHM2rpQvg3AYeFee68/MFoj6HDELEBRFbOC2QDHN
         xbLMKhm+CIItFEZfH1fyFYu1Qb9vvtXnsxHW9Edh6zNUasRqXT1jmj5gKPc1OKTz028k
         q6aFyDGoi3N53SG8SD27zsg1X7WjAmpes3Kt1oZN8YHxRb72GLluQGY3q5zcracoBrsH
         7tFJW/Doktf9KT6ImGgtaT3vIkHkUmbno3PAmw6EUSmfHbRKCIBtlzvswp3fpg631u+7
         87sA==
Received: by 10.66.88.197 with SMTP id bi5mr47872875pab.58.1351121983490; Wed,
 24 Oct 2012 16:39:43 -0700 (PDT)
Received: by 10.66.189.166 with HTTP; Wed, 24 Oct 2012 16:39:13 -0700 (PDT)
X-Google-Sender-Auth: nirf_oebSo3GodH717KTwiGuRic
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208327>

Hi,

I am doing some experimenting with git-mktag, and was looking into the
format it expects on input.

Should this sequence of commands work?

kalki:[~]% mkdir /tmp/gittest; cd /tmp/gittest
kalki:[/tmp/gittest]% git init
Initialized empty Git repository in /tmp/gittest/.git/
kalki:[/tmp/gittest]% echo "test" > test
kalki:[/tmp/gittest]% git add test
kalki:[/tmp/gittest]% git commit -m "commit-test"
[master (root-commit) c0ae36f] commit-test
 1 file changed, 1 insertion(+)
 create mode 100644 test
kalki:[/tmp/gittest]% git tag -m "tag-test" tag-test
kalki:[/tmp/gittest]% git cat-file -p e619
object c0ae36fee730f7034b1f76c1490fe6f46f7ecad5
type commit
tag tag-test
tagger Anand Kumria <akumria@acm.org> Thu Oct 25 00:32:32 2012 +0100

tag-test
kalki:[/tmp/gittest]% git cat-file -p e619 | sed
-e's/tag-test/tag-test2/' > tag-test2
kalki:[/tmp/gittest]% cat tag-test2
object c0ae36fee730f7034b1f76c1490fe6f46f7ecad5
type commit
tag tag-test2
tagger Anand Kumria <akumria@acm.org> Thu Oct 25 00:32:32 2012 +0100

tag-test2
kalki:[/tmp/gittest]% git mktag < tag-test2
error: char112: missing tag timestamp
fatal: invalid tag signature file
kalki:[/tmp/gittest]% git --version
git version 1.7.9.5

The error message related to the timezone / timestamp being incorrect
but I can't see what the problem is.

Any advice appreciated.

Please CC me as I may miss your reply.

Thanks,
Anand

--
=E2=80=9CDon=E2=80=99t be sad because it=E2=80=99s over. Smile because =
it happened.=E2=80=9D =E2=80=93 Dr. Seuss
