From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/2] mergetools/p4merge: create a base if none
 available
Date: Mon, 25 Mar 2013 10:47:25 -0700
Message-ID: <7v7gkvz80i.fsf@alter.siamese.dyndns.org>
References: <1363137142-18606-1-git-send-email-kevin@bracey.fi>
 <1364126098-10788-1-git-send-email-kevin@bracey.fi>
 <1364126098-10788-2-git-send-email-kevin@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Mon Mar 25 18:48:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKBUy-0007Sd-TP
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 18:47:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758785Ab3CYRr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 13:47:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64751 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757857Ab3CYRr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 13:47:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D1FEAB43;
	Mon, 25 Mar 2013 13:47:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7fGZUsXrE2X72MrLg+11YsurG/k=; b=fpPvwr
	3x+ihrhKPk9YOYRaBJoMhVvkpo1hz+N0VbH2FcuUr2Ypaxbbv51nDut894Dtcgpn
	RQeAV3C29Jxuf+xOpODXiM0azfAusfdSb2FsdYurckjMM/Z7vh9Q2AJteqqe+3LJ
	cbFthQ7yZmTGIbZLWLHGvSlipZ01KTbDosCMU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qjgJGXOdFdFwonhrpnVVkH8ua3uZgu+H
	v7kLQRPry7YZVZenCWrsS5fH0A9gOoYF0CIdt2Vgg6Bh2VcGLOiudgTb7EOh6f70
	yaexZIMO/KVijt60ub4/+uCqdPy0bdgnT2rMKr+ZYaHpCgiT9E5Ht6fThV1V/vfD
	Y/CPBMCqs1M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62325AB42;
	Mon, 25 Mar 2013 13:47:27 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D2824AB41; Mon, 25 Mar 2013
 13:47:26 -0400 (EDT)
In-Reply-To: <1364126098-10788-2-git-send-email-kevin@bracey.fi> (Kevin
 Bracey's message of "Sun, 24 Mar 2013 13:54:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0EA0D7FE-9574-11E2-A8DE-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219049>

Kevin Bracey <kevin@bracey.fi> writes:

> Minor change from v3: that version moved initialisation of src1 higher up,
> detaching it from its associated comment. This move was only required by
> earlier versions, so v4 leaves src1 in its original position.

The "funny filename" comment was from b539c5e8fbd3 (git-merge-one:
new merge world order., 2005-12-07) where the removed code just
before that new comment ended with:

	merge "$4" "$orig" "$src2"

(yes, we used to use "merge" program from the RCS suite).  The
comment refers to one of the bad side effect the old code used to
have and warns against such a practice, i.e. it was talking about
the code that no longer existed.

I think the two-line comment should simply go.

Given that, I _think_ it is OK to move the initialization of src1
next to that of src2; that may make the result easier to read.

Thanks.
