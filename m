From: Lea Wiemann <lewiemann@gmail.com>
Subject: git-name-rev --undefined / --always
Date: Fri, 06 Jun 2008 01:49:19 +0200
Message-ID: <48487B7F.5000909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 06 01:50:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4PDv-0001LZ-FJ
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 01:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763176AbYFEXtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 19:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761819AbYFEXtX
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 19:49:23 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:13141 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758694AbYFEXtW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 19:49:22 -0400
Received: by fg-out-1718.google.com with SMTP id 19so501321fgg.17
        for <git@vger.kernel.org>; Thu, 05 Jun 2008 16:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:subject:content-type:content-transfer-encoding:from;
        bh=sm1qnHva7Q6ihlKmYipHojVWQkg37X8vLvw0bMmxHP0=;
        b=C8RIwCqxzwc1ymaMcOQSzvvfzUJSnJ84bkoUJMmvo4zEQMqY7JB00+lAkE2/cezKPF
         FncRZd65lfdeJPAgdV/d8IEoy7tx63FJTcC2Pecvi1i2b5batZY+nEHOAfQ5vpU6bAqA
         FMt6R56qLE7VDMG39ITYF0mwM85xvYOFh45Ek=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding:from;
        b=m07xSaFhDzVZ2Oft6PoGwAKV+B8gB3qkO1pYRKPUiYawv2PFr0Hy9XKm30RQgyIfeE
         db4G8P0pbkeTkAGvDyBKHXJ7QjDUHr0lRmWd4wwaKyw2vkRE/NBmoqTe67l4aeTiLsCc
         uBxKLZIo8QYvB2Fv8+sgG68m97kf3ILJ3x9P4=
Received: by 10.86.26.11 with SMTP id 11mr3064319fgz.23.1212709761272;
        Thu, 05 Jun 2008 16:49:21 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.234.84])
        by mx.google.com with ESMTPS id b17sm8196241fka.6.2008.06.05.16.49.20
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Jun 2008 16:49:20 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84003>

The name-rev command has an option --undefined (which is not documented 
in git-name-rev.txt) that doesn't do anything.  If you look at 
builtin-name-rev.c, allow_undefined never gets set to anything but 1, I 
think.  In that case --undefined could be made a dummy option for 
compatibility and the allow_undefined code could be ripped out.

In the same file, there's also an "else if (always)" clause that, if 
allow_undefined is indeed always true, never gets run.  "git-name-ref 
--tags --always master" still prints "undefined" despite the --always 
option.  (--always is undocumented as well.)

Perhaps someone more knowledgeable should take a look at this (and maybe 
write up a test case or two), I don't feel confident submitting patches 
to this file.

-- Lea
