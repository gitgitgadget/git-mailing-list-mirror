From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 00/13] "rerere" minor clean-up
Date: Tue, 30 Jun 2015 23:04:46 -0700
Message-ID: <1435730699-9124-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 01 08:05:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAB8v-00048W-IO
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 08:05:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbbGAGFD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 02:05:03 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:33422 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbbGAGFB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 02:05:01 -0400
Received: by igcur8 with SMTP id ur8so82890657igc.0
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 23:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id;
        bh=kqFTmZ7SSWpdvgDR6jd1XQ9EBBfo37V+qFVLnZI32yg=;
        b=XAfvpwK9IxbxezqF5qB5nQ1X0t1gzbsrb/uwMISEdLby2NiE6b3HnxsnJ1zP2SLjMx
         RMP7O0GFRtEZXhVv5Eewp67fGx2SVGEO72wZbRrcDMZImvB77G6XD807a6eOPbNUfBbz
         /Ameyj7IFG+OiBB2jR5YZlVA/jdeCIN8AKV0FJtKpjbH/2THlPKZ+yJwvI9gcEdKnHLA
         iliSpAtzpHD3Ck+UyaG+qDJOtC+BL/Ji68zgh6dyBpvOIn5mmRZJcWYAu1Kj8hco1BQ2
         ihVzqkzj/hTCMFH3Czmvxvct0i6QtDf3nWv1T8PyOCjOwmqlVx6hb/R4WrBXnphVtf74
         Tilw==
X-Received: by 10.107.31.134 with SMTP id f128mr36294424iof.19.1435730700769;
        Tue, 30 Jun 2015 23:05:00 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:502c:1da0:e16d:2d77])
        by mx.google.com with ESMTPSA id j4sm635289igo.0.2015.06.30.23.05.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Jun 2015 23:05:00 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-rc0-209-g5e1f148
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273117>

Here is an collection of various minor clean-ups in the
implementation of one of my most favourite feature, rerere.

This still hasn't reached the step to make the right refactoring to
allow me to fix a bug I wanted to fix, which prompted me to look at
this code, but it should give me a good starting point.

Junio C Hamano (13):
  rerere: fix an off-by-one non-bug
  rerere: plug conflict ID leaks
  rerere: lift PATH_MAX limitation
  rerere: write out each record of MERGE_RR in one go
  rerere: report autoupdated paths only after actually updating them
  rerere: drop want_sp parameter from is_cmarker()
  rerere: stop looping unnecessarily
  rerere: explain the rerere I/O abstraction
  rerere: explain MERGE_RR management helpers
  rerere: explain the primary codepath
  rerere: explain "rerere forget" codepath
  rerere: explain the remainder
  rerere: refactor "replay" part of do_plain_rerere()

 rerere.c | 389 +++++++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 293 insertions(+), 96 deletions(-)

-- 
2.5.0-rc0-209-g5e1f148
