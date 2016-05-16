From: Nathan Wendt <nawendt84@gmail.com>
Subject: (unknown)
Date: Mon, 16 May 2016 10:58:55 -0500
Message-ID: <CAB3F6BwTSWe2cXUNmfN1EZJKOQLrq-rauBtCwpa8ikuVK+siNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 17:59:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2Kv6-0002sb-Vs
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 17:59:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754196AbcEPP65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 11:58:57 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:33952 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753654AbcEPP64 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 11:58:56 -0400
Received: by mail-qg0-f50.google.com with SMTP id 90so90992386qgz.1
        for <git@vger.kernel.org>; Mon, 16 May 2016 08:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=IhRqQtyRnvKooT1VTIV4rrTSGs7Q7F0hqmboUBTC7ZI=;
        b=qBLx44tBfiYRGGx9FP6dfyrsLbkpKSwhuDyATaypktrAb7ewL3bCd+qW64t6nG+5Li
         Djm1hZc01YyVnq6HRyKsjNBaRBTJVLh8IBp4paQGrj8ziNIMvY2dICvqoTJtyHsZuwDn
         P7+9rAF2j2lxuuqHHgDBVT8fNsQVasCdQcx7LXIbyDCpsD4E6yCOcZ1tJxvgQrTDlMU5
         36o6J0Hxm6L2KQ7ZJTYRVqg4IVawRT7EnolBHZd8RCEPkQDIdC0lV69dPiOtSkWkxmPB
         LKH3ZOLwv6tkjGHlDzRjp1DCpltO5d4XCb/Xphk5//+mGfWYdyLoeO9xoJndnKz7URpt
         UoZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=IhRqQtyRnvKooT1VTIV4rrTSGs7Q7F0hqmboUBTC7ZI=;
        b=L/l3MBGdZpu7yJjEDPZNXlhA/rGewwUkq9S1gEDuY3ukCl+qufpv2AKChWJDbYi6rH
         D5R7KvGu6VDH6LpslKwf8GWQvTH4mLgbPAaW22ZDbb0J+3OVop15GOa1VdukeYKCU+9Z
         VeakkSzou7euIhHm/Kx1IbEJ/tmJ0cbCNNEBUgEF1lTl6qwyffoD+QvF8kyQa6ZgWK2H
         orsDi/VeMPhQpGGoNXE1TKSqPn5AXtnBdTCeyulCRWsDNDUSoDSPLJCnpN4N1jBlhNHF
         MmeNzb63MJqhLjx7vcIvpGEKiEb2Qx9XpdthisLB4Gb/l2CutRR+KegmVruYRbCC7AUR
         Nj0Q==
X-Gm-Message-State: AOPr4FUi6rIaYtQZwR81N7dfXC7Zm1MBgvr7l/Ch1EVwH/X7q6IhMbc9hZ4ZBN18S85lLQdNyljB+HTZje5fVg==
X-Received: by 10.141.28.204 with SMTP id f195mr31063961qhe.59.1463414335185;
 Mon, 16 May 2016 08:58:55 -0700 (PDT)
Received: by 10.55.153.3 with HTTP; Mon, 16 May 2016 08:58:55 -0700 (PDT)
Subject: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294747>

Recently I have run into an issue with the git-completion.tcsh script
where an error would occur upon sourcing the file on login. The error
that would occur was:

__git_tcsh_completion_version: Subscript out of range.

In taking a look at the script, I noticed that when the script parses
the tcsh version that I am running it does not put the output into an
array. Thus, when it attempts to access subscript 2 of
__git_tcsh_completion_version it throws the above error. To correct
this, I changed

set __git_tcsh_completion_version =  ` \echo ${tcsh} | \sed 's/\./ /g'`

to

set __git_tcsh_completion_version =  `( \echo ${tcsh} | \sed 's/\./ /g' )`

and the script runs correctly. I could not find others having issues
with this in the forums so I am not sure if this is unique to my
system or not. Thought I would pass it along.

For reference, I am running tcsh 6.17.00 on RHEL 6.8

Thanks.
