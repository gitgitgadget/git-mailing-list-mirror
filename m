From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: [RFC/PATCH v4] Better control of the tests run by a test suite
Date: Wed, 30 Apr 2014 02:50:41 -0700
Message-ID: <1398851444-2492-1-git-send-email-ilya.bobyr@gmail.com>
References: <1398154767-1276-1-git-send-email-ilya.bobyr@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 11:51:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfRAm-0003Ku-Nz
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 11:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753770AbaD3JvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 05:51:12 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:61949 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576AbaD3JvK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 05:51:10 -0400
Received: by mail-pd0-f172.google.com with SMTP id g10so1495047pdj.3
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 02:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+LGzBQ7w723sJBiZsyiqoAemkpy/suDN3HLwsQGqdmQ=;
        b=YY1mWCGlGqx8DurfEXeOZpQNPjYr75dAZ7jFKwsvp7ShPK3Tm87m9pbZjL0grIVsO5
         wW1xZNtfXAckCgDKhM3foINxkTZZnlu8566k8NcsUaTsG7T3rrJ2OKaa6Hw17AGVm95I
         HtBKG/PQAk+bJYpeXDvj/Wo/a70Hd3+YbSq5QplYmmwsS2IXXvq6BXT+hUnNyqqFDGu5
         mGo6BMR7MVyIzWKSkz7i0GllemzHqXfOB+bzo8e6SER+oyCT7AXajvqib36bcLihqeB2
         ThVWFM7fQicXlJIB/rJ54QfeGL4u6Ak+yKlAqEP4BXrta3rj9vcE9rsX6hDKrYic8AyZ
         1Iqw==
X-Received: by 10.66.141.144 with SMTP id ro16mr6498434pab.131.1398851466262;
        Wed, 30 Apr 2014 02:51:06 -0700 (PDT)
Received: from localhost.localdomain (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id ss2sm131761603pab.8.2014.04.30.02.51.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Apr 2014 02:51:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1398154767-1276-1-git-send-email-ilya.bobyr@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247694>

This patches add `--run` option to the test suites to allow one to run
individual tests out of the test suite.  Like this:

    ./t0000-basic.sh --run='-4,7,9-12,15-'

Previous version:

    [RFC/PATCH v3] Better control of the tests run by a test suite
    http://www.mail-archive.com/git@vger.kernel.org/msg48304.html

This version addresses comments by Junio[1] and Eric Sunshine[2].  I think that
they are mostly minor changes.  

[1] http://www.mail-archive.com/git@vger.kernel.org/msg48454.html
    http://www.mail-archive.com/git@vger.kernel.org/msg48455.html

[2] http://www.mail-archive.com/git@vger.kernel.org/msg48463.html

I've replied to those messages. There are two comments from Junio that did not
result in changed.  All the others have been addressed I hope.

Ilya Bobyr (3):
  test-lib: Document short options in t/README
  test-lib: tests skipped by GIT_SKIP_TESTS say so
  test-lib: '--run' to run only specific tests

 t/README         |   85 +++++++++++-
 t/t0000-basic.sh |  419 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 t/test-lib.sh    |  119 +++++++++++++++-
 3 files changed, 611 insertions(+), 12 deletions(-)
