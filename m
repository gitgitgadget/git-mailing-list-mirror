From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-svn, perl/Git.pm: extend and use Git->prompt
 method for querying users
Date: Tue, 03 Jan 2012 16:12:28 -0800
Message-ID: <7vy5toqqab.fsf@alter.siamese.dyndns.org>
References: <4EC52508.9070907@tu-clausthal.de>
 <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com>
 <4EC65DE4.90005@tu-clausthal.de>
 <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com>
 <4ED0CE8B.70205@tu-clausthal.de>
 <20111130064401.GC5317@sigill.intra.peff.net>
 <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain>
 <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de>
 <4EF9ED58.8080205@tu-clausthal.de> <7vd3b967ql.fsf@alter.siamese.dyndns.org>
 <7vty4l4rr8.fsf@alter.siamese.dyndns.org> <4EFA5F08.2060705@tu-clausthal.de>
 <7vpqf91kqo.fsf@alter.siamese.dyndns.org> <4EFAF241.9050806@tu-clausthal.de>
 <7v39c41keo.fsf@alter.siamese.dyndns.org>
 <7vpqf8z8a6.fsf@alter.siamese.dyndns.org> <4F00B7F3.1060105@tu-clausthal.de>
 <7vzke4vebl.fsf@alter.siamese.dyndns.org> <4F038E49.9080809@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Wed Jan 04 01:12:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiET6-0003Eg-0S
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 01:12:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755256Ab2ADAMc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jan 2012 19:12:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37306 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754975Ab2ADAMa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2012 19:12:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 239B672A9;
	Tue,  3 Jan 2012 19:12:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SPVFFfH8/zZsTnBHqUA+Sv3kZ6Y=; b=yFL075
	hraGHhhyFNQ8Aub7f8/jWHirGXLFKn8aVrU6lPtrMQ4YLieVR0TtBV4jzWLaus43
	ocL1OqyDgaKTiLMUwAN0vLhSIjByxxryZxUNhOIDeIYwzhGZWtESNKxN4/di1Due
	4/UOT/DjpxuJ6iqApFPEpnWbIH5Sm9xk5Rqik=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QDjUzmrF9LVINB1CCiOeeIwgfzzH07lq
	lirR+VG+eEI5Az2rCDMWvqMp4akt9eFwFQNwB5keFlVjIf8LFBNbPAWht86GbM/4
	w0LwPtf+rmnQQolObIeUJBo9YZS0fxX3KmB5UlKB8mTm8T22KRkRi37pVv1rXLlj
	Dd6Jh+D09as=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BBB572A8;
	Tue,  3 Jan 2012 19:12:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A11DE72A7; Tue,  3 Jan 2012
 19:12:29 -0500 (EST)
In-Reply-To: <4F038E49.9080809@tu-clausthal.de> (Sven Strickroth's message of
 "Wed, 04 Jan 2012 00:24:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CA521BE6-3668-11E1-9A10-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187908>

Sven Strickroth <sven.strickroth@tu-clausthal.de> writes:

> git-svn reads usernames and other user queries from an interactive
> terminal. This cause GUIs (w/o STDIN connected) to hang waiting forever
> for git-svn to complete (http://code.google.com/p/tortoisegit/issues/detail?id=967).
> git-core already asks for username using *_ASKPASS tools, this commit
> also enables git-svn to do so.
>
> This change extends the Git::prompt method, so that it can also be used
> for non password queries (e.g. usernames), and makes use of it instead
> of using hand-rolled prompt-response code that only works with the
> interactive terminal.

Now "prompt" is no longer a method but is merely a helper function, so
I've queued this (and 1/2 rewrite we discussed in a separate thread) to
'pu' after rewording the commit log message.

Thanks.
