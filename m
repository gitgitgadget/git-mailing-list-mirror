From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: ambiguous git-log date and timestamp syntax
Date: Sun, 2 Mar 2008 10:40:54 +0100
Message-ID: <200803021040.55252.jnareb@gmail.com>
References: <715587AA-D485-4B31-A786-D26334506007@gmail.com> <200803012326.05698.jnareb@gmail.com> <alpine.LSU.1.00.0803020240390.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Rhodes, Kate" <masukomi@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 02 10:41:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVkhQ-00083G-My
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 10:41:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbYCBJlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 04:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbYCBJlE
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 04:41:04 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:12042 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895AbYCBJkz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 04:40:55 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2974880nfb.21
        for <git@vger.kernel.org>; Sun, 02 Mar 2008 01:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=5tTrOiZTZY2cYI4pNs3SOW/Q4skQJsDC2M7QjBbwtks=;
        b=qckCpdnyntvVDDyAwVnz5EGOyzOXoVK1tiEU+ZI2eJfCtsEgSRp7GrrvkEvYP3t1UwVIQp6rJEcSEz1K2IKFrocYb/LsP7zU6B0M8AfJmK5ljcy6taiUUIoE2wrh2JJoLqrpHmq5N0obLjq4yQH+JwXD5SeBPmUDAWsfDyx9i9c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bFVP1hhSqOX3gHs22sxVVelVVaJw3grK/aHDty6DNfSUIIqDo7QnH/VYUVmpT4wmkMi7pDqV3TEqBvIlM3IrYqp13D+JSByssIS2JomXJobfVurjKjei+7YS7KhkfrZ+lJcPbf3Xj3J15bSDxuhPjwKAUS+w1LzT3ptFakxe8Ao=
Received: by 10.82.148.7 with SMTP id v7mr17170235bud.37.1204450853607;
        Sun, 02 Mar 2008 01:40:53 -0800 (PST)
Received: from ?192.168.1.15? ( [83.8.212.124])
        by mx.google.com with ESMTPS id b33sm20283746ika.5.2008.03.02.01.40.51
        (version=SSLv3 cipher=OTHER);
        Sun, 02 Mar 2008 01:40:52 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LSU.1.00.0803020240390.22527@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75754>

On Sun, 2 Mar 2008, Johannes Schindelin wrote:
> On Sat, 1 Mar 2008, Jakub Narebski wrote:
> 
>> BTW. Git has few other such "reimplementing the wheel" things, like 
>> strbuf, or ALLOC_GROW, or it's own parseopt. I guess main reasons are to 
>> avoid adding yet another dependency, and that existing solutions doesn't 
>> fill all git needs.
> 
> Or that the existing wheels are quadratic wheels, and flat.

That's what I meant by "existing solutions don't fill all git needs".

> Just look at our own parse-options.[ch].  It is _still_ smaller and less 
> difficult to read than GNU getopt.  Yet, it is also much more powerful and 
> easier to use.

I meant here not only 'getopt', but also 'argp' (from libc), or 'popt'
library (used by rpm).

> Likewise, strbuf compares to Bstring, for example (although you might say 
> that Bstring is more powerful, but it comes at a price: it clutters the 
> namespace, and is not as performant as strbuf).

I vaguely recall something of discussion about this.

> ALLOC_GROW() is so small as to not merit any third-party dependency.  

True.

> Also, I'd like to caution that depending on 3rd-party libraries is not 
> always easy: just think about how much pain we suffer from the 
> ever-changing asciidoc package, and the problems wit docbook xsl.

I was rather thinking about something like git "dependency" on libXdiff,
namely having it embedded in git sources, perhaps as submodule, with git
specific improvements / changes / simplifications.


I wonder if it would be worthwhile to extract all those useful codelets
(mini libraries) like approxidate, strbuf, parseopt, ALLOC_GROW, 
list utils, etc. into separate micro-projects, to be able to be used
by other projects, for *them* not to have to reimplement the wheel.

Just a thought...
-- 
Jakub Narebski
Poland
