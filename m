From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH B v4 0/5] git config: reorganization
Date: Sat, 21 Feb 2009 02:49:24 +0200
Message-ID: <1235177369-2727-1-git-send-email-felipe.contreras@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 21 01:51:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lag5W-0007JC-Lx
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 01:51:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754339AbZBUAte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 19:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754293AbZBUAtd
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 19:49:33 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:40466 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754127AbZBUAtc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 19:49:32 -0500
Received: by mail-bw0-f161.google.com with SMTP id 5so3160875bwz.13
        for <git@vger.kernel.org>; Fri, 20 Feb 2009 16:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=MSG8VkjlazByeMjmDxPzeUE5B9z7leCBg4EX54eO/Jo=;
        b=W6i8UOLBsHQ8qpdyZLjoaiUYYpk89FQLJ3dnSxMexp/37Dx+uy9hoMemhftNJIRnuD
         JyhBsFNGhZjsFslyESORK8AFvS3AJ4PhSBnaAowYxjPnXy9eBmktqYW3gsN6/93BOV7P
         y6vwxX+yfTexZLFI3u8SmM1M3XBD46rguL/EM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=mgHnMf0sg5GKknOlHIZRXhoJySD61bcAHCr0O0KDyXMb83pR5aqPwuFZZRbpwdJZHm
         xoFgNqQI8v8dDw+nGWxc7+07wECG+ZnlpQhakU0aRIldUEPwrDRZ4wjLPLc340nQJNhi
         L4ZXPjf7BTqF5Lt1F3ocM0hbALdzYY+7tXko0=
Received: by 10.181.199.11 with SMTP id b11mr473712bkq.127.1235177371581;
        Fri, 20 Feb 2009 16:49:31 -0800 (PST)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id 22sm5712479fkr.34.2009.02.20.16.49.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Feb 2009 16:49:31 -0800 (PST)
X-Mailer: git-send-email 1.6.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110915>

This patch series is the first of a two parts reorganization for more
maintainability and user friendliness.

The main change is the switch to use parseopt which provides a nicer help usage
dialog. The rest of the changes take advantage of the initial reorganization to
do more strict option parsing.

Felipe Contreras (5):
  git config: reorganize to use parseopt
  git config: don't allow multiple config file locations
  git config: don't allow multiple variable types
  git config: don't allow extra arguments for -e or -l.
  git config: don't allow --get-color* and variable type

 builtin-config.c |  385 +++++++++++++++++++++++++++++++-----------------------
 1 files changed, 223 insertions(+), 162 deletions(-)
