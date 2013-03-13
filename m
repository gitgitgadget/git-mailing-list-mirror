From: =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>
Subject: Suggestion for difftool behaviour during a merge conflict
Date: Wed, 13 Mar 2013 19:48:59 +0100
Message-ID: <CAFaJEqu8gHSLK5u7v5ZOaJ1XjAhV=F9p46MEo2sDVH4vpXAojA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 13 19:50:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFqkZ-00055R-7O
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 19:50:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932902Ab3CMStk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Mar 2013 14:49:40 -0400
Received: from mail-vc0-f182.google.com ([209.85.220.182]:45858 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755178Ab3CMStk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Mar 2013 14:49:40 -0400
Received: by mail-vc0-f182.google.com with SMTP id fl11so735585vcb.13
        for <git@vger.kernel.org>; Wed, 13 Mar 2013 11:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=ck+04LpCZFv/o8Fm/XVwePVbF1vNnw3XPE3HAIBAfUE=;
        b=ScHDB4vuuwXKWXBmYtZ3fbIVj5u+ZXNWOaz6pu875bIYPuT2sx2kvut8YuDChm59Wu
         DeGsvGM99MLnzOSDGBDuVyMacMolv2Zq+YItxGWOjunvUd9puGO8nMRH74oty4WAYhdQ
         cLQ5+B7AA05zQFV6iJXmijgjJ6nOv50GkOB0cLVTEH0K3vtYRnt0SdUX3nRNx+M8Wi8a
         CT8EX/1alXU7VaseAjz2kIStenImKNoL//5IMWnZDfeHgbYIbfZCMxCKqv+fn5o6uxST
         fr032OITWvc0d9JMCn1p0PnQFyfEbDwTwKdDT17vlfhE6S8q1NYa1XAKr6lh2jurA12v
         Sa0g==
X-Received: by 10.220.248.134 with SMTP id mg6mr4502017vcb.2.1363200579289;
 Wed, 13 Mar 2013 11:49:39 -0700 (PDT)
Received: by 10.58.206.68 with HTTP; Wed, 13 Mar 2013 11:48:58 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218082>

When a merge is ongoing and there are conflicts, 'git difftool' will
output the exact same --cc-style diff output as 'git diff' will without
further explanation. This has lead to some confusion: A couple of weeks
ago a person asked on #git why his difftool wasn't working. After a lon=
g
while we realized difftool's behaviour after invocations such as 'git
difftool HEAD~ HEAD' would work as expected but 'git difftool' "simply
wouldn't".

With that in mind I have three suggestions on improving 'git difftool':

 - Show a three-way diff between the versions (local, remote, merge)
   using the user's configured difftool. Diffing against the version
   containing the markers will generate some extra noise in the difftoo=
l
   and might be confusing, but it's similar in behaviour to how 'git
   difftool' normally works.

 - Prompt the user if they want to launch 'git mergetool' instead since
   a merge is ongoing. Reasonable but it might be awkward if the user i=
s
   asked whether the conflict was resolved or not when all they wanted
   to do was to visually diff something.

 - Add a notice to stderr saying that a --cc-style diff output is shown
   instead; or document the behaviour in the man page. Definitely the
   simplest option.

I'm willing to try to take a stab at either of these but I wanted to
bring it up first. There is of course an implicit fourth option which i=
s
to do nothing, and that I'm wrong about this :)

Best regards,
=C3=98ystein Walle
