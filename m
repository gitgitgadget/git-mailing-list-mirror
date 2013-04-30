From: Steffen Jaeckel <steffen.jaeckel@stzedn.de>
Subject: Re: Unexpected behavior of git-subtree
Date: Tue, 30 Apr 2013 13:13:54 +0200
Organization: Steinbeis Innovationszentrum Embedded Design und Networking
Message-ID: <10210336576.20130430131354@stzedn.de>
References: <1003348467.20130429193427@stzedn.de> <20130429182052.GN472@serenity.lan>
Reply-To: Steffen Jaeckel <steffen.jaeckel@stzedn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Apr 30 13:14:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UX8VU-0003qa-Gq
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 13:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760269Ab3D3LN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 07:13:56 -0400
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:14248 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760023Ab3D3LNz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 07:13:55 -0400
X-RZG-AUTH: :Jm0Bdkutd9+hmApeFfvVItwLAhvERWWdnqr6RNEtsBX+cJj9Jg197xtEQP6NGcQ=
X-RZG-CLASS-ID: mo00
Received: from [192.168.1.7] (pd956be74.dip0.t-ipconnect.de [217.86.190.116])
	by smtp.strato.de (josoe mo39) (RZmta 31.27 AUTH)
	with ESMTPA id q06bcdp3UB77sL ; Tue, 30 Apr 2013 13:13:53 +0200 (CEST)
X-Priority: 3 (Normal)
In-Reply-To: <20130429182052.GN472@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222928>

On Monday, April 29, 2013, 20:20, John Keeping, <john@keeping.me.uk> wrote:
> On Mon, Apr 29, 2013 at 07:34:27PM +0200, Steffen Jaeckel wrote:
>>
>> ---- snip ----
>> sjaeckel@T7400-003 /h/projects/my_project (develop)
>> $ GIT_TRACE=2 git subtree push --prefix=lib/com_lib/ git@git.local:com_lib develop -b develop

> Without knowing much about git-subtree, this looks like the culprit.  A
> quick look at cmd_push in git-subtree.sh indicates that it doesn't check
> for an error return from 'git subtree split --prefix=$prefix', so if
> that goes wrong you end up doing:

>     git push $repository :refs/heads/$refspec

> which deletes the branch.

> Can you try running this:

>     git subtree split --prefix=lib/com_lib/

> and see if that gives the same "fatal: bad object" message as above?

John, thanks for testing!
I just found out that it's all about the slashes....

The solution was:
> git subtree push --prefix=lib/com_lib git@git.local:com_lib develop
look at the missing '/' at the end of the prefix.


Steffen
-- 
Steffen Jaeckel
