From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 4/3] gitweb: Update README that gitweb works better with PATH_INFO
Date: Sun, 1 Feb 2009 22:37:45 +0100
Message-ID: <200902012237.46837.jnareb@gmail.com>
References: <1233365512-7130-1-git-send-email-giuseppe.bilotta@gmail.com> <1233365512-7130-3-git-send-email-giuseppe.bilotta@gmail.com> <1233365512-7130-4-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	bug-CGI.pm@rt.cpan.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 01 22:39:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTk2G-0007Wt-9N
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 22:39:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752915AbZBAVh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 16:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752218AbZBAVh6
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 16:37:58 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:29678 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbZBAVh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 16:37:57 -0500
Received: by fg-out-1718.google.com with SMTP id 16so445820fgg.17
        for <git@vger.kernel.org>; Sun, 01 Feb 2009 13:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=2BgXnK5fMVVLerIuDyCkMCYy5d5VV36BVugPSSrMvec=;
        b=lzaUYarCSF3KlhQlb/MMX7kwuwsDLqihhgwSWWM6HVAbalBjt/x2bw3FikHRDgpa4p
         FlIYoyRzZ8gGiq8iVfLjjhk/XeRcPjGtIcEiOhnMy5nGkx+2kBx7CbMBvJiQGE/Ae/O7
         uMb3vs/4Wo1z+jf1E06kili5+wG5+HHnAJG8E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Dh+sE40gRkWVJWPQA3CxjD6uS8FKux4UgA4RqN+qalkTxB+bi2AY0yE05L6oFunTn5
         Whq3jUSFacjwQEKUBi2XnqlLvJOq5IW97JV7FsVwhOsUimt7jrAV7KlSrBfBgqcjl8mG
         j8o3xpT3CA6tU9ZJCEjn/f5APom1Nkf9YOnZU=
Received: by 10.86.97.7 with SMTP id u7mr703983fgb.8.1233524275290;
        Sun, 01 Feb 2009 13:37:55 -0800 (PST)
Received: from ?192.168.1.13? (abwv210.neoplus.adsl.tpnet.pl [83.8.245.210])
        by mx.google.com with ESMTPS id 3sm2607984fge.52.2009.02.01.13.37.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 01 Feb 2009 13:37:54 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1233365512-7130-4-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108010>

One had to configure gitweb for it to find static files (stylesheets,
images) when using path_info URLs.  Now that it is not necessary
thanks to adding BASE element to HTML head if needed, update README to
reflect this fact.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is update of gitweb/README to fit state after Giuseppe patches.

There is a little problem either with terminology, or with CGI.pm
module itself. RFC 1808 "Relative Uniform Resource Locators" says
that:
  http://git.example.com/cgi-bin/gitweb.cgi  is absolute URL
  /cgi-bin/gitweb.cgi                        is relative URL
                                            but absolute path
  gitweb.cgi                                 is relative URL
                                            and relative path

while CGI.pm (or, to be more exact, its url() method) says:

  url() or url(-full)  returns http://git.example.com/cgi-bin/gitweb.cgi
  url(-absolute)       returns /cgi-bin/gitweb.cgi
  url(-relative)       returns gitweb.cgi (or /cgi-bin/gitweb.cgi)

That is why I used "Full URL"  for $my_url = $cgi->url();
and "absolute URL" (as before) for $my_uri = $cgi->url(-absolute);
in gitweb/README.

 gitweb/README |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/gitweb/README b/gitweb/README
index 52ad88b..a9dc2e5 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -162,14 +162,12 @@ not include variables usually directly set during build):
    $GITWEB_LIST during installation.  If empty, $projectroot is used
    to scan for repositories.
  * $my_url, $my_uri
-   URL and absolute URL of gitweb script; you might need to set those
-   variables if you are using 'pathinfo' feature: see also below.
+   Full URL and absolute URL of gitweb script;
+   in earlier versions of gitweb you might have need to set those
+   variables, now there should be no need to do it.
  * $home_link
    Target of the home link on top of all pages (the first part of view
-   "breadcrumbs").  By default set to absolute URI of a page; you might
-   need to set it up to [base] gitweb URI if you use 'pathinfo' feature
-   (alternative format of the URLs, with project name embedded directly
-   in the path part of URL).
+   "breadcrumbs").  By default set to absolute URI of a page ($my_uri).
  * @stylesheets
    List of URIs of stylesheets (relative to base URI of a page). You
    might specify more than one stylesheet, for example use gitweb.css
-- 
1.6.1
