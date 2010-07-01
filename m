From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: 'cherry' does not cope well with merges
 from upstream
Date: Thu, 01 Jul 2010 16:52:14 -0700
Message-ID: <7vbpaq3glt.fsf@alter.siamese.dyndns.org>
References: <1278012954-sup-3724@pimlott.net>
 <20100701210919.GA4283@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andrew Pimlott <andrew@pimlott.net>, git <git@vger.kernel.org>,
	=?utf-8?B?RnLDqWTDqXJpYyBCcmnDqHJl?= <fbriere@fbriere.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 02 01:52:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUTYi-0000Qa-8A
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 01:52:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752979Ab0GAXwi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Jul 2010 19:52:38 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50090 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811Ab0GAXwh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jul 2010 19:52:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F99DC0E89;
	Thu,  1 Jul 2010 19:52:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=6/1L8scddhHG
	1IlTZChNOcIfBj0=; b=BRnqYw9gHxOoNS1JmHkRaXfJtD3QsUp28tKBmiqdpiWS
	zr+9ITXeuzgsvM5lNZs5Qflh7jaL5PWxj5OwjeyOsiT/ysoBhYSRwnJhuDIEvenp
	/E5GSEDuKAjI7/vKxUBVikHatbPtB8ZQqO04IZvSH5pHTgSrhmGuheJ3WjJIv1s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=mcZGIw
	ZqHXu7LGSB+ym961bY6bfvKsT9n6Lf6qgcOpJdBSoh1jbPT7XMPR07KSd6OplcoG
	hs2WUedxj52wwyRcFaMyoqhAlQZV4x+DJDO/QiitbmS3WGQIUHkforMKqqeimz7D
	l6vveEuT33VmC8LlE6EkKnXZOGlnrlgKUTMug=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BB80C0E85;
	Thu,  1 Jul 2010 19:52:25 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B8490C0E7C; Thu,  1 Jul
 2010 19:52:16 -0400 (EDT)
In-Reply-To: <20100701210919.GA4283@burratino> (Jonathan Nieder's message of
 "Thu\, 1 Jul 2010 16\:09\:19 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B2B90378-856B-11DF-A026-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150090>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Example:
>
>  o---o---F---X'---G---U [upstream]
>           \        \
>            X----Y---M---T [topic]
>
> Suppose the author of the =E2=80=98topic=E2=80=99 branch starts from =
upstream
> commit F and makes a few changes.  One is applied upstream, and
> additionally there is some other useful upstream change, so he
> performs a merge to include the upstream updates into topic.
> The expected output from =E2=80=98cherry=E2=80=99 is:
>
>  + T
>  + Y
>  - X
>
> Consider the author of a different branch, also called =E2=80=98topic=
=E2=80=99, but
> this one starts from commit G.  Some infrastructure from an existing=20
> branch is needed, so first she merges that.  Then she adds her own
> commit.

Sorry, but it is unclear to me what kind of history you have in mind at
this point.  What "existing branch" are you talking about?  Presumably =
it
is not the [topic] in an earlier example, nor it is [upstream] right?

o---o---o---o----G-------.---U [upstream]
                  \       \=20
                   X---Y---M---T

Something like this?

> The expected output from =E2=80=98cherry=E2=80=99 is:
>
>  + T
>  + Y
>  + X
>
> since none of the new commits have been applied upstream since
> the fork point.
>
> =E2=80=98cherry=E2=80=99 cannot distinguish between these two cases, =
in part because
> it does not distinguish between parents in a merge commit.

Now you completely lost me.  I guess the biggest reason is you only tal=
k
about "the expected output" without talking about "what it actually
gives".  Hence it is unclear what the significant difference "between
these two cases" you are trying to stress here.

> Thoughts?  Improvements?

I think the actual patch text has the same problem.  You say "these
commits" without saying which ones they are; perhaps saing "the commits
represented by asterisks in the picture" or something may help, but I
dunno.
