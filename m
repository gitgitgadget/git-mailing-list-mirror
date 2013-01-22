From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Update :/abc ambiguity check
Date: Mon, 21 Jan 2013 20:10:50 -0800
Message-ID: <7vlibldfhx.fsf@alter.siamese.dyndns.org>
References: <1358773249-24384-1-git-send-email-pclouds@gmail.com>
 <7vsj5ufia6.fsf@alter.siamese.dyndns.org>
 <CACsJy8B1uxbJvP+0ZEx3br9_Qr9ZX7num8bcgd5sFS7XnvGNpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 05:11:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxVCj-00033W-Sm
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 05:11:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752865Ab3AVEK4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 23:10:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34807 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751404Ab3AVEK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 23:10:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25FA8BD04;
	Mon, 21 Jan 2013 23:10:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4UUwu5AWS+mxksdF3/ujlErVaws=; b=wKaUgw
	ncjXIMgTV0V2eqkH/5THpuyeRoU3dkqYnEJifh5JtlSTwWy/2GeqNy/jctIpdrqi
	a6LMr/ZJOveFQn6sjH50Fo1r9uUL/0VWqjkPq1U6BSAYata0WE5wbgN4dZGCaRSz
	bsunuhCJ43QXbXuKp3aYxJxDlXiaggitVPsHg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r43m24bUzzNi+VZFHi0RyDzCIQO100hj
	0NW2975hG2aE3v5gTOcLr5G9H6jCB+TacdM9PwKxOuZJtGchCJMn5IhgUAEje09d
	M1cHcGMpg/1zbVjIanAIDJ/IgpMJIAqMaXB4psMKeTzwJTXoc1T/iw/aCsbcRNy7
	I5W4C42pwk4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B9E0BD03;
	Mon, 21 Jan 2013 23:10:53 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9A12FBD01; Mon, 21 Jan 2013
 23:10:52 -0500 (EST)
In-Reply-To: <CACsJy8B1uxbJvP+0ZEx3br9_Qr9ZX7num8bcgd5sFS7XnvGNpw@mail.gmail.com> (Duy
 Nguyen's message of "Tue, 22 Jan 2013 09:46:13 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B62DCEDE-6449-11E2-AA1E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214190>

Duy Nguyen <pclouds@gmail.com> writes:

>>> ... take ":/abc" as rev even it's ambiguous. This patch makes it:
>>>
>>> - ambiguous when "abc" exists on worktree
>>> - a rev if abc does not exist on worktree
>>> - a path if abc is not found in any commits (although better use
>>
>> The "any commits" above sounds very scary. Are you really going to
>> check against all the commits?
>
> If I remember correctly :/ will search through commit chains until it
> finds a commit that matches. So :/non-existent-string definitely
> searches through all commits.

That is the real work the user asked us to do, so it is not a wasted
latency.  The description looked as if you were doing extra work
only for disambiguation, which triggered my "Huh?" meter.
