From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Set Makefile variables from configure
Date: Wed, 04 Nov 2009 11:36:32 -0800
Message-ID: <7v7hu6gjzz.fsf@alter.siamese.dyndns.org>
References: <20091103222123.GA17097@progeny.tock>
 <1257357960-12763-1-git-send-email-bwalton@artsci.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jrnieder@gmail.com, git@vger.kernel.org
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Wed Nov 04 20:36:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5lez-0001jV-1N
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 20:36:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757909AbZKDTgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 14:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757901AbZKDTgh
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 14:36:37 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57225 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757597AbZKDTgg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 14:36:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 717FA92371;
	Wed,  4 Nov 2009 14:36:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5ZclBgYRh3RENql+9+MtprLsjwo=; b=DARSuN
	IbdHKyafRcHWsvjPHGoPSMvwgIGfwCOiuBheKXTYwA7GPHZRk39CmmIKq0cCb3zP
	lW/j8x9Tm+Zu4Rp0Eqg+1ja8EIXM9RuvKWiN2hDBbrTuYhCQLWa4a6LKTTowOg0z
	rvtiNKOVyYqDBZxthKBfvdyPG6LXF+48eLqts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BA0nroqGgO1eJBr/bbwAhOxEgNCS/f5f
	ECV73lbfxE0iEv9Ol9hAFiNAQTS2KZSuOZi47A+SCHK0vfIV5+o49Sn1w1PrltuR
	qwdoVH9lGiXzFzAUaTzkEAk1OXFG8T/1Dkugcaudu4rNz+eanUbDLsr9p77W46Ih
	Kcz4hVF7QI0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 445E292370;
	Wed,  4 Nov 2009 14:36:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 059E49236B; Wed,  4 Nov 2009
 14:36:33 -0500 (EST)
In-Reply-To: <1257357960-12763-1-git-send-email-bwalton@artsci.utoronto.ca>
 (Ben Walton's message of "Wed\,  4 Nov 2009 13\:05\:58 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5E8F3A96-C979-11DE-BEED-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132119>

Ben Walton <bwalton@artsci.utoronto.ca> writes:

> Ok, a second attempt, taking into account Jonathan's feedback and
> proposed updates.  The revised macro allows for specified help text.
>
> I opted to use a more 'dry' approach to the macro instead of repeating
> the boilerplate AC_WITH_ARG bits when calling this feature.
>
> Additionally, I only WARN when 'yes' or 'no' is passed.  Bailing on
> errors in most cases is reasonable, but I don't think it's globally
> appropriate.
>
> As to why I want this...It's cleaner, in my opinion, to do all build
> configuration through a single mechanism than to do most with
> ./configure and the rest with variables passed to make.  In other
> words, this is purely a style issue.

Sorry, I wasn't following the discussion primarily because I am totally
uninterested in autoconf myself (it's purely a style issue and using a
single mechanism of echoing into config.mak is just as clean), so allow me
to ask a stupid question that might have been already answered while the
initial round was discussed.

I am a bit puzzled about the "warning" logic.  Is this because you expect
variables we typically give YesPlease/NoThanks as their values will not be
handled with this new PARSE_WITH_SET_MAKE_VAR() macro?
