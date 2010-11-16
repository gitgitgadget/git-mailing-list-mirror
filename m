From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/3] Introduce sorted-array binary-search function.
Date: Tue, 16 Nov 2010 09:27:16 -0800
Message-ID: <7vy68ti3gr.fsf@alter.siamese.dyndns.org>
References: <1289255942-19705-1-git-send-email-ydirson@altern.org>
 <1289255942-19705-2-git-send-email-ydirson@altern.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Tue Nov 16 18:27:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIPJe-0000Ji-9i
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 18:27:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755789Ab0KPR12 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 12:27:28 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35769 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755679Ab0KPR11 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Nov 2010 12:27:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D3BBB3B2E;
	Tue, 16 Nov 2010 12:27:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h2fhs8zMTK09Gp9i+MPyZEOUodQ=; b=hy6xzc
	Eh8+5g+bEcO6k4A6106vAr/bUcWAR/q8JJ1nSrh6S6x+nfOU+WEGk4N5Gfn6U0FU
	XI2iHwt6xLO/5nM5UjEMNToRTF8353DQKGkSqVzZZT9OQ7znOHjnUnyf1E4dA0j2
	48VzBpuTyPqzGiSc6Zn4IGwi261+mdRmOpyLw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xbmz31sAbptkP8bd36EAX8JRZyvgxvgn
	rkv7t9NFA7nfx0adfyR1cPHmvP/euM2h1X99BTQG51CsKACcksbtyV21DXKhcaDw
	zdj4OlzFnxAN/0LEICxBwCf+zjiO4ZLh9SZo5xis5zSe1XC8q91HdU29c29hwMBK
	nta++AOAPsU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B295D3B2D;
	Tue, 16 Nov 2010 12:27:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9C0DE3B29; Tue, 16 Nov 2010
 12:27:28 -0500 (EST)
In-Reply-To: <1289255942-19705-2-git-send-email-ydirson@altern.org> (Yann
 Dirson's message of "Mon\,  8 Nov 2010 23\:39\:00 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CAFCF168-F1A6-11DF-BEED-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161566>

Yann Dirson <ydirson@altern.org> writes:

> We use a cpp-based template mechanism to declare the array and its
> management data, as well as a search function, derived from locate_rename_dst()
> from diffcore-rename.c.  Thanks to Jonathan Nieder for this design idea.

Hmmm.... Yet another binary search...

Can we generalize the existing ones first before adding any of this in
(hint: look for "git grep -w -e hi --and -e lo")?
