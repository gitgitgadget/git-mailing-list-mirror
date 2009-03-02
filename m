From: Igor Lautar <igor.lautar@gmail.com>
Subject: git-svn multiple branches and merging
Date: Mon, 2 Mar 2009 13:09:35 +0100
Message-ID: <5fdd0830903020409j6e2b5269ubfb3ae6fe8266734@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 02 13:11:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Le6zF-0007Sk-3b
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 13:11:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758412AbZCBMJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 07:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758128AbZCBMJj
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 07:09:39 -0500
Received: from mail-fx0-f176.google.com ([209.85.220.176]:53597 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756688AbZCBMJi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 07:09:38 -0500
Received: by fxm24 with SMTP id 24so1944567fxm.37
        for <git@vger.kernel.org>; Mon, 02 Mar 2009 04:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=JF8uuI/kmaCDau8VM5XBpbef/+tzAs848esDsVNS9Zs=;
        b=T5KxjJ8oiKTqL+sYpX3S9gglIyADgAbK8529ylXCO6jnZBtdu+t1nJl5qiePCejgzh
         TlmSu50v2ZAwIp5EqHlA098lc5uDE3uqVBvJpadfo9kETop6MhNAPZVHjiQhoeAhJGT8
         cLvOJZj5MPdFrK32lq5HZUkHXXWdY2T6OLuhU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=jd8g3h0mwE2GtBhEmFJHKcoVIyfgGxEDX6MJ2/abgJbaT5W1tQ264dPTVee0TPjmkt
         2mJQIRbXAjEktLLVRnkksA+NY0qjhCnr9W8EYSM0TMPFm5wsjgTi7t/nlZkIswGGRAEK
         0kxdCF7V6NSK4Y8kqoSYP5dELhVhCb62/FRgI=
Received: by 10.181.199.6 with SMTP id b6mr2102820bkq.137.1235995775243; Mon, 
	02 Mar 2009 04:09:35 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111931>

Hi All,

I'm using git-svn to manage quite large svn repository. This
repository also does not follow 'general' svn rules about how to name
branches.

So we have something like:
trunk -> development
branches\version1 -> version1 maintenance
branches\custom\version1_fix -> customized version1 with certain fixes

etc.

When importing, I've only imported trunk and branches I'm interested
in. Thus, I have multiple remotes for which git-svn does not know they
are related (or how they branched from each other). Also, I have not
imported whole history, as its just to much trouble.

Now, I want to start a new branch, lets say branches\dev1, which is
branches from trunk. This will be used for various improvements, which
do not go to trunk immediatelly.
I also want to keep this branch in sync with main trunk.

Up to now, I have been doing this by git-cherry-pick all changes from
dev1 branch point. Is there a better way to do? Note that branch dev1
in git-svn does not know about previous commits in trunk (git remote
ref was initialized from branch point for dev1).

Just merging trunk (represented by a remote in git-svn) makes a mess
(as expected). Basically, what I want to do is tell git-svn that merge
was already done up to a certain point from that branch so git-merge
then only picks up new changes from that point on (and the ones that
have not been cherry-picked).

Is there a way to get out of this mess? I'm fine with cherry-pick, but
it requires some manual labor (like remembering/finding last
cherry-picked commit).

Thank you,
Igor
