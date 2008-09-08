From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [RFC] cherry-pick using multiple parents to implement -x
Date: Mon, 08 Sep 2008 09:37:21 +0200
Message-ID: <48C4D631.3010604@gnu.org>
References: <20080907103415.GA3139@cuci.nl> <7vtzcrn9uv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Stephen R. van den Berg" <srb@cuci.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 09:38:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcbKS-0007dn-OZ
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 09:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064AbYIHHhZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 03:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752050AbYIHHhZ
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 03:37:25 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:38873 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbYIHHhY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 03:37:24 -0400
Received: by yx-out-2324.google.com with SMTP id 8so762027yxm.1
        for <git@vger.kernel.org>; Mon, 08 Sep 2008 00:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding:sender;
        bh=VZa6+2uFUVyNioP9wuY7MK3sMBuoKJaTtEzHlToqD5s=;
        b=O1UHzFw9q2Pglqp64b5fMB5L0u1TvETcaQ+RL69oVe7suankvmo5D4NaA58x+HjZJl
         nUbJ1GdkjSWuD0i1Z8OrcTBCKJMCJrP/7FWMOD3vaRp/LZ5SLl+9aKRrggbiCCVJOd4z
         jsCpa6qAW4SjliXkDkFOXgYXJXRlt14tVaOUY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :sender;
        b=nSCsBOJWkyNaZQIaE7mBGdIxMj3B1tMohyQ1uyfqi2/c5gJ3w48uL6G4pwjYkxhuvc
         rBm95CyNguGYw962jILDAriteaDJR8zSq1Q5Sjfhkvjp3SPiYpPRl2YwjHzxlIj99bzj
         yyYncP9QsFs7J7Lhg0P+9ND/b189AI1CWurtw=
Received: by 10.103.245.18 with SMTP id x18mr9969739mur.20.1220859443063;
        Mon, 08 Sep 2008 00:37:23 -0700 (PDT)
Received: from scientist-2.local ( [195.176.178.209])
        by mx.google.com with ESMTPS id j9sm15781160mue.3.2008.09.08.00.37.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Sep 2008 00:37:22 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
In-Reply-To: <7vtzcrn9uv.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95225>

Junio C Hamano wrote:
> "Stephen R. van den Berg" <srb@cuci.nl> writes:
>> The questions now are:
>> - Would there be good reason not to record the backport/forwardport
>>   relationship in the additional parents of a commit?
> 
> In general, I do not think what you did is a good idea.

I agree with this, though I can see the motivation (for example that
git-patch-id, and hence git-cherry, often do not work because of context
changes).

This thread, however, spurred one observation and a question.

Observation: it seems to me that cherry-picking and merging are mutually
exclusive workflows.  You cherry-pick from a development branch to a
stable branch, you merge or rebase in the other direction.  Is this true
in general?  (I can see the obvious exception: you might cherry-pick
that very important bugfix, if you're not ready to do a full merge; but
if you rebase, that commit will go away as soon as you do it).

Question: how are topic branches managed in git.git?  In particular, how
are "graduations to master" done?  Do you cherry-pick the merge commit
that went into "next"?

Paolo
