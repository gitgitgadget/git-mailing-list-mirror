From: "Michael G. Schwern" <schwern@pobox.com>
Subject: Make git-svn Use accessors for paths and urls
Date: Fri, 27 Jul 2012 13:00:47 -0700
Message-ID: <1343419252-9447-1-git-send-email-schwern@pobox.com>
Cc: robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	normalperson@yhbt.net, jrnieder@gmail.com, schwern@pobox.com
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 27 22:01:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Suqit-0003LG-AS
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 22:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752641Ab2G0UBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 16:01:12 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57013 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486Ab2G0UBM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 16:01:12 -0400
Received: by pbbrp8 with SMTP id rp8so5499064pbb.19
        for <git@vger.kernel.org>; Fri, 27 Jul 2012 13:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=TK69WxMo0PbIyrVMBQqeGgpXy3J3j9T2XSJPTwi0J5k=;
        b=efcwagdsd9sE6bpQo/1zQF/0RWpLEjkxLwtnrUPLd09cptEaGxxz3Gm11uP8LxoFzp
         O2tE9f9PCLMdoqZxDQP6NTm5XOHiT3MKYAIW9F/34wA/92ADrfN2w3yndWEimon6z0HY
         nmAcbo2bA8ptJvFskG5hjgUmwzOJaKOAbAdP7HJLlhHGFJGwtY5fIa91ILiI8a6P822P
         dyBvCfdy+zybSZR8AoC94+jJbM9WAgUWMe8MPtcbfT/IXhF9MunBIn8GyJgBLNr/i92G
         pSfuaMjSyHQZxrZtvVyCthHUvOyGPIJdrhjnoFQO1U8FILA9qovH+6/RuuQQUWw2kTSD
         kzMA==
Received: by 10.68.201.135 with SMTP id ka7mr16934339pbc.15.1343419271710;
        Fri, 27 Jul 2012 13:01:11 -0700 (PDT)
Received: from windhund.local.net (c-71-236-173-173.hsd1.or.comcast.net. [71.236.173.173])
        by mx.google.com with ESMTPS id sk5sm2489907pbc.7.2012.07.27.13.01.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 27 Jul 2012 13:01:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202368>

This patch series gives Git::SVN and Git::SVN::Ra accessors for
path and url and then makes the rest of the code use them, rather
than grab at $obj->{path} and $obj->{url}.  This then will give
us the control necessary to canonicalize them as early as
possible (done in the next patch series).

There are plenty of other places in the code which will benefit
from accessors and functions, but those will come later.  path
and url were the most obvious.

This is a refactoring and has no functional change.  All git-svn
tests pass with SVN 1.6 for each patch.

This goes on top of my previous patch series to extract other
classes.  That hasn't been reviewed yet, but both that and this are
a simple patch series and I figure we can review a bit ahead.

This is the last refactoring patch series.  After this bugs, start
getting fixed.
