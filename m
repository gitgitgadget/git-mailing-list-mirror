From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: creation of empty branches
Date: Wed, 14 Nov 2012 11:10:07 +0100
Message-ID: <CAB9Jk9CaBECT7c_M9HvCbB8mFYGvdsmq_jFW4DF4NCO8Narnmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 14 11:10:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYZvQ-0000gQ-Tg
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 11:10:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161089Ab2KNKKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 05:10:12 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:35238 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161008Ab2KNKKI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 05:10:08 -0500
Received: by mail-da0-f46.google.com with SMTP id n41so127788dak.19
        for <git@vger.kernel.org>; Wed, 14 Nov 2012 02:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=lIqu+Ew5OoFTEhMwCNVw25B+GXUYTN0Nn2UK7ZnlKLA=;
        b=iLnNgrJza8hrNkWaMt9+ou82N80vjIKP1NJxVNd9S2lLaB+Me2cozB2w+lYvgamJAt
         IidSBRSk5634fFaTuWhNyda5GJtzUffHPhgJ7u8Vwo1Mm29QfvzXcE8Twvs6Set3mIrL
         qbT+hnBZoltVtEIvbOcj5m+2+vcBpL6oFEz1GTma5d8cOAEdssVS+R39F/4G+ss8llEb
         vlZGpL45llAeAla7rO2hRqqJ0WyAUTlJPGVRzIgdyuvlDbAYXBxB29UXGsAFQ+wwHJ8P
         g0ZEazfQGPR+qLaZZblbvos6hB22M4/PtCdafzL5Kn67IVuGYNEPJwwMGdObB8T8vy0v
         O0Dw==
Received: by 10.66.73.102 with SMTP id k6mr5847792pav.22.1352887808173; Wed,
 14 Nov 2012 02:10:08 -0800 (PST)
Received: by 10.67.3.101 with HTTP; Wed, 14 Nov 2012 02:10:07 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209708>

Hi,

the man page of git checkout does not describe the behavior of
git-checkout when asked to create empty branches. E.g.:

$ git init myrepo
$ cd myrepo
$ git checkout -b newbranch

the last command actually changes only the HEAD. It displays no output
telling the user that no switch to a new branch is done. Moreover, it
can be entered again without receiving any error message (unlike the
creation ot non-empty branches, which is instead rejected).
I would suggest to add to the DESCRIPTION, after the paragraph: "If -b
is given ...":

    "If the repository does not contain any branch, no new branch is
created, but the HEAD is set to refer to it."

Moreover, it is often reported (e.g. in the progit book) that git
checkout -b is equivalent to git branch; git checkout, and this is
true when nonempty branches are created, but it is not when the
repository is empty:

$ git init myrepo
$ cd myrepo
$ git branch master
fatal: Not a valid object name: 'master'.

however:
$ git checkout -b master
.... no error

This seems quite strange and difficult to understand: why should git
branch master issue an error while git checkout does not? I have the
impression that also git branch should not issue an error in this
case.

-Angelo Borsotti
