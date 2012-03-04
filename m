From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH 2/3] http: try standard proxy env vars when http.proxy
 config option is not set
Date: Sun, 4 Mar 2012 20:19:45 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1203042013410.5351@tvnag.unkk.fr>
References: <4F4CCE8A.4010800@seap.minhap.es> <878vjn8823.fsf@thomas.inf.ethz.ch> <7v62eqzrqm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>,
	git@vger.kernel.org, peff@peff.net, sam.vilain@catalyst.net.nz,
	sam@vilain.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 04 20:20:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4Gyk-0001zl-9I
	for gcvg-git-2@plane.gmane.org; Sun, 04 Mar 2012 20:20:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754765Ab2CDTUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Mar 2012 14:20:15 -0500
Received: from giant.haxx.se ([80.67.6.50]:36908 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754750Ab2CDTUN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2012 14:20:13 -0500
Received: from giant.haxx.se (localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-2) with ESMTP id q24JJm6p020785
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 4 Mar 2012 20:19:48 +0100
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) with ESMTP id q24JJjQL020772;
	Sun, 4 Mar 2012 20:19:45 +0100
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <7v62eqzrqm.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192170>

On Tue, 28 Feb 2012, Junio C Hamano wrote:

>> * Why do you (need to?) support HTTP_PROXY when curl doesn't?
>
> Let me add a third bullet point.
>
> I've heard rumors that libcurl on some versions/installations of Mac OS X 
> deliberately ignores the environment. For those who agree with Apple, it 
> would be a regression if we suddenly start the environment ourselves and 
> using it.

I can also add that in libcurl we completely deliberately do not support 
"HTTP_PROXY" (using all upper case) for a quite simple and boring reason:

The (very old) CGI interface that web servers use(d) to invoke programs 
server-side passes on header values in environment variables named 
"HTTP_[header]". So if you send a request to a server that starts a CGI script 
and use a request header named Proxy: in that request, that header will be 
passed to the CGI script using the environment variable "HTTP_PROXY" ...

-- 

  / daniel.haxx.se
