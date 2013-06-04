From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: git-daemon: needs /root/.config/git/config?
Date: Tue, 04 Jun 2013 21:05:44 +0200
Message-ID: <51AE3A88.2080203@kdbg.org>
References: <20130604141314.GD22308@pomac.netswarm.net> <20130604160815.GB15953@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Ian Kumlien <pomac@vapor.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 04 21:05:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjwYM-0004dy-K6
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 21:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872Ab3FDTFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 15:05:50 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:51735 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750784Ab3FDTFt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 15:05:49 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 6B9F2130055;
	Tue,  4 Jun 2013 21:04:53 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 1460919F5E2;
	Tue,  4 Jun 2013 21:05:44 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <20130604160815.GB15953@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226393>

Am 04.06.2013 18:08, schrieb Jeff King:
> Older versions of git silently ignored errors reading config files, but
> it was tightened in v1.8.1.1, as there can be quite serious implications
> to failing to read expected config (e.g., imagine transfer.fsckobjects,
> or receive.deny* is ignored).
> 
> However, since changing user id and leaving $HOME is so common, there is
> a patch under consideration to loosen the check only for the case of
> EACCES on files in $HOME. That commit is 4698c8f (config: allow
> inaccessible configuration under $HOME, 2013-04-12); it's not yet in any
> released version of git, though.
> 
> In the meantime, the suggested workaround is to set $HOME for the
> git-daemon user, rather than loosening /root.

I've a PHP script in ~/public_html that runs git. Without the mentioned
patch, the script bails out due to this error. This time it's Apache
that gets me into trouble because at the time the PHP script and git
run, $HOME is still /root, but the user identity is not root anymore.
The patch is direly needed; without it, I need to use 'env
HOME=/home/j6t /usr/local/bin/git' in my script.

-- Hannes
