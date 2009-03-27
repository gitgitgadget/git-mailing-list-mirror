From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Make local branches behave like remote branches when
 --tracked
Date: Fri, 27 Mar 2009 09:20:39 -0700
Message-ID: <7v1vsjey3s.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0903201358440.19665@iabervon.org>
 <1238100805-19619-1-git-send-email-git@drmicha.warpmail.net>
 <1238100805-19619-2-git-send-email-git@drmicha.warpmail.net>
 <1238100805-19619-3-git-send-email-git@drmicha.warpmail.net>
 <7vprg3fkw8.fsf@gitster.siamese.dyndns.org>
 <49CC9285.407@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Mar 27 17:22:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnEp5-0004TF-Qo
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 17:22:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758495AbZC0QUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 12:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755941AbZC0QUu
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 12:20:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50707 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758138AbZC0QUt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 12:20:49 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2D4C9A51D4;
	Fri, 27 Mar 2009 12:20:47 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A6414A51D3; Fri,
 27 Mar 2009 12:20:41 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3AAAEE96-1AEB-11DE-BADE-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114909>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Junio C Hamano venit, vidit, dixit 27.03.2009 09:08:
> ...
>> After calling r-f-t, because this new code assumes that for the "." remote
>> (aka "local repository"), r-f-t lies and does not give back what it
>> expects, fixes what it got back from r-f-t.  Shouldn't we be fixing this
>> inside r-f-t?
>
> The technical reason is that there is no local remote, i.e. no remote
> struct for '.', and I don't think we want it, because it would show up
> in all places where the list of remotes is searched/displayed/...
>
> With ret being the branch we talk about, r-f-t is passed ret->remote and
> ret->merge[i] only. In the local case, r-f-t cannot use the remote
> struct for '.' (there is none) to find what it needs, and it has no easy
> access to ret->merge_names[i] which is that info.
>
> branch_get(), on the other hand, has all needed info in place.

Thanks for a detailed explanation.  Would it deserve to be in the commit
log justification in a summarized form?

> ..., even worse: if foo is
> ambiguous because refs/heads/foo and refs/remotes/foo exist then
> refs/heads/foo would win, i.e. we used to output the *wrong* ref. The
> above disambiguates. But I'll see if I can simplify the output based on
> the necessity of disambiguation.

Thanks.
