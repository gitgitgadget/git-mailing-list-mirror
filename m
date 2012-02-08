From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] docs: add a basic description of the config API
Date: Tue, 07 Feb 2012 22:40:14 -0800
Message-ID: <7vmx8tzv3l.fsf@alter.siamese.dyndns.org>
References: <20120206095306.GA2404@sigill.intra.peff.net>
 <20120206095346.GA4300@sigill.intra.peff.net>
 <7vbopb61cd.fsf@alter.siamese.dyndns.org>
 <20120207180625.GA27189@sigill.intra.peff.net>
 <7vlioe1o1g.fsf@alter.siamese.dyndns.org>
 <CACsJy8AU3ZA1=Q3vahhP6Nr=FZNKd7oRJ04mtKVs+uvNqJeVaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 08 07:40:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rv1Cv-0002og-PG
	for gcvg-git-2@plane.gmane.org; Wed, 08 Feb 2012 07:40:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755661Ab2BHGkS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Feb 2012 01:40:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50997 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753251Ab2BHGkR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Feb 2012 01:40:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 89B9279BE;
	Wed,  8 Feb 2012 01:40:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vVmER3MUnlKY
	2MTPhAuxnd/wqAo=; b=J1JWN3U71/lCZQjdVBldfu72koGrSgj/rpJDyw5qALLb
	EOX+WLQT9pW8pCnINSrnUU3nYLwO/8wzmAmJA+KNqAlU2qOwnDb35kFQ0pD+kyg7
	ym0KLJH/l5y9POaBE+Iq4Xa+/iLifSY5rguEJ14WuQmh70vlrvcvrpjjZ5YkqfA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=MTFO/j
	r/eG6S90IFMMS3z0C6eHUPTCuSl45K2amBX8n7GKpdJB5rPVbQU9xTRvTN4lB8Io
	98jBUHF+0M/wVu3YVwNaL0elk1FeGKDxZnJduCTQGREVw+RDR2qr9n/i9unKvYtO
	6XcNI4HVD7xCiS4kTN6duKsGgTZdQcGjjk9IM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8102579BD;
	Wed,  8 Feb 2012 01:40:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0D78D79BC; Wed,  8 Feb 2012
 01:40:15 -0500 (EST)
In-Reply-To: <CACsJy8AU3ZA1=Q3vahhP6Nr=FZNKd7oRJ04mtKVs+uvNqJeVaw@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Wed, 8 Feb 2012 11:01:10 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C2A1AD44-521F-11E1-90B6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190223>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

>>> The "1 means I understood this" convention is used by userdiff_conf=
ig. I
>>> don't like that it is unlike every other config callback,...
>>> Looking at the code again, though, ...
>>> Hmm. Yeah. The userdiff calling convention dates back to late 2008.=
=2E..
>>> So I think we could go back and simplify the userdiff_config code n=
ow.
>>
>> I remembered where I saw the new "offender"; it was nd/columns
>> topic (Cc'ing Nguy=E1=BB=85n).
>
> nd/columns does use "1" convention in git_column_config(), but the
> direct config callback function does not return 1 to config machinery=
=2E
> All call sites follow this pattern:
>
> int ret =3D git_column_config(key, var, "command", &colopts);
> if (ret <=3D 0) return ret;
>
> I think it's ok.

I too think this should be acceptable, but that is not the point.

Your excuse that "the toplevel callback in my callchain never returns 1=
,
so overall the nd/columns series is ok" just muddies the water.  It mea=
ns
if later somebody wanted to use inner callback functions you use from t=
he
git_column_config() callchain chain as a toplevel callback for whatever
reason, that will violate the "0 for success, or -1 for error" conventi=
on.
More importantly, if somebody wants to turn a top-level callback that
currently returns 0 into a sub callback used by his callback callchain,=
 he
cannot change that existing callback to return 1 to tell him to short
circuit, because for other callers returning 1 would be a violation.

What I was getting at is that we probably should officially declare tha=
t
returning 1 to signal success is perfectly acceptable (and it probably
should mean the caller who called the callback function as a sub callba=
ck
should return immediately, taking it as a signal that the key has alrea=
dy
been handled), as the primary purpose of this thread to discuss Peff's
patch is to write these rules down.

Of course, all that relies on the audit of the git_config() machinery. =
I
think it is written to accept non-negative as success, and that is why =
I
said "I too think this should be acceptable" in the first place.
