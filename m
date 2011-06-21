From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 12/13] revert: Introduce skip-all to cleanup sequencer
 data
Date: Tue, 21 Jun 2011 13:02:13 -0700
Message-ID: <7vtybj6ji2.fsf@alter.siamese.dyndns.org>
References: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
 <1308661489-20080-13-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 21 22:02:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ79X-0002iV-U8
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 22:02:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756985Ab1FUUCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 16:02:18 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56657 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756854Ab1FUUCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 16:02:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2856E4CDD;
	Tue, 21 Jun 2011 16:04:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pa+FYI22zhngwZafBmJHVI2frYM=; b=bL6kF9
	nIDYn+/OAsxjcL9wfjouLxt0lt4NUTOlUFTNbAJ067naMf3NhDbn9VPMgMjvEs7X
	FDu9Vt47GHGjW1GZrVnF95VUTBhqxjuGgKXKHcfPDd2ZbAonmi4sDp1RRZj2s76V
	qpuB4wKixJ1UCC2s+RZNHXiyjM2zNWh1+pX+A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lMmz8ZVCjT86vvkvmXv00V2ZPd+NfLpV
	gc+ZAd4L7iMkX0KD+nJ2vEfElYPaP/KAr488vvlXkYPAFxdD01RGG2WIAt3lRBvW
	5HYlwDCdqVgDOppA/96Z+6iH1I2ADHtA+T1MyYhF0/Vd3WEm7yb5OUYaaz6rpwNz
	FTPs30pmZg8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 21B544CDC;
	Tue, 21 Jun 2011 16:04:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 755A34CCB; Tue, 21 Jun 2011
 16:04:27 -0400 (EDT)
In-Reply-To: <1308661489-20080-13-git-send-email-artagnon@gmail.com>
 (Ramkumar Ramachandra's message of "Tue, 21 Jun 2011 13:04:48 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AAE79874-9C41-11E0-A0C3-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176192>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> diff --git a/builtin/revert.c b/builtin/revert.c
> index 5c0b97e..eb68068 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -46,6 +46,9 @@ enum replay_action { REVERT, CHERRY_PICK };
>  struct replay_opts {
>  	enum replay_action action;
>  
> +	/* --skip-all */
> +	int skipall_oper;

Yikes what is that "oper" doing there?  Don't truncate a word in the
middle only to shorten names and make it unclear what you want to say. Is
that operand? operation? In this case, I think "int skip_all" is
sufficient, and you can lose the comment that adds no extra information.
