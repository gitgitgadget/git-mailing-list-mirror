From: Thell Fowler <tbfowler4@gmail.com>
Subject: [RFC] Allowing new eof whitelines while still doing whitespace
 trailing-space fix.
Date: Sat, 01 Aug 2009 11:53:44 -0500
Message-ID: <1249145624.2774.16.camel@GWPortableVCS>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 01 18:53:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXHpi-0005VT-1h
	for gcvg-git-2@gmane.org; Sat, 01 Aug 2009 18:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbZHAQxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2009 12:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751814AbZHAQxN
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Aug 2009 12:53:13 -0400
Received: from mail-px0-f179.google.com ([209.85.216.179]:33920 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803AbZHAQxN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Aug 2009 12:53:13 -0400
Received: by pxi9 with SMTP id 9so46407pxi.33
        for <git@vger.kernel.org>; Sat, 01 Aug 2009 09:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=RQcEijeALaSKL4UXSMaWFusCM8RTo/XwQnEMkp5+AkM=;
        b=HW2LZzE3tsEECWceMn9b2ZyeZk4d3Lbu92Al6ETEzDTy71ERAVVtWPXzVeFOXliH7q
         iEYUm3uJnN3kOCJTw4i254Ml4ZMmWV8IUq6l59NHThHIx0JcuZvaZUzvMK3DhrcP4hZG
         qsPb3ntrx7c3LgztW44eW0ubWN0lWTrKEikGs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=VTeKgwEj4iq67k9KFV5kEUogp3dGywh/3YssY7njmKtvjvq31QmtXb0/W6X8H6/a+O
         PCloG7lMeWbpN2E3TaBwGlUChhx0+a8OnCwtHcppA542nxfnm/ZTQUcdRnErYdGb+Qbf
         RbSjqCvNHaKpta+sbHbC2iKBxHgGjsDVGT0QI=
Received: by 10.114.94.14 with SMTP id r14mr5776288wab.74.1249145593277;
        Sat, 01 Aug 2009 09:53:13 -0700 (PDT)
Received: from ?192.168.1.105? (ip70-178-75-143.ks.ks.cox.net [70.178.75.143])
        by mx.google.com with ESMTPS id l27sm7333003waf.55.2009.08.01.09.53.10
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 01 Aug 2009 09:53:11 -0700 (PDT)
X-Mailer: Evolution 2.26.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124637>

As part of a current mirroring project of a dirty upstream repo that has
mixed line endings and leading/trailing whitespace issues it became
apparent that the current trailing-space fixing in ws.c worked
correctly, but the new_blank_lines_at_end processing in builtin-apply.c
would remove the newly fixed line.  Also, as noted in a previous thread,
there are times when adding new whitelines at eof is a needed
capability, yet the desire remains to correct other whitespace issues
within the patch.

The patch in the follow-up post is an attempt to fix that.  This is my
first git-core patch, so please be honest but gentle. :P  If the fix is
of interest I'd be glad to go through the steps of making a test case
and whatever else is needed.
