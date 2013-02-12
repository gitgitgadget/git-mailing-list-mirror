From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 3/6] Git.pm: refactor command_close_bidi_pipe to use
 _cmd_close
Date: Tue, 12 Feb 2013 13:17:20 -0800
Message-ID: <7v621xfd0f.fsf@alter.siamese.dyndns.org>
References: <cover.1360677646.git.mina86@mina86.com>
 <fc760829f74f31d23f94b61a9e087eda2a66956e.1360677646.git.mina86@mina86.com>
 <7va9r9gy5y.fsf@alter.siamese.dyndns.org>
 <20130212204807.GB25330@sigill.intra.peff.net> <xa1tk3qd9qza.fsf@mina86.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michal Nazarewicz <mina86@mina86.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 22:17:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5NEZ-000087-Qa
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 22:17:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757657Ab3BLVRY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 16:17:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40618 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752915Ab3BLVRX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 16:17:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EFD2BB807;
	Tue, 12 Feb 2013 16:17:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YES68SRwBvZkYhd1dbcM+UwH3ZA=; b=BMMvFM
	lJCos/xbwXQZPIJKCGBP0taHrBUiTrt9oEMVnANr9hiM4w6hFVfkUDrT2eJeQKBQ
	ogv8dkQsIUHcQIo42S778RQkhdgsHwsFg+Uz5a7rc+ojpS2miJxbHjEenMN0I1Jm
	K1G5SvOZkSw7PNmK6wa7Q68VWAEst8Y4/Ylyw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ed0o00RerywJ08vT791kmjfg5QRRDt+/
	E9pVgT6bzK8ix79JXYugBD5M4Sw6vhpw+1+4bsj+y78kHSo8VynfziAoWnyPFO8K
	xi5eOLseUA2PfJxQ+Igxqc70ExsvnQeQUrH30/XfMIEcB/yJ4pYKifebwSmnA2Mj
	O6SAuNnbIuo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4C9DB806;
	Tue, 12 Feb 2013 16:17:22 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4BDE0B801; Tue, 12 Feb 2013
 16:17:22 -0500 (EST)
In-Reply-To: <xa1tk3qd9qza.fsf@mina86.com> (Michal Nazarewicz's message of
 "Tue, 12 Feb 2013 22:12:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9729CCB0-7559-11E2-97E5-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216203>

Michal Nazarewicz <mina86@mina86.com> writes:

>>> Michal Nazarewicz <mpn@google.com> writes:
>>> > The body of the loop in command_close_bidi_pipe function is identical to
>>> > what _cmd_close function does so instead of duplicating, refactor change
>>> > _cmd_close so that it accepts list of file handlers to be closed, which
>
>> On Tue, Feb 12, 2013 at 10:55:05AM -0800, Junio C Hamano wrote:
>>> s/file handlers/file handles/, I think.
>
> On Tue, Feb 12 2013, Jeff King wrote:
>> And s/refactor change/refactor/.
>>
>> Other than that, I think the series looks OK. I have one style micro-nit
>> on patch 4 which I'll reply in-line. But it is either "fix while
>> applying" or "ignore", I don't think it will be worth a re-roll.
>
> All fixed.
>
> Junio, do you want me to resend or would you be fine with just pulling:
>
> 	git://github.com/mina86/git.git master

Neither.  I agree with Peff that these micronits are not enough
reason for the trouble of rerolling the series, so I'll just amend
them at my end.  Please double-check what you see on the 'pu' branch
when I push today's integration result out later.

Thanks.
