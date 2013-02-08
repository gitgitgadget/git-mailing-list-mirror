From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] git-remote-mediawiki: use Git's Makefile to build
 the script
Date: Fri, 08 Feb 2013 10:13:23 -0800
Message-ID: <7v62223c8s.fsf@alter.siamese.dyndns.org>
References: <vpqobfxwg2q.fsf@grenoble-inp.fr>
 <1360174292-14793-1-git-send-email-Matthieu.Moy@imag.fr>
 <1360174292-14793-5-git-send-email-Matthieu.Moy@imag.fr>
 <7vhaln7wkg.fsf@alter.siamese.dyndns.org>
 <20130208042800.GB4157@sigill.intra.peff.net>
 <vpqzjzeaevm.fsf@grenoble-inp.fr>
 <20130208174350.GA28266@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 08 19:13:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3sSN-0004YS-Sa
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 19:13:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946898Ab3BHSN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 13:13:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32959 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946853Ab3BHSN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 13:13:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 854D7BAB5;
	Fri,  8 Feb 2013 13:13:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g7j2TEAEiXGIy76XfxFta66bbgM=; b=Oe5J2L
	VDoHRlpf/SLyADJlnibAHESitaD7ORbFipqKy4CKzT1DMO/dUUIHE29ucudrk7a8
	xKpGF4KE4iAoGE8JVaXYeOKYKLY+O5TK3+pnVxabSC+ASrJHDtWG3CuYHuzbq6v4
	BbD7FkpZu8oIH6eW0wa2K0CjF7P1RzzLNwnVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ya4BxlJIupwiZcI4umQ/y96YNJw0tWp7
	bzy4ZTLNfUW9iBZueoOSRahNK1L3wovahKt3RtGcae9WmjHKNbk+3FVktMVxEeS0
	herT8G98AQWDNXAM4m+VpDQpAzlTZgxtFfOtooCYZdElt+f8THlcdOlfgiT2yNtY
	5ffB2xIuUIM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 783FBBAB4;
	Fri,  8 Feb 2013 13:13:25 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA7A8BAB2; Fri,  8 Feb 2013
 13:13:24 -0500 (EST)
In-Reply-To: <20130208174350.GA28266@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 8 Feb 2013 12:43:50 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3AB2E53E-721B-11E2-A451-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215794>

Jeff King <peff@peff.net> writes:

> On Fri, Feb 08, 2013 at 06:34:37PM +0100, Matthieu Moy wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > That seems much cleaner to me. If done right, it could also let people
>> > put:
>> >
>> >   CONTRIB_PERL += contrib/mw-to-git/git-remote-mediawiki
>> 
>> Actually, you can already do this:
>> 
>>   SCRIPT_PERL += contrib/mw-to-git/git-remote-mediawiki.perl
>> 
>> probably not by design, but it works!
>
> So putting:
>
>   ROOT=contrib/mw-to-git
>   git-remote-mediawiki: FORCE
>           @make -C ../.. SCRIPT_PERL=$(ROOT)/$@.perl $(ROOT)/$@
>
> in contrib/mw-to-git/Makefile would already work? Neat.

That essentially is what [v2 2/2] does, no?
