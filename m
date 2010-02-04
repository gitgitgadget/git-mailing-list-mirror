From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 0/4] gitweb: preliminary notes support
Date: Thu,  4 Feb 2010 17:18:54 +0100
Message-ID: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 17:19:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd4QJ-00070M-MQ
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 17:19:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758291Ab0BDQTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 11:19:11 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:58585 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758245Ab0BDQTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 11:19:09 -0500
Received: by fxm20 with SMTP id 20so2728254fxm.1
        for <git@vger.kernel.org>; Thu, 04 Feb 2010 08:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Faf2+JCiu3gTvClpMuxgX7LlUudFEpZyF13WFnlEGas=;
        b=W/INJUE3gqInBawW8mbxDjbk9z24l3Be+Jd924CgdGaqXcadQe47rrS4DRKrsRGDry
         BCOLEqbZRS91afn/EV+wtB56hY6tYlpGvsVrmFs071qgDH0Eg82EQFUoad30BT9S734F
         iJzkqp428ZJClveN3Td8pYzV7YT1nWnxzKph0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=n4N+r5D64T3UW7uAFuRAqmGLbYHCg9DpXUrojsJRugxEfR8FfPyYFEpr1qAjAUWR2A
         MVNoV+cEtU/JL+UnW3nuxmp7WyNh2AaN0gHjxHJsFbK/RK+2yp9GTl9Kl0NoG5/oK1Jv
         gvqhXYQL4FmbutxT+a+ZEsuivWTRTM1i01Ews=
Received: by 10.223.14.206 with SMTP id h14mr1398274faa.92.1265300348088;
        Thu, 04 Feb 2010 08:19:08 -0800 (PST)
Received: from localhost ([151.60.177.52])
        by mx.google.com with ESMTPS id 19sm563078fkr.48.2010.02.04.08.19.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Feb 2010 08:19:04 -0800 (PST)
X-Mailer: git-send-email 1.7.0.rc1.193.ge8618
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138970>

This small patchset introduces notes support in gitweb.

The feature is designed to be powerful and flexible: any amount of notes
ref spaces can be used, and per-namespace styling is possible.

The implementation is not exactly high-performance, needing no less than
one extra git call per commit per notes ref space (two if a note exist),
and is thus disabled by default.

It's quite likely that appropriate C plumbing in git could speed this
considerably; the current implementation, OTOH, has the advantage of
working even when the git core does not support notes itself.

Giuseppe Bilotta (4):
  gitweb: notes feature
  gitweb: show notes in shortlog view
  gitweb: show notes in log
  gitweb: show notes in commit(diff) view

 gitweb/gitweb.css  |   51 +++++++++++++++++++++++
 gitweb/gitweb.perl |  116 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 166 insertions(+), 1 deletions(-)
