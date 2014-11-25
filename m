From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH 0/2] git-am: add --message-id/--no-message-id options
Date: Tue, 25 Nov 2014 15:00:54 +0100
Message-ID: <1416924056-29993-1-git-send-email-bonzini@gnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 25 15:01:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtGg2-0007ho-6z
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 15:01:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbaKYOBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 09:01:05 -0500
Received: from mail-wi0-f175.google.com ([209.85.212.175]:55248 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbaKYOBE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 09:01:04 -0500
Received: by mail-wi0-f175.google.com with SMTP id l15so9250682wiw.2
        for <git@vger.kernel.org>; Tue, 25 Nov 2014 06:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=8sMVUgUB4tUGdF4sonbuBk68l6OSjAQoBHvL1v/O9gQ=;
        b=OYpwNGZyY5X4ZCLeyeCiHyvU9MTNxg5fJX/4Vdm8lNCcs8tHOswg+yXQ6GZj3iglgF
         tloBVCaJ03xKVbpD8UwOhMZI59SHb1I7/SDdoNiL/3joyCqcvqTv78jDxIjiyaRkJiiD
         /K22IwpjibiV5aMlUxhCcRhmaiCq6KZwMx0vayrACfPHHZO/VXqHI8UnoRD5MYF8RXO0
         ixyr9ZNPsFR+P6zNgetCsBAZzYY0ewN8J+U5QdIONb3UHBhjBX5CWA8d4xO/r6DTKUGz
         XHQauMeUEG6rp2/G0fnazpfSKNXQqD/r+L9SOW+lYPBwnlAoSRimGzoDi7JFsPYLmesv
         /wtw==
X-Received: by 10.180.84.198 with SMTP id b6mr32087596wiz.41.1416924063276;
        Tue, 25 Nov 2014 06:01:03 -0800 (PST)
Received: from donizetti.redhat.com (net-93-146-133-240.cust.vodafonedsl.it. [93.146.133.240])
        by mx.google.com with ESMTPSA id d5sm2009054wjb.34.2014.11.25.06.01.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Nov 2014 06:01:02 -0800 (PST)
X-Mailer: git-send-email 2.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260218>

From: Paolo Bonzini <pbonzini@redhat.com>

This series adds a --message-id option to git-mailinfo and git-am.
git-am also gets an am.messageid configuration key to set the default,
and a --no-message-id option to override the configuration key.
(I'm not sure of the usefulness of a mailinfo.messageid option, so
I left it out; this follows the example of -k instead of --scissors).

This option can be useful in order to associate commit messages with
mailing list discussions.

If both --message-id and -s are specified, the Signed-off-by goes
last.  This is coming out more or less naturally out of the git-am
implementation, but is also tested in t4150-am.sh.

Paolo Bonzini (2):
  git-mailinfo: add --message-id
  git-am: add --message-id/--no-message-id

 Documentation/git-am.txt       | 11 +++++++++++
 Documentation/git-mailinfo.txt |  5 +++++
 builtin/mailinfo.c             | 22 +++++++++++++++++++++-
 git-am.sh                      | 21 +++++++++++++++++++--
 t/t4150-am.sh                  | 23 +++++++++++++++++++++++
 t/t5100-mailinfo.sh            |  4 ++++
 t/t5100/info0012--message-id   |  5 +++++
 t/t5100/msg0012--message-id    |  8 ++++++++
 t/t5100/patch0012--message-id  | 30 ++++++++++++++++++++++++++++++
 9 files changed, 126 insertions(+), 3 deletions(-)
 create mode 100644 t/t5100/info0012--message-id
 create mode 100644 t/t5100/msg0012--message-id
 create mode 100644 t/t5100/patch0012--message-id

-- 
2.1.0
