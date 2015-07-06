From: Jacob Keller <jacob.keller@gmail.com>
Subject: refspecs with '*' as part of pattern
Date: Mon, 6 Jul 2015 11:31:42 -0700
Message-ID: <CA+P7+xoosLG3J5uUVakzwYoxVARs-NH4BJBtsMgw2NB39vyE6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 20:32:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCBBY-0001VE-9y
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 20:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbbGFScE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 14:32:04 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:34681 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574AbbGFScC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 14:32:02 -0400
Received: by oiab3 with SMTP id b3so6027724oia.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 11:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=xIQtnjlSHq1CVm2Vg3S3s/phMOekXZ7EQOxV96MYhkg=;
        b=laIEbhKAk7l/ZwTfQ8xP/X0AeZbKWIylKq9axbN5VhrSaR7f5nZwzwH6yeYoJxGoBq
         muK9nlmgEqrvaL2dVP7i2HXuWjqm+qjpKQTdhYhh8L9McyGRGSZGkFeIEajwdLZvWuX8
         Z4pRBhnR6otsla/rmtbybIpOfRGf7Xi785M+7N09sbeKgLRqkLLqKrsjqjYqo+UjfvPu
         WdUSoiwhzCk/TjrhA6IhiX5tuMTipDGDmINN17uvg7Zj/AUGhs5CEZyjzG9ISgL+gld3
         QIqw0RtgTBzW20kymnFell3uVrmtHa6ONDBLt3jYtEuL9MWgSNWW7CRPK3OfmLCO7GCH
         gX4Q==
X-Received: by 10.202.0.212 with SMTP id 203mr212445oia.58.1436207522133; Mon,
 06 Jul 2015 11:32:02 -0700 (PDT)
Received: by 10.76.174.8 with HTTP; Mon, 6 Jul 2015 11:31:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273447>

Hi,

I've been looking at the refspecs for git fetch, and noticed that
globs are partially supported. I wanted to use something like:

refs/tags/some-prefix-*:refs/tags/some-prefix-*

as a refspec, so that I can fetch only tags which have a specific
prefix. I know that I could use namespaces to separate tags, but
unfortunately, I am unable to fix the tag format. The specific
repository in question is also generating several tags which are not
relevant to me, in formats that are not really useful for human
consumption. I am also not able to fix this less than useful practice.

However, I noticed that refspecs only support * as a single component.
The match algorithm works perfectly fine, as documented in
abd2bde78bd9 ("Support '*' in the middle of a refspec")

What is the reason for not allowing slightly more arbitrary
expressions? Obviously no more than one *...

It seems like the "strict" requirements, as in the above commit, but i
an unable to find what these requirements are, and why they can't
allow more expressions.

It's possible that users might not expect it to work, but maybe it
could be configured behind an extra option to prevent accidental use?
I think it's quite intuitive though.

Maybe because it allows some shenanagins to rename tags, but... that's
really the user's fault... Another reason for putting this behind an
option possibly?

Personally I would like to be able to use this as it allows much more
fine grained control over what I fetch, and lets me stick with the
un-namespaced tags which are something I can't change.

If this isn't something that can be done I would appreciate a good
explanation of what it might break and why it's a bad idea...

Regards,
Jake
