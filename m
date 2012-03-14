From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for push.default
Date: Wed, 14 Mar 2012 20:15:23 +0100
Message-ID: <4F60EE4B.9020803@ira.uka.de>
References: <vpqobs65gfc.fsf@bauges.imag.fr> <1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr> <1331288715.21444.38.camel@beez.lab.cmartin.tk> <4F5A4C45.7070406@xiplink.com> <4F5AF1A8.4050604@alum.mit.edu> <4F5E12A5.6030701@xiplink.com> <vpqzkblixmb.fsf@bauges.imag.fr> <20120312183725.GA2187@sigill.intra.peff.net> <vpqy5r44zg7.fsf@bauges.imag.fr> <7vehswljxi.fsf@alter.siamese.dyndns.org> <4F5F60C5.6020900@ira.uka.de> <7v7gyoxuth.fsf@alter.siamese.dyndns.org>
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
X-From: git-owner@vger.kernel.org Wed Mar 14 20:15:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7tf9-0002Io-Cf
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 20:15:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755331Ab2CNTPC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 15:15:02 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:34120 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753960Ab2CNTPA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Mar 2012 15:15:00 -0400
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1S7tee-00084W-4A; Wed, 14 Mar 2012 20:14:51 +0100
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1S7ted-00076C-Vc; Wed, 14 Mar 2012 20:14:36 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <7v7gyoxuth.fsf@alter.siamese.dyndns.org>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1331752491.371711000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193151>

On 13.03.2012 18:41, Junio C Hamano wrote:
> Holger Hellmuth<hellmuth@ira.uka.de>  writes:
>> If Peff's "push to same branch in a different remote" is a bug (and
>> IMHO it is) it should not count as a reason for what should be the
>> default.
>
> I may phrased it poorly, but I don't think you mean "if the bug is fixed,
> then the behaviour of upstream is simple and easy to understand".  The

I think the behaviour of the whole pull/push system is not easy to 
understand. One has to learn a lot of concepts about git before being 
able to answer the simple question "if I do 'git push' now, what happens?".

Since I am using git without any collaboration I never had much need to 
play around with the whole porcelain remote configuration (cloning and 
using git config was enough). So today I tried to create a bidirectional 
link between a local and a remote branch using only porcelain commands 
(i.e. without using git config directly). Somehow I didn't succeed. I 
can either use git checkout --track or git push -u to make a pull 
connection between the two, but to automatically push I would have to 
create a branch of the same name (and know that this is the magical 
ingredient that makes it work!)

Maybe what is missing is a parameter to git-push that tells git that 
from now on this is what git push should do per default in this branch 
(Similar to what git checkout --track does). This would mean that even 
new users could do most remote configuration with just the knowledge of 
git checkout and git push.

By the way I think I found another "hole" in the porcelain: If you add a 
single branch to follow with git remote add -t <branch> ..., you can't 
add another. A second git remote add -t <otherbranch> ... will be met 
with an error that the remote is already configured. I would have to 
delete the remote and add it again with git add -t <branch> -t 
<otherbranch> ..... Or use a different remote name (which would be 
confusing later on). Did I miss something?
