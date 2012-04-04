From: Tim Henigan <tim.henigan@gmail.com>
Subject: Output of 'diff' and 'diff --raw' not the same for modified submodule
Date: Wed, 4 Apr 2012 09:03:26 -0400
Message-ID: <CAFouetg6rB7oyYGBuMMSgWzaKFwUWTdp4OUo3czvJro4iHa_kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 04 15:04:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFPsZ-0005gJ-AY
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 15:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756259Ab2DDND2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Apr 2012 09:03:28 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:54575 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756193Ab2DDND1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Apr 2012 09:03:27 -0400
Received: by yenl12 with SMTP id l12so86053yen.19
        for <git@vger.kernel.org>; Wed, 04 Apr 2012 06:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=NQt5vr04PWb7uLqCAuEWSqm7/JRjWTpxCUfY5/oWHp8=;
        b=osuN5KY/jO0C7y2/+En647El7Hb4lpiP6N+xkQRQb7fagIM/hO7HPonA6K2vg2JtY9
         VUIB8RXwZU2UCiNUs1mRdp3Ate3RT7onDnvH20mqAP8ge9GmJKvllDGfL/6osufPk9t/
         Wciv85/xhlFnflo3v98FlIqWIf32/feh954F3oAnitrgSX3hclb1K3HPdDa7DhYvi9kB
         GBqhGkwRaDNsXCa85eAQOzimmi2u/uDgbDkMLKVNghlaDZ9fL12VW4sV0xW5K6c+bQvV
         mdgtBh+oPA77aARJdyp+LeCY4Vr7ARh46CTFOyZ5e9pYtOYUZJWWXasi+88FrpL0/NnM
         kULA==
Received: by 10.50.207.5 with SMTP id ls5mr1414046igc.51.1333544606744; Wed,
 04 Apr 2012 06:03:26 -0700 (PDT)
Received: by 10.42.225.193 with HTTP; Wed, 4 Apr 2012 06:03:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194699>

If a submodule has new commits, then 'git diff' and 'git diff --raw'
report different outputs.

=46or example, the following output is given after adding a new commit
to a submodule:

$ git version
git version 1.7.10.rc4

$ git diff
diff --git a/lib/tst-mergetool b/lib/tst-mergetool
index 9917ea0..5bc1908 160000
--- a/lib/tst-mergetool
+++ b/lib/tst-mergetool
@@ -1 +1 @@
-Subproject commit=C2=A09917ea0c228a0c24153da38df954f8a9d78cafac
+Subproject commit 5bc19083c436aaa85762cdc309e62ed98f5cc276

$ git diff --raw --no-abbrev
:160000 160000=C2=A09917ea0c228a0c24153da38df954f8a9d78cafac
0000000000000000000000000000000000000000 M =C2=A0lib/tst-mergetool


'git diff' shows the new SHA1 for the submodule, but 'git diff --raw'
shows the NULL ID. =C2=A0From the diff man page, I understand that the =
NULL
ID indicates "creation, unmerged or 'look at the work tree'", but I
expected the output of two commands to match.

Is this the intended behavior?

Thanks,
Tim
