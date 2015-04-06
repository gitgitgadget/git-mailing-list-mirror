From: Shane da Silva <shane@dasilva.io>
Subject: Why can't I stash submodule changes?
Date: Sun, 5 Apr 2015 19:15:26 -0700
Message-ID: <CAAKwDd8SVA=ynzH_U1M3bb+mLZMnF79-imBLrU+x9qcbXfWO3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 04:15:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YewZY-0006Y8-DK
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 04:15:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838AbbDFCP1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Apr 2015 22:15:27 -0400
Received: from mail-qc0-f178.google.com ([209.85.216.178]:36149 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632AbbDFCP1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Apr 2015 22:15:27 -0400
Received: by qcgx3 with SMTP id x3so5477761qcg.3
        for <git@vger.kernel.org>; Sun, 05 Apr 2015 19:15:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=gJhwok6CvuO/lfXGQoLz9JoUcfQAUm39WlKXVyfAqVY=;
        b=FrACWGYbYCSe8NRBB1deaISq6SqkKhX1B8POyJDdu7Q345JC6TH4ALNbkFI1iZ1tFZ
         FDMxM4a6rGtips9U7hvMH9LPFJDLWTHjycvJK4pXNOGnLj/etAvmZYGqyj5XlQSSueHD
         dCmlgeJz00jko6qKCwdZ3X+QUMoxtUpjqOBvA8VFkcD2mBabhctj8Uzqxmfs0C7vslll
         yG4O7q4YEUYdBVq0WkxqZqcd17ePOB3ZjMIzbliqzu+GI03N2oYQAyiDvMnE1ZksyZGw
         h4rzCPJGyDiDVZSZpj8ZIRJiMdjVUQpL8QN0qtBNulpR+oi+ycf0J6XFB/l0/h5YPQzC
         gvgw==
X-Gm-Message-State: ALoCoQmION76bvlF32HL1BRhg4/5zQU/xrsOpTUjOYY7CB4/K5eFfJEdX6cB+OXa6yWlp46NjKhb
X-Received: by 10.140.151.197 with SMTP id 188mr8484428qhx.18.1428286526348;
 Sun, 05 Apr 2015 19:15:26 -0700 (PDT)
Received: by 10.229.138.1 with HTTP; Sun, 5 Apr 2015 19:15:26 -0700 (PDT)
X-Originating-IP: [67.180.197.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266828>

I=E2=80=99m having trouble understanding why I cannot stash changes to =
a submodule.

When adding a submodule to a repository (`git submodule add
=2E/sub-repo`), I can then run `git stash` and `git stash pop` with
expected results=E2=80=94the submodule disappears and reappears in the =
working
tree.

However, when I try stashing an update to a submodule, `git stash`
reports =E2=80=9CNo local changes to save=E2=80=9D. The following shell=
 script
illustrates this behavior:


# Create repo
mkdir test-repo
cd test-repo
git init
git commit --allow-empty -m "Initial commit"

# Create submodule
mkdir sub-repo
cd sub-repo
git init
git commit --allow-empty -m "Initial commit"
cd -

# Add submodule
git submodule add ./sub-repo
git commit -m "Add submodule"

# Modify submodule
cd sub-repo
touch foo
git add foo
git commit -m "Submodule changed"
cd -

# Stash submodule change
git stash # <---------------------------Displays "No local changes to s=
ave=E2=80=9D


I=E2=80=99m trying to wrap my head around why this is the current behav=
ior, as
I suspect this is intentional but it seems unexpected. If anyone can
shed any light on this, I would really appreciate it!

Thanks,

Shane
