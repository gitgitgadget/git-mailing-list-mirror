From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 0/7] fmt-merge-msg improvements
Date: Wed, 24 Mar 2010 00:15:57 -0700
Message-ID: <1269414964-9518-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 24 08:16:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuKpK-0006lG-TD
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 08:16:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754860Ab0CXHQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 03:16:10 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:44767 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753204Ab0CXHQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 03:16:09 -0400
Received: by gwaa18 with SMTP id a18so1867821gwa.19
        for <git@vger.kernel.org>; Wed, 24 Mar 2010 00:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=pZFx+az9jDWpajOvHUPrMG0bek3dYwhKnR4vMjJ3+GE=;
        b=B8bn7fwbHH2CkWZLVYA5dGlyy2oeG0V92on9XARkGpyPX3CCx0nNzCM8GJ/Wm3BpEw
         RXQrIjsz2NhKCsELEUxgIr+eVHyboScvUnRvC5noEsuvlvPNfq8e5rMSTOiV98Uw5Jj9
         NhK6DqHBjoL8IFt/ARiGY/tiQx8vjyK7yGlMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=q+v2Va3wstzBDlpQ1diGRz3Pk1bPPU6G++lsKdjGG0XrRTwzJh0IEz0E2kuG/LEU2V
         IjWRKndwwPguTwBomPsuznCZgWCkURv5xxwZoYcrgpFElTMA+q6jO3G5MvLlhEAJGBOz
         yjfRbE457NkDKnwX/2XXm2X8hJodOlrOzVBH4=
Received: by 10.150.66.5 with SMTP id o5mr10888301yba.159.1269414966955;
        Wed, 24 Mar 2010 00:16:06 -0700 (PDT)
Received: from localhost (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 22sm5223553iwn.12.2010.03.24.00.16.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Mar 2010 00:16:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3.254.g4503b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143067>

The first one might be considered a bug, although triggering it is
probably impossible. Not much of a price to pay for correctness
though.

The next two patches modernize and update the test a bit.

The next 3 patches try and reduce the code size by libifying(?)
fmt-merge-msg.

The final patch is just a "while I'm here" thing and might be
unnecessary if we decide to just remove the summary option.

Stephen Boyd (7):
  fmt-merge-msg: be quiet if nothing to merge
  t6200: modernize with test_tick
  t6200: test fmt-merge-msg more
  fmt-merge-msg: use pretty.c routines
  string-list: add unsorted_string_list_lookup()
  fmt-merge-msg: remove custom string_list implementation
  fmt-merge-msg: hide summary option

 Documentation/technical/api-string-list.txt |    6 +-
 builtin/fmt-merge-msg.c                     |  159 ++++++++--------------
 string-list.c                               |   13 ++-
 string-list.h                               |    3 +-
 t/t6200-fmt-merge-msg.sh                    |  196 ++++++++++++++++++++++-----
 5 files changed, 235 insertions(+), 142 deletions(-)
