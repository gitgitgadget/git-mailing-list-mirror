From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i -p: use rerere to resolve conflicts if enabled
Date: Sun, 17 Jun 2012 15:12:04 -0700
Message-ID: <7vy5nl611n.fsf@alter.siamese.dyndns.org>
References: <1339769855-94161-1-git-send-email-ddkilzer@kilzer.net>
 <7vwr38bmj5.fsf@alter.siamese.dyndns.org>
 <B4036488-1ECA-41C9-BD97-B2ABD116D54C@kilzer.net>
 <7vd34z96lv.fsf@alter.siamese.dyndns.org>
 <76A6615B-5758-4D67-A556-2EE131FF7B20@kilzer.net>
 <7vmx427aj0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kilzer <ddkilzer@kilzer.net>
X-From: git-owner@vger.kernel.org Mon Jun 18 00:12:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SgNhf-0001xi-FS
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jun 2012 00:12:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753181Ab2FQWMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jun 2012 18:12:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60178 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751943Ab2FQWMH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2012 18:12:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AAF079795;
	Sun, 17 Jun 2012 18:12:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r2G1/ZtZEhnu5JHOurZMedpVmKM=; b=Jqb3ES
	qttkkPs12my/C0+n/6dL9bjC9Tm5aUOYFTB+qkXEln9KWMFfKD+BaBpi9OQTgRQc
	M8E98UZ1ll4cKwtC3HYt8BlmOpHyByv2sT4530dtESbUd83WsviGx2AMCBq2oj0T
	94L0ScKOZMYW5Qn5kdGTusshinehfRnHeSa4s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TQscCw1HgnrSHfxoKQ3ge2z7WRzps+Zl
	HG+4VhYPmtfwc+s7so5ioM5iUKkBaWmGobGM26m6c0if8zq+NRlvAQyRmqSMk+J4
	QWmnIWWpgJ7ZssSRBKnRwUwQHs6hD+5ZQRl70UHLdIiIOiRnAUi9Tct/yNOYjee9
	AFOq2gK8Bg8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A1DA69794;
	Sun, 17 Jun 2012 18:12:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 338509793; Sun, 17 Jun 2012
 18:12:06 -0400 (EDT)
In-Reply-To: <7vmx427aj0.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 16 Jun 2012 22:49:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7961C144-B8C9-11E1-9511-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200133>

Junio C Hamano <gitster@pobox.com> writes:

> Or are you only talking about the error exit from "git merge" that
> would cause "git rebase -i" to stop and give control back to the end
> user?
>
> I suspect that the latter behaviour to stop "rebase" in the middle
> is in line with the spirit of --rerere-autoupdate, and it is not
> likely that we would want to change it.

See this for the background:

  http://thread.gmane.org/gmane.comp.version-control.git/85176/focus=85231

The entire thread (except for articles from a few uninformed
noisemakers) is worth a read, as some issues that were discussed
have resulted in more recent "rerere", and the original inquiry by
Ingo illustrates the motivation behind them quite clearly.

And we can see that I was right when I wrote in the above that not
committing is the right thing to do for --rerere-autoupdate /
rerere.autoupdate even though I did not remember that thread.  The
second step described as "the way forward" in the quoted article
hasn't happened yet.
