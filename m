From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH] http.c: Use curl_multi_fdset to select on curl fds
 instead of just sleeping
Date: Wed, 2 Nov 2011 20:34:19 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1111022026390.7774@tvnag.unkk.fr>
References: <1320230734-5933-1-git-send-email-mika.fischer@zoopnet.de> <7v62j2js3p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Mika Fischer <mika.fischer@zoopnet.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 02 20:34:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLga0-0006MN-KB
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 20:34:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838Ab1KBTe2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 15:34:28 -0400
Received: from giant.haxx.se ([80.67.6.50]:49820 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750708Ab1KBTe1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 15:34:27 -0400
Received: from giant.haxx.se (localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-2) with ESMTP id pA2JYKXx016811
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 2 Nov 2011 20:34:20 +0100
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) with ESMTP id pA2JYJdI016800;
	Wed, 2 Nov 2011 20:34:19 +0100
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <7v62j2js3p.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184658>

On Wed, 2 Nov 2011, Junio C Hamano wrote:

I'm totally fine with the patch's approach with respect to how it uses libcurl 
and it should be an improvement compared to the previous way.

>> + curl_multi_fdset(curlm, &readfds, &writefds, &excfds, &max_fd);
>
> I couldn't find in http://curl.haxx.se/libcurl/c/curl_multi_fdset.html
> what the version requirement for using this function is, but the same
> comment as above applies here.

That function has been around for as long as the multi interface has, so it 
should be safe to use it just as widely as curl_multi_perform().

> By the way, I think I saw Daniel posting a link to a nicely formatted table 
> that lists each and every functions and CURLOPT_* symbol with ranges of 
> version it is usable, but I seem to be unable to find it.

Right, the document is a bit hard to find and I should figure out a more 
prominent place to link to it. But it can be found here:

https://github.com/bagder/curl/blob/master/docs/libcurl/symbols-in-versions

-- 

  / daniel.haxx.se
