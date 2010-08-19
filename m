From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: t5560-http-backend-noserver.sh fails on FreeBSD 8.1-STABLE
Date: Thu, 19 Aug 2010 15:56:43 +0000
Message-ID: <AANLkTin8KvXBn4R3-_2_wG3B3QU9F1X0Ax69Rrb1cw1y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Tarmigan Casebolt <tarmigan+git@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 19 17:56:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Om7U3-0001sB-DB
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 17:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277Ab0HSP4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Aug 2010 11:56:46 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36626 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824Ab0HSP4p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Aug 2010 11:56:45 -0400
Received: by fxm13 with SMTP id 13so1156908fxm.19
        for <git@vger.kernel.org>; Thu, 19 Aug 2010 08:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=nbDbADK4tP904e0sZ3b0rmxMbWXdq11gzNWldZEGGLU=;
        b=A5umnQ4lrmiLvcl7RnrtA7n1CYid8ayaDGhZDv0H8e5/YmttUEOfPvHMI356WZkF4M
         PCfQuiI0kuQERRyqN7CFm1TzkuOEH7AcmYU45jiJfpYbB/pqPZEO0WIHOmVWD0v9sETE
         O/NcqefCJk67ZFCszBWADr1S+dctfDwNc3USQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=ld4AItkNM4Zcv+dG0K3IEZe3piciEaNL7jgSqzfov+t2L4/XI9KxIdVFys12MB8DBx
         Ra9DaRfiq/IZ2EkCWb4Px6vnscVvcfn1oFu/rBhvH17Wv0JLmdREehbAkcatzgfntJtb
         6FRlk8fCDsLaD5VmspuZaaLE6mxC8LLeDnGAw=
Received: by 10.223.122.146 with SMTP id l18mr9538707far.82.1282233403580;
 Thu, 19 Aug 2010 08:56:43 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Thu, 19 Aug 2010 08:56:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153930>

I haven't investigate this, but here's the failure output:

$ ./t5560-http-backend-noserver.sh --immediate --verbose
[..]
ok 5 - export if git-daemon-export-ok

expecting success:
        log_div "getanyfile true"
        config http.getanyfile true &&
        get_static_files "200 OK"

ok 6 - static file if http.getanyfile true is ok

expecting success:
        log_div "getanyfile false"
        config http.getanyfile false &&
        get_static_files "403 Forbidden"

ok 7 - static file if http.getanyfile false fails

expecting success:
        log_div "uploadpack default"
        GET info/refs?service=git-upload-pack "200 OK"  &&
        POST git-upload-pack 0000 "200 OK"

--- exp 2010-08-19 15:56:14.000000000 +0000
+++ act 2010-08-19 15:56:14.000000000 +0000
@@ -1 +1 @@
-Status: 200 OK
+Status: 404 Not Found
not ok - 8 http.uploadpack default enabled
#
#               log_div "uploadpack default"
#               GET info/refs?service=git-upload-pack "200 OK"  &&
#               POST git-upload-pack 0000 "200 OK"
#
