From: "Nathan Panike" <nathan.panike@gmail.com>
Subject: [PATCH 2/2] Give %as and %cs meaning for pretty format
Date: Thu, 28 Aug 2008 06:09:46 -0500
Message-ID: <d77df1110808280409t561de23ay49741f7088ed1f58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 28 13:11:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYfOx-00006A-Uf
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 13:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752263AbYH1LJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 07:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752234AbYH1LJt
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 07:09:49 -0400
Received: from ag-out-0708.google.com ([72.14.246.249]:63311 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226AbYH1LJs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 07:09:48 -0400
Received: by ag-out-0708.google.com with SMTP id 31so874303agc.10
        for <git@vger.kernel.org>; Thu, 28 Aug 2008 04:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=H/1nmT8xAgW/pVXrfL5fFmCxqV/iozLnUGtr6zv9wY4=;
        b=TRHCRY+3FK5uvWRwlfotPbNamh4BMVsS6UFQ9LByhncqlE23nYWbdJJ8bBi2fCqPWH
         yWgXfEdqHhMVlgYF6bywko5b3ptlKkgfUy0HDRZ/IoqAP3q7TDMXPsHzMaiSQ6sZD32F
         qPLSYbKXCrYhzBBWcZpuqJ4yyytSrVzr81kgk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=Lcj79CuRYdOic9eroFXhU0T+5tKZQn056Ezj7NjTLhrACtFtyp+Vqu1ovvE9Z6CZ18
         7+OFAf8SeiilJWJAuwtuf44xQTlTljCogQrRyuLSorvJrfRouAC2q9vAaY5TcxdB4tBN
         BQWe/kSDmItZF5NNtU9OuzwybmQ9/gyuMnl0g=
Received: by 10.66.240.18 with SMTP id n18mr3203408ugh.60.1219921786793;
        Thu, 28 Aug 2008 04:09:46 -0700 (PDT)
Received: by 10.66.234.6 with HTTP; Thu, 28 Aug 2008 04:09:46 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After this patch, if one does, for example

git log -1 --pretty=format:"%as %h" e83c5163316f89bfb

one gets

2005-04-07 e83c516

and if one does

git log -1 --pretty=format:"%cs %h" e83c5163316f89bfb

one gets

2005-04-07 e83c516

Signed-off-by: Nathan W. Panike <nathan.panike@gmail.com>
---
 pretty.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/pretty.c b/pretty.c
index 33ef34a..b1319a8 100644
--- a/pretty.c
+++ b/pretty.c
@@ -388,6 +388,9 @@ static size_t format_person_part(struct strbuf
*sb, char part,
        case 'i':       /* date, ISO 8601 */
                strbuf_addstr(sb, show_date(date, tz, DATE_ISO8601));
                return placeholder_len;
+       case 's':       /* date, short */
+               strbuf_addstr(sb, show_date(date, tz, DATE_SHORT));
+               return placeholder_len;
        }

 skip:
-- 
1.6.0.1
