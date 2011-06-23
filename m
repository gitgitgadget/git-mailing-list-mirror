From: Maarten Billemont <lhunath@gmail.com>
Subject: ''git submodule sync'' should not add uninitialized submodules to .git/config
Date: Thu, 23 Jun 2011 13:13:50 +0200
Message-ID: <0D2618D7-0681-4E71-B412-36D490D45B9D@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 23 13:18:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZhv6-0001NY-Fl
	for gcvg-git-2@lo.gmane.org; Thu, 23 Jun 2011 13:18:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759043Ab1FWLRz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jun 2011 07:17:55 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35680 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753011Ab1FWLRy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jun 2011 07:17:54 -0400
Received: by fxm17 with SMTP id 17so1204413fxm.19
        for <git@vger.kernel.org>; Thu, 23 Jun 2011 04:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:content-type:content-transfer-encoding
         :subject:date:message-id:to:mime-version:x-mailer;
        bh=IsFZjhqPXw6a0mTfxxeDiPTqP5C6lVEbHIpAG5gp3lc=;
        b=MQrlGlVYX+XwyhrzP6KAnaErfuSW1WExwQhzYWXjGlH10pXJCTksGdEptWqcB3L7yA
         DwfDbEy1+u697fbkivCdtgPpgpEum73H3abyau+jRz57sDcIHyTqxpU6WIJ/PNnyXRPy
         tfYBvivm7K6wtUG7JzYD39ldsdvP/Nxi3qMsk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :to:mime-version:x-mailer;
        b=BjmVM3x6YOTfW9XPnwtMZC7Rp4PnVezQKkfWC2KMF+mHG89rCrk1n1a1YyvckQFLpc
         sKIB+/0yiG6WD27iNKxKiLRixzpDcbYFW9tIEJB7CCZJ6BHN1E78AdMWa3Jlmu/eVsRO
         lq0xsm3hG674WF1NYiGLBGDtR0AOMZi8X847A=
Received: by 10.223.102.131 with SMTP id g3mr2487793fao.68.1308827633414;
        Thu, 23 Jun 2011 04:13:53 -0700 (PDT)
Received: from [10.5.0.13] (satura.lyndir.com [178.63.61.197])
        by mx.google.com with ESMTPS id h28sm917520faj.5.2011.06.23.04.13.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 23 Jun 2011 04:13:52 -0700 (PDT)
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176268>

When I initialize 2/3 submodules of my git repository and do git submodule update, all is fine: Only the 2 submodules that I need are updated.

When I run a git submodule sync to update the URLs that may have been changed in .gitmodules, it ADDS the URL of the submodule that was NOT initialized, thus "initializing" it.

Now, when I run git submodule update, it starts checking out the third module and my workflow is broken.

git submodule sync should not add entries to .git/config, only update existing ones.