From: Eduardo Robles Elvira <edulix@wadobo.com>
Subject: Presenting git timetracker tool, asking asking git notes merge
Date: Sat, 4 Dec 2010 08:49:16 +0100
Message-ID: <AANLkTi=XOF83Ch8aU0Nj+KDUjvobM_7cT08bDT3k9bNr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org,
	=?ISO-8859-1?Q?Daniel_Garc=EDa?= <danigm@wadobo.com>
X-From: git-owner@vger.kernel.org Sat Dec 04 08:49:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POmsW-0000S1-OF
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 08:49:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754653Ab0LDHtk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Dec 2010 02:49:40 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42892 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754418Ab0LDHtj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Dec 2010 02:49:39 -0500
Received: by mail-iw0-f174.google.com with SMTP id 6so830475iwn.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 23:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received:from:date
         :x-google-sender-auth:message-id:subject:to:content-type;
        bh=kunnF2CnbKiqJ2G/Ady+upuATUUrLXS49tCWomUYTJk=;
        b=Oow/PsN/91Co8/ditFCrRjii2A3CURIbSxVTsmcGYfIpCSmKG+jAPNaNI7dDiBRXq3
         ecCKwAMiImLd1nzYXnFlexn0bXF3OLvwxs+RDk4JJV4O2RAoNnO8kEVrS3sycmnlgou3
         ZSEnI6EIn4Kcim4qFforS76AMW1ZtKmpnl9Kk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type;
        b=qjYVtjpkm3uMl2TMHSiNdkfYcJBkW4dr1iM63/MVlJPJc3D+LI3jLIh9cqQvWBUN4x
         9eu0Ks5MHZQqgHM/Oosga623NeJs2pr6nEfV2zSPpjwN06jwMdy4H32VAZWM0TWAR5co
         PQ1DjFnKtQROOWKX5YYBm2g5BJSrFqWc0C9C4=
Received: by 10.231.167.67 with SMTP id p3mr2909654iby.20.1291448977408; Fri,
 03 Dec 2010 23:49:37 -0800 (PST)
Received: by 10.231.35.10 with HTTP; Fri, 3 Dec 2010 23:49:16 -0800 (PST)
X-Google-Sender-Auth: msh4Jm6rPXDv7g8tT86ww2uu3yg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162890>

Hello everyone!

I'm glad to present you a new git tool I've been working on together
with Daniel (danigm), the new git timetrack comand, part of the
distributed time tracker project [1]. It allows you to track the time
spent in commits done to a git repository. I want to thanks for the
help to the people in #git-devel IRC Channel, without their help this
would have been much more difficult to develop.

Git timetracker uses Git notes to add Time-spent annotations to
commits. It actually requires git-next because it makes use of git
notes merge. Git timetracker is really easy to use, a small example is
shown in the wiki [1]. As a tip, notice that git timetrack --summary
accept the same options as git log, so for example you can do a git
timetrack --summary --since=1week dir/file.c .

Why did we develop timetracker? We are creating a small software
company and we needed to do (rough) estimations of the time the
development in the projects we work on will take, so we thought that
the first thing we need to do that is to have some real information
about time spent in those projects.

When the user does a git push, the timetracker notes are pushed,
because git timetrack --init adds a push=... line to the remote in the
config files. When it does git pull, it also pulls notes because of a
fetch=..., and it merges those notes in refs/notes/merge with an
post-merge hook. That solution is suboptimal, because for example when
doing git pull --rebase that doesn't work, and the user needs to do
manually a git timetrack --merge. Can't we add an option to git pull
to merge the fetched notes? For me, as a git notes user, it would be
great if I had something like
fetch=refs/notes/timetracker:refs/notes/timetracker and
notes-automerge=refs/notes/timetracker in my remote, and then doing a
git pull automatically calls to git notes merge.

Regards,
   Eduardo
--
[1] http://wadobo.com/trac/dtt
