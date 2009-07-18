From: Bodo Schlecht <schlecht@superdigi.de>
Subject: instaweb does not start because of a small syntax error in .git/gitweb/httpd.conf
Date: Sat, 18 Jul 2009 17:08:19 +0200
Message-ID: <4A61E563.7000401@superdigi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 17:19:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSBhB-000651-3y
	for gcvg-git-2@gmane.org; Sat, 18 Jul 2009 17:19:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500AbZGRPTW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2009 11:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752369AbZGRPTV
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jul 2009 11:19:21 -0400
Received: from [95.129.49.49] ([95.129.49.49]:50608 "EHLO mail.superdigi.de"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752165AbZGRPTU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2009 11:19:20 -0400
X-Greylist: delayed 660 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Jul 2009 11:19:20 EDT
Received: from [192.168.178.3] (p57B9C262.dip.t-dialin.net [87.185.194.98])
	by mail.superdigi.de (Postfix) with ESMTPSA id 4E07F9015F
	for <git@vger.kernel.org>; Sat, 18 Jul 2009 17:08:05 +0200 (CEST)
User-Agent: Mozilla-Thunderbird 2.0.0.22 (X11/20090701)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123524>

When I start instaweb with

  git instaweb

I get this error:

  Syntax error on line 8 of /media/disk1part4/Eigene Dateien/superdigi/superdigientwicklung/.git/gitweb/httpd.conf:
  TypesConfig takes one argument, the MIME types config file
  Could not execute http daemon apache2 -f.

Line 8 of /.git/gitweb/httpd.conf reads

  TypesConfig /media/disk1part4/Eigene Dateien/superdigi/superdigientwicklung/.git/mime.types

As you see, there is a space in the path so it should be quotes:

  TypesConfig "/media/disk1part4/Eigene Dateien/superdigi/superdigientwicklung/.git/mime.types"

In all other lines of http.conf the path is correctly in quotes:

  ServerName "git-instaweb"
  ServerRoot "/media/disk1part4/Eigene Dateien/superdigi/superdigientwicklung/.git/gitweb"
  DocumentRoot "/media/disk1part4/Eigene Dateien/superdigi/superdigientwicklung/.git/gitweb"
  PidFile "/media/disk1part4/Eigene Dateien/superdigi/superdigientwicklung/.git/pid"
  Listen 127.0.0.1:4321
  LoadModule mime_module  /usr/lib/apache2/modules/mod_mime.so
  LoadModule dir_module  /usr/lib/apache2/modules/mod_dir.so
  TypesConfig /media/disk1part4/Eigene Dateien/superdigi/superdigientwicklung/.git/mime.types
  DirectoryIndex gitweb.cgi
  LoadModule cgi_module /usr/lib/apache2/modules/mod_cgi.so
  AddHandler cgi-script .cgi
  <Location /gitweb.cgi>
    Options +ExecCGI
  </Location>
