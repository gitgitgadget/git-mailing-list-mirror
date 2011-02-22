From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How do I make git-format-patch reject 8-bit encodings?
Date: Mon, 21 Feb 2011 16:19:16 -0800
Message-ID: <7vbp24hqez.fsf@alter.siamese.dyndns.org>
References: <4D62E315.7040506@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Timur Tabi <timur@freescale.com>
X-From: git-owner@vger.kernel.org Tue Feb 22 01:19:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Prfya-0003yQ-RX
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 01:19:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246Ab1BVATZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 19:19:25 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59672 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584Ab1BVATX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 19:19:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 32685441C;
	Mon, 21 Feb 2011 19:20:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jIsyaBfTOBn3Gw8ebfLDuRXkJlg=; b=LIXpVo
	bMPt63sS1YYG/n0+C2bjfkfkeOIniYqLg1jqARaWZ9/uJ0voZE4H9wmvUgHUjODx
	U7mFgV93Y5i6DgIHuwZy1vFwN4CtzCXLV5l+o2W4RPI6TIHhCgV/T6Qh2rcPB8gn
	v8zviPoiByYcykR2KM68w2SPVZUCWjNAHnjXg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=svvdOM44WcGTia1iSRp443kk7aDmrQEM
	eLK5/aAe1KgCJGQ6I+XCNDM9QXclmB53uIGAboMjxISNpFPz48eDX7Kqx0brfnJU
	GPFg0wH4vW7Hi/h/WCGXE6gDh6r+uvUK8MFfs/outA4oNQw1SLrWcgYP/sNbm8uM
	qXcNgNFpW40=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0FFE1441B;
	Mon, 21 Feb 2011 19:20:32 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 24CBB441A; Mon, 21 Feb 2011
 19:20:28 -0500 (EST)
In-Reply-To: <4D62E315.7040506@freescale.com> (Timur Tabi's message of "Mon\,
 21 Feb 2011 16\:11\:33 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8F4A6B5E-3E19-11E0-B9F1-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167517>

Timur Tabi <timur@freescale.com> writes:

> Is there any way to get git-format-patch to refuse to create a patch that has
> 8-bit characters in it?  That is, if a given commit somehow has an 8-bit
> character (e.g. utf-encoded), then I want git-format-patch to refuse to create a
> patch for that commit.
>
> Also, how can I do the same thing with git-send-email?  That is, if the patch
> requires an 8-bit encoding, how do I get it to refuse to send the patch?

Feels like an X-Y problem, but wouldn't it be an option to let
format-patch write into individual files, check these files and reject
ones that are not 8-bit clean, and then send the result out via
send-email?  You should be proofreading the format-patch output to catch
and fix typos before hading them to send-email anyway, so the above would
be the natural thing to do.
