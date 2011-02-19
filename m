From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Merging limitations after directory renames -- interesting test
 repo
Date: Fri, 18 Feb 2011 16:52:34 -0800
Message-ID: <7vsjvkn8vh.fsf@alter.siamese.dyndns.org>
References: <AANLkTimsQmOLDENX27YqpicBeFFZrfgEAsLvFiJqoV7w@mail.gmail.com>
 <20110218222151.GB4258@sigill.intra.peff.net>
 <AANLkTimKp+Z==QXJg2Bagot+Df4REeANuxwVi7bpPCXr@mail.gmail.com>
 <AANLkTimuU4A7sUqo-dpW3ch4H_WJg+G2ynNmagx=C9t8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Feb 19 01:52:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pqb47-0003R4-97
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 01:52:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752931Ab1BSAwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 19:52:47 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52365 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118Ab1BSAwq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 19:52:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D87DA3760;
	Fri, 18 Feb 2011 19:53:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Swvo8XZ3BTtRoYXgzixxXeZh2Vs=; b=mj/jdY
	9lKykFFbyJnAWcaZy3MEx2IaRlDojPTma/rLeO5xizyWnWj9MVG/hroJOYBbFz3K
	hS1V0BttxN6jsL2+iUk+X4BLUtINud8jUL6SkUvnhnTciJOvpIUBqVnEsZKPoSeD
	WcpPXPJhPo4XEbICS+8qTHi8vgXprzkk+/tP4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b2l/1/WsVZ4S8dpcaacdYzPntpWsGcFq
	TLJV6vTMJRoc8pIK74lw0sdWEx6Lzb5uMDsEtUTgs3lqaK7SL+Z0rTrlm2CH0nZj
	T0O+c4E2MgLnqCTvD1ueV80uv2DRgn2tbrIfif3S25q0PjALF644Gg6TzJJ541dU
	+fPeFpS8rlw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 91113375F;
	Fri, 18 Feb 2011 19:53:49 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 51F44375E; Fri, 18 Feb 2011
 19:53:44 -0500 (EST)
In-Reply-To: <AANLkTimuU4A7sUqo-dpW3ch4H_WJg+G2ynNmagx=C9t8@mail.gmail.com>
 (Linus Torvalds's message of "Fri\, 18 Feb 2011 16\:26\:14 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B6A8F778-3BC2-11E0-9218-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167241>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> And the bug is that we didn't even ask for copy detection! This just
> confuses merging more.

Yeah, I think it is probably a good idea to really limit the rename
detection only to renames at least inside merge-recursive.  The static
variable does look ugly but it shouldn't be a rocket surgery to pass it
down if we want to.
