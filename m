From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email: add ~/.authinfo parsing
Date: Tue, 05 Feb 2013 15:10:20 -0800
Message-ID: <7v6226pdb7.fsf@alter.siamese.dyndns.org>
References: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com>
 <7vvcafojf4.fsf@alter.siamese.dyndns.org>
 <20130130074306.GA17868@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michal Nazarewicz <mpn@google.com>, git@vger.kernel.org,
	Krzysztof Mazur <krzysiek@podlesie.net>,
	Michal Nazarewicz <mina86@mina86.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 06 00:10:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2rf5-0006Ki-F1
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 00:10:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756515Ab3BEXKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 18:10:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45163 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756381Ab3BEXKX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 18:10:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18310C06F;
	Tue,  5 Feb 2013 18:10:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Hd4sis2H5w08onGlXH3GZeIInEQ=; b=EctgDW
	NpEi+feOoGnQq0h+EpkZJOgfn7UjzjpdAuxzaT6h0VmJzw70t42UqUtTR5lOtJRv
	SmWryo+Y0X05j5qsGXpSSh9yA7ptmf1CfLwvx07259yRBabQWO9nfPCQ5L1PIbpp
	gkjUiuS9S5pMlcUh+repts0fqnqBAFVRSvxSo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p/OsNL16YCnbVz3VJejRkKFlfWxq0sJA
	unqLSSBQ6Ehk1YnX1g3LFkQT6tNcGs90woqG1mO6kW1MWqFA3ku3wYZBp1HQGRp+
	l1Nha10f1+ojtXOKWx3HNIOTKBobIRgKo5pv0T6uOZuwQlpt6fPWbk60hKHscm25
	XQ2j/xuSxAE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CEA8C06E;
	Tue,  5 Feb 2013 18:10:23 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7D808C06D; Tue,  5 Feb 2013
 18:10:22 -0500 (EST)
In-Reply-To: <20130130074306.GA17868@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 30 Jan 2013 02:43:06 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3796C2C8-6FE9-11E2-B331-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215550>

Jeff King <peff@peff.net> writes:

> On Tue, Jan 29, 2013 at 11:53:19AM -0800, Junio C Hamano wrote:
>
>> Either way it still encourages a plaintext password to be on disk,
>> which may not be what we want, even though it may be slight if not
>> really much of an improvement.  Again the Help-for-users has this
>> amusing bit:
>
> I do not mind a .netrc or .authinfo parser, because while those formats
> do have security problems, they are standard files that may already be
> in use. So as long as we are not encouraging their use, I do not see a
> problem in supporting them (and we already do the same with curl's netrc
> support).
>
> But it would probably make sense for send-email to support the existing
> git-credential subsystem, so that it can take advantage of secure
> system-specific storage. And that is where we should be pointing new
> users. I think contrib/mw-to-git even has credential support written in
> perl, so it would just need to be factored out to Git.pm.

I see a lot of rerolls on the credential helper front, but is there
anybody working on hooking send-email to the credential framework?
