From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] setup_revisions: remember whether a ref was positive
 or not
Date: Mon, 08 Aug 2011 16:17:05 -0700
Message-ID: <7vy5z3trwu.fsf@alter.siamese.dyndns.org>
References: <1311517282-24831-1-git-send-email-srabbelier@gmail.com>
 <1311517282-24831-4-git-send-email-srabbelier@gmail.com>
 <7vy5znscst.fsf@alter.siamese.dyndns.org>
 <7vr55fs1z0.fsf@alter.siamese.dyndns.org>
 <CAGdFq_ghxFdpjxCgTNbqXWGpt0rpJaGZ1_h+ZC71PzaPzbQ-0A@mail.gmail.com>
 <7vy5zabbz7.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1108081748060.7748@s15462909.onlinehome-server.info>
 <7vfwlbztfg.fsf@alter.siamese.dyndns.org>
 <CAGdFq_hLy6_AW-Yh_9fi318Z6jdkFWw5+cYrwMtOitDkGQorFA@mail.gmail.com>
 <7vty9rv9p2.fsf@alter.siamese.dyndns.org>
 <CAGdFq_joHskwhp=934OjirmXiRMR3NbGd4s-hSjJc-gCFT_Jew@mail.gmail.com>
 <7vliv3v8cx.fsf@alter.siamese.dyndns.org>
 <CAGdFq_iHBE7eESpsX_doyfJu6EAkPOJpBgqkw1psMhqATf2oCw@mail.gmail.com>
 <7vhb5rv7x0.fsf@alter.siamese.dyndns.org>
 <CAGdFq_ioxeZUCnn-fFKuiT-6eVzVoph8eQE2j0hEbAxtDZzGnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 09 01:17:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqZ4N-0007xT-Q0
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 01:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753224Ab1HHXRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 19:17:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45857 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753080Ab1HHXRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 19:17:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AED3F4527;
	Mon,  8 Aug 2011 19:17:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tapzzNzt4fYrTh82AsBODzFlnLg=; b=i9KpJR
	Ln4VUJ7xsUhlbMR6iMBQr/t/YyS1eM0TUUx/0Xzu05q1DGumP5GbUggbIByGye3+
	p3Z7xO5dwZre+UTYPjoQ1nmL2tloVTMoBpyDPpkZlt3ENVwbhdb6xZSAM7CBpTrT
	DvWg/rPTmnHD0RoQ5wgOGY1+QpSiXaSpNZJtg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F/a/n0/VlnXIW7SBb0sDTEbSpnaq9itE
	nmVYUBApk43/BS5FO1UT5r8gk20na0wIHUbcjXghBcdAHEBQMFxFdCgVwWnkX/kE
	br9PDFEjZWKb85yiZ6AXWH2UZI6/7VwGgeTCJGm7w34vSFCX6Di2bYNah4S21mKI
	3wme49+4wxc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A50414526;
	Mon,  8 Aug 2011 19:17:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3186D4525; Mon,  8 Aug 2011
 19:17:07 -0400 (EDT)
In-Reply-To: <CAGdFq_ioxeZUCnn-fFKuiT-6eVzVoph8eQE2j0hEbAxtDZzGnQ@mail.gmail.com> (Sverre
 Rabbelier's message of "Tue, 9 Aug 2011 00:48:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 88DCA1EA-C214-11E0-A845-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179006>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Because no actual users are actually having this problem (e.g., at
> times typing "git diff ^C A B" and are seriously troubled by it), or
> at least haven't spoken up? Or do you meant that you are that user?

Yes, I am that user who have been disturbed by the command line revision
parser limitation for a loooooooong time and have been wanting to see it
properly fixed for quite a while (by myself or by somebody else).

Otherwise why would I have bothered to spend 93 lines to describe it and
its one possible solution that I _think_ is general enough to cover both
of the real issue identified in this thread?

I may probably be being slightly unfair, for two reasons. The primary
reason is because the affected codepath is so central to the UI that
fixing this properly is more important than various random tweaks we make
in other areas (which makes me particularly picky with respect to ensuring
that the future expansion would be easy). Seeing a single-bit "hack" not
from a complete newbie but from two known-to-be-competent long timers of
Git is another.

There are numerous hacks that try to work around the same revision parser
limitation (lossage of information), and I have been hoping that a series
that touch the parser to leave more information during parsing to be
cleanly enhancible to get rid of them (e.g. "git checkout $commit" vs "git
checkout $branch" looks at the command line itself, but it should be able
to call into the revision parser and inspect what the parser gives it
back).
