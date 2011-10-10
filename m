From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2] Teach merge the '[-e|--edit]' option
Date: Mon, 10 Oct 2011 00:05:02 -0700 (PDT)
Message-ID: <m3ehyl1g5v.fsf@localhost.localdomain>
References: <7vk48gwvyd.fsf@alter.siamese.dyndns.org>
	<1318023997-54810-1-git-send-email-jaysoffian@gmail.com>
	<7vfwj4tplw.fsf@alter.siamese.dyndns.org>
	<CAG+J_Dzrk5x0+JRC8EbrAxjZE+hD+-5mp+H=F=M8Su2WosPfmg@mail.gmail.com>
	<7v8votpx4n.fsf@alter.siamese.dyndns.org>
	<7vr52lo1m3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 10 09:05:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RD9vF-0002ny-8x
	for gcvg-git-2@lo.gmane.org; Mon, 10 Oct 2011 09:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980Ab1JJHFG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Oct 2011 03:05:06 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44331 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884Ab1JJHFF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Oct 2011 03:05:05 -0400
Received: by bkbzt4 with SMTP id zt4so8109055bkb.19
        for <git@vger.kernel.org>; Mon, 10 Oct 2011 00:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=Kw2QR/N2ZW0SuzYdaYkdWdjgVsKTdNH862gLG6X2K/8=;
        b=nC38htTX5354+Fya8N7lhuo36GmhMFPCtavKeF1sRT4GSAVdF9WZFcChpRlAIaSNfU
         0i6XwAmAVWOukQDFc8yXo4kqjxhcGa1G4JTyKZ2ZbecNWLrJJz7K1XESlnW1W94PUDhi
         /G+83wHYcUdZRHYSHVAGKZXnucrwkEzF6IEZY=
Received: by 10.223.76.11 with SMTP id a11mr25411340fak.1.1318230303781;
        Mon, 10 Oct 2011 00:05:03 -0700 (PDT)
Received: from localhost.localdomain (abvm60.neoplus.adsl.tpnet.pl. [83.8.210.60])
        by mx.google.com with ESMTPS id y8sm29946840faj.10.2011.10.10.00.05.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 10 Oct 2011 00:05:02 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p9A74SVv006217;
	Mon, 10 Oct 2011 09:04:39 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p9A74C5t006189;
	Mon, 10 Oct 2011 09:04:12 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vr52lo1m3.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183229>

Junio C Hamano <gitster@pobox.com> writes:

> By the way, on the other side of this same coin lies another use case
> (different from the one in the footnote in the previous message) for
> "merge --no-commit". When you know that a particular merge _will_ nee=
d
> semantic adjustments, even if it were to textually merge cleanly, you
> would want the command to ask you for help to come up with the final =
tree,
> instead of trusting the clean automerge result. This often happens wh=
en
> the topic branch you are about to merge has changed the semantics of =
an
> existing function (e.g. adding a new parameter) while the branch you =
are
> on has added new callsite to the function (or the other way around). =
In
> such a merge, you would need to adjust the new callsite that does not=
 know
> about the additional parameter to the new function signature.  For ex=
actly
> the same reason, it is not a kosher advice to give to users of modern=
 Git
> to "interfere with the merge with 'merge --no-commit', and then concl=
ude
> with 'commit'", as 'commit' has less information than 'merge' itself =
what
> 'merge' wants to do in addition to recording the result as a 'commit'=
=2E

Yet another issue is if we should blindly trust automatic merge resolut=
ion.
It is considered a good practice by some to always check (e.g. by compi=
ling
and possibly also running tests) the result of merge, whether it requir=
ed
merge conflict resolution or not.

IIRC Linus lately said that making "git merge" automatically commit
was one of bad design decisions of git, for the above reason...

--=20
Jakub Nar=EAbski
