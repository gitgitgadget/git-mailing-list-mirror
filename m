From: Vijay Lakshminarayanan <laksvij@gmail.com>
Subject: Re: How to find a commit that introduces (not removes) a string?
Date: Thu, 03 Nov 2011 21:43:21 +0530
Message-ID: <87zkgdgp5q.fsf@gmail.com>
References: <j8to8h$vqd$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 03 17:13:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLzv6-0008P4-A7
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 17:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933917Ab1KCQNc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Nov 2011 12:13:32 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:49735 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933739Ab1KCQNb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2011 12:13:31 -0400
Received: by ywf7 with SMTP id 7so1480688ywf.19
        for <git@vger.kernel.org>; Thu, 03 Nov 2011 09:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=cE8awlUxUcDdtz4ALUqSOzR9SVCGgMqeN6ohZDfMEOE=;
        b=TgJD0/+RxbqtU2xD6ll9A8j0f3hXYc+10Futd7tHoTCiKr07B0FfkOUYQ2zuRuACxx
         BntWVa8HeG5LTArRTjsD15EKpY6pHprcisqQkF7RD/+qTx/oo748r0WJZwJUzU92b0H+
         Cy8Lz76Q6fDg4qJF/cXkYgNgpSBFgOww7TDvU=
Received: by 10.236.200.201 with SMTP id z49mr14619842yhn.20.1320336810541;
        Thu, 03 Nov 2011 09:13:30 -0700 (PDT)
Received: from BALROG ([59.92.14.5])
        by mx.google.com with ESMTPS id x3sm18420945anl.6.2011.11.03.09.13.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 Nov 2011 09:13:29 -0700 (PDT)
In-Reply-To: <j8to8h$vqd$1@dough.gmane.org> (Sebastian Schuberth's message of
	"Thu, 03 Nov 2011 10:50:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (windows-nt)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184727>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> Hi all,
>
> I know about git log's -S / -G, but I'm unable to make these search through *introduced* strings only. Is there a way to do so?

This appears to work:

$ for ref in `git log -SWORD --pretty=format:"%h"` ; do 
    git log -1 -p $ref | grep WORD | grep -E '^[+]' > /dev/null ; 
    if [ $? -eq 0 ]; then 
        echo $ref; 
    fi ;
  done

substitute WORD for what you're looking for.  Note that it is repeated
twice.

> Thanks!
>
> PS: I also read [1], but although the author claims to be interested in introduced strings only, he seems to be satisfied with -G, which slightly puzzles me.
>
> [1] http://stackoverflow.com/questions/5816134/git-finding-a-commit-that-introduced-a-string

-- 
Cheers
~vijay
