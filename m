From: Derek Moore <derek.p.moore@gmail.com>
Subject: Re: RCS Keywords in Git done right
Date: Tue, 2 Dec 2014 11:03:05 -0600
Message-ID: <CAMsgyKbd8Eq07LUktaVy7zyFQwOJ3KOrkJCipp6P9F1_W=OYCg@mail.gmail.com>
References: <CAMsgyKbTRY5=cHj8Ar8zHDd5WdbcNwZC5caGV-snvZU4aek=YQ@mail.gmail.com>
	<CAGZ79kZz4_q+p91e7fn8uS--DRqEUPj_eeQPf2WPOWEk=R8fkw@mail.gmail.com>
	<CAMsgyKZywnac_b2RV0dGs9zOdemJDUQ8oR=bSydBuSxp1VDixQ@mail.gmail.com>
	<CAGZ79kZLAHDG8h5DMQdOH2cQtaMs_iCtC-xsoKst966a+jaBNA@mail.gmail.com>
	<CAMsgyKZWr-1isLvRXMFdzOYu0Yfm3vN_bdk4oRg6UhzSOMq_yQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 18:03:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xvqr2-0003sg-Fp
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 18:03:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbaLBRDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 12:03:07 -0500
Received: from mail-oi0-f47.google.com ([209.85.218.47]:65470 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753306AbaLBRDG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 12:03:06 -0500
Received: by mail-oi0-f47.google.com with SMTP id v63so9499837oia.34
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 09:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vHmCwRoPLSA5fwS6ffbvOMmzHec/waExkbj0nePb8WY=;
        b=txG698JC1LL/7h8S2Jh9TP0ExIq1eDYctE2w5EazXUSPDVBib3tPilj3HP215Swory
         iTWS2pxONJ+g/RO61y7e1FTCGL1yz9K8ZyUv+XwNyHqwEhF0z8JfpYOKQfwfqsH7Wfmp
         4ScXBIdJqqEPox14ui4hTOephp4IqgYeVDdvHTEe1IPbKIMWwck3v5BQ2mRBtK10dh40
         v/jitRdioFeLjNhxK/2Tw16701iFcNxaor/Dj2oB9vKi5I6EYL5htRNXuI4akdp9IzF1
         jglgU/oQGMoea0lHVbv1zppA4MBvGX6qbHZKe8ieFWOMC7Or8GfOgAme7YfNVXtxYIRt
         oGZw==
X-Received: by 10.60.58.65 with SMTP id o1mr258225oeq.30.1417539785202; Tue,
 02 Dec 2014 09:03:05 -0800 (PST)
Received: by 10.76.33.68 with HTTP; Tue, 2 Dec 2014 09:03:05 -0800 (PST)
In-Reply-To: <CAMsgyKZWr-1isLvRXMFdzOYu0Yfm3vN_bdk4oRg6UhzSOMq_yQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260577>

> My current approach is:
> 1) find files common between @ & @{-1}, "ls-tree --full-tree
> --name-only -r" both branches, take the intersection
> 2) find current branch's commits for common files, for each file in
> intersection "log -1 --format=%H $current_branch -- $file"
> 3) find common files where latest commits differ, for each file in
> intersection keep the file if current branche's latest commit does not
> equal prior branch's latest commit
> 4) overwrite all kept files with the results of git-archive

PS: In large repos, I can dump the entire contents of the repo out of
git-archive faster than I can look up the commits of common files
between two branches for a more limited and surgical dump from
git-archive (say, 30 seconds to dump everything out of git-archive vs.
1 minute 30 seconds to find the intersection of files and look up the
latest commits).
