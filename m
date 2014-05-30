From: Nathan Neulinger <nneul@neulinger.org>
Subject: feature request - implement a "GIT_AUTHOR_EMAIL" equivalent, but
 processed BEFORE .gitconfig
Date: Fri, 30 May 2014 13:19:17 -0500
Organization: Neulinger Consulting
Message-ID: <5388CBA5.9030403@neulinger.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 30 20:19:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqROm-0000bQ-PF
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 20:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933095AbaE3STU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 14:19:20 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:40176 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932473AbaE3STT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 14:19:19 -0400
Received: by mail-ob0-f178.google.com with SMTP id va2so2181964obc.23
        for <git@vger.kernel.org>; Fri, 30 May 2014 11:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:subject:content-type:content-transfer-encoding;
        bh=hhXzty3hUSb0l+FKfJOjKAT5CCPHLdsU8p2ulXOWQNU=;
        b=YXC9Y/3v9sGlrhn5BR/WH1zOVSEp1mulG1e7HDKcNq788VlP+j72ySR5TprMXX8jx1
         q7zT1zUnzrIpG3dRNFc63vXGVBNWoa7Yq3hRvul836VnMltOuCiB/3DIWD7f9f0LGJbp
         Pv76szFHiJktQ/eDix1ujS+QGTaXtNz77PAajhnZkq8zBwAsyaKsA+t5Zq+FtMbrpKVX
         g0ViMUArKJa6kabb4nhQSBL2Mbg9KT78RiKudgrBUWLZk9up2szK9/aiAjIqZcqoBlM2
         fx+GnZnRp6mD6jv/F19UPgM9a9S/wpLaBgFTrZPEyIkNJM/1nfUjf8a/BD6vRwGZXAXv
         DlgA==
X-Gm-Message-State: ALoCoQnpepUYqgHQLwvTgvl49ynaO1Xc+FStg47iAbhp8tpo4vWX8fb5WQJqPd/zAUedLV4OiBMQ
X-Received: by 10.182.106.99 with SMTP id gt3mr19752056obb.24.1401473958749;
        Fri, 30 May 2014 11:19:18 -0700 (PDT)
Received: from infinity.srv.mst.edu (infinity.srv.mst.edu. [131.151.49.1])
        by mx.google.com with ESMTPSA id yt12sm8368305obc.4.2014.05.30.11.19.17
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 30 May 2014 11:19:18 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250459>

Four related feature requests/ideas:


1. equivalent to GIT_*_EMAIL/NAME vars, but processed only if git config doesn't set values

Right now, there isn't any way to have a systemwide profile script that tries to determine a better default for the user 
name/email values, such as in the case of shared logins. The best I've been able to do for now is use the 'EMAIL' var.

Use case in my environment - most shared-login accounts are accessed via krb5 login, so it provides a nice way to set a 
better default for "who is doing this commit" than just the userid.


2. Setting option to user.name (or other setting) that would BLOCK the commit from occurring at all if it would 
otherwise fall back to defaults. I thought this previously worked by setting an empty value, but apparently doesn't work 
that way in current versions.


3. Setting option to user.name/user.email to prompt, SVN-style, for the name/email. Yes, this would be 
annoying/obnoxious to use normally, but intent is to avoid un-named "root@host" commits that would otherwise occur from 
user being lazy.


4. (This would accomplish all of the above) - enhance the include.path option to support the "!" syntax similar to what 
aliases can do. i.e.

[include]
    path = !/usr/local/bin/gen-git-env

or

[include]
    cmd = /usr/local/bin/gen-git-env


-- Nathan

------------------------------------------------------------
Nathan Neulinger                       nneul@neulinger.org
Neulinger Consulting                   (573) 612-1412
