From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git gc --aggressive led to about 40 times slower "git log --raw"
Date: Wed, 19 Feb 2014 10:59:34 -0800
Message-ID: <xmqqd2ij9be1.fsf@gitster.dls.corp.google.com>
References: <CAEjYwfU==yYtQBDzZzEPdvbqz1N=gZtbMr5ccRaC_U7NfViQLA@mail.gmail.com>
	<87r470ssuc.fsf@fencepost.gnu.org>
	<CACsJy8D9tws_gu6yWVdz3t+Vfg5-9iorptn4BLnTL3b+YWcHzQ@mail.gmail.com>
	<87ioscsoow.fsf@fencepost.gnu.org> <20140218155842.GA7855@google.com>
	<xmqqzjlocf28.fsf@gitster.dls.corp.google.com>
	<CACsJy8AEXP45K+r3gGVTWbn4uuPLeHOkf-an20rj77QSfG1-ew@mail.gmail.com>
	<xmqq4n3warni.fsf@gitster.dls.corp.google.com>
	<CACsJy8C+wGd9WxnsML6-_G_S5GtN2pCPf09kcFtBVu-SDfP8YA@mail.gmail.com>
	<CAGK7Mr4wpwUK6UF6vTmgszX4sajPDvQazY2QagFfH9BEJx_9Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Kastrup <dak@gnu.org>,
	Christian Jaeger <chrjae@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Philippe Vaucher <philippe.vaucher@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 19 19:59:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGCMx-00031S-SJ
	for gcvg-git-2@plane.gmane.org; Wed, 19 Feb 2014 19:59:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754823AbaBSS7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Feb 2014 13:59:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54073 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754402AbaBSS7i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Feb 2014 13:59:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD3DC6D04D;
	Wed, 19 Feb 2014 13:59:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UKdDvf0UEBwFkGL28/geRbE5QkM=; b=UfB/sc
	irQXVI795gekek63FANDNBUm/pld8ojHf4Fl9dnoNtwaWgBYDLHD2vyBxs7t06IU
	bAx1mQWiNLigKAXFPSqwUjE72brjAU8qquEuuYAvlka5pXJZd/NhUAHvHAHpUix1
	gTtBRfqf8GVvQ1qcwui8Jf0Mc1xPH4Jp0Pcec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KDnJ7oTf06e1qTUzvPsv+KbrNuMEyBOb
	YXLDUgUCxd847RJI2DO+b5nvoahZwhaOhzP3yY58Z+dUeEQFAhCLyqN15iNF+V4W
	wGMBRVDj2JnIP35mGp6LVNxDL+sia51Az0MTv6kTYKoUx+jKBqqFNZNSH9ZBrdhl
	FtSEP07F8jo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BCD1E6D04C;
	Wed, 19 Feb 2014 13:59:37 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CAFBC6D04A;
	Wed, 19 Feb 2014 13:59:36 -0500 (EST)
In-Reply-To: <CAGK7Mr4wpwUK6UF6vTmgszX4sajPDvQazY2QagFfH9BEJx_9Ow@mail.gmail.com>
	(Philippe Vaucher's message of "Wed, 19 Feb 2014 09:38:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FA44FB2C-9997-11E3-8DD9-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242398>

Philippe Vaucher <philippe.vaucher@gmail.com> writes:

>> fwiw this is the thread that added --depth=250
>>
>> http://thread.gmane.org/gmane.comp.gcc.devel/94565/focus=94626
>
> This post is quite interesting:
> http://article.gmane.org/gmane.comp.gcc.devel/94637

Yes, it most clearly says that --depth=250 was *not* a
recommendation, with technical background to explain why such a long
delta chain is a bad idea.
