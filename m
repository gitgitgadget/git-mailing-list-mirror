From: Kevin Bracey <kevin@bracey.fi>
Subject: Re: Reset by checkout?
Date: Sat, 31 May 2014 10:27:04 +0300
Message-ID: <53898448.8040105@bracey.fi>
References: <20140531144610.754B.B013761@chejz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Atsushi Nakagawa <atnak@chejz.com>
X-From: git-owner@vger.kernel.org Sat May 31 14:47:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wqigu-0001he-9L
	for gcvg-git-2@plane.gmane.org; Sat, 31 May 2014 14:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756390AbaEaMrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2014 08:47:06 -0400
Received: from mo68.mail-out.ovh.net ([178.32.228.68]:40547 "EHLO
	mo68.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756382AbaEaMrF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2014 08:47:05 -0400
X-Greylist: delayed 12604 seconds by postgrey-1.27 at vger.kernel.org; Sat, 31 May 2014 08:47:05 EDT
Received: from mail173.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo68.mail-out.ovh.net (Postfix) with SMTP id D13F4FFA7BA
	for <git@vger.kernel.org>; Sat, 31 May 2014 09:27:08 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 31 May 2014 09:33:00 +0200
Received: from 62-183-157-30.bb.dnainternet.fi (HELO ?192.168.1.10?) (kevin@bracey.fi@62.183.157.30)
  by ns0.ovh.net with SMTP; 31 May 2014 09:32:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <20140531144610.754B.B013761@chejz.com>
X-Ovh-Tracer-Id: 9631229278703357969
X-Ovh-Remote: 62.183.157.30 (62-183-157-30.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -100
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeejvddrieejucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-Spam-Check: DONE|U 0.538278/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeejvddrieejucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250508>

On 31/05/2014 08:46, Atsushi Nakagawa wrote:
>    `git checkout -B <current-branch-name> <tree-ish>`
>
> This is such an useful notion that I can fathom why there isn't a better,
> first-tier, alternative.q
I'm 100% in agreement. "Reset current branch to X" is an extremely 
common operation, and I use this all the time. But having to actually 
name the current branch is silly, and like you, I'm prone to swapping 
the parameters.

I guess in theory using "checkout" allows fancier extra options like 
"--merge" and "--patch", but I don't think I've ever used those with 
checkout, let alone this mode, where I really do just want a "reset", 
with safety checks.

The original "git reset --hard" used to be a pretty top-level command. 
It was used for aborting merges in particular. But I think it now stands 
out as being one of the only really dangerous porcelain commands, and I 
can't think of any real workflow it's still useful for. Maybe it could 
now be modified to warn and require "-f" to overwrite anything in the 
working tree?

While digging into this, it seems "git reset --keep" is actually pretty 
close to "git checkout -B <current branch>". It certainly won't lose 
your workspace file, but unlike checkout it /does /forget what you've 
staged, which could be annoying. Maybe that could be modified to keep 
the index too?

(I like your alias.become - might try that).

Kevin
