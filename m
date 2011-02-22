From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/15] Mark "init", "clone", and "add" output for
 translation
Date: Tue, 22 Feb 2011 10:11:09 -0800
Message-ID: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
 <20110221040012.GB26968@elie> <20110221101229.GA32137@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 22 19:11:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Prwhs-00063s-EE
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 19:11:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754852Ab1BVSLW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 13:11:22 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55882 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754751Ab1BVSLV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Feb 2011 13:11:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2172E498D;
	Tue, 22 Feb 2011 13:12:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=H2GLKaTn+MJC
	O688QltYkxRQFFA=; b=WXda7PsFvqqxMNA+MDsgU4zWBf3NrxCJ/cRe2w7Z2qQ1
	zaq5IzV1ZgJYowipBt8Ezgb8iRhbURafXkDz/UWtnB0OTADSCCOEIsEEn1zgR+lX
	Ha/nZg/v2duvwHWNrWK65M+cjBEAbTRox7mH10DY9NN/g4uOloNjJxK/q7ZFgMc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=aBYVtZ
	cbh6PYNfKH8jtLa/4GSqtmnWaj7PKxHwkVFhs19s48eUxeGiWPglwOkgEx/PWufi
	TWGNTRQ2gPbui3t+vJieEO9Gl2D/f7u/MiYzWnQbLD22hc3O+MHU5ZEXtralWLAe
	TJNl9MshDMDIbIAmiqlI8lQpzKRn/BE01oLBc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E3AAA498B;
	Tue, 22 Feb 2011 13:12:26 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9513E4989; Tue, 22 Feb 2011
 13:12:22 -0500 (EST)
In-Reply-To: <20110221101229.GA32137@elie> (Jonathan Nieder's message of
 "Mon\, 21 Feb 2011 04\:12\:29 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4DEF9F58-3EAF-11E0-AFF0-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167567>

Jonathan Nieder <jrnieder@gmail.com> writes:

> This series still includes the skeleton gettext.h wrapper.
>
> Changes from v1:
>
>  - clearer commit messages, hopefully
>  - clearer documentation for GETTEXT_POISON in the makefile
>
> Please feel free to try it out, complain, ack, send patches, and so
> on.
>
> Jonathan Nieder (2):
>   i18n: do not poison translations unless GIT_GETTEXT_POISON envvar i=
s
>     set
>   update-index --refresh --porcelain: add missing const

I took this series (minus 4/15), which roughly corresponds to up to 13/=
72
of =C3=86var's original.  A few quick comments:

 * 01/15
   Thanks for guarding the header file from double inclusion.  I have t=
his
   nagging feeling that the inline _() function might be too clever for
   some compilers (non gcc and perhaps older versions of gcc), but we c=
an
   always ifdef it away if it turns problematic.

 * 02/15
   I am not entirely happy that it is a too generic name to contaminate
   namespace of programs that may want to get i18n support while wantin=
g
   to catch bugs with their own unrelated poisoning scheme.

   As to Malkovich, I tend to agree with your reasoning that code that
   emit messages prefixed by "#" rebase relies on should be restructure=
d
   to limit the scope of translation to just the body of these lines, a=
nd
   that should be done in a separate patch.

 * 04/15
   Deferred per request from =C3=86var.
