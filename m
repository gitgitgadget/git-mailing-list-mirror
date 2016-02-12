From: Tim Ringenbach <tim.ringenbach@gmail.com>
Subject: git svn dcommit doesn't support --username option for file:/// urls
Date: Fri, 12 Feb 2016 17:14:45 -0600
Message-ID: <CAGZMbfc5Oi=EOYbCbZWfM1T65AZwCEbsso+QTkAe1sa4hRC61A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 13 00:14:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUMvK-00089J-Bv
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 00:14:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947AbcBLXOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 18:14:46 -0500
Received: from mail-ob0-f180.google.com ([209.85.214.180]:35987 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbcBLXOp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 18:14:45 -0500
Received: by mail-ob0-f180.google.com with SMTP id gc3so42020832obb.3
        for <git@vger.kernel.org>; Fri, 12 Feb 2016 15:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=0EmHTFRrfUx+SVIenVcRazIU8YWGJ6YAfnxWJkFL44I=;
        b=dMKb6S+DY0KnNHrRYdq64zDE1uVHzkvQcPjodDRsFIaNjmp2uSeqfMp/itrjloelDP
         RwSj59FsxKWfuseCMpFiZMkCixO1kuEgX1MXLSxCHGQlBMfuNrEzTgv+C+ORFniD9ful
         yvE4KHlbNNJmJE0RacsO+0QH7wyZiYIwRdl0vP6dzOhcecUvMHYVTNNZ3JMTvAkYq160
         z3xohaXJW1R5/agMe3J/bFzKyh02EVWdu8op0YP4TbVRkKaSW20h2vOTWY2OflYEfp0H
         cJUuvQJy9BJ/kUPHm/L5c0AyUd78xCObddmF9GQBwcUimWBIwvK8b3bIjQLsWkB8/kRf
         3VEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=0EmHTFRrfUx+SVIenVcRazIU8YWGJ6YAfnxWJkFL44I=;
        b=mGM3qQ0AEZsb1goY82bPVT0FFe8eXvLomXjPV6HRcaVmrQAk8hCQC6t6n6oy5dMNHT
         OnoeQrY/vjif1SKpcB/ZFYnfecVZ7EQ14Im0q7PE06EsIszgc7LvWuSADFiTCXcd9hDm
         szmhYelfG32MCDggy4e++f5tijgxEy1Rj4fFG1G7Cow8JewbsGPdcjCW1BmaAjBwjiEU
         WnfPapRLiSHYLs9QFF3W1n6oOtsaJ0kuci5hLyHRnljmdIUljrBt29PYQSzTb5T3FpAF
         oK4rwP7qeU3Nm6gtq4gtrDwUIuF5HwBKTFliVZmM4f17k7s5oeraCi+pbgwxftwNYSjD
         p2/Q==
X-Gm-Message-State: AG10YOS27eyBjp5DGL3H51qjshDgj/F5H2bjrWWz5yxSevDnomOvxMy5IVF6z8KwsnQp2YWAInJD2ijYcBRFsw==
X-Received: by 10.182.241.134 with SMTP id wi6mr3491422obc.81.1455318885079;
 Fri, 12 Feb 2016 15:14:45 -0800 (PST)
Received: by 10.202.49.193 with HTTP; Fri, 12 Feb 2016 15:14:45 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286081>

Hi,

'git svn dcommit' doesn't seem to honor the --username argument when
my svn repository url is a file:/// url.  It doesn't complain either,
it just seems to silently ignore the option. My dcommits show up as
the user I'm logged in as. The only way I found to change that is to
'sudo' to some other user.

The actual 'svn' command does support --username with 'svn commit'.

What I'm actually up to, is trying to make a svn to git mirror
bi-directional. Right now, I have a cron job that 'git svn fetch's and
'git push origin's with some configs setup so that it does what I
want.

I was experimenting with writing some scripting to go in the other
direction, and my first step was seeing if I could commit to svn as
any user.  It seems like I should be able to and that git-svn just
doesn't support it.

(BTW, I'm aware there's a lot of pitfalls I'll have to work around,
and that I'll need to be very careful with verifying that the most
recent 'git-svn-id:' matches the branch and revision I expect to be
committing to, and that bad things will happen if I mess it up.)

Thanks,
Tim
