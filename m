From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC GSoC 2009: git-submodule for multiple, active developers
 on  active trees]
Date: Wed, 01 Apr 2009 08:26:15 +0200
Message-ID: <49D30907.6090606@op5.se>
References: <526944450903251314o622711b5u3665bac90398d6be@mail.gmail.com>  <20090330153245.GD23521@spearce.org>  <526944450903310830q5f56fe82xb64ae8dc3c954ffb@mail.gmail.com>  <alpine.DEB.1.00.0903311749160.7052@intel-tinevez-2-302>  <526944450903311532u24eb74fby1f558c1bef5c653a@mail.gmail.com>  <alpine.DEB.1.00.0904010058490.6616@intel-tinevez-2-302> <526944450903311649q358d43edkf07e2e5058a9e527@mail.gmail.com> <alpine.DEB.1.00.0904010247170.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: P Baker <me@retrodict.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 01 08:27:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LotvW-0002JJ-B6
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 08:27:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755456AbZDAG0X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 02:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755352AbZDAG0X
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 02:26:23 -0400
Received: from mail.op5.se ([193.201.96.20]:55152 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755037AbZDAG0W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 02:26:22 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 0635B1B80F21;
	Wed,  1 Apr 2009 08:03:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dtmpyfEzBTAv; Wed,  1 Apr 2009 08:03:51 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.14])
	by mail.op5.se (Postfix) with ESMTP id BACDC1B80F1A;
	Wed,  1 Apr 2009 08:03:50 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <alpine.DEB.1.00.0904010247170.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115340>

Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 31 Mar 2009, P Baker wrote:
> 
>> I'll paraphrase to see if I understand your points:
>>
>> *Moving objects from submodule .git directories into the base .git/
>> directory would protect the submodules and is a good idea.
> 
> No, I did not say that.
> 
> I said that moving submodules' working directory need to protected when 
> renaming/deleting submodules.
> 
> Even worse, I think that moving the .git/ directory into the 
> superproject's .git/ would be at least quite a bit awkward in the nested 
> case.
> 

Not necessarily. The .git directory of a submodule need not be named .git
inside the superprojects .git directory. I could well imagine something
like this:

.git/modules/submod(.git)/modules/nested-submod(.git)

For deeply nested submodules (eurgh), one might run into path length limit
issues though. The point is that we will need some library-like function
to find the repository of the submodule. Once that's done, the same call
with a different $gitdir should be able to find the nested submodule.

I'm also thinking of libgit2 here, where each repository will be
represented as a struct that must be passed to the various $gitdir
searching functions. This is necessary to allow a single program to access
multiple repositories, and the .git/modules scheme makes supporting
submodules in the library quite trivial.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
