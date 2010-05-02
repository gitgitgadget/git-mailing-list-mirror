From: Will Palmer <wmpalmer@gmail.com>
Subject: [PATCH v4 0/3] pretty: format aliases
Date: Sun,  2 May 2010 12:00:41 +0100
Message-ID: <1272798044-10487-1-git-send-email-wmpalmer@gmail.com>
Cc: wmpalmer@gmail.com, gitster@pobox.com, peff@peff.net,
	jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 02 13:01:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8WvT-0002Nv-S8
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 13:01:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755632Ab0EBLBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 07:01:09 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:62076 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755590Ab0EBLBH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 07:01:07 -0400
Received: by wwb34 with SMTP id 34so1083003wwb.19
        for <git@vger.kernel.org>; Sun, 02 May 2010 04:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=hFVaCN+a8EPgB6jc+bkU2/4FcpYlEqDDF6mOM3yAT5g=;
        b=c3CxlcWAooVMRC4OqA06NAivX3l71nzQxpxD8LzQaQQ5GwtcT1kUk96nK+PS3KGjvN
         X4SBTycXFyMGwCPIYBD7MAA6vFunT7nLV2RKPIq7tCzLYfH5NbzwHUAMYU5UYibZxKUR
         jr7nWRQfWaMn6YFIExi2tFGIHPyMIXMoP0mMA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=wSLGmQOzYJLknOF6ePq5YjgHGcXRRL8cMHB04/UiUJgAWpm46co6QQ06uvsrWI9bi5
         7U4WB67NinT/hFGHIqX82eCOBfmEMx02+Z3sA9vXYr8OXnFQ4AQ+tVeJavTkWYrGHOoC
         pdZN9udG598cZbHB2Z4x+QMjsPbi7VMX9ZjBQ=
Received: by 10.216.157.4 with SMTP id n4mr10197303wek.53.1272798064886;
        Sun, 02 May 2010 04:01:04 -0700 (PDT)
Received: from localhost.localdomain (5acc34b2.bb.sky.com [90.204.52.178])
        by mx.google.com with ESMTPS id b2sm25456649wbb.14.2010.05.02.04.01.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 02 May 2010 04:01:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.13.gbb0a0a.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146160>

The following patch series adds the ability to configure aliases for
user-defined formats. The first two patches add infrastructure for the
ease of adding additional formats, and infrastructure for defining
format aliases, respectively. The final patch adds support for defining
format aliases via a config option.

This is the fourth version of the patch series. The most notable change
from the last iteration is the removal of changes to other pretty-format
options, such as the "conditional colors" patch and "%H/%h --abbrev"
patches. I still think those were good patches, but the %H change in
particular was controversial enough that it would have needlessly stood
in the way of the rest of the series, and '%?C' looked out-of-place in
this series without any other format changes. The removed patches will
be worked on independently and will be submitted separately later.

Jeff King noted an artifact of format.pretty.<name> left in the
documentation, thanks.

Junio asked for a better error message when looped-aliases were found,
so that's been put in.

The copyright notice for the added test has been changed to the standard
boilerplate, because there's no reason to bring politics into a patch.

Most other changes since the last iteration were simple style fixes,
mostly a result of muscle memory from the coding conventions I use at
work, though a couple of things (like not initializing static variables)
were more towards the "you can do that? But my CS teacher in highschool
told me not to!" end of the spectrum. Hopefully I've caught all the
style problems this time.

Will Palmer (3):
  pretty: make it easier to add new formats
  pretty: add infrastructure to allow format aliases
  pretty: add aliases for pretty formats

 Documentation/config.txt         |    9 ++
 Documentation/pretty-formats.txt |    7 ++-
 pretty.c                         |  154 ++++++++++++++++++++++++++++++++------
 t/t4205-log-pretty-formats.sh    |   66 ++++++++++++++++
 4 files changed, 212 insertions(+), 24 deletions(-)
 create mode 100755 t/t4205-log-pretty-formats.sh
