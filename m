From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add git-edit-index.perl
Date: Thu, 18 Dec 2008 13:40:34 -0800
Message-ID: <7vprjpf9gt.fsf@gitster.siamese.dyndns.org>
References: <20081217204749.GA18261@janet.wally>
 <20081218043734.GD20749@coredump.intra.peff.net>
 <alpine.DEB.1.00.0812181446430.6952@intel-tinevez-2-302>
 <20081218140411.GB6706@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Neil Roberts <bpeeluk@yahoo.co.uk>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 18 22:42:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDQd8-0002K2-LJ
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 22:42:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752266AbYLRVko (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 16:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752227AbYLRVko
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 16:40:44 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52864 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183AbYLRVko (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 16:40:44 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0628A1A979;
	Thu, 18 Dec 2008 16:40:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id F2F191A988; Thu,
 18 Dec 2008 16:40:36 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 85642BBA-CD4C-11DD-A167-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103497>

Jeff King <peff@peff.net> writes:

> On Thu, Dec 18, 2008 at 02:48:39PM +0100, Johannes Schindelin wrote:
>
>> Yes, it is a neat idea.  But I always keep in mind what Junio had to say 
>> about my "add -e" thing (that I use pretty frequently myself): you will 
>> put something into the index that has _never_ been tested.
>> 
>> Would we really want to bless such a workflow with "official" support?

Back in stone ages of git, there wasn't usable tool support to make random
unproven commits, later to be tested separately before releasing.  The old
aversion to committing something that has never existed as a whole in the
work tree comes from those days.

The world has changed quite a bit since then, and I do not think the
argument holds anymore when better tool support for "commit first,
validate and fix-up as needed later" workflow is available.

> That is definitely something to be concerned about. Which is why my
> workflow is something like:
>
>   $ hack hack hack
>   $ while ! git diff; do
>       git add -p
>       git commit
>     done
>   $ for i in `git rev-list origin..`; do
>       git checkout $i && make test || barf
>     done
>
> That is, it is not inherently a problem to put something untested into
> the index as long as you are doing it so that you can go back and test
> later.

Yeah, I do not think there is anything inherently wrong about it, either.
