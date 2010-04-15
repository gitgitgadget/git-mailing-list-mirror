From: Johannes Gilger <heipei@hackvalue.de>
Subject: Re: git diff/grep add --exclude option
Date: Thu, 15 Apr 2010 20:25:30 +0000 (UTC)
Message-ID: <slrnhsetj6.esr.heipei@dualtron.heipei.net>
References: <1271106125.3031.31.camel@kheops>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 15 22:25:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2VdC-0003yn-EV
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 22:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756701Ab0DOUZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 16:25:41 -0400
Received: from lo.gmane.org ([80.91.229.12]:42544 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756539Ab0DOUZk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 16:25:40 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1O2Vd4-0003tE-KO
	for git@vger.kernel.org; Thu, 15 Apr 2010 22:25:38 +0200
Received: from u-7-112.vpn.rwth-aachen.de ([137.226.103.112])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Apr 2010 22:25:38 +0200
Received: from heipei by u-7-112.vpn.rwth-aachen.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Apr 2010 22:25:38 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: u-7-112.vpn.rwth-aachen.de
User-Agent: slrn/0.9.9p1 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145022>

On 2010-04-12, Sylvain Rabot <sylvain@abstraction.fr> wrote:
> I was surprised to not find an option to exclude file from git diff/grep
> outputs like -x for diff or --exclude for grep. It's too bad because it
> can be really useful.

Yeah, me too, but probably because I never needed it ;) Anyway, there
were some discussions on this before [1]. I thin a viable workaround is
using ls-files and grep. Quick example:

git diff -- $(git ls-files | grep -Ev "(^Documentation|^compat/mingw.c)")

would show everything except the whole Documentation subtree and mingw.c
from compat. Now, you might even whip that into your very own
shellscript or use a git alias (dirty):

[alias]
  ediff = "!sh -c 'git diff -- $(git ls-files | grep -Ev $0)'"

And call it with 
  git ediff "(Documentation|compat/mingw.c)"

Greetings,
Jojo

[1] - http://lists-archives.org/git/708604-how-to-exclude-files-from-git-diff.html

-- 
Johannes Gilger <heipei@hackvalue.de>
http://heipei.net
GPG-Key: 0xD47A7FFC
GPG-Fingerprint: 5441 D425 6D4A BD33 B580  618C 3CDC C4D0 D47A 7FFC
