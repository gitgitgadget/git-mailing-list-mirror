From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH 0/3] fix "git diff --color-words -U0"
Date: Wed, 28 Oct 2009 13:24:29 +0100
Message-ID: <1256732672-11817-1-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Markus Heidelberg <markus.heidelberg@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 13:26:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N37bi-00047W-61
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 13:26:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740AbZJ1M0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 08:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbZJ1M0G
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 08:26:06 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:60166 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712AbZJ1M0G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 08:26:06 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 6E581133B7A68;
	Wed, 28 Oct 2009 13:25:12 +0100 (CET)
Received: from [89.59.65.242] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #314)
	id 1N37aQ-0002WH-00; Wed, 28 Oct 2009 13:25:10 +0100
X-Mailer: git-send-email 1.6.5.2.86.g61663
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX198OfijrXUpjpr+Cm6zOlDULBcVYfM15pku71Co
	ay8kg6w4TTnQMmJwRz4E9ECikMQtRv98BZeE3jSCZJbyipcrE0
	IR+fywF/CCWz+X1RRkSQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131461>

The wrong output roughly is as follows:

@@ -a,b +c,d @@
@@ -e,f +g,h @@
some red, green and black text
more red, green and black text

When it should be:

@@ -a,b +c,d @@
some red, green and black text
@@ -e,f +g,h @@
more red, green and black text


Markus Heidelberg (3):
  t4034-diff-words: add a test for word diff without context
  diff: move the handling of the hunk header after the changed lines
  diff: fix the location of hunk headers for "git diff --color-words
    -U0"

 diff.c                |   40 +++++++++++++++++++++++-----------------
 t/t4034-diff-words.sh |   20 ++++++++++++++++++++
 2 files changed, 43 insertions(+), 17 deletions(-)
