From: "Vegard Nossum" <vegard.nossum@gmail.com>
Subject: Unfathomable merge conflict
Date: Sun, 8 Jun 2008 09:57:16 +0200
Message-ID: <19f34abd0806080057i7ddaff3exbf410879c5b7d031@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 08 09:58:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5FnX-0003CD-4V
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 09:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753955AbYFHH5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 03:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753979AbYFHH5S
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 03:57:18 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:18344 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753673AbYFHH5R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 03:57:17 -0400
Received: by rv-out-0506.google.com with SMTP id l9so2114868rvb.1
        for <git@vger.kernel.org>; Sun, 08 Jun 2008 00:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=Vz6+YEzmAB6t/+HQ/3L8z5r4J8oTtg0gdFkx8AfUShQ=;
        b=e2MZ/SKGgmZ3lzhk6cemBkw8mtLYfBq4ULtTS4LiD2uSfNaaj8Wjo+600sv+P9w8fl
         QToPUySZBdar8DAebQMCpuUDuGPH5/LiG7d9PKzBna4AYxpujSYgn0yzrjiIm6MHmcrQ
         BOaX2WPuDPlTZgu02O5SNlU1vksZIP3y/wmjo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=k2DKZdWxHHZGWSQThWaJafjFrIAsAXNjSgI/Tf7npsBtyA7FsiDvaY5spAmjvpkAvX
         OAM5n3ulduCzjDHyEggRsOAKu/3Hhte3XXAoOuPhbJq9Jve0sa0586JtKUjBJpFkFeYL
         RUf/YKzpyWXCM+YhZJ4Xb+dnkvI4Lj60CCnng=
Received: by 10.141.15.19 with SMTP id s19mr1238789rvi.205.1212911836779;
        Sun, 08 Jun 2008 00:57:16 -0700 (PDT)
Received: by 10.140.136.1 with HTTP; Sun, 8 Jun 2008 00:57:16 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84257>

Hi,

I want to do a kind of manual rebase where I check out an older
version of a branch and simply re-apply a selection of the commits
following this point in history.

So in this specific case, I want to check out v2.6.25 of linux-2.6.git
and re-apply all the changes that were made to the file
net/mac80211/rc80211_pid_algo.c between v2.6.25 and v2.6.26-rc4.

In order to determine which commits I need, I used the following command:

$ git log --follow v2.6.25..v2.6.26-rc4 net/mac80211/rc80211_pid_algo.c

The last entry on the screen is this:

commit 8318d78a44d49ac1edf2bdec7299de3617c4232e
Author: Johannes Berg <johannes@sipsolutions.net>
Date:   Thu Jan 24 19:38:38 2008 +0100

    cfg80211 API for channels/bitrates, mac80211 and driver conversion

so I checkout v2.6.25 and try to cherry-pick it. But it fails with a conflict:

CONFLICT (content): Merge conflict in net/mac80211/rc80211_pid_algo.c

So I wonder: How can this happen? This should be the first change
since v2.6.25 that touches the file, yet it fails with a conflict in
the very same file. Where does the conflict come from?

I have tried both --date-order and --topo-order for git-log, and also
used the symmetric difference (...) in addition to the range format
(..), but still this is displayed the first commit (in chronological
order) that should be applied.

Thanks in advance for any explanations or tips.


Vegard

-- 
"The animistic metaphor of the bug that maliciously sneaked in while
the programmer was not looking is intellectually dishonest as it
disguises that the error is the programmer's own creation."
	-- E. W. Dijkstra, EWD1036
