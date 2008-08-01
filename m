From: cte <cestreich@gmail.com>
Subject: Re: linking libgit.a in C++ projects
Date: Thu, 31 Jul 2008 18:17:45 -0700
Message-ID: <ac9f0f090807311817n551f53a5mb1270e6f4b2a058e@mail.gmail.com>
References: <ac9f0f090807310253v1d97e2a1n4ddf34aa4fdc79f0@mail.gmail.com>
	 <20080731105727.GF7008@dpotapov.dyndns.org>
	 <ac9f0f090807310410u461f5584ved74769d8452c539@mail.gmail.com>
	 <bd6139dc0807311127j57d9ab5ckd6acf16d17621614@mail.gmail.com>
	 <ac9f0f090807311444lb2f02e6ud76463b359184fbd@mail.gmail.com>
	 <bd6139dc0807311451t763aa07bsf9474fce4073babd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Dmitry Potapov" <dpotapov@gmail.com>, git@vger.kernel.org
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Fri Aug 01 03:18:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOjI8-0005O8-9P
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 03:18:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753008AbYHABRr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 21:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752841AbYHABRr
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 21:17:47 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:65180 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829AbYHABRq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 21:17:46 -0400
Received: by yw-out-2324.google.com with SMTP id 9so495948ywe.1
        for <git@vger.kernel.org>; Thu, 31 Jul 2008 18:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=8LRy7ixtg6OXs/uficdr+0tN9k7Rmti/q9Y2LsQRUnM=;
        b=v48lx+7dGMNfdektoLVu9S7DKYa02OiY5rdO4fkA2hLUrbVYzdkq8p1nBfViVyNitS
         88VGTmPnniJTUryAadY0RXAlSxzn55STSdhABtxDofs8wmaUQ2/wZxwFH6kJ5lMBAlry
         urzjBG1QYWVTGaleZQLTeir+o/GQKxZOgTVZY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=JWvSgeujDZRx1TWQC2d/wS4BJKo1GOsfs9/Hed6jmTfVFia8LtEMhM65hJQuSPN3lw
         Pqngz7DdaWT9YO6ckbtXYCdQDMrI28E1BzJlco6IIqjjKQ5ct28FDV1+c1jFBBduF1XI
         QhH9Lg1oq05hADrkfkbRx1nKWcRM5AvFnoyZI=
Received: by 10.150.91.17 with SMTP id o17mr2237040ybb.222.1217553465339;
        Thu, 31 Jul 2008 18:17:45 -0700 (PDT)
Received: by 10.151.78.17 with HTTP; Thu, 31 Jul 2008 18:17:45 -0700 (PDT)
In-Reply-To: <bd6139dc0807311451t763aa07bsf9474fce4073babd@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91016>

> On Thu, Jul 31, 2008 at 23:44, cte <cestreich@gmail.com> wrote:
>> Using output from the command line utilities as an API has its own set
>> of problems. For instance, check out some of the difficulties that
>> gitk and qgit have had to deal with:
>> http://kerneltrap.org/mailarchive/git/2007/11/2/379067.
>
> I beg to differ. If I skimmed the topic correctly, the problems there
> were not related to having to parse git's output, but due to the fact
> that '--topo-order' is a post-processing operation, which takes long.
> Do read the recent discussion between Linus and Roman about that.

Didn't mean to imply that somehow it is no longer a post-processing op if you
aren't using git plumbing. The discussion shows, however, that if gitk
was actually
doing the revision traversals, then it would be able to trigger events
that update the
gui whenever it wanted, which would have allowed it to implement the
early output
feature without changing any of the git source. Instead, git-log had
to be altered to
address gitk's needs, and an option was added that users don't
typically use. This is
not exactly what I would consider spartan programming
(http://www.codinghorror.com/blog/archives/001148.html),
plus there are already too many options to remember! Anyways, I
suppose it is pointless
to argue about which approach is better, because both have trade-offs,
and the correct
path depends on your use case.

>>> There is, use the plumbing, forward compatibility is 95% assured. With
>>> the exception of major releases, for which any plumbing
>>> output/behavior changes will be announced in the changelog, usually
>>> including an explanation on how to change your code to match.
>>
>> 95% assured != correct, IMO :)
>
> Why not? Junio has a very good reputation of keeping git backwards
> compatible. The 95% is of course not an actual figure but an
> expression meant to indicate "statement is true, minus a few rare case
> exceptions".

Definitely not questioning his ability to maintain backwards
compatibility; it was
merely an observation about your strange definition of correct. In school, when
I completed 95% of a proof, it was never marked as "correct", and I
was told that I hadn't actually proven anything. Those damn teachers :)
