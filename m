From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 04/13] Teach rebase interactive the mark command
Date: Wed, 30 Apr 2008 08:25:13 +0200
Message-ID: <481810C9.3030409@viscovery.net>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org> <1208132469-26471-3-git-send-email-joerg@alea.gnuu.de> <1208132469-26471-4-git-send-email-joerg@alea.gnuu.de> <7vabjm78v2.fsf@gitster.siamese.dyndns.org> <20080422095549.GB3752@alea.gnuu.de> <alpine.DEB.1.00.0804221127360.4460@eeepc-johanness> <7vy775ygjm.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804221810180.4460@eeepc-johanness> <7v3ap5a4ny.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804290138170.27457@eeepc-johanness> <7vk5ih8ckp.fsf@gitster.siamese.dyndns.org> <4816CA72.8070405@viscovery.net> <alpine.DEB.1.00.0804291147450.27457@eeepc-johanness> <7vk5ig745b.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804292220120.13650@eeepc-johanness> <7viqy05mhp.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804292355060.1
 7469@eeepc-johanness> <7v63u05khw.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804300016130.17469@eeepc-johanness> <7v1w4o3zle.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?ISO-8859-1?Q?J=F6?= =?ISO-8859-1?Q?rg_Sommer?= 
	<joerg@alea.gnuu.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 08:26:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr5lZ-0001Ci-86
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 08:26:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755733AbYD3GZV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 02:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757276AbYD3GZU
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 02:25:20 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:13350 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755610AbYD3GZS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 02:25:18 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Jr5kg-0004kM-Cc; Wed, 30 Apr 2008 08:25:14 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 0C7BC6B7; Wed, 30 Apr 2008 08:25:14 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7v1w4o3zle.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80799>

Junio C Hamano schrieb:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> On Tue, 29 Apr 2008, Junio C Hamano wrote:
>>> Perhaps it would help to go back to the message J6t incompletely quoted, 
>>> and try the example with the parent order of Y swapped (i.e. B == Y^2, C 
>>> == Y^1)
>>>
>>> Recreating X and Y both need to refer to the rewritten B as the 
>>> parameter to "merge" insn.  You create X first then you cannot refer to 
>>> B anymore to recreate Y.  The other way around you cannot name B to 
>>> recreate X.
>> If you refer to "B" as the "short name of the original commit which refers 
>> to the rewritten commit as soon as B was rewritten", then I really do not 
>> see the problem.
> 
> Hmmm.  Perhaps you are thinking about using not just A, B, C but also
> names like X, Y, and Z in the insn sequence?  I was operating under the
> impression that you used only single parent commits to name things, and a
> name will stand for the result of the last operation that used the name
> (e.g. after "pick B", B names the result of cherry-picking the original B
> to detached HEAD).
> 
> 
>                  A
>                 / \
>                /   X
>               /   / \
>              O---B   Z
>               \   \ /
>                \   Y
>                 \ /
>                  C
> 
>             X = checkout A, merge B
>             Y = checkout C, merge B
>             Z = checkout X, merge Y
> 
> I start from Q, create A', B' and C' with:
> 
> 	reset Q
> 	pick A
>         reset Q
>         pick B
>         reset Q
>         pick C
> 
> Then I can recreate X by doing
> 
> 	reset A
>         merge B
> 
> The problem I had was to figure out the way to go back to "rewritten X".
> I assumed you would say "B" because that is the last insn in the sequence
> that used that name.
> 
> But instead you are thinking of letting me just say "X", and somehow make
> the machinery guess by noticing "Ah, original X is a merge between
> original A and B, and we have a merge between rewritten A and rewritten B,
> so we will treat that merge as rewritten "X"?

You had used this notion in your post:

	merge B -- recreate X

Did you mean the '-- recreate X' part as just a comment? I understood it
as part of the instruction, namely to say that the result of the merge is
the rewritten X. In this case you can refer to X in subsequent insns
unambiguously (keep in mind that it is actually the abbreviated SHA1 of
the original merge commit).

-- Hannes
