From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug(let): status reports 'can fast-forward' when not true
Date: Tue, 21 Apr 2009 16:28:26 -0700
Message-ID: <7veivl60yt.fsf@gitster.siamese.dyndns.org>
References: <20090421205352.GA29125@hashpling.org>
 <20090421210233.GB13151@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Charles Bailey <charles@hashpling.org>, git@vger.kernel.org,
	Kjetil Barvik <barvik@broadpark.no>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 22 01:30:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwPPs-0006Ab-Gw
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 01:30:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753466AbZDUX2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 19:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752915AbZDUX2h
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 19:28:37 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56575 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbZDUX2h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 19:28:37 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 783DBACFF0;
	Tue, 21 Apr 2009 19:28:35 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B4291ACFEE; Tue,
 21 Apr 2009 19:28:28 -0400 (EDT)
In-Reply-To: <20090421210233.GB13151@coredump.intra.peff.net> (Jeff King's
 message of "Tue, 21 Apr 2009 17:02:33 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 227F9F3E-2ECC-11DE-9B0C-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117163>

Jeff King <peff@peff.net> writes:

> [cc'ing Kjetil, as this is a fallout of 19de5d6]
>
> On Tue, Apr 21, 2009 at 09:53:52PM +0100, Charles Bailey wrote:
>
>> I was not really thinking when I get fetched, and ran git status on my
>> pu branch. I was told that pu was behind origin/pu by 104 commits and
>> could be fast-forwarded, so I git merged origin/pu and was mildly
>> surprised when git merge made a commit for me.
>> 
>> A quick investigation revealed that pu had (of course) been rewound,
>> but the only commits that it had that the new pu didn't, were merge
>> commits.
>
> I think this is an unintended consequence of 19de5d6
> (stat_tracking_info(): only count real commits, 2009-03-04). It is
> perhaps more useful when seeing the actual numbers to see only the count
> of real commits, but it makes statements like "can be fast-forwarded" no
> longer true.
>
> So I think we need to either:
>
>   1. reword the "can be fast-forwarded" text to something else
>
>   2. revert 19de5d6, since merge commits _can_ be interesting
>
>   3. refactor stat_tracking_info to return "real" and "merge" counts,
>      and change the text for the case of "real == 0 && merge > 0".
>
> -Peff

Let's revert it for now and then try #3 after 1.6.3 final.
