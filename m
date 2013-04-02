From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 0/4] run-command: new check_command helper
Date: Tue,  2 Apr 2013 04:31:45 -0600
Message-ID: <1364898709-21583-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>, Aaron Schrab <aaron@schrab.com>,
	Clemens Buchacher <drizzd@aon.at>,
	David Michael Barr <b@rr-dav.id.au>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 02 12:33:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMyWg-0002NH-EC
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 12:33:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762007Ab3DBKcp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 06:32:45 -0400
Received: from mail-gg0-f172.google.com ([209.85.161.172]:37543 "EHLO
	mail-gg0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761062Ab3DBKco (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 06:32:44 -0400
Received: by mail-gg0-f172.google.com with SMTP id f4so21843ggn.31
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 03:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=EchpiYBgePc26fbwVOyHJCUxivMBKtOQdeEKnkZhRK0=;
        b=bZUW/Lii5kl6AhCjkklzB56meWCq964sw+djnTXzsv20lffe2P71fxnupHqwT/jXfS
         dDSMMoziiY99LJmV8JXU+S9vvHk1CiGDYpgvT/nAVUTEvF0rB39d2IvioGk6W7mD7yHb
         E4SlO7TKXJ9HBI4BCwwpaFYf4hJjAY8QF9v1FajyyimbeFyVbTjhYRRXirIn5didzx2N
         tGhYp2bXKKsbjDRuWd9yq/+XvrnmqudNR4q+sLnhzVvIFj7FUWrbnricXlk2p1cKDhPB
         DaBYRHq4e/MqmiHU8rDUrSkE+GldobLisAqOlw1DAiANItigTPRGmb8vV4+1fyqyLlyA
         hBhg==
X-Received: by 10.236.179.36 with SMTP id g24mr13865303yhm.90.1364898764202;
        Tue, 02 Apr 2013 03:32:44 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id z12sm2011801yhg.8.2013.04.02.03.32.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Apr 2013 03:32:43 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219762>

Hi,

Here's the second version of the patches incorporating input from Junio and Peff.

The first patch does all the work, the second patch uses it; basically, this is
needed so the transport-helper code is able to check if the remote-helper child
is stilll running. Without this support, the status of the remote-helper files
and configuration can end up very badly when errors occur, to the point where
the user is unable to use it any more.

The rest of the patches are for testing purposes only. I ran all the tests with
these, and I didn't see any problems.

Felipe Contreras (4):
  run-command: add new check_command helper
  transport-helper: check if remote helper is alive
  tmp: remote-helper: add timers to catch errors
  tmp: run-command: code to exercise check_command

 git-remote-testgit        | 12 ++++++++++
 run-command.c             | 58 ++++++++++++++++++++++++++++++++++++++++++-----
 run-command.h             |  5 ++++
 t/t5801-remote-helpers.sh | 19 ++++++++++++++++
 transport-helper.c        | 11 +++++++++
 5 files changed, 99 insertions(+), 6 deletions(-)

-- 
1.8.2
