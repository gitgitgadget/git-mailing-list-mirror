From: Dmitry Oksenchuk <oksenchuk89@gmail.com>
Subject: Joining historical repository using grafts or replace
Date: Thu, 30 Oct 2014 18:39:56 +0300
Message-ID: <CA+POfmvCiNBF=P-OvQBTROVhaLtOdgNTDgPNyS=97bupSGk=4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 30 16:40:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjrpR-0005Ox-T7
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 16:40:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934051AbaJ3Pj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2014 11:39:58 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:44062 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933274AbaJ3Pj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2014 11:39:57 -0400
Received: by mail-yk0-f177.google.com with SMTP id 79so2375018ykr.8
        for <git@vger.kernel.org>; Thu, 30 Oct 2014 08:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=FqG0N0UzAp4l8DeviQ5FuFatMjdh6GN1oLHO0JyFKCg=;
        b=zPw/n7c9UMLLHCLOHGsHg5Ag2kY36lLhbbK0OoreZelICRzxyn5ypFSAoXpD588zgj
         rBQ/4sk9f+7qXp0pOT3hAj8HOaCPsbG6Kr3nYtgESWfKXYvDRX/1AV69mQKLbLo1eccQ
         kmg0h8V85TFMTL3oYUlGUKGVSWr0vFk02DBeZ+okG4uIBlBgq2Jo/nNgEFv6X+kbyvT9
         K9Sf76KIc7+FZ2/i7g1GKgApaFEmsmtOuW5YqTDrWPA1/bT5AEyJJac0rUuezTAq0UZs
         mQmAevRl1BWaLANghGiSpKJwxw4c+7RFOBg6XqiZFX63bi5r/DGSWREgzT4mllZWZpmf
         Powg==
X-Received: by 10.236.17.197 with SMTP id j45mr8001490yhj.49.1414683596637;
 Thu, 30 Oct 2014 08:39:56 -0700 (PDT)
Received: by 10.170.141.194 with HTTP; Thu, 30 Oct 2014 08:39:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

We're in the middle of conversion of a large CVS repository (20 years,
70K commits, 1K branches, 10K tags) to Git and considering two
separate Git repositories: "historical" with CVS history and "working"
created without history from heads of active branches (10 active
branches). This allows us to have small fast "working" repository for
developers who don't want to have full history locally and ability to
rewrite history in "historical" repository (for example, to add
parents to merge commits or to fix conversion mistakes) without
affecting commit hashes in "working" repository (the hashes can be
stored in bug tracker or in the code).

The first idea was to use grafs to join branch roots in "working"
repository with branches in "historical" repository like in linux
repository but it seems that grafts are known as a "horrible hack" (
http://marc.info/?l=git&m=131127600030310&w=2
http://permalink.gmane.org/gmane.comp.version-control.git/177153 )

Since Git 1.6.5 "replace" can also be used to join the histories by
replacing branch roots in "working" repository with branch heads in
"historical" repository.

Both grafts and replace will be used locally. Grafts is a bit easier
to distribute (simple copying, replaces should be created via bash
script).

Are there any disadvantages of using grafts and replace? Will both of
them be supported in future versions of Git?

Thank you,
Dmitry
