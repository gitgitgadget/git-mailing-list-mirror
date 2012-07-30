From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] buitin_config: return postitive status in get_value
Date: Mon, 30 Jul 2012 08:51:51 -0700
Message-ID: <7vehnts0vc.fsf@alter.siamese.dyndns.org>
References: <1343475730-18743-1-git-send-email-nikolay@vladimiroff.com>
 <CACsJy8BUU13H1tRfTtUme_7u0Jf0upca31U-VNhXva_0R2MLoQ@mail.gmail.com>
 <CAJg5NvdAq_zEx2phVGS4EiUfqMtFJA2Bo=y1d3FJyWXtzMwCTw@mail.gmail.com>
 <20120728132923.GA31388@do> <7vipd7vzql.fsf@alter.siamese.dyndns.org>
 <7v4noqwb6e.fsf@alter.siamese.dyndns.org>
 <CACsJy8CSXo-BsVsqNb4+f97ns30SuSn_iRJgEk=WjgGyEQaywQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nikolay Vladimirov <nikolay@vladimiroff.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 17:52:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvsGF-000537-QW
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 17:52:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753731Ab2G3Pvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 11:51:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60401 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753091Ab2G3Pvy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 11:51:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BEC5A802E;
	Mon, 30 Jul 2012 11:51:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xWJd6qgynei3uIWyNQeyK8lf2O0=; b=sP72C3
	SPBlVEMLReCXlvLrFwJFaepjMoB/zyScusqQmxc5w2JyU3YRCK8kOHEuOYfdE7gK
	UihqMxggmRTYnLK4vI1qdOuK10jGMGYtu39ds0yIW+RIEpnYV334kRXGzeagZ2R5
	Y9zXm9JY0gepLb76tQnCBiyDUBXvkwa7RQeME=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X1fUFnnW6OC+gG7/0L0Fz5X/KLP9RRYl
	CihEHhyPpVrCEqboQcgPFon4v7khmCnc72jjTdBYIK3gDbrqPXx0uEOV+qNkhcEg
	0o2BLYFYIZxjApIAvdHoS/lqfZ/paDJ/5IsgoE7ClleH8bpOWQi74RvrFCHVlUec
	Dujvad4XIdU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABEFF802D;
	Mon, 30 Jul 2012 11:51:53 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 25F1A8029; Mon, 30 Jul 2012
 11:51:53 -0400 (EDT)
In-Reply-To: <CACsJy8CSXo-BsVsqNb4+f97ns30SuSn_iRJgEk=WjgGyEQaywQ@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Mon, 30 Jul 2012 19:26:51 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7B80AC86-DA5E-11E1-95E1-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202568>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Mon, Jul 30, 2012 at 3:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> +. You use '--global' option without $HOME being properly set (ret=128),
>> +. Any other errors (ret=7).
>
> To be pedantic, ret=128 is a result of die() and not setting $HOME is
> just one of them. There's also ret=129 for usage(), which is not
> documented. So maybe we can make it clear that we document some exit
> codes, but not all of them.
>
>> -This command will fail (with exit code ret) if:
>> +This command will fail with non-zero status if:
>
> "This command will fail with non-zero status. Some important exit codes are:"

Sounds good; will squash in.
