From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Problems with git fetch confusing foo and foo.git repos
Date: Sat, 18 Aug 2012 13:33:58 -0700
Message-ID: <7vk3wwrlc9.fsf@alter.siamese.dyndns.org>
References: <1345299904.27428.50.camel@ted> <1345301383.27428.55.camel@ted>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>,
	"Ashfield\, Bruce" <Bruce.Ashfield@windriver.com>,
	"saul.wold" <saul.wold@intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
X-From: git-owner@vger.kernel.org Sat Aug 18 22:34:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2pjM-0002cq-SM
	for gcvg-git-2@plane.gmane.org; Sat, 18 Aug 2012 22:34:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752262Ab2HRUeC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Aug 2012 16:34:02 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40353 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751357Ab2HRUeA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Aug 2012 16:34:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 700D297DE;
	Sat, 18 Aug 2012 16:34:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=68+zbfpXyzIN0L6wD43Pdd2pT6A=; b=LYu24B
	BRlayZiSabLZR5VpuIGqwYZOgLwiwt4nRJN8D+vmwMTrMlNGywod/wvJARPY2LFy
	/UR7gypCOlKfecHn7zAy5sHz3ntvwNLQPkz6ay9NZT3glXYDAdk73tg0NEUUyeoG
	BUMtzv/+3PuuJpqKOSoRKEz6Bfig82GhmXSGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H2XC6LW/U4NpPpRssOcXPuYBekDiJIef
	qbGUTWoVurJ0nHt/TaYIXp+uRIRXjwkptAzIuQe2WotoY0HSaol1hGoWF2M8iZG6
	KYQC3hWcVme9QgkZTr3X4CtTRC7vJ8t8144Ai13fF343z6uUe8JLcE+4avbs8cLz
	7uEYxGwhnZg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C26397DC;
	Sat, 18 Aug 2012 16:34:00 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B666197D9; Sat, 18 Aug 2012
 16:33:59 -0400 (EDT)
In-Reply-To: <1345301383.27428.55.camel@ted> (Richard Purdie's message of
 "Sat, 18 Aug 2012 15:49:43 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0A62E80A-E974-11E1-8F34-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203695>

Richard Purdie <richard.purdie@linuxfoundation.org> writes:

> I'd add that I think the commit made for the original problem[1] has
> fixed this scenario since it now will prefer foo over foo.git also in
> the fetch case even if the / is removed from the url.

OK.

As understand it, these "check various possibilities e.g. $name,
$name.git $name/.git" were never meant to be a way to encourage
users to have multiple repositories next to each other under
confusing names in the first place.  It was merely to allow users to
have one of them (some may prefer $name/ that is with working tree,
so we allow $name/.git to be discovered, while some may want to have
a bare repository at $name.git that is bare, so we also allow it to
be discovered).  The recent tweak was to favor the case where the
name asked explicitly by the user is matched first, and it does not
fundamentally change the intent of the basic design in any way.

Thanks for confirming that the tweak works well for you.

> My test machines
> don't have that version yet though and I'm left with a problem where git
> is older than 1.7.9.2. 

So what do you want to see happen next?
