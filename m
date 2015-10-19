From: Lars Schneider <larsxschneider@gmail.com>
Subject: [RFC] URL rewrite in .gitmodules
Date: Mon, 19 Oct 2015 21:28:20 +0200
Message-ID: <DCA9FD0F-252B-4CD7-9137-395771CBC62E@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 19 21:28:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoG6e-0005Vu-Qn
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 21:28:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753951AbbJST2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 15:28:25 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:36617 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753733AbbJST2Y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Oct 2015 15:28:24 -0400
Received: by lffz202 with SMTP id z202so38452403lff.3
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 12:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:message-id:date
         :to:mime-version;
        bh=TZQ6QYsRHxwTVGNKRwVYb0pdiWI53s+6c+9VfqBIt+A=;
        b=PlhKa3v8P/No7x0YKg1FhkNnURepLcQf2TIDz4sA93w9bMK56vOc1+4KLO8kG5Xhcq
         eg94FanyKcQ0IHW7pjLULWXgypwzkjenhW5Cbra7qozXmi1istSCbyh8gIrBAN2ydp5K
         vRWsDPmKMpJNmBhr4r3f27W9U/krfWRlZ5AkkpNFVliiPzrE8dUn0c6yi5aUnOewY0SA
         YwMami9/USbiXmux6osXjJ3WcrH0pvaWhgPAnHQ+RUk8rS3gFFircpuCT+FoEOd3y26Y
         GsaXwPR6c6gvR+kxpcOPoM2p4SPpGEqTb0Ol60qg7RXNnOlWytEyKoviiH7kGc5hgSm0
         kSZw==
X-Received: by 10.180.87.194 with SMTP id ba2mr22384374wib.11.1445282902921;
        Mon, 19 Oct 2015 12:28:22 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB5D2E.dip0.t-ipconnect.de. [93.219.93.46])
        by smtp.gmail.com with ESMTPSA id ub7sm16206563wib.17.2015.10.19.12.28.22
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 19 Oct 2015 12:28:22 -0700 (PDT)
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279887>

Hi,

I have a closed source Git repo which references an Open Source Git repo as Submodule. The Open Source Git repo references yet another Open Source repo as submodule. In order to avoid failing builds due to external services I mirrored the Open Source repos in my company network. That works great with the first level of Submodules. Unfortunately it does not work with the second level because the first level still references the "outside of company" repos. I know I can rewrite Git URLs with the git config "url.<base>.insteadOf" option. However, git configs are client specific. I would prefer a solution that works without setup on any client. I also know that I could update the .gitmodules file in the Open Source repo on the first level. I also would prefer not to do this as I want to use the
  very same hashes as defined by the "upstream" Open Source repos.

Is there yet another way in Git to change URLs of Submodules in the way I want it?

If not, what do you think about a patch that adds a "url" section similar to the one in git config to a .gitmodules file?

Example:
----------
[submodule "git"]
	path = git
        url=git://github.com/larsxschneider/git.git

[url "mycompany.com"]
        insteadOf = outside.com
----------

Thanks,
Lars