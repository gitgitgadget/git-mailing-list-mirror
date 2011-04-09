From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] add -u: get rid of "treewideupdate" configuration
Date: Sat, 09 Apr 2011 14:34:28 -0700
Message-ID: <7voc4fyuqj.fsf@alter.siamese.dyndns.org>
References: <1302138996-10006-1-git-send-email-gitster@pobox.com>
 <1302138996-10006-3-git-send-email-gitster@pobox.com>
 <20110408175149.GA3917@sigill.intra.peff.net>
 <7vaag04k8m.fsf@alter.siamese.dyndns.org>
 <20110408202404.GA16540@sigill.intra.peff.net>
 <7vmxk01izn.fsf@alter.siamese.dyndns.org>
 <20110408223206.GA7343@sigill.intra.peff.net>
 <7vei5c1iat.fsf@alter.siamese.dyndns.org>
 <7vaag01gdl.fsf@alter.siamese.dyndns.org> <20110409043824.GA22543@do>
 <7v39ls10q6.fsf@alter.siamese.dyndns.org>
 <BANLkTinSZeNizg+8wEu_wjc09E_1dius5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 09 23:34:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8fns-000597-Br
	for gcvg-git-2@lo.gmane.org; Sat, 09 Apr 2011 23:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755698Ab1DIVen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2011 17:34:43 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52575 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755708Ab1DIVem (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2011 17:34:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0471E5041;
	Sat,  9 Apr 2011 17:36:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=weDYjISayH7uLGxcW8Paa/k0dLA=; b=c8QLJ4
	FVEeVUPcFKaOLQlaxRN15eDQXRa9nUvUlRcq73/WZ47ZEzdi9err++IKIQED1PX3
	9slLSV8sf2I8r8IYHHPSXJMVpC2J1T/W79q+uPIKqxA3MK/FcI5n5xm8/hXgI1Sd
	fRojVe3F2ze3NPkJmfzIHVhx/TQjiVtlsaIps=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RxZ6SOHuFy4KO2N6AgGjW2SLMOZcp5xO
	IyAsURVaiIxd4V+4mOSMhHDEemig8bEfTTjVBWmyu5MC9npD02TxPuW+7BsimVv2
	aOZaEOIveKlMmHrjoNpFVHALIJUR0DWphqU5pEFZMsa3f3OjSHMxrtqtqMdmTu1/
	AV4P34JJLo4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ADEC4503F;
	Sat,  9 Apr 2011 17:36:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 67AD2503E; Sat,  9 Apr 2011
 17:36:27 -0400 (EDT)
In-Reply-To: <BANLkTinSZeNizg+8wEu_wjc09E_1dius5Q@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Sat, 9 Apr 2011 12:05:45 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6FF86F6A-62F1-11E0-8965-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171207>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Sat, Apr 9, 2011 at 11:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> ... If you rewrite the verify_filename() in the
>> way I outlined above, you wouldn't have to.
>
> I considered that, but we may need to go through the whole worktree
> just to verify "*.c" matches something.

You are absolutely right.  After all, this is only meant to be a quick
sanity check to ensure that we got the user's intention absolutely right
when the user did not disambiguate with '--'.  When we see all earlier
ones are object names (and cannot be filenames) and all later ones have
working tree entries (and cannot be object names), we are sure that we got
the missing '--' boundary right.

And we error out when there is any doubt, and that is a good feature.
Even when there is no glob involved, e.g. "git log builtin-add.c", we fail
the parsing, because there is no builtin-add.c in the filesystem in
today's checkou.  That behaviour is coming exactly from that reasoning: we
may be sure that "builtin-add.c" cannot be an object name, but we don't
know if it is a typo of builtin/add.c (or builtin-add.o, etc.), and we
don't want to make the user wait while we are guessing.

So let's forget about the suggestion.  Thanks for injecting sanity to the
discussion and stopping me from going overboard.
