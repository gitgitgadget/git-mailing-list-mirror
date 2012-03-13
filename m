From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for push.default
Date: Tue, 13 Mar 2012 15:59:17 +0100
Message-ID: <4F5F60C5.6020900@ira.uka.de>
References: <vpqobs65gfc.fsf@bauges.imag.fr> <1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr> <1331288715.21444.38.camel@beez.lab.cmartin.tk> <4F5A4C45.7070406@xiplink.com> <4F5AF1A8.4050604@alum.mit.edu> <4F5E12A5.6030701@xiplink.com> <vpqzkblixmb.fsf@bauges.imag.fr> <20120312183725.GA2187@sigill.intra.peff.net> <vpqy5r44zg7.fsf@bauges.imag.fr> <7vehswljxi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 15:59:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7TBs-0002i4-Hm
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 15:59:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755443Ab2CMO7D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 10:59:03 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:35586 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755233Ab2CMO7A (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Mar 2012 10:59:00 -0400
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1S7TBF-0005qM-4h; Tue, 13 Mar 2012 15:58:44 +0100
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1S7TBE-0006qL-Mb; Tue, 13 Mar 2012 15:58:28 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <7vehswljxi.fsf@alter.siamese.dyndns.org>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1331650724.585175000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193030>

On 13.03.2012 14:17, Junio C Hamano wrote:
> that is required to understand it is greater.  Also the current
> implementation of 'upstream' has some weird semantics (or undesigned
> bugs) pointed out by Peff, which would make it even more confusing.

If Peff's "push to same branch in a different remote" is a bug (and IMHO 
it is) it should not count as a reason for what should be the default.

One small point in favor of "current" I haven't seen mentioned: It is 
the smaller/more compatible change from the "matching" behaviour.

The most important point for me in the discussion up till now (because 
it matches my newbie experiences): It doesn't matter that much for new 
users whether "current" or "upstream" is default, because they mostly 
work on master and create branches from local master.

But in that case the typical situation where the default comes into play 
will be when they accidentally are on a branch other than master and try 
to use 'git push'. In that case "current" would push (wrongly) to a 
similar named branch on the remote while upstream would not because the 
local branch would have no upstream configured. Small point in favor of 
"upstream"

The symmetry is what really makes me vote for "upstream". Both 
"upstream" and "current" play to the expectations of new users, 
"upstream" because of the symmetry and "current" because they usually 
expect some connection between branches of the same name in different 
repositories. But only upstream will help those who want to cure git 
push with git pull. And that would be the whole crowd having just a 
whiff of experience with cvs or svn. And if I could take a guess, that 
is the case for the majority of computer science students at a typical 
university (the rest mostly having no experience with version control at 
all)



By the way, the documentation is very confusing in its description what 
git push without parameters does. For example it is not really explained 
in the description or options part, the only explanation is in the 
Examples. There "git push" points to "git push origin" and:
-------------
"git push origin
            Without additional configuration, works like git push origin :.

            The default behavior of this command when no <refspec> is 
given can be configured by setting the push option of the
            remote.
------------

Now the refspec documentation never says anything about what '.' means 
(the only docu about refspecs I could find is in pull-fetch-param.txt 
that is included by git-fetch and git-pull. I thought there was another 
manpage about refspecs but I couldn't find it).
And shouldn't the second sentence above be "... can be configured by 
setting the push.default option of the remote" ?

Is this patchworthy (in that case I'll try to make one) or did I just 
not read at the right places?
