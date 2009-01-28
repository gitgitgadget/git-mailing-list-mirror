From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2] gitweb: make static files accessible with PATH_INFO
Date: Wed, 28 Jan 2009 01:20:38 +0100
Message-ID: <200901280120.38985.jnareb@gmail.com>
References: <1232973937-23875-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 01:22:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRyBx-0002vN-UL
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 01:22:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbZA1AUl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 19:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbZA1AUl
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 19:20:41 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:23792 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375AbZA1AUk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 19:20:40 -0500
Received: by fg-out-1718.google.com with SMTP id 13so336809fge.17
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 16:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=VRT0OEApoeZOYPERF7ddu0i1FA/cPu5vxO0WKt9CaD8=;
        b=nLlY8P4nOL3xegVWBzZy4WsvyCkLQnwfTM8F/w7Gmh1Hb5Ea828aGlNWST5rAyJHn3
         g3J3hc1Uh6rDxN8OAGM9LHeLhUBWRuZRJKsnsR3BOjQdZOiGICJr3/moyLa0Citq2AIA
         givqCZdl7jJXTKwyHx8TtiMaVudvmb4hF2ctQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ql1eL/nnz9P4OUjORxLpN37WdxnP89f7lqo/KMfIW1K3YvbD3BkgnaG3MzCCTyicAB
         OkR9s37cvmkJYg6mKjRlk6n1vf/Exnazrd9yi015uVeA3ksRgjCYquY3B/TpBP8tfV48
         +qV9/SYU+iNl7anyUar5xBmTwqVaqnaSWfxtI=
Received: by 10.86.60.14 with SMTP id i14mr328854fga.21.1233102038695;
        Tue, 27 Jan 2009 16:20:38 -0800 (PST)
Received: from ?192.168.1.15? (abvq8.neoplus.adsl.tpnet.pl [83.8.214.8])
        by mx.google.com with ESMTPS id 4sm2591202fge.25.2009.01.27.16.20.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Jan 2009 16:20:37 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1232973937-23875-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107432>

On Mon, 26 Jan 2009, Giuseppe Bilotta wrote:

> It's sick that $cgi->url() has no way to print the script base url
> without path_info information (or that, if it has, it's very well
> hidden).

Actually:

http://localhost/cgi-bin/gitweb/printenv.cgi/path/info?query=a;string=b;c=c;c=a

url(-absolute=>1)  = /cgi-bin/gitweb/printenv.cgi
url(-relative=>1)  = /cgi-bin/gitweb/printenv.cgi
url(-full=>1)      = http://localhost/cgi-bin/gitweb/printenv.cgi
url(-path_info=>1) = http://localhost/cgi-bin/gitweb/printenv.cgi/path/info
url(-query=>1)     = http://localhost/cgi-bin/gitweb/printenv.cgi?query=a;string=b;c=c;c=a
url(-base=>1)      = http://localhost 

$ENV{'SCRIPT_NAME'} = /cgi-bin/gitweb/printenv.cgi
$ENV{'PATH_INFO'}   = /path/info

With CGI.pm version 3.10
-- 
Jakub Narebski
Poland
