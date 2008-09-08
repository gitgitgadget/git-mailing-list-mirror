From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] cherry-pick using multiple parents to implement -x
Date: Mon, 08 Sep 2008 07:37:01 -0700 (PDT)
Message-ID: <m34p4qpuuu.fsf@localhost.localdomain>
References: <20080907103415.GA3139@cuci.nl>
	<7vhc8rjyxj.fsf@gitster.siamese.dyndns.org>
	<20080908115129.GA19031@cuci.nl> <48C522F6.7090308@gnu.org>
	<20080908134222.GA20998@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Bonzini <bonzini@gnu.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Mon Sep 08 16:38:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kchsg-0005g5-95
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 16:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550AbYIHOhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 10:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbYIHOhG
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 10:37:06 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:9291 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbYIHOhE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 10:37:04 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1500634fgg.17
        for <git@vger.kernel.org>; Mon, 08 Sep 2008 07:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=8TFzzQRMrW3MdQyrZOlHsScHxmFDeMo/AZHqv3OjIeM=;
        b=ZPeS+UyH6Dzwe4Q2LAN7wopWe7jUlGrUAvHBWi9y46CmP/Sh9zSKUWbBnCP2QAjvPn
         xsZ+BnxbbUgb5U3JFZ2jKqSFZQ5HYkogDlzE7AxGy0FxC4bu9wKoyuzEuei6/xumSYkW
         kZP0Aw+Sr+nOflhfthpO9F+Tl0T6xCU1Ch98M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=Z8IDySyiBiDr30viTLm1IVRy+B1hCaJMLBwZtzI/HAzDKi8WlUqLpSEAbsbnw8rnUM
         XButeY3ef8aTyhWqyqwWTho5oe+6fAgPbn1Ss79LclJxJMHn46S1h6QWyeye2C8/J3MO
         ONUzqgkxiMuaW9NxtQIIFQX6UI5jhp7R8Jres=
Received: by 10.86.36.11 with SMTP id j11mr11395310fgj.7.1220884622734;
        Mon, 08 Sep 2008 07:37:02 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.207.55])
        by mx.google.com with ESMTPS id l19sm4573555fgb.7.2008.09.08.07.37.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Sep 2008 07:37:01 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m88Eb0RZ017836;
	Mon, 8 Sep 2008 16:37:00 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m88Eavqg017832;
	Mon, 8 Sep 2008 16:36:57 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080908134222.GA20998@cuci.nl>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95252>

"Stephen R. van den Berg" <srb@cuci.nl> writes:
> Paolo Bonzini wrote:

>>> commit 7df437e56b5a2c5ec7140dd097b517563db4972c
>>> tree a006f20b481d811ccb4846534ef6394be5bc78a8
>>> parent ff1e8bfcd69e5e0ee1a3167e80ef75b611f72123
>>> parent bbb896d8e10f736bfda8f587c0009c358c9a8599
>>> cousin 6ffaecc7d8b2c3c188a2efa5977a6e6605d878d9
>>> cousin a1184d85e8752658f02746982822f43f32316803
>>> author Junio C Hamano <gitster@pobox.com> 1220153499 -0700
>>> committer Junio C Hamano <gitster@pobox.com> 1220153499 -0700
> 
>> What about "origin", and making it propagated through cherry-picks?  In
> 
> "origin" gives a better sense of direction, so maybe that's better, yes.
> 
>> other words, if I "cherry-pick -x" A generating B, and do the same on B
>> generating C, C should have A as origin.  Also, "git cherry-pick -n -x"
>> should add the commit to a list of origins somewhere so that "git
>> commit" can reuse it.
> 
> That is debatable, and should be configurable with a switch.
> It depends on the way of operation, I guess.
> If one picks A -> B, and then B -> C, then usually for C you want B
> to be the origin to indicate that the patch has been tested and shaved
> to fit from A -> B, and further polished to fit from B -> C.
> Usually backporting involves shaving the patch slightly to fit the older
> branch, and in that case it is truly more honest to point back to B
> instead of A from C.  And besides, you can follow the chain to C -> B -> A
> if you like, no information is lost.
> 
>> Furthermore, "git cherry" should use origins if available.
> 
> That is one of the places in git that needs to accomodate the new field,
> luckily the impact on the rest of git-core is rather minimal, I think.

Unfortunately I think it is more complicated than that.

If I understand correctly (please correct me if I am wrong) you meant
'cousin' / 'origin' link to refer only to single commit, and not to
the whole history ending with given commit, as it is in the case of
'parent' link.  One thing to consider is the fact that git is
_snapshot_ based, while cherry-picking is _changeset_ based.  When you
cherry pick commit B to apply on top of commit A, what you do in fact
is to pick (A^..A) or in other syntax (A-A^) change, and apply it on
top of A.  So cherry picked B, let's denote it by B', is in fact
C'=(A-A^).  For example having only commit A is not enough to replay
cherry-picking.

Second, unless such header would be for informational purposes only
(there was even proposal to add generic 'note <sth>' informational
only header, but it was shot down; see the archives), you would have
to do quite a bit of surgery to revision walking code.  For example
you would have to think about how commits pointed by 'origin' header
would be protected against pruning; if you allow to prune parents of
grandparents of cherry-picked commits, you would break I think a lot
of assumptions in the code, and assumption in git design that if we
have commit, then all that it references should be available (well,
there are grafts, and there is shallow clone, but those modify
reachability...).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
