From: Jay Soffian <jaysoffian@gmail.com>
Subject: git diff timing oddity
Date: Thu, 6 May 2010 01:04:18 -0400
Message-ID: <y2j76718491005052204qb6de9c26k58eb1550f1c5346f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 06 07:04:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9tG6-00066e-GP
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 07:04:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502Ab0EFFEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 01:04:20 -0400
Received: from mail-iw0-f197.google.com ([209.85.223.197]:42533 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710Ab0EFFET (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 01:04:19 -0400
Received: by iwn35 with SMTP id 35so7436427iwn.21
        for <git@vger.kernel.org>; Wed, 05 May 2010 22:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=fSmjRZVA4D30HyKUaH96O9eExhkvS+5rCZ7K+r/a58k=;
        b=MGWhTTbU5Ib0pF37JDFfMX1RhYHAlWFyCm1Z5QvA+SmRqMiaifn6mq2hufjxC2wg40
         zbZJF8oiSHTqB2cEUViBsnFJh3NVKxI/8WBg8DEOW1X5XxDHbo4IEqsA/4QbQgvPVDOX
         BtF3IMNjNTrNGO636LMzoYwtuTmsiOnvWfdsY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=wDhSBKy/AAOYhT1QRPI2q7LoZxfPeSrMC0DfrMY+KQ7xnMIfvQakBJ6cW1wFU7kd+0
         lG0etD9JB1B3oQ5Cma2eEHJvAQHGQjy2+4qP6Np+ZVnndijSNnX5B+/lvQZX7MsWDOtn
         FkamHjKSbwqbcUPHolXh/Nj8u1um6YCrSsGxE=
Received: by 10.231.173.77 with SMTP id o13mr1951719ibz.55.1273122258857; Wed, 
	05 May 2010 22:04:18 -0700 (PDT)
Received: by 10.231.34.8 with HTTP; Wed, 5 May 2010 22:04:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146436>

git version 1.7.1, Mac OS X 10.6.3, largish repo (42K files, 35K
commits, well packed ~ 1GB). Difference between origin and HEAD is a
single commit.

$ time git diff --stat origin  >/dev/null

real	0m0.942s
user	0m0.713s
sys	0m0.223s

$ time git diff --stat origin  >/dev/null

real	0m0.944s
user	0m0.712s
sys	0m0.227s

$ time git diff --stat origin  >/dev/null

real	0m0.944s
user	0m0.712s
sys	0m0.225s

$ time git diff --stat origin HEAD >/dev/null

real	0m0.022s
user	0m0.006s
sys	0m0.012s

$ time git diff --stat origin HEAD >/dev/null

real	0m0.022s
user	0m0.006s
sys	0m0.013s

$ time git diff --stat origin HEAD >/dev/null

real	0m0.023s
user	0m0.006s
sys	0m0.013s

These should be identical commands, so why is the "origin HEAD" form
running an order of magnitude faster?

j.
