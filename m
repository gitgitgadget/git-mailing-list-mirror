From: Thomas Nyberg <tomnyberg@gmail.com>
Subject: Corruption of branch?
Date: Mon, 14 Dec 2015 12:40:33 -0500
Message-ID: <566EFF11.6010600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 14 18:40:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8X73-0005gQ-3y
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 18:40:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194AbbLNRkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 12:40:36 -0500
Received: from mail-qg0-f51.google.com ([209.85.192.51]:36139 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901AbbLNRkg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 12:40:36 -0500
Received: by qget30 with SMTP id t30so17938030qge.3
        for <git@vger.kernel.org>; Mon, 14 Dec 2015 09:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=xuwj5wQDwdCeg19xQtR6yVZOToKsAeASqZYqzlu/KQs=;
        b=PCmA4uC76cI+D14ZwIyifI90FXzgcgIZU9h/x8vR9TeaXdj1X4eEUW29NQElQh/brl
         XzdRNIXg0FcMH+jeCLVNTwY1veA0biQ5YkAsEvPknVq/7WhWmPziHuCaYIB+gUvJMpEq
         dHEsAHL5/UAXo+eeFg4Ar9mCKRkVARwkG3jsJUMwgwHdAjPU1EGbAe3n4sEjue5/7u0y
         ouKuN90xAx7u0yWlt/ZR0sh3mmqNkSjazYmsqaDMHOM/43Y0ol6F+aqbwJM2ElTEIaor
         sLl4TWq14EYoiSNokBvpulnNRDG+EVHRB3dPu7v4SZYyKf2xv5sRXyTPKS3AgP5nmMDl
         JcyQ==
X-Received: by 10.140.225.144 with SMTP id v138mr37050095qhb.89.1450114835359;
        Mon, 14 Dec 2015 09:40:35 -0800 (PST)
Received: from [128.59.76.160] (dyn-128-59-76-160.dyn.columbia.edu. [128.59.76.160])
        by smtp.googlemail.com with ESMTPSA id 70sm9468587qkw.8.2015.12.14.09.40.34
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Dec 2015 09:40:34 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282372>

Hello,

I have a repository (which I unfortunately cannot provide access to) 
which is having some odd things happening with one (and only one) of its 
branches. This workflow repeats the issue (here `bad_branch` is one of 
the remotes branches; i.e. `origin/bad_branch`):

(1) clone the repository
(2) git checkout `bad_branch`

Basically nothing happens. Nothing is printed and I stay on the master 
branch. I also checked $? and there is no error code that is set. If I 
choose any of other branches, it correctly creates a local branch, sets 
it to track the remote and then switches to the local branch.

It seems like there could be some sort of weird bug in the checkout or 
possibly somehow some corruption in the actual object tree. From my 
vantage point, however, the data appears totally fine. For example, in 
`.git/packed-refs` everything appears normal and if I explicitly 
checkout the commit IDs directly (i.e. just copy the commit 
corresponding to refs/remotes/origin/bad_branch and checkout $commit) it 
checks out fine. If I do this with the bad_branch I get a detached HEAD 
as expected and git log lists the commits that it should.

This seems a bit odd to me. There's certainly some sort of error 
somewhere, but it's passing silently. I'm not really sure how to debug 
this and it's too bad I can't actually link the actual repository. I 
presume if I have the time I could try compiling git from source and 
seeing if it still shows up. I tested it on the following two versions 
of git get the same error:

* 1.9.1 (installed as a package from Linux Mint 17.2 Rafaela)
* 2.1.4 (installed as a package from Debian Jessie 8.2)

Also I should note that the original repository is hosted on Github.

Thanks for any help. Hopefully the fact that I can't provide enough 
information for others to reproduce the issue isn't too large a bother...

Cheers,
Thomas Nyberg
