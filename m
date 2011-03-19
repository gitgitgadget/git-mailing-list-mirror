From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] gitweb: rename parse_date() to format_date()
Date: Sat, 19 Mar 2011 11:00:51 -0700
Message-ID: <7vwrjvq9bg.fsf@alter.siamese.dyndns.org>
References: <ab54ba2199cc7487e383a31e3aa65885@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 19:01:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q10SZ-0005XC-FT
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 19:01:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756894Ab1CSSBD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 14:01:03 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64378 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756828Ab1CSSBB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 14:01:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D548D3E79;
	Sat, 19 Mar 2011 14:02:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=OjENFxMXW5VDFavW2njpdfZwTtg=; b=Grxe4D
	AyGvHCp77CayvB014p3RyrOlwegRlhBTZRnVzqwvEIrtE1Xy6HELtWCg83Dmi9VZ
	WfZ6jZ6SQ6/bI+rft+i7m27hspJIDCyNvTdJrw4n+9/w2dv3bhfr1WniuL0Zto2d
	XzgMpj1qCXMdph47nrp+YKOr3fckd2jSQ3d+w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YDRNU8HzSehcY8egk9NkP9eciq58wOiB
	L5OHFXGGdduRnNSfXQAcMw2+n+w03MmJvOftxFXd6X+9ox7ufezsKqV9BwwVVxmD
	Pl9+aprVykyR5UOHe7flM//d2u1eORoZHX48/iBx2DQShRRIw+tvEwYxZiXw1scb
	tOPQhWcq8ko=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A100D3E78;
	Sat, 19 Mar 2011 14:02:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 83F5D3E76; Sat, 19 Mar 2011
 14:02:29 -0400 (EDT)
In-Reply-To: <ab54ba2199cc7487e383a31e3aa65885@localhost> (Kevin Cernekee's
 message of "Fri, 18 Mar 2011 22:39:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 109F433A-5253-11E0-90D0-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169452>

Kevin Cernekee <cernekee@gmail.com> writes:

> One might reasonably expect a function named parse_date() to be used
> for something along these lines:
>
> $unix_time_t = parse_date("2011-03-19");
>
> But instead, gitweb's parse_date works more like:
>
> &parse_date(1300505805) = {
>         'hour' => 3,
>         'minute' => 36,
>         ...
>         'rfc2822' => 'Sat, 19 Mar 2011 03:36:45 +0000',
>         ...
> }
>
> Rename the function to improve clarity.  No change to functionality.

Except for a small detail that the function also takes the "-0800"
timezone string, I think this is a good change.

The word "parse" makes the readers expect that its input is something
"format" would have produced for use by others (often humans, but there
are functions that parse xml ;-).
