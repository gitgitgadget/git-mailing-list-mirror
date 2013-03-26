From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Changing submodule foreach --recursive to be
 depth-first, --parent option to execute command in supermodule as well
Date: Mon, 25 Mar 2013 22:25:20 -0700
Message-ID: <7vd2umvikf.fsf@alter.siamese.dyndns.org>
References: <CA+aSAWuoxZkSnRybhefnFr9ngs3tHmt6hAH4o0ebjYKvjJ-vpw@mail.gmail.com>
 <51351CF5.7010308@web.de> <7vhakqwz1e.fsf@alter.siamese.dyndns.org>
 <20130305075901.GB4677@sandbox-ub> <7vhakpvnex.fsf@alter.siamese.dyndns.org>
 <CA+aSAWvQj2wuJX3ENNn7n_pMJjA6nauve5BLRugiTuhWN25Ctg@mail.gmail.com>
 <7vboaxu23y.fsf@alter.siamese.dyndns.org> <51365AB6.2010602@web.de>
 <CABURp0psgofX=ean+KKooN74pF4Ns-gDGt68vc5Exs6NmDRUyw@mail.gmail.com>
 <513B7D08.20406@web.de>
 <CABURp0qBA6myf7_SuaxJSrePJHmh2v-nmtLRzKTtgAJxLkJ-tQ@mail.gmail.com>
 <514782D3.5060200@web.de> <7vhajyviny.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <phil.hord@gmail.com>,
	Eric Cousineau <eacousineau@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Lars Hjemli <hjemli@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Mar 26 06:25:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKMOM-0008DQ-PW
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 06:25:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933828Ab3CZFZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 01:25:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59975 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933505Ab3CZFZW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 01:25:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 411489FA6;
	Tue, 26 Mar 2013 01:25:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6iWGX2s7dfLeONdLCoYHYSGScOc=; b=HQR787
	jeZSj9dIsMbKyLGKbYjAbVTnYl4htDHexjRGxlxD0jkg4leNp/fn0iP5P6sBJrAH
	SseVbDlOTYbt0ZPK0CfleEOCemLRIT+nMMwZQRgWK46A+MTKNkM6ScpiGVChnA7d
	G+9opqVtVsbX7cZQf5390uwY2rLk8yvB2yyGY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yI68ha6yKzQAnUnFour2jbNSorbMCUUD
	VhiUN7O894+WkTiqLnzcCDTY6zUpTczRYLFvArIZcC1xn4HK/OStd4o4WVAKi+BG
	ol0ykrLtCIaq3xh9XcoOzpVPEf5e6crds4xytRBvZiLYLpacRivgRLny6mePTLr8
	q8mTnFe+jNA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35CEF9FA5;
	Tue, 26 Mar 2013 01:25:22 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB8509FA3; Tue, 26 Mar 2013
 01:25:21 -0400 (EDT)
In-Reply-To: <7vhajyviny.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 25 Mar 2013 22:23:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8DFDA778-95D5-11E2-BB52-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219135>

Junio C Hamano <gitster@pobox.com> writes:

> Jens Lehmann <Jens.Lehmann@web.de> writes:
> ...
>>>>>> I totally agree with that. First, adding --include-super does not
>>>>>> belong into the --post-order patch at all, as that is a different
>>>>>> topic (even though it belongs to the same use case Eric has).

I forgot to say that I haven't changed my mind about this part.  "Do
we visit the top-level?" is an orthogonal and different topic and is
better done in a patch separate from the one for --post-order.

Thanks.
