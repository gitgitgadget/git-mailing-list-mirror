From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: FW: git via http protocol _and_ a proxy using NTLM authentication
 -- git 1.5.4.2 & curl 7.18.0
Date: Tue, 26 Feb 2008 23:01:49 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0802262254240.13009@yvahk3.pbagnpgbe.fr>
References: <AA28F077645B324881335614E4F7C428034C00@win-ex01.bench.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Ken.Fuchs@bench.com
X-From: git-owner@vger.kernel.org Tue Feb 26 23:02:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU7sh-0001Aw-U2
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 23:02:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763462AbYBZWB6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 17:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763840AbYBZWB6
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 17:01:58 -0500
Received: from kluster1.contactor.se ([91.191.140.11]:45955 "EHLO
	kluster1.contactor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761702AbYBZWB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 17:01:57 -0500
Received: from linux3.contactor.se (linux3.contactor.se [91.191.140.23])
	by kluster1.contactor.se (8.13.8/8.13.8/Debian-3) with ESMTP id m1QM1n9H020460;
	Tue, 26 Feb 2008 23:01:49 +0100
X-X-Sender: dast@linux3.contactor.se
In-Reply-To: <AA28F077645B324881335614E4F7C428034C00@win-ex01.bench.com>
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75180>

On Tue, 26 Feb 2008, Ken.Fuchs@bench.com wrote:

> +       curl_easy_setopt(result, CURLOPT_PROXYAUTH, (long)CURLAUTH_NTLM);
> +       curl_easy_setopt(result, CURLOPT_PROXYUSERPWD,
> +               "<user-id>:<password>");

First, you should rather allow any auth and not just the specific one you 
want.

Then, the userid and password is probably better passed in embedded in the 
proxy URL as that's given on the command line/environment already. Or as 
separate arguments.

> It seems that git fetch (via HTLM proxy) works until
>
>> fatal: Couldn't find remote ref HEAD

Well, the CURLOPT_PROXY is set in transport.c as well which your patch didn't 
address. If that's the case, I figure the verbose output should've shown some 
auth failures with the proxy?
