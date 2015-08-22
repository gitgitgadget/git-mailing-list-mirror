From: Karthik Nayak <karthik.188@gmail.com>
Subject: GSOC: Unify the commands `git tag -l`, `git brach -l` and `git for-each-ref`
Date: Sat, 22 Aug 2015 13:15:52 +0530
Message-ID: <CAOLa=ZRS-f0tOo+EC0_Su8aZ8cz9pratmg4vjkG+DC8gAeYAJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 22 09:46:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZT3Vq-00050r-6u
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 09:46:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753298AbbHVHqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2015 03:46:40 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:34790 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648AbbHVHqW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2015 03:46:22 -0400
Received: by oiey141 with SMTP id y141so53809512oie.1
        for <git@vger.kernel.org>; Sat, 22 Aug 2015 00:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=1GJqQMT+c2zmbw3P8K6JgoC5I+R1xSbpEVlh7d14tG0=;
        b=EeLTNC9iEA68s4tIazwGjraycSLPoH8p43Ke2RFbgQrTdqhzbbZI6fFDKNDzE2zrYh
         myDi/HCt5b6cpQS6fFj+PM3oFnoMs/STCO3s/ls0i94RWBZOB5qSMNTHrikKiEVT0gdp
         TZ0h9awunCoViPgXCXZOxpVCpnCe6paeqSKebTqyDr+kAHt7bWFRuJOBAo15anoad88s
         soln14wkz/e/uZonrDsQGoJCndzWg2NT/Vq//goQlpYv+/zJYGRbDfHgYjbceiHCXhIa
         5mJwZU+YYmwUIMUhHkDpGapCusw79T9MEzyB4yKZ2QaTiCR7Cn4xVJi6716DzGouWLAi
         sDPQ==
X-Received: by 10.202.200.75 with SMTP id y72mr11399267oif.111.1440229581952;
 Sat, 22 Aug 2015 00:46:21 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Sat, 22 Aug 2015 00:45:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276385>

Hello All,

As part of GSoC I'm working on the Unification of 'for-each-ref', 'tag -l'
and 'branch -l'.

Current Progress:

1. Building ref-filter.{c,h} from for-each-ref.
This is the process of creating an initial library for the unification
by moving most of the code from for-each-ref to ref-filter.{c,h}.
Merged into next

2. Add options to ref-filter.
This includes the porting of --points-at, --contains, --merged,
--no-merged options from builtin/branch.c and builtin/tag.c, Also the
implementation of these options into for-each-ref.
Merged to next

3. Port builtin/tag.c to use ref-filter.
Here we port tag.c to use ref-filter and also port the --format,
--sort and --merged and --no-merged options to builtin/tag.c.
Version 13 can be found here:
* http://thread.gmane.org/gmane.comp.version-control.git/276363
There was a lot of discussion on v12 (especially how %(align)...%(end) should be
handling '--quote') which can be found here:
* http://thread.gmane.org/gmane.comp.version-control.git/276133

4. Port builtin/branch.c to use ref-filter filtering APIs.
Here we make use of the filtering APIs provided by ref-filter to filter out
branches. Also make it learn the '--points-at' command.
version 3 can be found here:
* http://thread.gmane.org/gmane.comp.version-control.git/276377

As my mentors suggested, I'm working on the printing aspects of branch.c now.
This involves supporting %(if)....%(then)....%(else)....%(end). and
making branch.c
use show_ref_array_item() rather than using its own implementation.

As the ground has been laid for %(align)....%(end) atom, the work shouldn't be
of much difficulty.

Will push most of my work to github: github.com/KarthikNayak/git

-- 
Regards,
Karthik Nayak
