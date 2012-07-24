From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/7] i18n: rebase: mark strings for translation
Date: Tue, 24 Jul 2012 11:57:11 -0700
Message-ID: <7vtxwxf0mw.fsf@alter.siamese.dyndns.org>
References: <cover.1343112786.git.worldhello.net@gmail.com>
 <b263c2bcc5dd6d611a1e3a4f6a87042d4cdb50aa.1343112786.git.worldhello.net@gmail.com> <20120724180138.GF2939@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 20:57:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StkIK-0002zm-T7
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 20:57:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755839Ab2GXS5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 14:57:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47849 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755106Ab2GXS5O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 14:57:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C02728450;
	Tue, 24 Jul 2012 14:57:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8TlwWimlOfW0XW40L+zIdigp8u4=; b=gf3T+M
	N04dmgxlHzidRf0X7uhp/ZTKqtWMKCO2l7uMGqHCLlkh7E+44++Rhg6uLHijeheu
	+6TJCcg5G0Hw3NGINmgKXxbwY2NHL6S3Z2QWJSCw6bZinSAcegv6QiuIoEJowdjL
	5KroGMJqVu6nDPtilsDFbqi7ntDqti9wvLEm0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FDN5oDK8icGRNT02F43PSkEJ6lmjkvB8
	lLLqdHLOw/+yulhLHH9fMT3in6rrJqRfGiPUMjkmTH0lFGi7LUSvT6P7CgK9BIJX
	wb0SQLZTeIPglmfmyzF9p5QvBVfdcL6+SUnH9wTmpCfpFQ7KF6xVDQhnghMEwv+l
	S7S5/gpU8uY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABFE4844F;
	Tue, 24 Jul 2012 14:57:13 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D9EC844D; Tue, 24 Jul 2012
 14:57:13 -0400 (EDT)
In-Reply-To: <20120724180138.GF2939@burratino> (Jonathan Nieder's message of
 "Tue, 24 Jul 2012 13:01:38 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 610A623A-D5C1-11E1-B7D3-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202052>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Probably it would make sense to do
>
> 	resolvemsg="
> 	$(gettext 'When you have resolved this problem, run "git rebase --continue".
> 	If you prefer to skip this patch, run "git rebase --skip" instead.
> 	To check out the original branch and stop rebasing, run "git rebase --abort".')
> 	"
>
> anyway, so the translators could have fewer newlines at the edges to
> fuss about.

Nice.

> Maybe, to allow changing the commands without having to update
> translations:
>
> 	state_dir_base=...
> 	cmd_live_rebase='git rebase (--continue | --abort | --skip)'
> 	cmd_clear_stale_rebase="rm -fr \"$state_dir\""
> 	die "
> 	$(eval_gettext 'It seems that there is already a $state_dir_base directory, and
> 	I wonder if you ware in the middle of another rebase.  If that is the
> 	case, please try
> 		$cmd_live_rebase
> 	If that is not the case, please
> 		$cmd_clear_stale_rebase
> 	and run me again.  I am stopping in case you still have something
> 	valuable there.')"

Again, nice.

Thanks.
