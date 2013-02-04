From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Should "log --cc" imply "log --cc -p"?
Date: Mon, 04 Feb 2013 08:36:43 -0800
Message-ID: <7vfw1c3ujo.fsf@alter.siamese.dyndns.org>
References: <7vmwvl6lj9.fsf@alter.siamese.dyndns.org>
 <510F95D7.6010107@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 04 17:37:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2P2b-0007qz-9q
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 17:37:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756082Ab3BDQgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 11:36:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57727 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753996Ab3BDQgq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 11:36:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A712ABEBB;
	Mon,  4 Feb 2013 11:36:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YzxC1UwzRKsJsYMpVvzQcbO6ZKM=; b=uVCffN
	GIkJYIE6dvYLNsILCbQqqyLEKO9MzrPT4HQb9wwFtm4JBMANVUBovci0EAqdEyj6
	tETZJiccBLzV4sSL+8mdb5/Nwd4cSIko9kx6zV30bKojSOLlmC9pyWBxF/gjN0ih
	QCYHKs+VSvP12Zj3ryCutwt2P2BurPzG+/1MQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DJevhvFMszyEqd0+TWSilwuBjkQqwPLQ
	VS3QDYtL1BbOgCPdCjbMWJcUfPmnI0XuLjjFDHeeRjGs8343rXbMqpFkuECg96Jb
	qM45YoutaHZIBhUVZsoGs9Kw7yC0mguaWAD8QRTjbkMRUd6TxubZD47NuBHiDMwa
	ctOWsz6KQX4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9779ABEB9;
	Mon,  4 Feb 2013 11:36:45 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0022EBEB2; Mon,  4 Feb 2013
 11:36:44 -0500 (EST)
In-Reply-To: <510F95D7.6010107@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Mon, 04 Feb 2013 12:04:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 100E641E-6EE9-11E2-922F-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215388>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> But diffs are on here ("-p"), it's just that the default diff option for
> merges is to not display them. Well, I admit there's two different ways
> of thinking here:
>
> A) "git log -p" turns on diffs for all commits, and the default diff
> options is the (non-existing) "--no-show" diff-option for merges.
>
> B) "git log -p" applies "-p" to all commits except merge commits.
>
> I'm strongly in the A camp,...

I can personally be trained to think either way, but I suspect that
we already came halfway to

  C) "-p" asks for two-way patches, and "-c/--cc" ask for n-way
     patches (including but not limited to n==2); it is not that -p
     asks for patch generation and others modify the finer behaviour
     of patch generation.

"git log/diff-files -U8" do not need "-p" to enable textual patches,
for example.  It is "I already told you that I want 8-line context.
For what else, other than showing textual diff, do you think I told
you that for?" and replacing "8-line context" with various other
options that affect patch generation will give us a variety of end
user complaints that would tell us that C) is more intuitive to
them.

But I do not feel very strongly that I am *right* on this issue, so
I won't do anything about it hastily right now.
