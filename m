From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 3/6] Git.pm: refactor command_close_bidi_pipe to use
 _cmd_close
Date: Tue, 12 Feb 2013 10:55:05 -0800
Message-ID: <7va9r9gy5y.fsf@alter.siamese.dyndns.org>
References: <cover.1360677646.git.mina86@mina86.com>
 <fc760829f74f31d23f94b61a9e087eda2a66956e.1360677646.git.mina86@mina86.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: peff@peff.net, git@vger.kernel.org
To: Michal Nazarewicz <mpn@google.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 19:55:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5L1B-0006bE-O8
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 19:55:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933898Ab3BLSzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 13:55:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63501 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933812Ab3BLSzI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 13:55:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BBB8CC360;
	Tue, 12 Feb 2013 13:55:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e+ylbSPWrqLrfTlilfnbpGh9Dx4=; b=uukEyN
	Khlf89YbwYmHADfDJ/9fcVzsaagnA68lYctYV+dainFSUyfBmFLkw0xZZ9Qd+XOR
	9GqTFpAFebmYrNlaODHl3MhMDBEDpB/NzKiwSojlxJ8u9jH2y/saU8W82QJohcUK
	+n+OLxeNxqDNKRlE6E2S1+fbRbh54WEhXmRTw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vgWJfu0hBNUzm+miXuwCFy0btIML7fii
	UpYoz1OhrJInLSY8nIgIY690DLHqB9cwOShw/mmz2mlNnjqVB+M+4yoPTZEnZowI
	vSoCtfEUAp9h1ukg1j+4UaXlvo9xO9ZmBo6IhJwrT4Q3lPUutoxvfTleYLif9C+Z
	BOSz1reaLUc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B1649C35F;
	Tue, 12 Feb 2013 13:55:07 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 344C3C35D; Tue, 12 Feb 2013
 13:55:07 -0500 (EST)
In-Reply-To: <fc760829f74f31d23f94b61a9e087eda2a66956e.1360677646.git.mina86@mina86.com>
 (Michal Nazarewicz's message of "Tue, 12 Feb 2013 15:02:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B7D99D64-7545-11E2-9C92-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216174>

Michal Nazarewicz <mpn@google.com> writes:

> From: Michal Nazarewicz <mina86@mina86.com>
>
> The body of the loop in command_close_bidi_pipe function is identical to
> what _cmd_close function does so instead of duplicating, refactor change
> _cmd_close so that it accepts list of file handlers to be closed, which

s/file handlers/file handles/, I think.
