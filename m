From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v3] format-patch --signature-file <file>
Date: Sat, 17 May 2014 09:02:21 -0700
Message-ID: <1400342542-11256-1-git-send-email-jmmahler@gmail.com>
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 17 18:02:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wlh4Y-0006q7-3I
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 18:02:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbaEQQCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 12:02:50 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:49257 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932223AbaEQQCt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2014 12:02:49 -0400
Received: by mail-pa0-f54.google.com with SMTP id bj1so3860972pad.13
        for <git@vger.kernel.org>; Sat, 17 May 2014 09:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=fRzQeYD1QO14+Yl923dRR4Ztvq3M8YIoG0ZRNqc3GmA=;
        b=ea8F4z5quP/Atln4ZuA4dp2+PMVVvaS4dbQ83zrF3a8qRIKbLhuIMU9CYaTK3h/PfI
         bTnPFXrMHmNWdobSrKjNG5dPeHS4oj5j66m1yMQ1DR3hpOzag+adJKMkiGheyxLcpZQz
         fRVRwmnE0bENK5H91zInyZC6v43aOZsUSqFbGBXsCzJsum3uFVT7ZOiYXhRgFYRQx44j
         FMgEmfOnUd8mj4Q1BhcTdSHV+/98awd0fPUajuuz4Lh3Yl6qWZ3aG4VnRK2mdRI6poJ6
         YB4uCCXKjr2wWJ6/sTi4XbnXqTk8VJ8R3xnmFK+3qLRsxN9lSktHW7+HIXjZkyepg9mC
         vUlQ==
X-Received: by 10.66.181.70 with SMTP id du6mr29362443pac.23.1400342569180;
        Sat, 17 May 2014 09:02:49 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id yv7sm49585341pac.33.2014.05.17.09.02.45
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 17 May 2014 09:02:47 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Sat, 17 May 2014 09:02:44 -0700
X-Mailer: git-send-email 2.0.0.rc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249486>

v3 patch to add format-patch --signature-file <file> option.

This revision includes changes suggested by Jeff King:

  - Instead of a custom OPTION_CALLBACK, use OPT_FILENAME which
	correctly resolves file names which are not evaluated by the
	shell such as "--signature-file=<file>"

  - Use strbuf_read_file() which eliminates the arbitrary size limit
	and simplifies the code.

  - Generate an error if the file cannot be read instead of quietly
	continuing.  This is accomplished with strbuf_read_file().

  - Die if both --signature and --signature-file are used.

Jeremiah Mahler (1):
  format-patch --signature-file <file>

 Documentation/git-format-patch.txt |  4 ++++
 builtin/log.c                      | 13 +++++++++++++
 t/t4014-format-patch.sh            | 28 ++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+)
