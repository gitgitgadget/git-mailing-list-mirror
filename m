From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pathspec: reserve some letters after a colon pathspec
Date: Wed, 23 Mar 2011 11:04:44 -0700
Message-ID: <7vvcz9emrn.fsf@alter.siamese.dyndns.org>
References: <bc49592f5e524a0d12aa55eeca1c5ca659b6525f.1298974647.git.git@drmicha.warpmail.net> <1300894353-19386-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 19:05:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2SQZ-0004NP-TW
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 19:05:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755265Ab1CWSE6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Mar 2011 14:04:58 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40171 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754042Ab1CWSE5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2011 14:04:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 603644C1D;
	Wed, 23 Mar 2011 14:06:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=eU8AwcGsLqu8
	B6lU0iR3msPNzlM=; b=WHOlBA8L8fxhvQdmV/tVR+fJb71TaxiWah6bQ0sS43pt
	yCe3XUkAdcCEvvglzrfE7keOLK1Ue6A2y+F3mm0Pb7KzDEPPgwI/Eg3JSvNzLGom
	evOPEFHI6ohoZj8NdPPSCKKQZQSgdQbSpA01LwarlktG6RSaa5VRyDghYjv0h7I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=vMmejA
	oAjCAdgfxRWpoDJXzNkuAeetAp7rAHqt3wG+OBkMWkeAfMOF75J2dl7ric2uPMV4
	egBR3pKs37cYzZ17tEItFsRulXYiJAIowph5ufRtQEmV9muio2ZfBPAPIpXtRBje
	HHdyhjm748XX77XxP/5Es2N/+MmJeK+W8Wqvk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 29E684C1B;
	Wed, 23 Mar 2011 14:06:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E94274C15; Wed, 23 Mar 2011
 14:06:26 -0400 (EDT)
In-Reply-To: <1300894353-19386-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 23 Mar
 2011 22:32:33 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 47D7D218-5578-11E0-9169-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169860>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> Pathspec ':something' means 'something' at top directory. Limit it a
> bit so that ':<non-alnum>something' can be reserved for future
> extensions. ':\<non-alnum>something' can be used to achieve
> ':something' before this patch.
>
> All non-alphanumeric chars on the en_US keyboard, except \ and ., are
> currently reserved.

While I was writing the other message, I really was hoping that people
would notice that trying to limit the magic signature (i.e. "which magi=
c I
want" in my previous message) to a non-alnum letter that cannot easily =
be
remembered would be a bad direction.  A set of short mnemonic is fine, =
but
we probably should prepare the syntax framework to reserve spelled out
magic names for readability.

Here is a weather-baloon.  I will use colon below as the magic introduc=
er,
as I don't care very deeply about the choice of it.

 - "^:([^\w\d]+)(.*)$", that is "a magic introducer followed by a seque=
nce
   of non-alnum followed by the remainder" means that the part that is
   given to the matching engine is $2, and each gibberish character in =
$1
   determines what magic is requested when the matching engine does its
   work.  Among the gibberish that can be in $1, we currently would wan=
t
   to support:

    . '/' denotes that $2 is relative to root of the working tree, i.e.=
 do
      not add 'prefix' to it at the left.

    . '!' denotes that the matching with $2 should not honor globbing.

   e.g.

    ":/*lib/**/foo.h", if '*' denoted recursive glob support for '**/' =
to
    mean "zero-or-more levels of any directory" [*1*], it would find an=
y
    foo.h in a directory 'lib' or its subdirectory that is found in
    anywhere in the working tree.

 - "^:((?:[-a-z]+)(?:,[-a-z+]+)*):(.*)$", that is "a magic introducer,
   followed by one or more alpha-string separated with comma, followed
   by a magic terminator, and the remainder" means that the remainder i=
s
   what is given to the matching engine, and the alpha-strings spell ou=
t
   the name of the magic.  We currently would want to support:

    . 'full-tree' means exactly the same as '/' mnemonic above.
    . 'noglob' means exactly the same as '!' mnemonic.

   e.g.

   ":full-tree,recursive-glob:lib/**/foo.h" would be how you fully spel=
l
   the above example in the mnemonic section [*2*].


[Footnote]

*1* "man zshexpn" and look for "Recursive Globbing".

*2* It would be "/full-tree,recursive-glob/lib/**/foo.h" if the magic
introducer were '/', which might be easier to the eye.
