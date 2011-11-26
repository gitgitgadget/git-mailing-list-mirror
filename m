From: Junio C Hamano <gitster@pobox.com>
Subject: Re: what are the chances of a 'pre-upload' hook?
Date: Sat, 26 Nov 2011 15:13:38 -0800
Message-ID: <7vr50uwk7x.fsf@alter.siamese.dyndns.org>
References: <CAMK1S_jaEWV=F6iHKZw_6u5ncDW0bPosNx-03W9bOLOfEEEY1Q@mail.gmail.com>
 <CAMK1S_gh_CsWc-DnbOuUwn+H1i3skm99xzDbWe-wxsKKS0Qw-w@mail.gmail.com>
 <20111125144007.GA4047@sigill.intra.peff.net>
 <7v7h2my0ky.fsf@alter.siamese.dyndns.org>
 <20111126225519.GA29482@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 27 00:14:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RURRZ-0006CD-Cw
	for gcvg-git-2@lo.gmane.org; Sun, 27 Nov 2011 00:14:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755136Ab1KZXNo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Nov 2011 18:13:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46897 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755122Ab1KZXNl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Nov 2011 18:13:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 195B75B08;
	Sat, 26 Nov 2011 18:13:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lNVWGpZbh0Uwm5eDS/JVPOoPpMA=; b=WUr05l
	Txes/UxdkesnBmfJORaRZQShuHLDkP8jFgGM04Sl0w+ifhhDBI839DPtnPmTQJtO
	ih0dEOUC86LIoN3EwUDPEsdN8/4dQed97GoQ4whikm7G4XP1lDtDgneThWdM1i/F
	/LoUJ22RZpqal0HeP8J5e10qTm4YeBvQl0I/c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LtD/X4r9rC4pdZlVi4GM7IhOeXdKEzHr
	R0NQHm1Jja2EymJ/au1BAsYekLCXxOnDzod5B2OrPbRA/oygneYFgem6B3f82Fzg
	RstjCGjnQkIgJsHVrH/wgFlVDxw2cB7FOTho35HgsOYCmXr0+DMgZw4r2rGns3du
	5Nlob8MNflA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E9585B07;
	Sat, 26 Nov 2011 18:13:40 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9777B5B05; Sat, 26 Nov 2011
 18:13:39 -0500 (EST)
In-Reply-To: <20111126225519.GA29482@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 26 Nov 2011 17:55:20 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 468E6B86-1884-11E1-ADBF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185959>

Jeff King <peff@peff.net> writes:

> Bob could run a specialized server for (b) that listens on a unix socket
> and triggers his hook. But why? Why not just do the whole thing over
> git-daemon or smart http, which already exist?

If that "whole thing" is "to allow an arbitrary code to run anywhere as
incoming user", I would apply the "why?" to a different part of the
statemennt. Why allow running an arbitrary code at all?

Running things as Bob with setuid is not a solution, either.

A pre-anything hook wants to see if the accessing user, not the owner of
the repository, can or cannot do something to the repository and decide
what to do.
