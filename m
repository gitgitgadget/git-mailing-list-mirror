From: Junio C Hamano <gitster@pobox.com>
Subject: Re: unclear documentation of git fetch --tags option and tagopt
 config
Date: Thu, 13 Dec 2012 16:13:40 -0800
Message-ID: <7vd2ydwkwb.fsf@alter.siamese.dyndns.org>
References: <CAHtLG6Ti7yPFfhTb2qfSKE1+5n4Ftey4DQeqpm3SSL-bOfspUg@mail.gmail.com>
 <7v7golzta8.fsf@alter.siamese.dyndns.org>
 <084AB408ED4E4CF3B048B8615658F158@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>,
	<git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Dec 14 01:14:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjIuf-0002Ej-VQ
	for gcvg-git-2@plane.gmane.org; Fri, 14 Dec 2012 01:14:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755308Ab2LNANp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2012 19:13:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34508 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753579Ab2LNANo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2012 19:13:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8956A8C1;
	Thu, 13 Dec 2012 19:13:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zAdaoxSX2Uv2vyuQgGJBCgYG8eQ=; b=HxEWw9
	IVWE/m8f4+ZHZQLBnukk/XPUhgwA4/ML1DMkpk2xWMV7zCzNXe25dB6Hre83fzKJ
	kFal6DJP+S3jl5UlCYaGran0PPgzPFXkcRKf6gxkWSDKuUgS0WLRBCL5a2282w+7
	4Ohyq/e1VAsCDgxt8OqEWO9WgcdgTCYT/mB6A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BnuN/qF3Ty0edynLmC7TCfqTgGuO22mD
	2PGXIS8QvXMD6c+Tqpz0JgH6TODs5QLwRL0+1X7HAjdHhjkdcpu9m1HurYD5fwB2
	HNCrxgy3888T+Ct4IgwqcxAKTaKb2/M/UhP2jE7Utuz6bdDGlpmtVhLxM49OP284
	M7b+c/0qzs0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B5D08A8C0;
	Thu, 13 Dec 2012 19:13:43 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 19B33A8BE; Thu, 13 Dec 2012
 19:13:43 -0500 (EST)
In-Reply-To: <084AB408ED4E4CF3B048B8615658F158@PhilipOakley> (Philip Oakley's
 message of "Thu, 13 Dec 2012 23:54:45 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1E9C4C6A-4583-11E2-BBBF-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211481>

"Philip Oakley" <philipoakley@iee.org> writes:

> What would be the best way of updating the documentation to clarify the 
> point? Given ch3cooli's previous surprise.

Oh, thanks for bringing it up.  I was about to start another message
that begins with "Having said all that..." ;-)

I think the entire paragraph should be rewritten.  The first long
sentence explains that you will get tags that point at the branches
and other stuff you follow by default, so there is no need to
explicitly ask for tags most of the time.  While that is true, it is
secondary in describing what "--tags" is about.  It is to grab all
tags and store them locally, and that needs to come at the very
beginning.

And that auto-following behaviour is already described in the
previous entry for -n/--no-tags.  So how about something like this:

	This is a short-hand for giving "refs/tags/*:refs/tags/*"
	refspec from the command line, to ask all tags to be fetched
	and stored locally.

Note that it is deliberate that the above does not mention tagopt
configuration at all.  The variable was primarily meant to be used
with --no-tags, so that with this:

    [remote "origin"] tagopt = --no-tags

you can "git fetch origin" to keep up with the development on
branches without having to fetch tags from there.  Fetching tags and
only tags from a remote is almost always not what you want; in other
words, remote."origin".tagopt set to --tags is a misconfiguration
99% of the time, unless you are only interested in following tagged
release points.
