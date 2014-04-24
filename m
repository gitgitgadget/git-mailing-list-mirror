From: Ivo Bellin Salarin <ivo.bellinsalarin@gmail.com>
Subject: GIT, libcurl and GSS-Negotiate
Date: Thu, 24 Apr 2014 19:17:36 +0200
Message-ID: <CAPc4eF__gWMy=E-8tdpMn_irA4m7mYF3=cwN6JeAqJsdPshNLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 24 19:17:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdNHK-0001e7-GR
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 19:17:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754057AbaDXRRi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 13:17:38 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:46990 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753581AbaDXRRh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 13:17:37 -0400
Received: by mail-oa0-f43.google.com with SMTP id eb12so2983562oac.30
        for <git@vger.kernel.org>; Thu, 24 Apr 2014 10:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=3VDuX7R7SwFWTi0oZkt+qPqLAijGYG1j1XOjzcglUYY=;
        b=XpM4BeLMPkUbCUO26d6tlc/I6MBrSmKI0EHs1O7nKgPs1T6hLvqT4x2eUZCDzTXI6i
         8EHL49oh2SvLZNqa6Xt18A/OG0tZVvob3+/3euQCvDGXFX+dFQZX3YIhjWvZZ/cSUgOR
         zhYEx5Hr/bldJH6d0pdb/W/mp8X6f3P8rlbSgoRKU/D/jvq2THb2Jb/f0iGTbWM9d260
         vsiSIUfd9uQchqFLEDlbZa1cy9Wnqv7miHDP6JMaJQIfGVuzYe8pYfd9i/a3G4Ux1Yss
         QoRNkOxkgb/MBbLXcrMKbZkUUN7J+mqX9AVROdak5jQab2QuHzv3yyOOSBzuC+ioSWp5
         riKQ==
X-Received: by 10.60.155.72 with SMTP id vu8mr2511046oeb.60.1398359856368;
 Thu, 24 Apr 2014 10:17:36 -0700 (PDT)
Received: by 10.76.0.200 with HTTP; Thu, 24 Apr 2014 10:17:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246978>

Hello,

I'm having problems while trying to authenticate against a TFS hosted
repository.

I experience the same problem in git for windows and in git for linux
(both versions are 1.9.2).

The problem is described on a [github msysgit/git
issue](https://github.com/msysgit/git/issues/171)

To shortly resume it, the problem is that:
* when the authentication method (WWW-Authenticate) is Negotiate AND
* when the server proposes a NTLMSSP_CHALLENGE in response of the
client's NTLMSSP_NEGOTIATE,
=> libcurl yields an "Authentication problem. Ignoring this.\n"
And the communication is closed.

At this point, in a normal communication, the client should send a
NTLMSSP_AUTH containing a Kerberos ticket.

Having seen the libcurl source code, I think we're passing through the
lines  from 776 to 780 of
[http.c](https://github.com/bagder/curl/blob/2e57c7e0fcfb9214b2a9dfa8b3da258ded013b8a/lib/http.c).
Some guy, on the github issue page, has suggested that this could be
related to an update of libcurl, when git was at its 1.8.2 version.

I'm not debugging libcurl, and I can't reproduce this problem @home.
So, has somebody already experienced the same problem? Is there a
solution?

Many thanks in advance,
Ivo
-- 
http://www.nilleb.com
