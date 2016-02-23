From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] t3034: add rename threshold tests
Date: Mon, 22 Feb 2016 23:06:05 -0800
Message-ID: <xmqqa8mr3nz6.fsf@gitster.mtv.corp.google.com>
References: <1456202325-6037-1-git-send-email-felipegassis@gmail.com>
	<1456202325-6037-2-git-send-email-felipegassis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	sunshine@sunshineco.com,
	Felipe =?utf-8?Q?Gon=C3=A7alves?= Assis 
	<felipegassis@gmail.com>
To: =?utf-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipeg.assis@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 08:06:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aY72z-0002VU-NB
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 08:06:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757181AbcBWHGJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2016 02:06:09 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55159 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752333AbcBWHGI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Feb 2016 02:06:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1CEED3E257;
	Tue, 23 Feb 2016 02:06:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=rP/zBVDduLK2
	Zl42qnTr3b1FS8c=; b=glRxPIG1e24XrMhsb4Uq5lgpDwj8AXxnbxkGizJTldd4
	yzZNKXewworQhvKFhUzJ8NnjEyGxkAYubJfBLqIEtxCpi9D3KLkd90DjGCJzuLYW
	oqC9o4YKAhH0JjzSTWBW+Dj7LwUgzPYCnZwk3L0m4PjwRW+QG1xQ7ufDXl+tH7M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=HCyIWa
	/pX+7/jLCgnr3Vuzi7w8ecfJ3rzw8sMT7DkT+Hs/lVyPfJ+FkS90OjkzIV5kbjmR
	WEsRP9sP1lMR9tf7W+MBLQRsY3Zd+GjOITlO/RpDzbIWdgKcbB87CN3JRZSQ4JB5
	/d8Q2AzVIfti1wqN5VStxgK9Q125J9xvXVMZE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 151683E256;
	Tue, 23 Feb 2016 02:06:07 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 894603E253;
	Tue, 23 Feb 2016 02:06:06 -0500 (EST)
In-Reply-To: <1456202325-6037-2-git-send-email-felipegassis@gmail.com>
	("Felipe =?utf-8?Q?Gon=C3=A7alves?= Assis"'s message of "Tue, 23 Feb 2016
 01:38:43
	-0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E885AA7A-D9FB-11E5-9918-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287028>

"Felipe Gon=C3=A7alves Assis"  <felipeg.assis@gmail.com> writes:

> +	test_cmp diff-output grep-output &&
> +	while read status old new
> +	do
> +		th[${old:0:1}]=3D${status:1}
> +	done <diff-output &&

Sorry, but I think this uses a few blatant bash-isms that we cannot
use in our scripts.
