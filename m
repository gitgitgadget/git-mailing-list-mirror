From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] redundant error message
Date: Thu, 05 Dec 2013 13:44:12 -0800
Message-ID: <xmqq8uvz3rdf.fsf@gitster.dls.corp.google.com>
References: <CACsJy8BtCi_QSMZXfnscQmRyjvgSV1fG6smAOoCSab_e2YATxQ@mail.gmail.com>
	<20131205191518.GB19039@sigill.intra.peff.net>
	<xmqqsiu73w6n.fsf@gitster.dls.corp.google.com>
	<20131205200306.GA13443@sigill.intra.peff.net>
	<xmqqfvq73vhw.fsf@gitster.dls.corp.google.com>
	<20131205210000.GA19617@sigill.intra.peff.net>
	<20131205212851.GA21776@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 05 22:44:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vogid-00081g-9m
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 22:44:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754035Ab3LEVoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Dec 2013 16:44:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39865 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752148Ab3LEVoR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 16:44:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E45D058390;
	Thu,  5 Dec 2013 16:44:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PfXgYSC13pmpxwzjRbNRZOv6R/U=; b=Kr/gB0
	5P1x/Vf68zb1hjW7ozSqzar6aZmUtDZKVNvmDOsjfwqIXt13C6YoCf5Yz/cqfx4r
	PFrS6b82jPiMliniTdPsPj9KxseXaNrjAv+tySe2mbMpaI26uetJCaPWPygOcmr2
	YfsWoPtu7oCFJ61XpBdj8CKw+Ws3itChfoAlI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=slCqs/giLsS4pGXX32HCvcQnpkAUHqjp
	UYAfDZwZkoB1yJPmqO+1ZL4MrkxSS0q7QBQ04mmXeWycCF21NQkh+7B6atD9J7er
	q0bYw598I4phmX0KsR8O30330VdA8x/R8FWyroCBqCkJDAPyP0KgNJauGdEufaKB
	qFFc3blNTCI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D20955838F;
	Thu,  5 Dec 2013 16:44:16 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E41665838E;
	Thu,  5 Dec 2013 16:44:15 -0500 (EST)
In-Reply-To: <20131205212851.GA21776@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 5 Dec 2013 16:28:51 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 633B975E-5DF6-11E3-9E34-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238913>

Jeff King <peff@peff.net> writes:

> BTW, the raw looping to find "--" made me wonder how we handle:
>
>   git log --grep -- HEAD
>
> I'd expect it to be equivalent to:
>
>   git log --grep=-- HEAD
>
> but it's not; we truncate the arguments and complain that --grep is
> missing its argument. Which is probably good enough, given that the
> alternative is doing a pass that understands all of the options. But it
> does mean that the "--long-opt=arg" form is safer than the split form if
> you are passing along an arbitrary "arg".

;-) Good flow of thought.  As to your rev-parse change, I don't
immediately think of a hole/flaw offhand; it looked a good
straight-forward change to me.
