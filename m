From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCHv5 2/6] Gitweb: add support for minifying gitweb.css
Date: Tue, 13 Apr 2010 21:28:32 +0100
Message-ID: <4BC4D3F0.5020107@hashpling.org>
References: <4BB430C3.9030000@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Mark Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Tue Apr 13 22:28:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1mj8-0000fe-Rr
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 22:28:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753762Ab0DMU2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Apr 2010 16:28:34 -0400
Received: from relay.ptn-ipout01.plus.net ([212.159.7.35]:8074 "EHLO
	relay.ptn-ipout01.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753615Ab0DMU2c (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Apr 2010 16:28:32 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAPVwxEtUXebz/2dsb2JhbACbRXG+DYUNBINE
Received: from relay02.plus.net ([84.93.230.243])
  by relay.ptn-ipout01.plus.net with ESMTP; 13 Apr 2010 21:28:30 +0100
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by relay02.plus.net with esmtp (Exim) id 1O1mij-0003VI-Qs; Tue, 13 Apr 2010 21:28:29 +0100
Received: from heisenberg2.hashpling.org ([192.168.76.29])
	by hashpling.plus.com with esmtp (Exim 4.69)
	(envelope-from <charles@hashpling.org>)
	id 1O1mij-0006Z6-Km; Tue, 13 Apr 2010 21:28:29 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.2; en-GB; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <4BB430C3.9030000@mailservices.uwaterloo.ca>
X-Plusnet-Relay: 6989e1276e8ccdf59a577dc557e5c190
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144831>

On 01/04/2010 06:36, Mark Rada wrote:
> @@ -84,13 +92,14 @@ endif
>
>   all:: gitweb.cgi
>
> +FILES = gitweb.cgi
>   ifdef JSMIN
> -FILES=gitweb.cgi gitweb.min.js
> -gitweb.cgi: gitweb.perl gitweb.min.js
> -else # !JSMIN
> -FILES=gitweb.cgi
> -gitweb.cgi: gitweb.perl
> -endif # JSMIN
> +FILES += gitweb.min.js
> +endif
> +ifdef CSSMIN
> +FILES += gitweb.min.css
> +endif
> +gitweb.cgi: gitweb.perl $(GITWEB_JS) $(GITWEB_CSS)
>

I have a question about this last line of the patch. Are GITWEB_JS and 
GITWEB_CSS supposed to be a source path or a URI?

The documentation for install (and my previous assumption) was that they 
represented the path on the target web server. I'm used to overriding 
them so that gitweb.cgi can live in my /cgi-bin directory, but the 
static files are served from /gitweb which is readable but not executable.

After this patch I had to removed $(GITWEB_JS) and $(GITWEB_CSS) from 
the list of dependencies for gitweb.cgi otherwise make failed.

Have I got the wrong end of the stick?

Thanks,

Charles.
