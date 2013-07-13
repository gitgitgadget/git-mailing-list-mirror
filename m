From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] push: document --lockref
Date: Sat, 13 Jul 2013 13:08:09 -0700
Message-ID: <7vr4f2gr4m.fsf@alter.siamese.dyndns.org>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org>
	<1373399610-8588-1-git-send-email-gitster@pobox.com>
	<1373399610-8588-8-git-send-email-gitster@pobox.com>
	<51DC7199.2050302@kdbg.org> <7vhag3v59o.fsf@alter.siamese.dyndns.org>
	<51DC78C0.9030202@kdbg.org> <7v38rnv0zt.fsf@alter.siamese.dyndns.org>
	<7vvc4jtjqa.fsf@alter.siamese.dyndns.org> <51DF1F56.9000705@kdbg.org>
	<7vzjtspwvo.fsf@alter.siamese.dyndns.org> <51E03B18.5040502@kdbg.org>
	<7vli5bllsd.fsf@alter.siamese.dyndns.org> <51E0605E.9020902@kdbg.org>
	<7vy59biih4.fsf@alter.siamese.dyndns.org> <51E0F93A.8050201@kdbg.org>
	<7vwqougwec.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Jul 13 22:08:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uy67N-0000JF-4h
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jul 2013 22:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758219Ab3GMUIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jul 2013 16:08:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34032 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758213Ab3GMUIN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jul 2013 16:08:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CBC23021E;
	Sat, 13 Jul 2013 20:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GBXBMc+n+oiZBQNqlAUHS4GG//k=; b=Of6RCz
	iB0UWHEC/QBLQC0Ol1swmkCfPKdjs8uBi0U1CGM44CKsK7zygKNKEXtT57SHnHh0
	PJ8hMgwyqL2aYihr2UklKBrozJRT07vLsfFQNGmMbLiKLttwwdE2ZLb1z1kZj336
	puQ+wdUe+3kI2PG10Re9h/v1h7vsd1rXgiwDY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fFJCjTOSgyiyRBieJAW7P7qN0a3TVa0N
	gBJ85yu3c+UhAoFilREKwRmnWEWuH0pmlCoA0LlCp+FfuMWTQgPkQjy64/YcR/U0
	s12Nk5+Y1mEQQ9WyMCzYT/qsSmpUUsUkTNB6hzdNxj1OVO5r1UN18BgqMGcIGpFc
	nAIB4cOGHtM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7EA523021C;
	Sat, 13 Jul 2013 20:08:11 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA33830219;
	Sat, 13 Jul 2013 20:08:10 +0000 (UTC)
In-Reply-To: <7vwqougwec.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 13 Jul 2013 11:14:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F0FC30CE-EBF7-11E2-AF08-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230289>

Junio C Hamano <gitster@pobox.com> writes:

> If "--lockref" automatically implies "--allow-no-ff" (the design in
> the reposted patch), you cannot express that combination.  But once
> you use "--lockref" in such a situation , for the push to succeed,
> you know that the push replaces not just _any_ ancestor of what you
> are pushing, but replaces the exact current value.  So I do not think
> your implicit introduction of --allow-no-ff via redefining the
> semantics of the plus prefix is not adding much value (if any),
> while making the common case less easy to use.
>
>> No; --lockref only adds the check that the destination is at the
>> expected revision, but does *NOT* override the no-ff check.
>
> You _could_ do it in that way, but that is less useful.

Another issue I have with the proposal is that we close the door to
"force only this one" convenience we have with "+ref" vs "--force
ref".  Assuming that it is useful to require lockref while still
making sure that the usual "must fast-forward" rule is followed (if
that is not the case, I do not see a reason why your proposal is any
useful---am I missing something?), I would prefer to allow users a
way to decorate this basic syntax to say:

    git push --lockref master jch pu

things like

 (1) pu may not fast-forward and please override that "must
     fast-forward" check from it, while still keeping the lockref
     safety (e.g. "+pu" that does not --force, which is your
     proposal);

 (2) any of them may not fast-forward and please override that "must
     fast-forward" check from it, while still keeping the lockref
     safety (without adding "--allow-no-ff", I do not see how it is
     possible with your proposal, short of forcing user to add "+"
     everywhere);

 (3) I know jch does not fast-forward so please override the "must
     fast-forward", but still apply the lockref safety, pu may not
     even satisfy lockref safety so please force it (as the "only
     force this one" semantics is removed from "+", I do not see how
     it is possible with your proposal).

So I would understand if your proposal _were_ to

 * add "--allow-no-ff" option;

 * change the meaning of "+ref" to "--allow-no-ff for only this
   ref"; and

 * add a new "*ref" (or whatever new syntax) to still allow people
   to say "--force only this ref".

but we still need to assume that it makes sense to ask lockref but
still want to ensure the update fast-forwards.  I personally do not
think it does [*1*].

The semantics the posted patch (rerolled to allow "--force" push
anything) implements lets "--lockref" to imply "--allow-no-ff" and
that makes it much simpler; we do not have to deal with any of the
above complexity.


[Footnote]

 *1* The assurance --lockref gives is a lot stronger than "must
     fast-forward".  You may have fetched the topic whose tip was at
     commit X, and rebased it on top of X~4 to create a new history
     leading to Y.

           o----o----Y
          /
     o---o----o----o----o----X
	X~4

     When you "git push --lockref=topic:X Y:X", you are requiring
     their tip to be still at X.  Other people's change cannot be to
     add something on top of X (which will be lost if we replace the
     tip of the topic with Y).

     If your change were not a rebase but to build one of you own:

     o---o----o----o----o----X---Y

     your "git push --lockref=topic:X Y:X" still requires the tip is
     at X.  If somebody rewound the tip to X~2 in the meantime
     (because they decided the tip 2 commits were not good), your
     "git push Y:X" without the "--lockref" will lose their rewind,
     because Y will still be a fast-forward update of X~2.
     "--lockref=topic:X" will protect you in this case as well.

     So I think "--lockref" that automatically disables "must
     fast-forward" check is the right thing to do, as we are
     replacing the weaker "must fast-forward" with something
     stronger.  I do not think we are getting anything from forcing
     the user to say "--allow-no-ff" with "+ref" syntax when the
     user says "--lockref".  It is not making it safer, and it is
     making it less convenient.
