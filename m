From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add two grep config options
Date: Mon, 28 Mar 2011 10:12:23 -0700
Message-ID: <7vvcz3yxs8.fsf@alter.siamese.dyndns.org>
References: <1301088071-918-1-git-send-email-jratt0@gmail.com>
 <7vlj024wal.fsf@alter.siamese.dyndns.org>
 <4D9037AA.9090601@drmicha.warpmail.net>
 <20110328115421.GA9232@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Joe Ratterman <jratt0@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 28 19:12:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4Fzk-0001Pc-FZ
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 19:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754470Ab1C1RMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 13:12:41 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38600 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754227Ab1C1RMk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 13:12:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 07BFC4555;
	Mon, 28 Mar 2011 13:14:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EquHlARztONLSVJdNFGwozYBH7o=; b=azIfmq
	lg/JkaNF/400VTjPVXCCNL4HS+rIj5/SD6/1cKlG2WVcDEeuLCpLOdBMWw7gCbUY
	USsino6swwLiMMaqBDl8MC4QHdK5GNBTc6vHG0B5GmDYVFjp7rX/m4qKp0xxzOmm
	PzKDg4642ZSu831b7HSrRHRSEPi/8T81OLE3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A59bY/USw6BpGElxSyIOYlzc494zSgzA
	33ijn/Nw63bIj5vXEv2hPte5trUIa+igpLbJAYnN3hVLNQ0Duld9/FHVBwc6w7wn
	nvi046LK8huoyAKGkiIFZYAoR5pJR6Ia8n/rVqDXsFR0fFWehbHGNevligXIUGA4
	tEU4IKigj8g=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BA0BE4553;
	Mon, 28 Mar 2011 13:14:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 48F3C4552; Mon, 28 Mar 2011
 13:14:12 -0400 (EDT)
In-Reply-To: <20110328115421.GA9232@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 28 Mar 2011 07:54:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D040871E-595E-11E0-8FFA-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170160>

Jeff King <peff@peff.net> writes:

> One shortcoming of such a scheme, though, is that it is an
> all-or-nothing proposal...

I fully agree with this assessment, and I think that was the primary
reason that we rejected --plumbing / GIT_PLUMB (i.e. as too naive to be
useful).

> So what we really want is to let the script "allow" certain options from
> the user's preferences. This could be done easily with individual config
> options, like:
>
>   git --allow=grep.extended grep ...

I think this is probably the right thing to do _if_ we wanted to add such
a configuration variable and give a way to let script writers protect
themselves.

But would any user go all that trouble, just not to say "-nE" from the
command line (or use an alias that was designed not to crash with
scripts)?
