From: George King <george@foursquare.com>
Subject: 2 cents regarding push.default change
Date: Mon, 19 Mar 2012 17:17:08 -0400
Message-ID: <CAE5dN1OqNFtiVxP6z6BbdtOfw+MvS5KNW6BYNYpVCVFePcVQPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 19 22:17:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9jxR-0006SI-Va
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 22:17:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755113Ab2CSVRc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Mar 2012 17:17:32 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:55090 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754937Ab2CSVRa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Mar 2012 17:17:30 -0400
Received: by lbbgm6 with SMTP id gm6so3694769lbb.19
        for <git@vger.kernel.org>; Mon, 19 Mar 2012 14:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=KfAXSNTkbZ5tSWnp25aZpwKAjT0Ery9Ksb8jkolUetU=;
        b=ZX+7vkcOPvGaoMiAHAyG9RHxKYNdy0QmudIg9AvI//ph06NFEC0YmVGqdlDAWyECxL
         L/rRhbue8OCj9f0MwWdg04pI/oKi+sk8OLj1JjQ+z+lCbgdnxCTfaUW2zeireGoPQQX8
         EJ3QoGfz+RasNTqXHByaar2Ax87QsBKe2E7yxYPAjkrgYtzx6QV7K+Zs7FhtyuNviOTy
         EzYtGoMwdrMSNWH9K40Y5p0Kd6SP9asf1YRdq+6qYTRqVDRsgIq146sdourbLFqpK7ks
         7V+ExbHdcj3M0Z9rFab7Em7mzwMq9ga4rwEIurd1tlPyr3PuFJpJNOcq1sGFDFGSE8CC
         bMGw==
Received: by 10.152.103.239 with SMTP id fz15mr10370826lab.42.1332191848772;
 Mon, 19 Mar 2012 14:17:28 -0700 (PDT)
Received: by 10.112.5.199 with HTTP; Mon, 19 Mar 2012 14:17:08 -0700 (PDT)
X-Gm-Message-State: ALoCoQkhAPG6g55GClDQ0xm5ldVeGorXlAj9cx0PM7tPnU7JIaqr+WSSnIjeKwRsmlsIoIW62IPf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193460>

Hello list,

I saw a post on hacker news soliciting feedback for the patch to
default to push.default=3Dupstream, I would like to relate my own
experience using git at work. In short, I support the change.

One of the more embarrassing things I have done here was 'push
--force' all branches to origin because of the current default,
'push.default=3Dcurrent'. The mistake would have been avoided with the
proposed change. The scenario was as follows:

- Our git server has master and main dev branches, as well as a number
of 'private' branches. The distinction between public / shared
branches and private / personal branches is informal within my team
(which is perfectly reasonable I think).

- I rebased a private branch locally, and wanted to save my day's work
to the server. because of the rebase, when I ran 'git push' the server
rejected it.

- Because I was working in a private branch, =C2=A0I thought it reasona=
ble
to run 'git push --force'.

- Because I had not pulled recently, my history for branch 'master' was=
 behind.

- The result was that in addition to forcing my private branch to the
new state (as desired), master was rewound to an old state,
effectively discarding the work of all my coworkers for the day.

- Luckily they still had their recent commits locally, so they were
able to push again and restore origin/master.

When this happened, my immediate reaction was 'git should not allow
that!' I immediately did some reading, discovered
'push.default=3Dupstream', and my team made that setting part our polic=
y
on the spot.

Aside from this particular problem, I also find the 'upstream' setting
more convenient, because I do not have to bring all branches up to
date before issuing 'git push'.

Hope that helps,

George King
