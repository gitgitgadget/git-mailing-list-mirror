From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: [RFC] separate .git from working directory
Date: Wed, 11 Oct 2006 20:23:50 +0700
Message-ID: <fcaeb9bf0610110623q365d3ffcw9ba9e11936d03a9d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Oct 11 15:25:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXe3u-0007HB-Lu
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 15:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWJKNXv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 09:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbWJKNXv
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 09:23:51 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:17549 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751274AbWJKNXv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Oct 2006 09:23:51 -0400
Received: by wx-out-0506.google.com with SMTP id s14so212175wxc
        for <git@vger.kernel.org>; Wed, 11 Oct 2006 06:23:50 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=U8qzOywVuykMZAQu1ocky9P0ypps+jIX37d4pa3iae+TnWe+BFeCfVSaHhD0bOuSpH4g6V0SsXOQK5NCFas6qkWV/kyKVmTh39kk6Fm6q7ZSXRTIPg1G4kIjRt+ugQDjk2E4WXj4hh4z9R3SpPIDykbQCbQ30IigLhR79yfOJ14=
Received: by 10.70.18.11 with SMTP id 11mr669723wxr;
        Wed, 11 Oct 2006 06:23:50 -0700 (PDT)
Received: by 10.70.46.13 with HTTP; Wed, 11 Oct 2006 06:23:50 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28714>

Hi,
I was thinking about this while reading subproject thread. In a simple
case, I have a repo A located at ~/project-a and another repo B
located at ~/project-a/some/dir/project-b. With this setup, command
"find" and other directory-recursive commands will run horribly from
~/project-a when they go inside project-b/.git (no I don't want to
repack -d everytime I want to find something).
I propose to move project-b/.git outside and place a file, say
.gitdir, in project-b directory. git-sh-setup and setup_git_directory
are taught to recognize .gitdir, read it to find the actual GIT_DIR
recorded inside .gitdir. This way git commands inside project-b should
work fine while I can "find ~/project-a -name blah" or "grep -R blah"
quickly.
.gitdir format could be  a simple shell-like format with environment
variable assignments.
BTW, talking about subproject support, how about git be taught to
ignore directories which contain .gitdir so that git commands will not
waste time checking project-b directory?
-- 
Duy
