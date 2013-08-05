From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] gc and impatience
Date: Mon, 05 Aug 2013 08:24:21 -0700
Message-ID: <7vk3k0not6.fsf@alter.siamese.dyndns.org>
References: <CALkWK0k2B5OW9zMrw0jBDDWpufojYDJybXa7jCBdzftNUc7mxA@mail.gmail.com>
	<CACsJy8DRo9Akoydwn9-EPOSyJiPhqAf1=HncYjHvXZwS4S_d7A@mail.gmail.com>
	<CAPc5daXi_ZG6GcK6pWafffyOY4MEZHUMkZxTxiRiU4BaFybqqg@mail.gmail.com>
	<CACsJy8DO4VyCK_xDJDGVx6JLTqjKAf24AUOW3=kZEMEVjAUSVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 05 17:24:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6Me5-000869-0E
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 17:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753167Ab3HEPYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 11:24:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57537 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752789Ab3HEPYY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 11:24:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 442F436A19;
	Mon,  5 Aug 2013 15:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HOT2woDd6wvvm4IsR7JnShmBlzM=; b=uxvKDK
	nNjoHNM9hnPOBSGXU3rmpTmAgSdgjjxZjcSaEqvmx63rWEWLfHI5iZH98emuIU7n
	jqrmuFwpov7ZCvuiBhkha4KfxUAkPkWxWE7K4bVPywWq+veAI2qz4Dizn6rdz1oF
	KjI54ZwZ89ELiQbaDbqoPsby3ZY19U4CUhmfE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DLh3S+ZptF2ZnIZ88COrxRtMJ3ygovnw
	ihlrO/dXXg6vnh21CaD/CqUeaEwiXx3JWogaaGmmGosVBcmCCuJVvd79iUzrpQRu
	pg8W8dS8q3nZ1sJdzpvegsINXI+LoZc1ZUxphvNixW9wsbx8b/69AK3EwiCe4YXP
	NdmnFCXuZj4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39A5B36A18;
	Mon,  5 Aug 2013 15:24:24 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9910136A11;
	Mon,  5 Aug 2013 15:24:22 +0000 (UTC)
In-Reply-To: <CACsJy8DO4VyCK_xDJDGVx6JLTqjKAf24AUOW3=kZEMEVjAUSVw@mail.gmail.com>
	(Duy Nguyen's message of "Sat, 3 Aug 2013 12:25:11 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1AF74542-FDE3-11E2-9DDD-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231655>

Duy Nguyen <pclouds@gmail.com> writes:

> I worry less about this. It's not the right model to have two machines
> modify the same shared repository (gc --auto is only triggered when we
> think there are new objects) even though I think we support it.

I am a bit hesitant to dismiss with "It's not the right model", as
the original of accessing the repository from two terminals while
one clearly is being accessed busily by gc falls into the same
category.

> If
> it's two _scripts_ modifying the same repo, I don't care as this is
> more about user interaction.

It can very well be two terminals, one on one machine each, both
with the same human end-user interaction.
