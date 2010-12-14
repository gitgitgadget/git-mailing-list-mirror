From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/19] tree-diff.c: reserve space in "base" for pathname
 concatenation
Date: Tue, 14 Dec 2010 09:11:15 -0800
Message-ID: <7vk4jcuvnw.fsf@alter.siamese.dyndns.org>
References: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
 <1292233616-27692-10-git-send-email-pclouds@gmail.com>
 <7vlj3t35ol.fsf@alter.siamese.dyndns.org>
 <AANLkTi=5QgkBd434=Z7MCA_ZNZCXVyXJYh_fd1A+B2ue@mail.gmail.com>
 <7vvd2wvs0m.fsf@alter.siamese.dyndns.org> <4D071DAA.3070400@viscovery.net>
 <AANLkTimzmq8gUpXUZ801Q+pua_mZMHTJ6wYt_CwcTr3v@mail.gmail.com>
 <4D0728F0.9020807@viscovery.net>
 <AANLkTikXvx7-Q8B_dqG5mMHGK_Rw-dFaeQdXi0zW98SD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 14 18:11:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSYPR-0003tg-0H
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 18:11:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759399Ab0LNRL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 12:11:26 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33174 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891Ab0LNRLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 12:11:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9A9AF3CE9;
	Tue, 14 Dec 2010 12:11:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hbJLrflIMpdFlzAgy4gfzLLeYN0=; b=lUmtIE
	PFyrYhkte8Gb0YfMbZu38xjm+2u1UxJkUc8ObpMz6y9EBceb21GNLNubHQ+sNmES
	K+U5N1g2+6Yqwvo2N8+HLP1hfmVC4flocjGwnV9/sXQJcGoGWdHC17+3MRf2lf8y
	xLsXX/PABkRKMTfktr/zEZ/r7ARhS15vMrfwk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WKOywlmMMxS8Kh6fp5P8YEiTQegkGxb3
	7Y8Y+UDWEfS7dBEH55ZKjjxYZzrTQzh5FIf2/hnkIlIpSJK0fEsGJF8OGVnkyuUt
	qi10VtQE227cVyzqV4ImpMSFTJAY7Va37LY1KzextifZKshwiNLP+5pq2zhTWzC8
	MaezfZPZkIM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6A7953CE8;
	Tue, 14 Dec 2010 12:11:47 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B379E3CE6; Tue, 14 Dec 2010
 12:11:42 -0500 (EST)
In-Reply-To: <AANLkTikXvx7-Q8B_dqG5mMHGK_Rw-dFaeQdXi0zW98SD@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Tue\, 14 Dec 2010 20\:01\:21 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3BB736B6-07A5-11E0-BE09-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163659>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> Just googled around and found this [1]. I'm going with strbuf so it
> can be reallocated if necessary. A bit tricky because "base" can be
> moved, but I think it's worth it.

Thanks---I was about to suggest using strbuf but you figured it out
already, which is good ;-).
