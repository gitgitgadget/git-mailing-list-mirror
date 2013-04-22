From: Junio C Hamano <gitster@pobox.com>
Subject: Re: jc/add-2.0-delete-default (Re: What's cooking in git.git (Apr 2013, #05; Mon, 15))
Date: Sun, 21 Apr 2013 18:51:37 -0700
Message-ID: <7vsj2jqqmu.fsf@alter.siamese.dyndns.org>
References: <7vd2tr6833.fsf@alter.siamese.dyndns.org>
	<20130418180017.GA5714@sigill.intra.peff.net>
	<7v61zj66wu.fsf@alter.siamese.dyndns.org>
	<20130418203035.GB24690@sigill.intra.peff.net>
	<7vvc7j4j0u.fsf@alter.siamese.dyndns.org>
	<20130418214427.GA10119@sigill.intra.peff.net>
	<7vobdb4hii.fsf@alter.siamese.dyndns.org>
	<20130419043142.GA5055@elie.Belkin>
	<7vbo9a3011.fsf@alter.siamese.dyndns.org>
	<20130419213455.GB20873@sigill.intra.peff.net>
	<20130421073918.GD10429@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org, Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 03:51:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UU5v4-0005J3-E0
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 03:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753416Ab3DVBvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 21:51:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52242 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753350Ab3DVBvm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 21:51:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B29FE913;
	Mon, 22 Apr 2013 01:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1B1T08JmP43E3wVsVi3gqks5+Nk=; b=qsv8RY
	bFObz2HKSifz2NMQlkpQcePKJhAvrROLpB3tbnTUSPEw017lVfyEtjltNQ2btmax
	Y0JJ03Fdkdt0HlyuZrp2EUygF10yGoZFdXBOAerCepbeMER5ckBLoU1KKycpnr8R
	bUqkB7B8gebvlkYHcF3fc32MI872xhKiDXNFw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=haiTMiuSUKZXq2yNniuG1MW8gdNdbMZQ
	nOC4lj4eCf2fjHq4jOoSN+J7NuZLCYwKa8uI1LIX/gH6qgtnYXYHqNtKN2vMjSEw
	RWbNbosuR2x2w3go6zZhj9RU5vQnQW7jKe1f1bw2MTGsLPwHqKU4VKR/FA/E/Gie
	GRFJHVn7Y9w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D656E912;
	Mon, 22 Apr 2013 01:51:39 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D193CE911;
	Mon, 22 Apr 2013 01:51:38 +0000 (UTC)
In-Reply-To: <20130421073918.GD10429@elie.Belkin> (Jonathan Nieder's message
	of "Sun, 21 Apr 2013 00:39:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2C1F5388-AAEF-11E2-91B8-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221985>

Jonathan Nieder <jrnieder@gmail.com> writes:

> How about something like this?
>
> 	warning: "git add" run on path with files removed (e.g., '%s')
> 	hint: use "git add --ignore-removals <pathspec>" to ignore removals
> 	hint: or "git add --no-ignore-removals <pathspec>" to notice them
> 	hint: --ignore-removals is the default but this will change soon
> 	hint: see git-add(1) for details
>
> Then the --ignore-removals option could be added using a patch like
> the following.

adding ignore-removals as a synonym (and keeping it) would be a good
idea.

We would still need to carry --all and --no-all that have been with
us ever since we added "-A" option, though.
