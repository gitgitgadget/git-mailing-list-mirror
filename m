From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/4] run-command: new check_command helper
Date: Mon,  1 Apr 2013 15:46:40 -0600
Message-ID: <1364852804-31875-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>, Aaron Schrab <aaron@schrab.com>,
	Clemens Buchacher <drizzd@aon.at>,
	David Michael Barr <b@rr-dav.id.au>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 01 23:53:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMmfp-0006O8-Cp
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 23:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758787Ab3DAVxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 17:53:11 -0400
Received: from mail-yh0-f49.google.com ([209.85.213.49]:53512 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757579Ab3DAVxK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 17:53:10 -0400
Received: by mail-yh0-f49.google.com with SMTP id m1so445905yhg.8
        for <git@vger.kernel.org>; Mon, 01 Apr 2013 14:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=Gh2FMn7OudkvHtmUS1zdffsobNg08Ha++sGz8M505uw=;
        b=ZYT3Lonr2FKhxgETmBrP6Khu80bMKeMlrbZ8qTFgR4qtTuKfRV0zwnFL1YB7uYSj1E
         ga8Ie+50W02mWGBVbZ3mdHoaQxhbEV3YzmwKo1jXuER/+OqgaShLUXwBcSkbfjj0lh+E
         X6DA7KOmuJo9G9vwRbHCDj0Spql6tUn/RO2isapKdxGbAkOF5g6ZPr/EO8sEkaJXR6Qv
         aKlGRMnN0ZSFqc+B8V/5l0I9mecFypoa2HBnC+KfbeLtEwcn2nW3dcjdwqIyW7cH2unK
         8DZPsubaPCBBAuuGVtsUgBq+xc0X5RBrpY02lEPh7K5qoRgKDXFD8u87Zf1tkOEl/uoa
         5cWA==
X-Received: by 10.236.223.137 with SMTP id v9mr11608180yhp.166.1364852857091;
        Mon, 01 Apr 2013 14:47:37 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id t27sm30067057yhm.20.2013.04.01.14.47.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Apr 2013 14:47:36 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219717>

Hi,

The first patch does all the work, the second patch uses it; basically, this is
needed so the transport-helper code is able to check if the remote-helper child
is stilll running. Without this support, the status of the remote-helper files
and configuration can end up very badly when errors occur, to the point where
the user is unable to use it any more.

The rest of the patches are for testing purposes only. I ran all the tests with
these, and I didn't see any problems.

Cheers.

Felipe Contreras (4):
  run-command: add new check_command helper
  transport-helper: check if remote helper is alive
  tmp: remote-helper: add timers to catch errors
  tmp: run-command: code to exercise check_command

 git-remote-testgit        | 12 +++++++++++
 run-command.c             | 52 +++++++++++++++++++++++++++++++++++++++++------
 run-command.h             |  6 ++++++
 t/t5801-remote-helpers.sh | 19 +++++++++++++++++
 transport-helper.c        | 11 ++++++++++
 5 files changed, 94 insertions(+), 6 deletions(-)

-- 
1.8.2
