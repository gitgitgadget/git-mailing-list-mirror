From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] git_mkstemp_mode, xmkstemp_mode: variants of
 gitmkstemps with mode argument.
Date: Sat, 20 Feb 2010 11:22:38 -0800
Message-ID: <7veikfk8zl.fsf@alter.siamese.dyndns.org>
References: <vpq7hq8stjt.fsf@bauges.imag.fr>
 <1266621718-4879-3-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sat Feb 20 21:36:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Niuug-0007yL-Rh
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 20:22:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755871Ab0BTTWp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 14:22:45 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54256 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755587Ab0BTTWo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 14:22:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B8209B9E2;
	Sat, 20 Feb 2010 14:22:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Thd4Zb7/uzmohbUP6Z4CfULuFIM=; b=bsOHgRCOwevK67f1wY1evRW
	GccoXg7vIJw7poS95cxoQrBwpSiUG5oKoh0N8Mn6knGEaxgkBNJ/0DNJ6senziYH
	w9jMdw8ZEse1O849eaL9zOz3CKRN4GO/Qf7lTob1sq70WQCJVHWhqxYn0MeuuiQJ
	6xqU44A/PabtwWmqHPto=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=rglquGL9A03Cx2NPu+sJW73Qsr9DiEL4ioOYhH6KD0tnALnFC
	z5kfEl4K4M475jnllIgD3+6C6ZDOUz9saCjaqFricRyLwT0/X8+rGHrVeotsQvev
	JE1TprKl+CwPbUPzIWsP4wIjTc/t+rLzSvFVklrZ67Xk57UNUd2+yxqGsU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 690B29B9E1;
	Sat, 20 Feb 2010 14:22:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CC67B9B9E0; Sat, 20 Feb
 2010 14:22:39 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 50F957E6-1E55-11DF-A14B-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140549>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> gitmkstemps emulates the behavior of mkstemps, which is usually used
> to create files in a shared directory like /tmp/, hence, it creates
> files with permission 0600. But we use it also to create pack files,
> which do not need this protection.

... and the conclusion is???

	Add git_mkstemps_mode() that allows us to specify the desired
        mode, and make git_mkstemps() a wrapper that always uses 0600
        to call it.  Later we will use git_mkstemps_mode() when creating
        pack files.

Without it, it sounds as if "so we change it not to do 0600 because I only
care about packfile creation, and do not care about future bugs when
people assume that git_mkstemps() behaves just like mkstemps()", but that
is not what you did.
