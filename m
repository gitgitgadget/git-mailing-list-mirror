From: Gautier Pelloux-Prayer <gautier.pelloux@gmail.com>
Subject: Shallow submodules update not working?
Date: Thu, 17 Sep 2015 13:28:14 +0200
Message-ID: <68A9767C-BC5B-479D-B212-BEB1CDF3E7E8@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 17 13:28:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcXMW-0005zc-98
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 13:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbbIQL2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 07:28:20 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:32843 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbbIQL2T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Sep 2015 07:28:19 -0400
Received: by wiclk2 with SMTP id lk2so19496837wic.0
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 04:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:message-id:date
         :to:mime-version;
        bh=sxZQL2AQLLEsoEWv/5sbYvhEUQTqJyh4JKm49k6eDYY=;
        b=jr2xX8x3rpryOzTRx518MfBoApgO4EYR9AMaZw9MEef6GtY94oYl1jiV+6eV+c07ct
         qDhryMpTlVA5mmVlFUDIqW9c9qMANH1AGYpNk+B7tUpP9AVYbcOLGWN04PJ9M+s5Mqtx
         e8BotBJigQw2rHOl/9DMsGu38Cv1JHfVYDXsxdb6xwwuMR7mDu6WUR+ekCcl3B3mCeF6
         KqyD/ptkk4elt2HjvTWeCHPiQV5CA94YKl/GQcVacv4K/d6DU6El8ZQXVM+RruHek196
         IDtBB+jJU6nIEa6eVgGD4siWDhbzcF34MwM67OQ5yKs7+pv0qnPH9REsagGt3pd+/xDB
         tQLQ==
X-Received: by 10.194.184.136 with SMTP id eu8mr34918743wjc.151.1442489298118;
        Thu, 17 Sep 2015 04:28:18 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2e97:fb90:2450:cfe5:f039:e84f? ([2a01:e35:2e97:fb90:2450:cfe5:f039:e84f])
        by smtp.gmail.com with ESMTPSA id bh5sm2884710wjb.42.2015.09.17.04.28.16
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Sep 2015 04:28:17 -0700 (PDT)
X-Mailer: Apple Mail (2.2104)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278107>

Using git version 2.3.8 (Apple Git-58), when I try to clone a repository with submodules using option --depth 1, I get two different behaviors for two different commands:

# 1 - using git clone --recursive directly (OK)
# repository last ref is cloned as well as its submodules
$ git submodule clone git://repository --depth 1 --recursive 

# 2 - using git clone then git submodule update (KO)
# repository is cloned, then submodules are cloned too but an invalid reference is fetched leading to "fatal: reference is not a tree: <submodule ref>"
$ git submodule clone git://repository --depth 1
$ cd repository
$ git submodule update --init --recursive --depth 1 #error 

I am wondering if the second scenario has the intended behavior, or if it should behave as the first solution. 

If this is the intented behavior, is it possible to retrieve a shallow version of submodules within an existing git repository, or the only solution is to clone the whole project with --depth 1 option?

Thanks, 