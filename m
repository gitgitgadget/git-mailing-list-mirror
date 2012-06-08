From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: [BUG] Out of memory on git log --simplify-by-decoration --first-parent
Date: Fri, 08 Jun 2012 20:23:44 +0200
Message-ID: <4FD24330.2030805@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 08 20:24:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sd3ql-0002Uz-RO
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 20:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761315Ab2FHSXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jun 2012 14:23:48 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:38978 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755965Ab2FHSXr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 14:23:47 -0400
Received: by eaak11 with SMTP id k11so1243159eaa.19
        for <git@vger.kernel.org>; Fri, 08 Jun 2012 11:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding:x-gm-message-state;
        bh=lE9fH2ABpXItZR9pOssU1wlnJdIM0xTYcUYSI58Ttv8=;
        b=PZ8dGu6443bam4EZVQdBgxv/L9Vgp3g9IwX+OGtRuFhm9EJVZ3SySRs8gHsXKMC3AX
         1jM40QqI3FWgmYw0Wf2gZzWm8L2i9ZYCRdM+plhkYusYP4qBJWVpE4mYG9bSQVdAvySY
         nePO4BQdx4eoe5J1kTlYdLUIrJFbaXpyjdCZ5WhNbhm/fQ7p4fQGgwqWhf0VaOFyogXh
         7vrCjRByex++QTjVl7fVPqvB7JrIxJ+fm4/I7hDu863+t1A1W14zbd+uT+NMp8XT6SW0
         wtCv3lw8wwIsA1dEG3Bej4P2Mfit6kicg1KDJSVeip7a07s05Ie0ujrgdI+hIHNMsO5O
         AacQ==
Received: by 10.14.29.4 with SMTP id h4mr3909350eea.178.1339179825567;
        Fri, 08 Jun 2012 11:23:45 -0700 (PDT)
Received: from [192.168.1.5] (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id m5sm24815837eeh.17.2012.06.08.11.23.44
        (version=SSLv3 cipher=OTHER);
        Fri, 08 Jun 2012 11:23:44 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
X-Gm-Message-State: ALoCoQnkN6rGlx5n+heCdOW3pRMZ2kCbnYetgm7i4N1lm9ogG2rBFHhn6kaB4JQhW6PZtcLiZc0t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199516>

git dies after calling the following command on the git repo:

$ git log f623ca1c...b9cfa4e9 --simplify-by-decoration --first-parent

This happens in simplify_merges () in revision.c. The list below shows 
the number of times the "while (list) { ..}" block is executed until git 
dies:

1475
3544
8274
19588
45689
106077
245329
565153
1269244
2614903
5871845
13138892
fatal: Out of memory, malloc failed (tried to allocate 8 bytes)

Verified with msysgit and on Ubuntu Linux.

Vincent
