From: Armin Kunaschik <megabreit@googlemail.com>
Subject: t1400 test failures
Date: Tue, 24 May 2016 13:18:23 +0200
Message-ID: <CALR6jEhDS46tC2W-oA2BsppVvjrDpRO92oQ-w=B-209M-EoSrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 13:18:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5AMA-0001yc-6x
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 13:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755801AbcEXLS0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 07:18:26 -0400
Received: from mail-yw0-f179.google.com ([209.85.161.179]:33343 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755798AbcEXLSZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 07:18:25 -0400
Received: by mail-yw0-f179.google.com with SMTP id h19so12284457ywc.0
        for <git@vger.kernel.org>; Tue, 24 May 2016 04:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=0I61Yb2mR1ReJ8yoYYQ2xFkldrLbXK8H9sfwFPDO8Jc=;
        b=YxMgPTqiq9ivUAImhZihkc+nm/3Zey1ixI73nkFaYs2PN7sm0zITMI5y3poS9l77qM
         JqvcsrCN5TUYFOS92zKOIjvNkLN5GcrBNbvka5dBmcI/TjFBtbj/iSAUI+AXT1LdaqJU
         eQ4DuPphrrZV/eYgvQtlMmwuQCFOY37YGI+Ke4rjDzRKd8Lb8Ao/+17g1QF1SLeURyCk
         eOnr7TRR397x7C7CVEdV9X9C1QeS/UkU7WM1N/i7GT5C6i60uYdjmlfcLMb3EuzjmXVG
         pazgtoZgRfUt3d+xelwNmWUIAtZIu+ITwxGYQZZw65zCmr+DzzVKE/Z8dclaebD61WjS
         DfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=0I61Yb2mR1ReJ8yoYYQ2xFkldrLbXK8H9sfwFPDO8Jc=;
        b=aQe7oti3DSTipzwUWk5BSBHDaY3Ev6DX26XEOWhmwSPbfobuBB0yjWsSmFroLAs3pj
         3/H2Nqp9eMM/I8PYjGAxMQAeqJK3CTvQi5UqxN4tmUu7g3dnDG/2WmeUJeGt6TJ7oi1Q
         AssUVHTxazd39bSHNvd40k6HTIQE3MDwpPQ7GFTxKDdiSN+e/DWn6AzY3Mvu0uLLAr5h
         truDTI1xHOCRZywAE0MFEkdDKI03JDlaYrVsseU/s1yMY0OT1gDsDyJ7Hd2qJIguPpuQ
         9l3f96jJLilASDpD9rdipUqxQT6kjcg2RduPnAvix4rISnD04zudo60jHZSxKhF9GGj8
         vwJg==
X-Gm-Message-State: ALyK8tKt+3jmSfY+9WC3jRyCTdXz7ITID6H8ahqDgu2xUtGxR1xzc19UU3qmiFnJYMG+OFNOSTBxUZbLwMqtCA==
X-Received: by 10.37.80.133 with SMTP id e127mr1915578ybb.162.1464088703872;
 Tue, 24 May 2016 04:18:23 -0700 (PDT)
Received: by 10.129.45.132 with HTTP; Tue, 24 May 2016 04:18:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295485>

Hello,

I have 2 failed tests here:
large transaction creating branches does not burst open file limit
large transaction deleting branches does not burst open file limit

both tests fail because of the decreased file limit:
git-2.8.3/t/../bin-wrappers/git: bad file unit number

The tests run fine on AIX with ksh88 when I increase the ulimit to 63 or higher.
bash and ksh93 test fine with the present ulimit of 32.

Changing the shell interpreter of the git-wrapper script to /bin/bash or
/bin/ksh93 is enough to make these 2 tests work with the lower ulimit.
All other scripts can be run with any shell.

I have no idea why the ksh88 consumes so much file descriptors, I also
don't have an idea if or how this test can be "fixed".

So I'll leave this here for information purposes :-)

Armin
