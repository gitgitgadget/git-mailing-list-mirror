From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/3] Support multiple virtual repositories with a
 single object store and refs
Date: Tue, 24 May 2011 18:21:00 -0700
Message-ID: <7vr57n60eb.fsf@alter.siamese.dyndns.org>
References: <1306284392-12034-1-git-send-email-jamey@minilop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Josh Triplett <josh@joshtriplett.org>
To: Jamey Sharp <jamey@minilop.net>
X-From: git-owner@vger.kernel.org Wed May 25 03:21:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QP2mq-0007m6-QU
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 03:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754725Ab1EYBVR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 May 2011 21:21:17 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37800 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754658Ab1EYBVR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 May 2011 21:21:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D733B57C2;
	Tue, 24 May 2011 21:23:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=DbwIrtM6SbVC
	nUEHT4aokoAWIfU=; b=OWqtdqiTemzgWwo/pxi6TEjAEw+zGQ6ly3MvCDpyAZML
	yQcMbkATnPvRndD/BHu5cCCk24f5zRlgRL902qs9JmmupO6bERDeN2IOYbx1ugZz
	CLSyErfmiTfWgLE0Q49B7F5edGrYmwT4g+iY0qY3+2acbDW9oVA6iJzgpC7RcU8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=yHfBJ5
	damADDOQNwuPbno80U+cCDZ9/9e4lC5GqA1DzUNTwFS3d+cFwcDeUA/nGJJ/8UP0
	1MbncZg0uSyzxUywnTc61coqMCh3AlKSUpdhMUqRUpi03W54r//9OiWlqCTdzOvk
	8KxRdjzUIlntmmgl34cQlAFa/jcgmnCVXwUt4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6889E57BE;
	Tue, 24 May 2011 21:23:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 69AF857BB; Tue, 24 May 2011
 21:23:09 -0400 (EDT)
In-Reply-To: <1306284392-12034-1-git-send-email-jamey@minilop.net> (Jamey
 Sharp's message of "Tue, 24 May 2011 17:46:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 91986F4A-866D-11E0-8D0E-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174366>

Jamey Sharp <jamey@minilop.net> writes:

> From: Josh Triplett <josh@joshtriplett.org>
>
> Given many repositories with copies of the same objects (such as bran=
ches of
> the same source), sharing a common object store will avoid duplicatio=
n.
> Alternates provide a single baseline, but don't handle ongoing activi=
ty in the
> various repositories.  Furthermore, operations such as git-gc need to=
 know
> about all of the refs.
>
> Git supports storing multiple virtual repositories within the object =
store and
> references of a single underlying repository.  The underlying reposit=
ory
> stores the objects for all of the virtual repositories, and includes =
all the
> refs and heads of the virtual repositories using prefixed names.

I do not see anything changed up to this point since the previous
round... sent a wrong patch?

In any case, I _think_ what you are trying to say is:

 - Implemented in the most na=C3=AFve way, you can host multiple instan=
ces of
   related projects, but that is wasteful; their object stores will hav=
e
   duplicated objects without sharing. (This is the crucial part missin=
g
   from your description that confused me when trying to _guess_ what
   problem you are trying to solve in the first place).

 - You _could_ use alternates mechanism to alleviate that problem, but =
it
   has issues, e.g. gc needs to be aware of other repositories (This is=
 in
   your first paragraph).

 - Instead, we could store a single, large, repository and carve out it=
s
   refs namespaces into multiple hierarchies, to make it look as if the=
re
   are multiple repositories. (The first sentence of the second paragra=
ph
   also confused me, as you said "Git supports storing multiple ..." in
   present tense).

One thing you would want to be careful with is what to do with the HEAD
symrefs, which should appear to read "ref: refs/heads/<some-branch>" fr=
om
the point of view of the clients that are under the illusion that they =
are
interacting with one specific repository among others, while for the
purpose of gc and things in the huge single repository they should be
pointing at something like "refs/hosted-1-project/heads/<that-branch>",
but other than that, after a lot of guesswork, the problem you are tryi=
ng
to solve seems clearer to me.

But please do not make me guess.
