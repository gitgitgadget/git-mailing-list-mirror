From: Thomas Adam <thomas.adam22@gmail.com>
Subject: When does git check for branch-X being uptodate with origin/branch-X?
Date: Mon, 21 Mar 2016 20:21:46 +0000
Message-ID: <CA+39Oz4izkhtxbUH8cQoD5-DLKAtv9KnC9OkG_ZhFw6Ysg0+gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 21 21:22:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai6L3-0007K6-AJ
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 21:22:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbcCUUWF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 16:22:05 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37695 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757370AbcCUUWC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 16:22:02 -0400
Received: by mail-wm0-f49.google.com with SMTP id p65so136791744wmp.0
        for <git@vger.kernel.org>; Mon, 21 Mar 2016 13:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=9Y9h16SZi8D5m6jTBee6yjCcagaZs74fxSx1YJ2NzAc=;
        b=nn9Zur0sAW/E2CHsO9adEkm10KBcum9kPbD5aHF1t6h9FMemgOCdim5dkKn4C0WD3B
         Qn2BSXFOm/fISOkK2GUJxDyXVW9qxMkj31sznt2GkIN+AsFJ/CxBamR3/ZHBsw/qV645
         ui1TL4hfZVU8nUivEBQGYbIORXU/JxgZrWwyZ8I2ljtC2wPrgYX0EC3RqHcpPCsmWDIq
         slJCZVllO1Z4lcRgw00Iipap2jvbUpKNLJtjYlEK8l1Z99iRaqp5d979SLeIZnipOAar
         vg5Jb04iEGc+pje99BhMLsYL/UOAtsHK5S0hq0vpLLg0xdbN0694fP/CfT1YzxXhYfU/
         iZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=9Y9h16SZi8D5m6jTBee6yjCcagaZs74fxSx1YJ2NzAc=;
        b=FN9TIIbM9RYF6n+Lvy+ptvGTWn8d3yHbHsp/gcF5aUXMbhwqiqNH/SbuQUVsvNzGLY
         ZQ9YcOJrrMLPXVvSeBByQRledKkt5Pg0PgVYmyyzrS1yHFWO7ZHoXoKJveiXxmq7AHks
         s1YSt37VYiZyB54jBeQ7GwhyNAtP6DWZ2rKhS/i9scGq2O5QfpWQXeIBviv1ZMY22wG1
         i6LWhPV14YRp9k2z0y3uIX0XJw2KUfArwXg11wnZAq1qPnvvAUgc9rhTdFga6fSvEwF0
         ZSPkzPvqxGhpQMy5IWerSdeaHT8i5zsCBCxP+up/L+QxzyCCMLTFCwEKx/ww5I2PlutR
         7q2Q==
X-Gm-Message-State: AD7BkJLXKdQnKVJyjrUCw9pTzJ02ZDzz6xw/Qh3pZAC1hEyj/mvhDA3luOCB3YigW3z8u67VrSi30PBmd2jKwA==
X-Received: by 10.194.58.169 with SMTP id s9mr32786469wjq.52.1458591720761;
 Mon, 21 Mar 2016 13:22:00 -0700 (PDT)
Received: by 10.194.110.168 with HTTP; Mon, 21 Mar 2016 13:21:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289454>

Hi all,

Something I've seen a few times of late (although I doubt that's any
indication that the code has changed in Git) is the reporting of
branch-X being uptodate with origin/branch-X when it isn't.

When does git check to see if branch-X has a remote tracking branch
and that it has changes on it?  Only, the output below is misleading:

% git checkout master
Switched to branch 'master'
Your branch is up-to-date with 'fvwmorg/master'.

[fvwm-cvs-to-git/docs]{10345}[0][master] % git pull
remote: Counting objects: 26, done.
remote: Compressing objects: 100% (12/12), done.
remote: Total 26 (delta 18), reused 22 (delta 14), pack-reused 0
Unpacking objects: 100% (26/26), done.
From github.com:fvwmorg/fvwm
   c029868..36cc898  master     -> fvwmorg/master
   4f0c7ec..36cc898  ta/git-docs -> fvwmorg/ta/git-docs
Updating c029868..36cc898
Fast-forward
[...]

Clearly, it's obvious that "Your branch is up-to-date with
'fvwmorg/master'." is misleading.  Note that in this case, there's no
passwords or other hindrances to Git being able to work out that a
branch is behind another.

Any light that can be shed on this, is much appreciated!

Kindly,
Thomas Adam
