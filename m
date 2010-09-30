From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 00/16] git-send-email cleanups
Date: Thu, 30 Sep 2010 13:42:53 +0000
Message-ID: <1285854189-10240-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Ryan Anderson <rda@google.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 30 15:43:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1JPz-0000iu-3w
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 15:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756027Ab0I3NnU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Sep 2010 09:43:20 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43294 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754656Ab0I3NnU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 09:43:20 -0400
Received: by wyb28 with SMTP id 28so1857464wyb.19
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 06:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=9U4J1xAxvzAEHlGGfLdeKBAIWeo4gL1V8bPpeIVZeZc=;
        b=A07Kk+pniVBlo/5sPdQ4rWIeyc+qu/xfz7p2sOFtyuCeAhlypJhxEGHFR7lmaD7CB6
         Z6Ew75oNPMjbGYLOp2LjXPcFGVp5MyhnNB5dHShjaeHxETlJtGy+J+cm5BFK9RJVzl6D
         2cGwQOHisOF2qTFX2hI2gNRX4jN0xhDcsDxPw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=VoYxRhqXEA5upS7sJZIzl9fV0xV99KDXisk5cuULGTbjuOftYN0NUAZTmfalSO8Zvw
         KGkBDj7tRBP6iZ4gPJN+g7sENyvysmkq2sjWtJZWoRLWGzQGO4vcmKwFel/oREvDfZmn
         mGI/MIY9+GmvhhecxcK/k/tZvbZL8Fs9mABwY=
Received: by 10.216.231.26 with SMTP id k26mr3057206weq.3.1285854198618;
        Thu, 30 Sep 2010 06:43:18 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e56sm6328567wer.46.2010.09.30.06.43.16
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 30 Sep 2010 06:43:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.159.g610493
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157651>

As threatened here's a series that cleans up some of the glaring warts
in git-send-email.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (16):
  send-email: use lexical filehandle for opendir
  send-email: use lexical filehandles for $compose
  send-email: use lexical filehandles during sending
  send-email: get_patch_subject doesn't need a prototype
  send-email: file_declares_8bit_cte doesn't need a prototype
  send-email: unique_email_list doesn't need a prototype
  send-email: cleanup_compose_files doesn't need a prototype
  send-email: use \E***\Q instead of \*\*\*
  send-email: sanitize_address use $foo, not "$foo"
  send-email: sanitize_address use qq["foo"], not "\"foo\""
  send-email: use (?:) instead of () if no  match variables are needed
  send-email: is_rfc2047_quoted use qr// regexes
  send-email: extract_valid_address use qr// regexes and /o
  send-email: send_message die on $!, not $?
  send-email: make_message_id use "require" instead of "use"
  send-email: use Perl idioms in while loop

 git-send-email.perl   |   80 +++++++++++++++++++++++------------------=
-------
 t/t9001-send-email.sh |    2 +-
 2 files changed, 39 insertions(+), 43 deletions(-)

--=20
1.7.3.159.g610493
