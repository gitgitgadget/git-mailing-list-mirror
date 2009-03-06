From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 0/3] Re: how to have --no-ff be the default for all branch
Date: Fri,  6 Mar 2009 17:15:12 -0500
Message-ID: <cover.1236377358.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	jean-luc malet <jeanluc.malet@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 06 23:17:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfiLj-0006q9-F7
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 23:16:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754881AbZCFWPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 17:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753973AbZCFWPa
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 17:15:30 -0500
Received: from qw-out-2122.google.com ([74.125.92.26]:2047 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792AbZCFWPa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 17:15:30 -0500
Received: by qw-out-2122.google.com with SMTP id 5so793684qwi.37
        for <git@vger.kernel.org>; Fri, 06 Mar 2009 14:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=ZtZImjjIYiaME40c9op6T5gDyAdk1DrfMoI8y8p8G9Y=;
        b=ma8F9yqKKo8YpHJkzRdsrFAonIKSoq3wf4fUv38fXHPSzUGg53rii0w09FrdUPpNg8
         pkfbNiW8T0BMQ6NtgzcI+G0dQEwHRcWNUhpJe+6GSbSLrUAYMUlYPES/6POGOtAciE3V
         N0UwJphZQVKLqzXY6ztR0FKMuGO37VzrnzU3E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=TsRLgTDp2WKhMAE/htWUF4srubjxcWu5C+UrByXWi4VweDdg4tJGItgCZMLRHtEsVL
         HOoSKwBKHFZPiFD1DSjpFZLwVoI1DDJFJIblYz9787HbJNzM5b8Mtm6piotLrznebdks
         yTUGVwF1tHnLzWxleJNVhaCRF1KwRghhfH8u0=
Received: by 10.224.2.82 with SMTP id 18mr4535144qai.262.1236377727975;
        Fri, 06 Mar 2009 14:15:27 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id 6sm1351082qwd.23.2009.03.06.14.15.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Mar 2009 14:15:27 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc2.332.g5d21b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112483>

2009/3/6 jean-luc malet <jeanluc.malet@gmail.com>:
> I would like that it is the default for all branch and that I use --ff
> when I want to do fast forward merge
> I know that I can set it up for one branch
> git config add branch.master.mergeoption --no-ff
> but I want it to be the default no just for one branch but for all branch
> git config add branch.*.mergeoption --no-ff
> don't work....

This series should do it for you. It teaches merge to support
merge.options, which is the default for all merge operations.

Jay Soffian (3):
  config: add git_config_option_string()
  builtin-merge: refactor to use git_config_option_string
  builtin-merge: add support for default merge options

 Documentation/git-merge.txt |   11 +++-
 builtin-merge.c             |   24 +++----
 cache.h                     |    2 +
 config.c                    |   39 ++++++++++++
 parse-options.c             |    2 +
 t/t7600-merge.sh            |  143 ++++++++++++++++++++++++++++++++++++-------
 6 files changed, 182 insertions(+), 39 deletions(-)
