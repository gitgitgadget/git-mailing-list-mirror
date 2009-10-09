From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix MSVC build on cygwin
Date: Thu, 08 Oct 2009 23:48:28 -0700
Message-ID: <7v3a5t6p1f.fsf@alter.siamese.dyndns.org>
References: <4ACE0388.6070706@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mstormo@gmail.com, GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Oct 09 08:51:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mw9Ji-0005Ea-45
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 08:51:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbZJIGtS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 02:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756858AbZJIGtS
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 02:49:18 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48265 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756565AbZJIGtS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 02:49:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DAA8B70444;
	Fri,  9 Oct 2009 02:48:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F1a0ftfEGyGOm1RXt1lFqISc8x8=; b=DnYryG
	TPWqtpiTjLTLwsNlaImGqwDPHglcTp7it+1fdgeM3xiK9azIkFI5KSmP9VY9dnYT
	VbFWEWmrh34cYlKUTUq16tXSW6NJ50t97YK9RtmO4SqdJ6drez4xExO/y90KfsIt
	bFFu2q1aUgoTPEusmXcNTHOxFgAfCpcFkJcfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ROjbdlX/ZLtpEkr7OHT2Y0RrsecbdLI5
	5b2t8pE66MYaess5lxADXiPiEfMbtbYv/LpsBrTAilS29+aE3fO+Or3KJAavx0N9
	YHpMixs0v1D+H9i0GYoTwDwM5lTAzCqlwrP3eQ5x1lCP6tZBIrM9hGtoEAqe7t8J
	qcJazPjvly8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B261C70443;
	Fri,  9 Oct 2009 02:48:33 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8FA7770442; Fri,  9 Oct 2009
 02:48:29 -0400 (EDT)
In-Reply-To: <4ACE0388.6070706@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Thu\, 08 Oct 2009 16\:21\:44 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C349BF22-B49F-11DE-B3EC-1000076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129741>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> In the MSVC section of the Makefile, BASIC_CFLAGS is set to a
> value which contains the string "-DWIN32-D_CONSOLE". This results
> in a (single) malformed -Define being passed to the compiler.
> At least on my cygwin installation, the msvc compiler seems to
> ignore this parameter, without issuing an error or warning, and
> results in the WIN32 and _CONSOLE macros being undefined. This
> breaks the build.
>
> In order to fix the build, we simply insert a space between the
> two -Define parameters, "-DWIN32" and "-D_CONSOLE", as originally
> intended.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>

Thanks; that's quite a detailed description to explain why -DFOO-DBAR is
bad when -DFOO -DBAR was wanted ;-)
