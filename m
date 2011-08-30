From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Add a remote helper to interact with mediawiki
 (fetch & push)
Date: Tue, 30 Aug 2011 10:13:50 -0700
Message-ID: <7vfwki3jqp.fsf@alter.siamese.dyndns.org>
References: <1314378689-8997-1-git-send-email-Matthieu.Moy@imag.fr>
 <1314378689-8997-2-git-send-email-Matthieu.Moy@imag.fr>
 <7v4o14dppz.fsf@alter.siamese.dyndns.org>
 <CAGdFq_iYRkfnTbYAgmX1g4uOxWb_ZYxr+TNinVfWRV-zXrnzAg@mail.gmail.com>
 <7v4o1092hn.fsf@alter.siamese.dyndns.org>
 <CAGdFq_jwLGZ+tLKramRrLJmwyY_uDtj7JXUwYBO9pSqOmZ20xQ@mail.gmail.com>
 <20110830035608.GB6647@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr>,
	Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Sylvain =?utf-8?Q?Boulm=C3=A9?= <sylvain.boulme@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 30 19:13:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyRss-0003Zf-4E
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 19:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754247Ab1H3RNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Aug 2011 13:13:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42291 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753657Ab1H3RNw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2011 13:13:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18DF23FD4;
	Tue, 30 Aug 2011 13:13:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3psTGzKg+F/GvGOVY3r8G5l8fhE=; b=qcCZLh
	z6dWkp4uzieB2IE1/NkOXMXYTPGcmf4hN0iqhW6enxOMtS/tn5WHQUtdNrihHAHh
	ebkuAR9d6wpZ1oMb7HyKrBDq1aTYQ4O+x+ZLszO/nMrZLauYvpG6x4VUmTZxnB1Y
	tqAchIYJRoGeyIf3VSC8PszmqF1Upw0KC5X+o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iO2Mu9sEZGQRmOgBZCiOYMTCkQ32CtXf
	qGYYshrzkmwVfm1136LUGwlbMS2M1mGdmzmMS0yUsX9RvFkXEG7Eo56Whk376IVn
	qYOc6AAoaOVzql2o7INcRPNpDBOKEHbiQTfLn921EDz7Ajk2LBVC1LGe1DGfX2Rn
	552NjxGsie0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EBFC3FD3;
	Tue, 30 Aug 2011 13:13:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B2563FD2; Tue, 30 Aug 2011
 13:13:51 -0400 (EDT)
In-Reply-To: <20110830035608.GB6647@elie.gateway.2wire.net> (Jonathan
 Nieder's message of "Mon, 29 Aug 2011 22:56:08 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6EBF7472-D32B-11E0-829A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180419>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Sverre Rabbelier wrote:
>> On Mon, Aug 29, 2011 at 08:05, Junio C Hamano <gitster@pobox.com> wrote:
>
>>> Does this exchange suggest that at least we would need an update to
>>> documentation around "done", as Matthieu's "why is 'done' needed even
>>> though I am not calling with --done?" sounds like a very fair question.
>>
>> No I think the documentation for fast-import is correct.
>
> However, the documentation for git-remote-helpers is hopelessly outdated.

Good point. If somebody writes a working remote-helper using "import" to
trigger fast-import as the back-end, and if it breaks because we changed
the way fast-import is invoked and the helper needs to be updated, we at
least need to give them a useful documentation that clearly states how the
helper is expected to behave.

> It does _not_ document recent changes; patches for that would
> presumably come on top.

Will queue this version for now, if only as a reminder that we would need
more updates.

Thanks.
