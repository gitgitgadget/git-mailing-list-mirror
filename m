From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Re: rebase -i: auto-squash commits
Date: Thu, 18 Jun 2009 01:20:20 -0700
Message-ID: <7vk53aymuz.fsf@alter.siamese.dyndns.org>
References: <e1868cfe0906170506o37a75c35m47f9456bf8ae47c1@mail.gmail.com>
	<43d8ce650906170555m644564b3v3722168f7217c326@mail.gmail.com>
	<7vvdmurfao.fsf@alter.siamese.dyndns.org>
	<20090618063348.6117@nanako3.lavabit.com>
	<alpine.DEB.1.00.0906180007370.26154@pacific.mpi-cbg.de>
	<20090618001111.GB12954@vidovic>
	<7v8wjq2kqc.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.1.00.0906181003300.4848@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	John Tapsell <johnflux@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 18 10:20:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHCrG-0001zJ-MJ
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 10:20:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066AbZFRIUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 04:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbZFRIUU
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 04:20:20 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:42923 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451AbZFRIUT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 04:20:19 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090618082020.QFPL20430.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Thu, 18 Jun 2009 04:20:20 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 5LLM1c0014aMwMQ03LLMcU; Thu, 18 Jun 2009 04:20:21 -0400
X-VR-Score: -200.00
X-Authority-Analysis: v=1.0 c=1 a=BJRVbhqwWo4A:10 a=qxMlQr2f8EPJW-bTgjoA:9
 a=Zq7zSPqFcpqwoRZweFgNlvopk5wA:4 a=_RhRFcbxBZMA:10 a=hiS08hySOk4z9fcu:21
 a=qLMYnL1HG6MC8rqW:21
X-CM-Score: 0.00
In-Reply-To: <alpine.DEB.1.00.0906181003300.4848@intel-tinevez-2-302> (Johannes Schindelin's message of "Thu\, 18 Jun 2009 10\:06\:07 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121810>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 17 Jun 2009, Junio C Hamano wrote:
> ...
>> The commit not only must begin with "squash to " but also there has to 
>> be a matching commit whose message begins with the remainder of the 
>> title of the "squash to" commit _in the range you are rebasing 
>> INTERACTIVELY_.
>> 
>> In addition, the resulting rebase insn is presented in the editor, and 
>> in a rare case where you do have such a commit, you can rearrange it 
>> back.
>
> Well, that really sounds pretty awkward to me.  I regularly call such 
> commits "amend".  If there is a risk I confuse myself as to which commit 
> needs to be amended, I use "amend.<short-hint>".
>
> I'd really rather stay with "fixup".  And as I use single-letter commands 
> quite often, I'd also rather stay away from that magic "!".  And by 
> "magic" I really mean that: people will not find that magic intuitive at 
> all.
>
> My vote is for "fixup".

I am too tired to either make the final judgement nor proposal on this
topic now, but before I forget here is one tangent.

I also often use "magic" commit log message in other occasions.  The most
important is "[DONTMERGE]" prefix to somebody else's commit I queue to
'pu' (or leave unmerged even to 'pu'---just keeping on a topic branch).  I
accept a patch with "am" and then "amend" after review when I find that it
needs more work.  One day I am hoping to write a pre-merge hook that
forbids commits marked with such magic to come into 'next' and down.

The point?

Earlier somebody objected to a command that changes behaviour based on
what is in the commit log message, but for the private commits the patch
under discussion deals with and the ones I mark with "[DONTMERGE]", the
commit log message _is_ the right place to leave a mark for commands to
take notice and act differently.

Of course we _could_ use notes for that, but that won't play well with
rebasing I suppose ...
