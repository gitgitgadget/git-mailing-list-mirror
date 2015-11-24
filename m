From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv2] git-p4: Handle p4 submit failure
Date: Tue, 24 Nov 2015 07:43:58 +0000
Message-ID: <1448351039-15625-1-git-send-email-luke@diamand.org>
Cc: sunshine@sunshineco.com, Junio C Hamano <gitster@pobox.com>,
	peff@peff.net, egirard@murex.com, larsxschneider@gmail.com,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 24 08:44:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a18Gu-0005Qt-Km
	for gcvg-git-2@plane.gmane.org; Tue, 24 Nov 2015 08:44:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753142AbbKXHoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 02:44:13 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36584 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635AbbKXHoL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 02:44:11 -0500
Received: by pacdm15 with SMTP id dm15so13786755pac.3
        for <git@vger.kernel.org>; Mon, 23 Nov 2015 23:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=GA4sRWDQWpriamhppWtCpfjOk4Mnn9zH/iwKAeowAGI=;
        b=chkA//X64tu9RdnguvHldz4wZtu9n6R9Q6TwUx40Ru7xDlro+e2Ejg/MEKP3z3oFN7
         G1U9ZIxiJwOezWv28RkDFlO92lhWaUesUvfQbaoWWggNkhbGkV7Sz9seRJKYqaJTAdNH
         uceC5fOBCSDlKrDe25mOeqixNJoNyw68+r6X8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GA4sRWDQWpriamhppWtCpfjOk4Mnn9zH/iwKAeowAGI=;
        b=MCdWfXSn5NBx0DprbeWjBPm2yu7q9XV/m/9jxG221kAwuUJNRTm7FjW8j+wBNydSeS
         8bpV/fKT+QgzRYVtDT9dCmUXpw+JO3S1Ek31DnrXjXrwDauhAHnL4kwPrjdp513zCDun
         Vn2BDyJLXazCkJnmpUjSf+F2AiWakGyF2XjE/5X0uKMDiDili84CwWKzfmeFZ7h1+DTf
         IgkQCoXkr6J7jQdyCbJEPrQoL4kYSK/jSGcyaZxJFWqxyemrYxpBjPXAps1GNX9QpjzH
         eI9BVeDwiQuXgrF2X41pU7I2df9hV+72vs1NrqMfgViOIZx3RcxvHPn/ltX18NsCy21Q
         yesQ==
X-Gm-Message-State: ALoCoQmrO1ALk5OyV/xwcziubpCYBjzy8GGPCd9KY7WwwL40zC46kQGBIIXSBahaWD+XjBJGwrbW
X-Received: by 10.66.141.231 with SMTP id rr7mr41177899pab.123.1448351051112;
        Mon, 23 Nov 2015 23:44:11 -0800 (PST)
Received: from lgd-kipper.corp.roku ([216.38.147.4])
        by smtp.gmail.com with ESMTPSA id ij3sm13058078pbb.62.2015.11.23.23.44.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2015 23:44:10 -0800 (PST)
X-Mailer: git-send-email 2.6.3.492.g06488d6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281610>

This is a small reroll of Etienne's earlier patch to clean up
the p4 repo on submit failure.

The only difference is to fix the t9807- test. This test
was trying to remove a file which had already been cleaned
up as a result of this change.

GIRARD Etienne (1):
  git-p4: clean up after p4 submit failure

 git-p4.py                | 71 +++++++++++++++++++++++++-----------------------
 t/t9807-git-p4-submit.sh |  2 +-
 2 files changed, 38 insertions(+), 35 deletions(-)

-- 
2.6.3.492.g06488d6
