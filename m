From: Daniele Segato <daniele.bilug@gmail.com>
Subject: Question about tracking multiple Subversion repository from the same 
	git repository with git-svn
Date: Thu, 10 Jun 2010 16:29:29 +0200
Message-ID: <AANLkTimMOPXecB0lZM3v2MaZgbhJWwtxOUIGgkxr_PGF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Wong <normalperson@yhbt.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 10 16:29:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMilL-0002D8-L2
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 16:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759245Ab0FJO3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 10:29:38 -0400
Received: from mail-ew0-f223.google.com ([209.85.219.223]:36948 "EHLO
	mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400Ab0FJO3i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 10:29:38 -0400
Received: by ewy23 with SMTP id 23so143562ewy.1
        for <git@vger.kernel.org>; Thu, 10 Jun 2010 07:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=2NCB8lNBgidEKU9c1wlnrXcEI+9M/4vTjFxLq4mdt58=;
        b=gxQGsa8GR0J+Fe7LHk4MV02lLPu4NasiCML4lnZOZU3J1vwcNwCV8SDHKkfaFxdFki
         IZks7QZBMA8UFGYU1fOzxS5r5Csqay8JiRAdljbTUr3jClhvFU6NKTnavkGuAUFpkroq
         CJgh6pWeY4Ieyq/K9BOTSJxLmJ0y/2lq8NtSE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=enCUnn4lXDU5e3pu3Mv18GuDzUUk3i1kYMPcLCMugkkTbjhxNpT5nRyOUw9ilRn48p
         g7+9Tp7Emn9mIzBToe/OT5CcVtKLOK9o8I+SWF0DHiBd3eIfHcoc/veqrXcVeR21D0bu
         UAjyodvEewPHRWH5nYWjwfshw4VqL4ldd1L3c=
Received: by 10.216.188.141 with SMTP id a13mr167642wen.43.1276180169370; Thu, 
	10 Jun 2010 07:29:29 -0700 (PDT)
Received: by 10.216.70.210 with HTTP; Thu, 10 Jun 2010 07:29:29 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148878>

Hi all,

Say that I have 3 subversion repository

svn: an online repo which I only have read-only rights.
abc, xyz: two project in two private repo where I have write rights.

[svn-remote "svn"]
	url = http://svn.online-repo.com/repos/public
	fetch = path/to/trunk:refs/remotes/svn/trunk
	branches = path/to/branches/*:refs/remotes/svn/*
	tags = path/to/tags/*:refs/remotes/svn/tags/*

[svn-remote "abc"]
	url = https://svn.local-repo/repos/public
	fetch = path/to/trunk:refs/remotes/abc/trunk
	branches = path/to/branches/*:refs/remotes/abc/*
	tags = path/to/tags/*:refs/remotes/abc/tags/*

[svn-remote "xyz"]
	url = https://svn.local-repo/repos/public
	fetch = path/to/trunk:refs/remotes/xyz/trunk
	branches = path/to/branches/*:refs/remotes/xyz/*
	tags = path/to/tags/*:refs/remotes/xyz/tags/*

Reading the man page of git-svn it seems this is possible and
specifically supported.


But I have some doubt.

Suppose I've already created the project "abc" starting with trunk
copied from a specific commit (tag) of the "svn" project.

1. Is there a way to tell git that abc/trunk is a branch of svn/tags/1.2.3 ?

2. can I rename svn-remote "svn" to something like "main" without side effect?

3. after 2) can I also rename all the names of the remote branches to
main/* instead of svn/* ?

4. if project xyz is no more of interest to me can I "discard" it and
remove the remote branches I don't need anymore?

5. when I'll decide to upgrade project abc to main version 2.0.0 I'll do:
git merge --squash main/tags/2.0.0
is this the best way?

6. after point 5) when I'll further upgrade the project abc to main
version 2.1.0 can I still do:
git merge --squash main/tags/2.1.0
or this will cause me problem? (the rerere option is set to true, so
conflicts already solved shouldn't be asked twice).

7. if the merge --squash cause a lot of conflicts is there a way to
split the conflict resolution across different persons?


Thanks for any help you'll give me.

Regards,
Daniele Segato
