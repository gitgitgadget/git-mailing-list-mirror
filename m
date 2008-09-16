From: "Michael Kerrisk" <mtk.manpages@googlemail.com>
Subject: Getting correct tree layout when importing svn repo into git
Date: Wed, 17 Sep 2008 00:05:24 +0200
Message-ID: <cfd18e0f0809161505g4c04bd88vaf4fd7c40f67b243@mail.gmail.com>
Reply-To: mtk.manpages@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: michael.kerrisk@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 17 00:06:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfigt-0007fh-LV
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 00:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbYIPWF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 18:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752163AbYIPWF0
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 18:05:26 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:23744 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbYIPWFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 18:05:25 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2871963rvb.1
        for <git@vger.kernel.org>; Tue, 16 Sep 2008 15:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=CajQk2RiTgM91tUrd7Q3+okeh5wDaEJ/pM3nr2WPE+0=;
        b=fWTD55wXejCWvrUCqlPtXGkAkgGWsWFNOb3fLlVevMZPVuAB/QGCdVICLnslYdZbjO
         X991PgReV2wn2g3QLpRmezY4VkZs135vAZ9Bmffnt024+CNKrVyWnFDySxdDmQp1vNXb
         H2Vn4l3VO6kkVVZP/cGqcqrG0esPHIc1YjVHo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition;
        b=fH7+BOcndOh2XST+Zet6AEVgFbacRKAAMUgfoc4f/LMcTBbAZTQlM0x6afj4RIpTsV
         pmWeM8OGkpGg4nSupfToPhnKRJclcPQky7X0918tIvhMmljLwXTnqDM4bREkbj1YwdGM
         jCgXp9CoiGyKCbIJA4g1K9xOboBYo9MwPIfko=
Received: by 10.141.29.18 with SMTP id g18mr6025246rvj.298.1221602724967;
        Tue, 16 Sep 2008 15:05:24 -0700 (PDT)
Received: by 10.141.176.2 with HTTP; Tue, 16 Sep 2008 15:05:24 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96038>

Hello,

I'm currently trying to import an svn repository, along with its tags,
into git, and everything seems okay except that after the import I
expect to have the following structure to my checked out repository:

    [root-dir]
        .git
        <checked-out-files>

But instead I end up with

    [root-dir]
        .git
        man-pages               <-- name of my svn project
            <checked-out-files>

I've tried out a few different command-line flag settings but so far I
haven't managed to get the desired layout.  I guess that I'm missing
something trivial, but I haven't worked out what it is so far.

The commands I'm using to do the import are:

$ git svn init file:///home/mtk/man-pages-rep/ -t tags -T trunk -b branches
$ git svn fetch

The svn tags are getting imported okay, since:

git branch -a | head
  tags/man-pages-2.00
  tags/man-pages-2.01
  ...
  tags/man-pages-3.08
  tags/man-pages-3.09
  trunk

The following commands show the layout of my svn repo, which is pretty
much standard:

$ svn list file:///home/mtk/man-pages-rep
branches/
tags/
trunk/
$ svn list file:///home/mtk/man-pages-rep/trunk
man-pages/
$ svn list file:///home/mtk/man-pages-rep/trunk/man-pages
Changes
Changes.old
Makefile
README
man-pages-3.09.Announce
...
man7/
man8/
scripts/
$ svn list file:///home/mtk/man-pages-rep/tags
man-pages-2.00/
man-pages-2.01/
...
man-pages-3.08/
man-pages-3.09/

What 'git svn init' command do I need to get the layout that I want
for my imported git repo?

Cheers,

Michael
