From: Victor Engmark <victor.engmark@gmail.com>
Subject: RFC: Folder Git
Date: Mon, 25 Apr 2011 10:32:36 +0200
Message-ID: <BANLkTim=xKxN9JovToVuOg=SQ2Mba1LvxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 25 10:32:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEHDn-0004AH-5U
	for gcvg-git-2@lo.gmane.org; Mon, 25 Apr 2011 10:32:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758083Ab1DYIci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2011 04:32:38 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49303 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756650Ab1DYIch (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2011 04:32:37 -0400
Received: by bwz15 with SMTP id 15so1484418bwz.19
        for <git@vger.kernel.org>; Mon, 25 Apr 2011 01:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=xsYbCApsx1AM42YnY199LtbIJ613/do139+rYNGwCsc=;
        b=PKM8E6QGsjw6J8jQLQ4X5l++fr9EfyXgoNPpl3IG3NoOeYR/HA1n3Uz6fJsUzLiNjh
         2M7di/UaXFx4c9LMiM7niC6N12XjQTcgxZ6zWWPfYlG2cbmy53ycwbx3xHgBmEXMLu0c
         67786o0EtU20kirtrdZn2KR4SJ5/EaOOjceXA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=AyjjasJDtJUl7Xd9cEpN9QGIkHOPetGGCQP8oleIZex9Ym0zyRJclslqp7K8Q3ip+r
         eZopax9VO9afGw9IHdB0BgSc6c7qonWrpqlyxiuiCZOyzXbvSOAB/2fhcGt/1S/s+XjG
         xJXOeGBGz50FVZr9FTZTe4HCmWl+hTMXZWuNE=
Received: by 10.204.181.7 with SMTP id bw7mr3154363bkb.16.1303720356143; Mon,
 25 Apr 2011 01:32:36 -0700 (PDT)
Received: by 10.204.48.143 with HTTP; Mon, 25 Apr 2011 01:32:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172016>

Most days I work on more than one repository, and on more than one
machine. I've never needed the "--" argument separator so far. This
combination makes it useful to have a way to run Git commands on
several repositories at once. A one-time solution would of course be a
for-loop which checks for a .git directory before running the given
command, but this operation ended up being frequent enough that I
wrote a script for it: fgit
<https://github.com/l0b0/fgit/blob/master/fgit.sh>. Features include:
* Runs the Git command given in all specified directories which have a
.git subdirectory, and warns about any that lack this directory.
* Should work with any path, containing spaces, newlines or other
exotic characters.
* Should work with any Git command that doesn't require the "--"
separator between the options and arguments.
* Prints the Git command before running it, for logging and repetition.
* errexit and nounset are active for each line, with one exception:
errexit is disabled for the running of the command, to allow it to
continue to other repositories.

Issues:
* Don't know if anyone else has used it. Probably not, so there's
bound to be issues (especially since it's been changed quite a bit the
last couple days for this RFC).

Is there a place for such a tool in Git porcelain or elsewhere in the
Git project, or should it be kept completely separate?

-- 
Victor Engmark
