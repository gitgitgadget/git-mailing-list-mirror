From: Scott Chacon <schacon@gmail.com>
Subject: [ANNOUNCE] Grack - Rack-based Git Smart-HTTP Handler
Date: Tue, 3 Nov 2009 10:57:53 -0800
Message-ID: <d411cc4a0911031057q652c325ay13dee80c7d9b4606@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 03 19:58:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5OZt-0005yS-LO
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 19:58:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752868AbZKCS5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 13:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752788AbZKCS5t
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 13:57:49 -0500
Received: from mail-pz0-f188.google.com ([209.85.222.188]:34515 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752724AbZKCS5t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 13:57:49 -0500
Received: by pzk26 with SMTP id 26so4144484pzk.4
        for <git@vger.kernel.org>; Tue, 03 Nov 2009 10:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=AHehXBgWNcnMksznFRpck5HeATBr1i+W/psqLmwUmvc=;
        b=b0LTIIoTuxX+a+mhd+EBm1guUwXDH1Cpc8Ok4NbQC9R+eEZEwDYFaSirljh9wnFLp1
         cwdsgfWHOU9L9JBwI8ZY88gCs0DiqJSmrtDMzIbWlcHT61ilYi4ERfT0WFsof3lYZ4LX
         3S4gGQ8lecqa8WJa8d6fysDAkcSrfLIS6Y1EQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=Cn8zr0ALN3ACcGb+MtiAfGhp9annZy1c/sERdIllE/Ahtc60WmxI0E/krfAFjVRo6t
         CpC7Zw+X8AsfTOFBQtHdYvdB5ES1981fF0r/goo/8BrVz3IuJ+aW61vMN4NrvoXMJ1xO
         FLtz2MLD9DyR9P4txtDLecXNZlZFVHWQ3eRP4=
Received: by 10.114.55.40 with SMTP id d40mr369482waa.169.1257274674124; Tue, 
	03 Nov 2009 10:57:54 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131986>

Just a quick note for those of you interested in running a smart-http
server once Shawns series graduates from 'pu' - I don't use Apache and
the provided git-http-backend CGI script only works with Apache
currently (and only CGI-supporting servers in general).  In order to
allow Git smart-http to work through a wider variety of servers, I
wrote a Rack application that does the same things that
git-http-backend does, in case CGI/Apache is not your particular bag
of fun.

Rack (http://rack.rubyforge.org/) is a Ruby webserver interface - you
can write an application for it and it has a bunch of handlers for
common webservers so you can deal with a middleware abstraction rather
than a specific server implementation.  This is nice because it means
the Rack app I wrote that provides (hopefully) identical functionality
to the git-http-backend script can run in the following webservers:

* Just about anything that supports CGI or FCGI
* Mongrel (and EventedMongrel and SwiftipliedMongrel)
* WEBrick
* SCGI
* LiteSpeed
* Thin
* Ebb
* Fuzed
* Phusion Passenger (which is mod_rack for Apache and for nginx)
* Unicorn

You can also generate a WAR file from it (via the Warbler project and
JRuby) that can be loaded into any Java application server (I tested
it on Glassfish, but Tomcat, Websphere, JBoss, Jetty, etc should all
work too).

The project is here:

http://github.com/schacon/grack

I've tested it on a few servers, I'll try to test it on more and
provide example setups for each.  If you use it, please let me know
how things go.

Scott
