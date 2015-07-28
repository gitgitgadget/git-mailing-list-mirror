From: Duy Nguyen <pclouds@gmail.com>
Subject: Fwd: Bug#793884: git: allows nonsensical command 'git checkout -b HEAD'
Date: Tue, 28 Jul 2015 21:33:14 +0700
Message-ID: <CACsJy8Atx7h8LHQ26rTx2jPUxL-+MSLva8njdoUs5+Aq-Eoj4Q@mail.gmail.com>
References: <20150728141858.22342.16605.reportbug@zam581.zam.kfa-juelich.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 28 16:33:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK5x1-00058h-CT
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 16:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbbG1Odp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 10:33:45 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:35824 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755700AbbG1Odo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 10:33:44 -0400
Received: by igr7 with SMTP id 7so119014179igr.0
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 07:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=/QbTfMrUeaB51V3Y09ZOpSB5p3uBA8e5MT21l1AW5Yw=;
        b=CLCvTe2rflVfxnfnXUFEqazrdz1cB/dp9zW6zeh4TEd+v583/ZKRs0d8vGk9nZylqa
         NBdm7JoqICc8wNXX+3rHwSCr/GjDJzRmjQ2pU8j4uzeqEIc/Bl3aMVGjzseYkiAmRVE+
         TKhMSd9Y6rO1rQOpshH/XaBEd9idUvUwxdnzGjViVb69glgD4nvtNXcp8r7y5qNcZnjP
         cPV+iZftjhExS7wWbxaJ0r0OTt9RH/KRhDlJ+UVy8R/Diu/y/sSzNf2sixB2CFHGNnwb
         FPwUSIzuhhwwxx3bl9TyAkg9n2a5EMF3al1BFXqVHQh5hMRheqatp/rKnHt4vDf/+Est
         nyaA==
X-Received: by 10.50.62.148 with SMTP id y20mr7345312igr.17.1438094023499;
 Tue, 28 Jul 2015 07:33:43 -0700 (PDT)
Received: by 10.107.191.193 with HTTP; Tue, 28 Jul 2015 07:33:14 -0700 (PDT)
In-Reply-To: <20150728141858.22342.16605.reportbug@zam581.zam.kfa-juelich.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274774>

This seems like a good thing to fix (i.e. make sure XX is not
ambiguous before creating it with "git checkout -b XX")


---------- Forwarded message ----------
From: Andreas Beckmann <anbe@debian.org>
Date: Tue, Jul 28, 2015 at 9:18 PM
Subject: Bug#793884: git: allows nonsensical command 'git checkout -b HEAD'
To: Debian Bug Tracking System <submit@bugs.debian.org>


Package: git
Version: 1:2.1.4-2.1
Severity: normal
Tags: upstream

$ git branch HEAD
fatal: it does not make sense to create 'HEAD' manually
# OK, special casing prevents this
$ git checkout -b HEAD
Switched to a new branch 'HEAD'
# but not this :-P
$ git checkout master
Switched to branch 'master'
$ git checkout HEAD
warning: refname 'HEAD' is ambiguous.
Switched to branch 'HEAD'
# oops ;-)
$ git checkout master
Switched to branch 'master'
$ git branch -d HEAD
Deleted branch HEAD (was 6e54945).
# OK, we can easily cleanup this mess again

The same works in 1:2.4.6-1 in sid.

If there is some special casing for HEAD in git branch, the same
should probably be done for git checkout -b, too.


Andreas



-- 
Duy
