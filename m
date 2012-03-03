From: Jared Hance <jaredhance@gmail.com>
Subject: [PATCH v2 0/3] Fix a few documents fixmes
Date: Sat,  3 Mar 2012 09:40:27 -0500
Message-ID: <cover.1330785363.git.jaredhance@gmail.com>
References: <cover.1330740964.git.jaredhance@gmail.com>
Cc: gitster@pobox.com, Jared Hance <jaredhance@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 15:41:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3q8y-0000Sv-2K
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 15:41:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752981Ab2CCOlC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Mar 2012 09:41:02 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38321 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752572Ab2CCOlA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2012 09:41:00 -0500
Received: by iagz16 with SMTP id z16so3544384iag.19
        for <git@vger.kernel.org>; Sat, 03 Mar 2012 06:41:00 -0800 (PST)
Received-SPF: pass (google.com: domain of jaredhance@gmail.com designates 10.42.19.5 as permitted sender) client-ip=10.42.19.5;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jaredhance@gmail.com designates 10.42.19.5 as permitted sender) smtp.mail=jaredhance@gmail.com; dkim=pass header.i=jaredhance@gmail.com
Received: from mr.google.com ([10.42.19.5])
        by 10.42.19.5 with SMTP id z5mr9194944ica.51.1330785660263 (num_hops = 1);
        Sat, 03 Mar 2012 06:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=c6UzAxVRBAM++AcXBERUHpecpvyFXbl4TUtqQMwyblA=;
        b=n89bgj0NdA8oDWmxAWTJOhp4GHjtGUgEdgqzbSusq2rgmjw9c5G1+inVLl0+quWsYo
         7MSMeucvFIrKx3yYvGM6MZwvqu1xM6hAlEfvDCqi3S4/HduVlXz0vB76wtmUdazau2+U
         1Dz1huruAVNnjbszSYRRv8uSc01RG2YQ+S5Cbj1V3W1AFHg4gM88BTkRGnToJ7kzPkmP
         6houpLQrm7+Xx/bGsTA8k9pDRvVviH58ylbKOksQTKGDgaFJ0ftQhSllLpoGd9JHp97d
         7zuiAYjhVg9UEG3xldkdj29tpL/3qJW8EnPT9GfqCXqbLmzBEngjA24Chz69uSIM2q8X
         mQLw==
Received: by 10.42.19.5 with SMTP id z5mr7559929ica.51.1330785660217;
        Sat, 03 Mar 2012 06:41:00 -0800 (PST)
Received: from localhost.localdomain (cpe-174-101-220-163.cinci.res.rr.com. [174.101.220.163])
        by mx.google.com with ESMTPS id b6sm5212250igj.7.2012.03.03.06.40.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Mar 2012 06:40:57 -0800 (PST)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <cover.1330740964.git.jaredhance@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192110>

A few patches that (hopefully) don't change the behavior of git except to
rectify a memory error. Also, this should ever so slightly help with
the parallelism of git (a GSoC proposal). All of these were found with
commented FIXME and git grep.

Jared Hance (3):
  Use startup_info->prefix rather than prefix.
  Fix memory leak in apply_patch in apply.c.
  Add threaded versions of functions in symlinks.c.

 builtin/apply.c |   30 +++++++++++++++++++++++++++---
 cache.h         |    4 +++-
 git.c           |    2 +-
 symlinks.c      |   28 ++++++++++++++++++++++++++--
 trace.c         |   10 +++++-----
 5 files changed, 62 insertions(+), 12 deletions(-)

-- 

Changelog since last series submission:
    - Whitespace fixes that I should have checked for before
    - Typo fix
    - Completely redo my fix to the memory leak to address issues pointed
      out by Junio.

Note: I'm not quite sure if I actually agree with the first change. It makes
sense right now if git.c is the only caller, but in the future, it might become
less flexible. It might be wise to actually make startup_info static to git.c
for protection in the future. They should be relatively independent, though,
so the 2nd and 3rd which are probably less controversal can easily be applied.

1.7.3.4
