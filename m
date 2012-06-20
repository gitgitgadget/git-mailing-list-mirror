From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 1/8] Makefile: apply dependencies consistently to
 sparse/asm targets
Date: Wed, 20 Jun 2012 13:10:19 -0700
Message-ID: <7vk3z1u4lw.fsf@alter.siamese.dyndns.org>
References: <20120619232231.GA6328@sigill.intra.peff.net>
 <20120619232310.GA6496@sigill.intra.peff.net>
 <20120620035015.GA4213@burratino>
 <20120620042607.GA10414@sigill.intra.peff.net>
 <20120620102750.GB4579@burratino>
 <20120620163714.GB12856@sigill.intra.peff.net>
 <20120620182855.GA26948@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 20 22:10:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShREU-0006kA-Rf
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 22:10:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758108Ab2FTUKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 16:10:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46757 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758030Ab2FTUKW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 16:10:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 99A848323;
	Wed, 20 Jun 2012 16:10:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xU6UvU+xd+QR7SLEOfn/OBWfTIY=; b=knVPCG
	8Yc3ghgJCnCDdR9d/7YR7DpJf2w2PNbI191vM+qtrpclzG2UDRbdkawG02eUwht1
	csiBlf44ESlQaBGA5RBuublP67/gRpsTbo4GUfNP8+pEg8mmqq71nuaVGJA2eJhA
	bLNJq7ATraEpX2RBfq8xxjkgwn0NhG2y05LAY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mUYghLk7krZigQ/AzYUUn063aH1wiPdD
	8lgNkCwd556qV8kereRojfE0qZiNT56OlmTo7lxsz1LXtZ2VihYCGCa0zW6Fk0b+
	dddpjwIxQ0hpjGFfXRFfypzrMTHJLeAbwjLgZofyhEQJDQOqKWiy+q8MF3D+9r5z
	JfKNn438yPE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E3828322;
	Wed, 20 Jun 2012 16:10:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 15BCA8321; Wed, 20 Jun 2012
 16:10:20 -0400 (EDT)
In-Reply-To: <20120620182855.GA26948@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 20 Jun 2012 14:28:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F66E00AC-BB13-11E1-B3A0-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200356>

Jeff King <peff@peff.net> writes:

> Here's an updated series that drops these lines and I hope will address
> the commit message issues you brought up:
>
>   [01/11]: Makefile: sort LIB_H list
>   [02/11]: Makefile: fold MISC_H into LIB_H
>
> New in this iteration to get rid of these largely pointless manual
> dependencies.
>
>   [03/11]: Makefile: do not have git.o depend on common-cmds.h
>
> New in this iteration.  I noticed while double-checking that this
> dependency is pointless.
>
>   [04/11]: Makefile: apply dependencies consistently to sparse/asm targets
>
> Updated based on earlier patches, and with a new commit message
> explaining a little more of what's going on.
>
>   [05/11]: Makefile: do not replace @@GIT_USER_AGENT@@ in scripts
>   [06/11]: Makefile: split GIT_USER_AGENT from GIT-CFLAGS
>   [07/11]: Makefile: split prefix flags from GIT-CFLAGS
>   [08/11]: Makefile: do not replace @@GIT_VERSION@@ in shell scripts
>   [09/11]: Makefile: update scripts when build-time parameters change
>   [10/11]: Makefile: build instaweb similar to other scripts
>   [11/11]: Makefile: move GIT-VERSION-FILE dependencies closer to use
>
> The rest are largely the same, but with a few minor textual updates to
> accomodate the earlier changes.

Looks good modulo a minor nit.  Will queue.

Thanks.
