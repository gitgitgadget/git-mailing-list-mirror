From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'show' pretty %B without a diff
Date: Mon, 20 Dec 2010 10:05:16 -0800
Message-ID: <7v4oa8cobn.fsf@alter.siamese.dyndns.org>
References: <20101220073842.GC10354@external.screwed.box>
 <7vmxo0ddbm.fsf@alter.siamese.dyndns.org>
 <20101220111214.GD10354@external.screwed.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Vereshagin <peter@vereshagin.org>
X-From: git-owner@vger.kernel.org Mon Dec 20 19:05:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUk6z-00063O-PM
	for gcvg-git-2@lo.gmane.org; Mon, 20 Dec 2010 19:05:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757555Ab0LTSFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Dec 2010 13:05:24 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61802 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745Ab0LTSFY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Dec 2010 13:05:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 24DDF2141;
	Mon, 20 Dec 2010 13:05:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nZCF9h1fPsus4wV++PmLcaKFKLo=; b=EgsEIq
	GTIbMJ9RnRmSeZZ6Evwh6c2GFwanpgW4bqUexsLRpjP+O3uCZm/pQedlpbvEY9/x
	zH7/oGHWzXnRK+PerM8JTPV9E1q9x+wlvMxvfWsYJeBvUXwJBq13tX9gSxdc2VJY
	oUCpmZzwi+RBuOfjUJGF3ZUQtOx3Uw1YE03As=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RbRxTD8fv1XP2S2EAasJrvTpcO/nS5fZ
	5fZ29p/9pnHLsyXw6WQqI5w1/QjixNCWaWDz2aJbTVWgW5bALdc8A0vlqS4/MClF
	Ivfgc72eG8siSvhASu3306hQu2nBVfBNdt9+tRx3XJAdIx7NN8tOpFUS17Ek3phu
	xSu9AmAhwlI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EFF402139;
	Mon, 20 Dec 2010 13:05:49 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 136DE2138; Mon, 20 Dec 2010
 13:05:46 -0500 (EST)
In-Reply-To: <20101220111214.GD10354@external.screwed.box> (Peter
 Vereshagin's message of "Mon\, 20 Dec 2010 14\:12\:15 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C6E6B032-0C63-11E0-90C4-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164001>

Peter Vereshagin <peter@vereshagin.org> writes:

> JCH> Especially if you are doing a script, you probably should be using
> JCH> "cat-file commit" anyway, no?
>
> cat-file doesn't seem to support formatting option?

That is exactly why I suggested "cat-file", as you are scripting.  We
reserve the right to change the human-visible formatting output from
Porcelain commands like "show" any time to make it "prettier" (we may
start coloring strings that look like object names in the commit log
message in "git show" output, for example), while giving scripts more
stable output through the plumbing commands like "cat-file" so that they
can parse and process without having to worry about the output format
changing under them.

If your script is _not_ parsing the git command output, but is just
blindly spewing it out to the invoking user, it is Ok to use "show",
though.  Check "-s" option to the "show" command in that case.
