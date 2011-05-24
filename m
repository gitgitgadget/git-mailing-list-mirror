From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 08/10] send-pack/receive-pack: Allow server to refuse
 pushing too large packs
Date: Mon, 23 May 2011 17:12:47 -0700
Message-ID: <7vhb8lrm68.fsf@alter.siamese.dyndns.org>
References: <1306111923-16859-1-git-send-email-johan@herland.net>
 <1306111923-16859-9-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue May 24 02:13:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOfFK-0001aJ-CH
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 02:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757817Ab1EXAND (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 20:13:03 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54242 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757729Ab1EXAM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 20:12:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ECD3352CC;
	Mon, 23 May 2011 20:15:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=72H3N2/Os00bCs0HC8Q7v+d8Kug=; b=vPb7dh
	q9RKRLYCAyMh3Kw8JAitXlequ4OheDzuYODxMGtnNa1WTcySzmRoN1s+mRkoTV8E
	hhcgJ8SSVNR/L1CLbk8j8iPGYZfXYU8Rn74YCK5bLW6dCQwN/LzFGYyyIIF6PyIH
	qh6z40kHgDec79u8jztzscYXCVRxWxN+NKJl8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ozCcVjaojcdLo1kwSaLwCA+9DQH3FklG
	B8e9zKLBlnYoQ+WEudVXte/O8puUJjqpiUyAOJ4Fs3F/Zr2REd+OvqMgEk5ME7G2
	fK6DUSTcQq5zCLEt9cVrHlkhPVhCtt5kpFzLQlp3vZxqJ6PVWqbIoQKD+Dw4XQou
	JSn6GpRSMBc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 97D3852CB;
	Mon, 23 May 2011 20:15:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4A20052CA; Mon, 23 May 2011
 20:14:57 -0400 (EDT)
In-Reply-To: <1306111923-16859-9-git-send-email-johan@herland.net> (Johan
 Herland's message of "Mon, 23 May 2011 02:52:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DDE3D0C0-859A-11E0-8693-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174298>

Johan Herland <johan@herland.net> writes:

> Add a new receive.packSizeLimit config variable which defines an upper
> limit on the pack size to accept in a single push.
>
> This limit is advertised to clients, using the new "limit-pack-size=<num>"
> capability.

Continuing my comments to 7/10, this shouldn't be closely tied to "pack",
but a more abstract concept of "total transferred data in bytes".

Aside from the name, the implementation looks fine, modulo that it should
not be passing --max-pack-size but --max-total-pack-size to the underlying
pack-objects command.

Thanks.
