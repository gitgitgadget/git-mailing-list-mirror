From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] {fetch,upload}-pack: allow --depth=0 for infinite
 depth
Date: Tue, 24 Aug 2010 10:39:46 -0700
Message-ID: <7vvd6zx63h.fsf@alter.siamese.dyndns.org>
References: <1282565304-3122-1-git-send-email-pclouds@gmail.com>
 <1282565304-3122-3-git-send-email-pclouds@gmail.com>
 <20100824135341.GA6457@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 24 19:40:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnxTd-0004On-Vh
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 19:40:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755214Ab0HXRj5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 13:39:57 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61740 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171Ab0HXRj4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Aug 2010 13:39:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C776AD0FA5;
	Tue, 24 Aug 2010 13:39:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=JU7gV1/N18ph
	s8f8AeUlElXVGNU=; b=k18JoCC0K5uhkJ4gdpUqMw8wzY6FrkUJHEooGJPYJP+v
	udTBcgCd8WB75HHX7eEXKRseZxeXo4+eaH7PCVf/1Y7jQUQ0svsKIUpDbOGBxTYU
	WEb3PeHyca7GJJlI6WnwFD3IwnTf8j0nG2RqCBRtyudVYj9WVYO4BRS7AdUEXq4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=IXNdwQ
	5sKbV1iwOz4WZiaPt1GGuxdHNVE/I+zvovS64ptadfHdQW6jYloPxI0F4WtwEf6q
	Z7AUrxpEQU7rwzptKI3z9eXSCa1h/X2i396lKqrUtO6Vk3fNQzDquxTHsSb6YWh5
	bkAUwyumjjipk5yCiBY44OCMEVCFHf3PSZLL4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 90AC5D0FA2;
	Tue, 24 Aug 2010 13:39:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CDBFAD0F99; Tue, 24 Aug
 2010 13:39:47 -0400 (EDT)
In-Reply-To: <20100824135341.GA6457@coredump.intra.peff.net> (Jeff King's
 message of "Tue\, 24 Aug 2010 09\:53\:41 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 994A1ED0-AFA6-11DF-BD5C-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154328>

Jeff King <peff@peff.net> writes:

> On Mon, Aug 23, 2010 at 10:08:24PM +1000, Nguy=E1=BB=85n Th=C3=A1i Ng=
=E1=BB=8Dc Duy wrote:
>
>> Users can do --depth=3D2147483648 for infinite depth now. It just lo=
oks
>> ugly. So make "0" special (i.e. infinite depth) at plumbing/protocol
>> level.
>
> What happens if I connect to an older server? Shouldn't "I understand
> depth=3D0 is infinite" be a server capability, and we hack around it =
by
> sending depth=3D2^32-1 when we have a modern client but an older serv=
er?

Good point.  Do we also need to find out how wide an int is on the othe=
r
end in that case?
