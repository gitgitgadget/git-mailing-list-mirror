From: "Raimund Berger" <raimund.berger@gmail.com>
Subject: Re: Newbie question regarding 3way merge order.
Date: Sat, 31 Jan 2009 14:14:02 +0100
Message-ID: <87r62jboth.fsf@gigli.quasi.internal>
References: <871vulda2r.fsf@gigli.quasi.internal>
	<20090131095724.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 31 14:15:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTFhB-0006cy-8j
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 14:15:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068AbZAaNOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 08:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751989AbZAaNOJ
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 08:14:09 -0500
Received: from mu-out-0910.google.com ([209.85.134.191]:6749 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930AbZAaNOI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 08:14:08 -0500
Received: by mu-out-0910.google.com with SMTP id g7so637378muf.1
        for <git@vger.kernel.org>; Sat, 31 Jan 2009 05:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:references
         :mail-followup-to:date:in-reply-to:message-id:user-agent
         :mime-version:content-type;
        bh=wdlpPmC9LWnkgKn/cTcmyCjw/1c3Ppmsi1FzzldEm/E=;
        b=uy/8BIcv+u+otu6fsKFxDab4pgaLS9yH4458JHWNNUMq+xDTOkSidfT2L82TK7Lgko
         HelWmqV2Hrip9TZ0oeqlbveRItsarSX9ebtCPA1ldlehnYJqhlwlx+vutXi5Ofj2pVmI
         zSkFDFKNkSu7HLzLZbPMpbD8PBoDpoI5a1uEU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:references:mail-followup-to:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        b=w+zW8naz/4xcGR+ygkagBSXdqYdlkzzBhJZKRo09H4pOHFkY4UnbvqL68B9TRbIRdk
         bLC4ChAKc3sXZWYvPgnnyjzNQpOGTV9dpyK75NxFgsnNwTfobcMZFLC9clr0+lRKAPYE
         UrZ7HMinWX/V+X/1sC8YKFHZqiF9FW/oQa78I=
Received: by 10.103.218.9 with SMTP id v9mr1027060muq.78.1233407645233;
        Sat, 31 Jan 2009 05:14:05 -0800 (PST)
Received: from gigli.quasi.internal (p5DC329D3.dip.t-dialin.net [93.195.41.211])
        by mx.google.com with ESMTPS id e8sm645835muf.30.2009.01.31.05.14.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 31 Jan 2009 05:14:04 -0800 (PST)
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <20090131095724.6117@nanako3.lavabit.com> (Nanako Shiraishi's
	message of "Sat, 31 Jan 2009 09:57:24 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107920>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting "Raimund Berger" <raimund.berger@gmail.com>:
>
>> The question is whether a (3way) merge is commutative, purely in terms
>> of content (i.e. disregarding commit history for now). Iow if no matter
>> in which order I merge A and B, i.e. A into B or B into A, I'd be
>> guaranteed to arrive at the same content.
>
> I think three-way merge of A into B and B into A will produce the same
> result when the merge doesn't conflict (when it does, you will get the
> conflict markers and text from A and B in a different order depending on
> the direction of the merge).
>
>> The reason I ask is obvious I guess. What basically interests me is if I
>> gave a bunch of topic branches exposure on a test branch and, after
>> resolving issues, applied them to stable, that I could be 100% sure to
>> not introduce new issues content wise just by applying merges in a
>> different order or form (rebase, patch set).
>
> I don't think you can make a blanket conclusion like that by only knowing
> that merging A into B and merging B into A would produce the same result.
>
> If you merge topics A, B, and C in this order into your current state O,
> there may not be any conflict, but if you merge the same topics to the
> same current state in different order, C, B and then A for example, you
> may get conflicts that breaks the merge. The commutativeness only says
> that merge of A into O will produce the same result as merge of O into A.
> It doesn't say anything about what would happen when you merge B to O.

That's correct. Strictly speaking one would also have to verify
associativity. I.e. whether merge(merge(A,B),C) == merge(A,merge(B,C))
for all A,B,C.

Thanks for making an implicit point explicit. So a followup question
would be: is git's 3way merge associative?

>From my pov people seem to assume it.
