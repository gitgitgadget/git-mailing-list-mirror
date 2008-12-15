From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH v2] git-branch: display sha1 on branch deletion
Date: Mon, 15 Dec 2008 11:23:06 -0600
Message-ID: <urlVZPqgW2MvLyyMWmI_xoDCxnKMd-kyAs1vihhFHBiFmQ3aPtF7Pw@cipher.nrlssc.navy.mil>
References: <AeIdfC6dcUaLaDHDaAdSq8Mxz6QoUdeypSUI24erUEyAHVz4HeTSCw@cipher.nrlssc.navy.mil> <UfCPFu_boLV0ycLKLmOno8GTqmtC4RSZZ9O6aRLGYjmSZOdKv6ywhCjApnplTHLxUIzO8KJ5Mww@cipher.nrlssc.navy.mil> <20081213063104.GA8480@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 15 18:24:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCHBP-0003wQ-4Y
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 18:24:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754339AbYLORXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 12:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754551AbYLORXV
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 12:23:21 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:49786 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754329AbYLORXU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 12:23:20 -0500
Received: by mail.nrlssc.navy.mil id mBFHN7Z9024737; Mon, 15 Dec 2008 11:23:07 -0600
In-Reply-To: <20081213063104.GA8480@coredump.intra.peff.net>
X-OriginalArrivalTime: 15 Dec 2008 17:23:06.0944 (UTC) FILETIME=[CB5B4400:01C95ED9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103187>

Jeff King wrote:
> On Fri, Dec 12, 2008 at 05:20:07PM -0600, Brandon Casey wrote:
> 
>> Make it easier to recover from a mistaken branch deletion by displaying the
>> sha1 of the branch's tip commit.
> 
> This version looks fine to me, but one nit:
> 
>> -     test "$(git branch -d my7 2>&1)" = "Deleted branch my7."'
>> +     sha1=$(git rev-parse my7 | cut -c 1-7) &&
>> +     test "$(git branch -d my7 2>&1)" = "Deleted branch my7 ($sha1)."'
> 
> There is a very very small chance that this sha1 might require more
> than 7 characters to be unique (small because we have such a tiny number
> of objects in the trash repo).

Yeah I was counting on the smallness of that chance to let me be lazy and
not think about how to get the proper abbreviated sha1.

> Maybe:
> 
>   sha1=$(git log --pretty=format:%h -1 my7)
> 
> is better (though I have to admit, if I were writing the test originally
> I would have tested the exit value of "git branch" instead of the
> message).

My feelings won't be hurt if you want to change it.

-brandon
