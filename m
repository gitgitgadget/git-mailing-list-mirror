From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 3/4] git-status: show short sequencer state
Date: Wed, 14 Nov 2012 05:29:55 -0800
Message-ID: <7vy5i4b9d8.fsf@alter.siamese.dyndns.org>
References: <1351553513-20385-1-git-send-email-hordp@cisco.com>
 <1352487385-5929-1-git-send-email-hordp@cisco.com>
 <1352487385-5929-4-git-send-email-hordp@cisco.com>
 <7vip9aiuk8.fsf@alter.siamese.dyndns.org> <50A13C9A.8070108@cisco.com>
 <50A2DCD7.4050909@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, phil.hord@gmail.com,
	Jeff King <peff@peff.net>, konglu@minatec.inpg.fr,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Kong Lucien <Lucien.Kong@ensimag.imag.fr>,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 14:30:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYd2j-0004eo-Eq
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 14:30:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422900Ab2KNN37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 08:29:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38322 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752262Ab2KNN36 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 08:29:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC6F56484;
	Wed, 14 Nov 2012 08:29:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mijEysiI4J+w/o74LY8k826uD6c=; b=GXcbeF
	Ta/9/92SLAqaVGvRSRrvNBjEYYs/A5m6fVGJ7Zi8vBRqIBghF4g2D21gZ15rfMxv
	m/gYXD2oT3qeHJ/mbP4xG/0X1BdPNwhABJnvShf29CEM9+2Q1qf19ZfUJQNY6ylw
	f++/Pr+HGWVByPnj4COn67xZ4ksqy4D6ufoX4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xLbiAVBG/Adgcg4uapF9mrC5lvf73i7J
	IWZEB/3V4byqxSx+05bNS4yPXzOl8EyESur7liFYz6vroV2YQJBsWCiEgyvpDkLE
	ELA/JierB/ZxCURhmg0CWX8be3SZ5LFD8hgP9B/lRKJhI2bOCq5Fs4QzPd4+7Jqt
	Boyf0mEGyRk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C944E647D;
	Wed, 14 Nov 2012 08:29:57 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1A9C4646F; Wed, 14 Nov 2012
 08:29:57 -0500 (EST)
In-Reply-To: <50A2DCD7.4050909@cisco.com> (Phil Hord's message of "Tue, 13
 Nov 2012 18:50:47 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 61C220FE-2E5F-11E2-AEBE-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209717>

Phil Hord <hordp@cisco.com> writes:

>> Do you think '--tree-state' is an acceptable switch or do you have other
>> suggestions?
>
> I've been calling these 'tokens' myself.  A token is a word-or-phrase I
> can parse easily with the default $IFS, for simpler script handling.

That name may be good for variables, but it is good only because you
as the implementor know what purpose the tokens are used for.
Instead of having to call them with a longer name, e.g. "state
tokens", only because you know that these tokens represent tree-wide
(as opposed to per-file) state, you can call them "tokens" in your
implementation (and in your head) without confusing yourself.

To the end users who should not care about the implementation
detail, it is not a good name at all.  The UI should surface the
purpose, i.e. what these tokens are used for, (e.g. to represent
tree-wide state) more than the fact that you happened to represent
them with a single short word (i.e. "token").

So --show-tree-state, --include-tree-state-in-the-output or
something along that line that tells the user what the option is
about is more preferable than --token.  After all, you may want to
use tokens to represent different kind of information in a later
topic that is not about a tree-wide state, and you will regret that
you used --token for this particular feature at that time.
