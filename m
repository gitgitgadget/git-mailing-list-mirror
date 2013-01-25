From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 0/7] mergetool-lib improvements for --tool-help
Date: Fri, 25 Jan 2013 01:43:47 -0800
Message-ID: <1359107034-14606-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 10:45:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyfqM-0008GQ-DR
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 10:45:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756034Ab3AYJoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 04:44:08 -0500
Received: from mail-ia0-f172.google.com ([209.85.210.172]:61569 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755829Ab3AYJoD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 04:44:03 -0500
Received: by mail-ia0-f172.google.com with SMTP id u8so290646iag.31
        for <git@vger.kernel.org>; Fri, 25 Jan 2013 01:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=TxShkiMlM7ME6XRooqOchiKfKMKtc8UzBcymFZiCExQ=;
        b=EHKP2M2m3im6Rn78c5OmGqkyTnrtUeuAUWSHxPa27U2UYHd6XyqOIzFqOjlfC/Pl43
         ANqGaItXDjCUMBSIEv7x6PYX0ty6TGEsxy39hMF9hreBTifVftJS4qD81l41DOMN36hF
         n6v7k+2tgCTXs0sNefjfuINzeapV2UHAh8+sEVg96FNiZ/nmXXqYdCQ4Jqxh2pq9XixX
         O1IFFnVUtqveY2spsF/zyfoJTfASNOpqLkByvCFiKwTuxJEwjBvOW/ilZiNb0dIsJU5V
         23Vi5MkigVUKR1bYeFBGVME+LuVDsOIZetiFEbipWM53SlBqoeu+xwLfysvU5IPqwFNM
         Sr1g==
X-Received: by 10.42.58.202 with SMTP id j10mr3068557ich.39.1359107043395;
        Fri, 25 Jan 2013 01:44:03 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id gs6sm314611igc.11.2013.01.25.01.44.01
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 25 Jan 2013 01:44:02 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.367.g22b1720.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214531>

I ran with John's idea and simplified a few more things so
that the --tool-help output shows the correct results.

My final commit is dependent on John's commits but the other two
could be picked up independently since they are general improvements.

This does add a few symlinks to the repo for the sake of simplicity;
I'm not sure if this presents a problem for folks on other platforms.

The replacement of vim with vimdiff and symlinks simplifies things
so that we can later auto-generate the list-of-all-tools for use
by Documentation/.  This was not previously possible due to the
special-case for the vim tools which this series eliminates.

David Aguilar (3):
  mergetools/vim: Remove redundant diff command
  mergetools: Fix difftool/mergetool --tool-help listing for vim
  mergetool--lib: Improve show_tool_help() output

John Keeping (4):
  git-mergetool: move show_tool_help to mergetool--lib
  git-mergetool: remove redundant assignment
  git-mergetool: don't hardcode 'mergetool' in show_tool_help
  git-difftool: use git-mergetool--lib for "--tool-help"

 git-difftool.perl           | 55 +++++----------------------------------
 git-mergetool--lib.sh       | 63 +++++++++++++++++++++++++++++++++++++++------
 git-mergetool.sh            | 37 --------------------------
 mergetools/gvimdiff         |  1 +
 mergetools/gvimdiff2        |  1 +
 mergetools/{vim => vimdiff} | 12 ++-------
 mergetools/vimdiff2         |  1 +
 7 files changed, 67 insertions(+), 103 deletions(-)
 create mode 120000 mergetools/gvimdiff
 create mode 120000 mergetools/gvimdiff2
 rename mergetools/{vim => vimdiff} (68%)
 create mode 120000 mergetools/vimdiff2

-- 
1.8.1.1.367.g22b1720.dirty
