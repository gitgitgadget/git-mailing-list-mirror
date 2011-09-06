From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: abort on shells that do not support
 ${parameter%word} expansion
Date: Tue, 06 Sep 2011 13:01:29 -0700
Message-ID: <7v62l58mp2.fsf@alter.siamese.dyndns.org>
References: <7vbouzxy7g.fsf@alter.siamese.dyndns.org>
 <rPnr5AVZRRnklxb_Yaj0gopXRTVCT-tq7iVG-1NoXjOrHWsyuLop-co4qtQjezJ98BaKc0R71r8fMcBOijq9oCOgfBF6ticVk17DwDQzV91bcC719fGSUPDsf40AuoRfgjURcxREkMk@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Naohiro Aota <naota@elisp.net>, git@vger.kernel.org,
	tarmigan+git@gmail.com, David Barr <davidbarr@google.com>,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Sep 06 22:01:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R11px-0000NV-QP
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 22:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754889Ab1IFUBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 16:01:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55592 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754812Ab1IFUBc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 16:01:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F14794CD8;
	Tue,  6 Sep 2011 16:01:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MN1eSJ/x5tJXtIZmNu2J1OEwc5w=; b=UTitmg
	hiusKQYTULsgbN34GAIpABgi23rMvoMNG9+ztG8fc3VOJNg0kW5444e8mlk6SwjO
	5kTexc2c57/tm2TQO+h8a+qfV3ZbGiTAB7HX/R9TKIgcfotYdMW/m1J7BA3tjhnt
	VL8rXOYSzpucACv121NNxfAnWt1Z/jVDmyfLA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TF18tQZmWuwv0E6ve8I7HvhMA4ni7xGb
	bLMRnAQHeUOgm3a3ESriwnO8ESu8LxToR8HpWeuj3TqaXyKo2eJI3s9EzPQMAYw7
	XVqmhcbgPOkbr3HddL2oOBZMplv9W6dvWuIiboYcZ0HxVRSjQjokZe4HiwrTH2tf
	FNeKCkD4wVI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E74F94CD7;
	Tue,  6 Sep 2011 16:01:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 50D9C4CD6; Tue,  6 Sep 2011
 16:01:31 -0400 (EDT)
In-Reply-To: <rPnr5AVZRRnklxb_Yaj0gopXRTVCT-tq7iVG-1NoXjOrHWsyuLop-co4qtQjezJ98BaKc0R71r8fMcBOijq9oCOgfBF6ticVk17DwDQzV91bcC719fGSUPDsf40AuoRfgjURcxREkMk@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Tue, 6 Sep 2011 14:09:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 03B38F0E-D8C3-11E0-A116-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180827>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> From: Brandon Casey <drafnel@gmail.com>
>
> Add an entry to the please_set_SHELL_PATH_to_a_more_modern_shell target
> which tests whether the shell supports ${parameter%word} expansion.  I
> assume this one test is enough to indicate whether the shell supports the
> entire family of prefix and suffix removal syntax:
>
>    ${parameter%word}
>    ${parameter%%word}
>    ${parameter#word}
>    ${parameter##word}
>
> FreeBSD, for one, has a /bin/sh that, apparently, supports $() notation but
> not the above prefix/suffix removal notation.

My reading of the later part of the thread you are basing the above is
somewhat different from your diagnosis. The funny seems to happen only
when there is a backslash-quoted glob special inside double-quotes
(e.g. "${parameter%\?*}") and the same shell does not seem to be choking
on many prefix/suffix expansion used in other test scripts.
