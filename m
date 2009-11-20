From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] git remote: Separate usage strings for subcommands
Date: Fri, 20 Nov 2009 01:36:46 -0800
Message-ID: <7vskc95yhd.fsf@alter.siamese.dyndns.org>
References: <4B04B4A2.8090001@gmail.com>
 <20091119124040.6117@nanako3.lavabit.com>
 <32c343770911190651w3f1ac9b6i2d3b1a62a032489f@mail.gmail.com>
 <7vlji2bd23.fsf@alter.siamese.dyndns.org>
 <32c343770911191058x7be7d34ascc3564064b880213@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, jrnieder@gmail.com,
	git@vger.kernel.org
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 10:37:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBPvO-00032w-Eo
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 10:37:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649AbZKTJgy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 04:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752203AbZKTJgy
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 04:36:54 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49773 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913AbZKTJgw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 04:36:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7D1649F64D;
	Fri, 20 Nov 2009 04:36:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=HVq2sybykHOWkOKfDCgCBZTvyCk=; b=qujtQhg0xwwdRFTXP7WkMpL
	40vFaeMI6ECMTTaTj/2/d0pseca3nY7ruUK+cNbKMBI8+ubnugZAKxzb0kBoaVrT
	ouNKRo3JXpMOiS24gGuKtcVngK9hOHWj20hqFPRIu0qkODSZc5619IRAPtQErnkr
	3dH7pCeXnEJSS30mORvA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=sqjnMRFxXOoayWAxDoP+YAR8Fh8/DI1PyUWmJlRd6LQcru8oV
	UpxfuXi/Rk1oVGnd2nPQzxwcIFJ8FascB02B350IzZH7sVU2XanSkQbf+EVHQNvl
	fhRrnotvBZJsjlgXeNfUarWEn0pq1u7R2tal85fQ43eraMYMYbtwddHEpI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3E8E49F64B;
	Fri, 20 Nov 2009 04:36:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B19DF9F64A; Fri, 20 Nov 2009
 04:36:48 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3D0525CA-D5B8-11DE-B285-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133319>

Tim Henigan <tim.henigan@gmail.com> writes:

> Using the 'add' subcommand as an example, the desired output is:
>
> Output of 'git remote -h':
>     "git remote [-v | --verbose]"
>     "git remote add [-t <branch>] [-m <master>] [-f] [--mirror] <name> <url>"
>     etc.
>
> Output of 'git remote add -h':
>     "git remote add [<options>...] <name> <url>"
>     followed by the detailed description given by 'parse_options()'.
>
> Text in 'man git-remote':
>     "git remote add [-t <branch>] [-m <master>] [-f] [--mirror] <name> <url>"
>     with the options explained in detail later in the file.
>
> Thanks for your patience,

I think the above looks good; thank _you_ for your patience.

I often wonder if we want to add to the parse-options library a function
that takes a "const struct option *" and some other unspecified hints, and
fills a strbuf with a one-line description, e.g.

    "[-t <branch>] [-m <master>] [-f] [--mirror]"

I expect we would eventually want to handle something like (this example
is from "git push"):

    "[--all | --mirror | --tags] [-n | --dry-run]"

and walking elements in a "struct option" one by one wouldn't give us
enough information to group all/mirror/tags in "one of these" brackets,
and that is what I mean by "some other unspecified hints".  Obviously we
could do the "[-n|--dry-run]" with existing information.

A helper function like that may make things a bit easier.  parse_options()
may need to take a custom callback function of some sort so that you can
override what parse_options_usage() does when responding to "remote -h"
and generate the list of subcommands and their options on the fly, though.

But that is all outside the scope of this particular patch.
