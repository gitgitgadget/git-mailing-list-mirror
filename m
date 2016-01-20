From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 2/2] submodule: port init from shell to C
Date: Wed, 20 Jan 2016 15:04:59 -0800
Message-ID: <xmqqvb6n3l9g.fsf@gitster.mtv.corp.google.com>
References: <1453255396-31942-3-git-send-email-sbeller@google.com>
	<1453260274-31005-1-git-send-email-sbeller@google.com>
	<xmqq60yo55jh.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kajF9zR_m0+hbvasf+rwQcuDeywCzmdjuT6C4M5MBvmUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 00:05:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aM1oL-0005rq-MC
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 00:05:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370AbcATXFG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 18:05:06 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58595 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751066AbcATXFD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 18:05:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 07D273E590;
	Wed, 20 Jan 2016 18:05:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bKz6+xm/Gxw7fcaU9ejbO3IjDz0=; b=C1HDCg
	JX7OVCDS9Gd3rPv0V7MLJ47tiy57nSeaIL8bTM/+M0ml4UdPEsnIO3vFQbZbNXUV
	AkoLCST3EKhAbCYo6M0CJrB/Vuqfw5MphmVlq0chayIbAuo8mTFfZRSQJLy/vYEy
	TPye992Tv6QhCh/HJIAEja+qYV4J0Qbe7P8vQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V7z4tgMkYmnJuA39QKjBY2FrPMOu4AJG
	DmNF47UwDtYO0u5Dg6zsi818DWLfotcq32EF+CoTdN02r67kk2exJQJTXIvJkxvT
	Y6jKeA/SPiFn4oNDC05dAf2/oNtVEzR8vUNrVnXFuHHK+hGzEhvqVg4pxIy2a8iz
	DDUSmtotPMY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3F1A53E58E;
	Wed, 20 Jan 2016 18:05:02 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DEF603E58C;
	Wed, 20 Jan 2016 18:05:00 -0500 (EST)
In-Reply-To: <CAGZ79kajF9zR_m0+hbvasf+rwQcuDeywCzmdjuT6C4M5MBvmUQ@mail.gmail.com>
	(Stefan Beller's message of "Wed, 20 Jan 2016 14:33:36 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3BAA5A3A-BFCA-11E5-A361-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284481>

Stefan Beller <sbeller@google.com> writes:

> "say" respects the setting of GIT_QUIET, which is usually set when
> --quiet is passed, so I think I want:
>
> -  A faithful rewrite from shell to C including messages respecting
>    --quiet, such that the "say" behavior is kept.
>
> - s/printf/fprintf(stderr, / for some messages

Yup, that is the correct order.  Thanks.
