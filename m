From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2013, #03; Wed, 11)
Date: Thu, 12 Sep 2013 11:14:36 -0700
Message-ID: <xmqqsix9q54j.fsf@gitster.dls.corp.google.com>
References: <xmqqzjrjq6ig.fsf@gitster.dls.corp.google.com>
	<20130912053644.GB1977@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 12 20:15:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKBPj-0006vg-BD
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 20:14:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757231Ab3ILSOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 14:14:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53330 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755120Ab3ILSOl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 14:14:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77FC641625;
	Thu, 12 Sep 2013 18:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/Z/5AWuQ8Ajq8suQ+GiwuJ4zRlI=; b=ZQtUQa
	oJWpB+YEWSZ++KUPr876dw17Ny6Za6HzuMIy1L7wDln+/5hei115zmeth0e+Cq2U
	IeKjplXD5LHWKmuTb6tmT1c1vkNwRD37W58b4mHCx1Ekb5TfT/c8thq6GCb1pcfB
	y4UNmRddh1pIq52JtFGEArDoUCwMln3w4jnXw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A7zhfVik5uGWhVt2tabvcrZU83j8890S
	PsW/nKROkE6RrOSlov3Je7eRObo4Awix5yMd779qp4TcY4XAKHVLo0f2mylhf9tb
	+9vdPyvKYRMPysuM8s2n8rpsqgqdBoUmBMNAs4B6/7nNrqkWKxhRO7SHkT8aXjeC
	1EzrM9c6VeY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E1F341623;
	Thu, 12 Sep 2013 18:14:40 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB9764161D;
	Thu, 12 Sep 2013 18:14:39 +0000 (UTC)
In-Reply-To: <20130912053644.GB1977@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 12 Sep 2013 01:36:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 30A1F2D6-1BD7-11E3-9273-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234665>

Jeff King <peff@peff.net> writes:

> This description is slightly inaccurate since the re-roll. I think it is
> now:
>
>   "git config" did not provide a way to set or access numbers larger
>   than a native "int" on the platform; it now provides 64-bit signed
>   integers on all platforms.
>
> Not a big deal, but it may make your life easier if this description
> ends up in the merge commit, and then you later try to write
> ReleaseNotes off of it.

Thanks, this helps very much.

If you are not interested in how a Git maintainer works, you can
stop reading.

Otherwise understanding of Documentation/howto/maintain-git.txt may
be necessary to grok the below.

The way I work these days is:

 - Add a "###" cut mark to Meta/redo-jch.sh so that topics I want to
   have in 'master' comes before it;

 - Proofread the description on these topics in Meta/whats-cooking.txt;

 - Make a copy of RelNotes to a temporary file and have it in my
   Emacs;

 - On 'master', run "Meta/redo-jch.sh -c1 -e", with emacsclient set
   to my EDITOR;

 - Edit the merge log message if necessary (and if I do so,
   whats-cooking needs to be also updated), but do not say "C-x #"
   yet;

 - Copy that final merge log message to that temporary file (it is
   all in the same Emacs, so this is very simple and easy) to add a
   new entry;

 - Go back to the merge log message and say "C-x #", which will go
   back two step in this list, repeatedly processing all the topics.

And then copy the temporary file over to RelNotes.
