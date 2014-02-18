From: David Kastrup <dak@gnu.org>
Subject: Re: error: src refspec refs/heads/master matches more than one.
Date: Tue, 18 Feb 2014 20:37:36 +0100
Message-ID: <871tz0rz3z.fsf@fencepost.gnu.org>
References: <20140214113136.GA17817@raven.inka.de> <87a9dt981o.fsf@igel.home>
	<CACsJy8BevKQaRLYMMv7bTjf_ZAOnkrimws519OyhGZz6_Vr_-A@mail.gmail.com>
	<xmqqy51dirjs.fsf@gitster.dls.corp.google.com>
	<20140215085355.GA15461@lanh>
	<xmqqha7wfdld.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Josef Wolf <jw@raven.inka.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 18 20:41:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFqXS-0006FA-PT
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 20:41:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752746AbaBRTk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 14:40:58 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:49186 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700AbaBRTk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 14:40:57 -0500
Received: from localhost ([127.0.0.1]:48226 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WFqXH-0003Ge-QD; Tue, 18 Feb 2014 14:40:56 -0500
Received: by lola (Postfix, from userid 1000)
	id 6CD7BE06E5; Tue, 18 Feb 2014 20:37:36 +0100 (CET)
In-Reply-To: <xmqqha7wfdld.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 18 Feb 2014 11:03:10 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242344>

Junio C Hamano <gitster@pobox.com> writes:

> Duy Nguyen <pclouds@gmail.com> writes:
>
>> +	if (!force && dwim_ref(name, strlen(name), sha1, &real_ref))
>> +		die(_("creating ref refs/heads/%s makes %s ambiguous.\n"
>> +		      "Use -f to create it anyway."),
>> +		    name, name);
>
> Does this check still allow you to create a branch "refs/heads/next"
> and then later create a branch "next"?  The latter will introduce an
> ambiguity without any prevention, even though the prevention would
> trigger if the order in which these two branches are created is
> swapped--- the end result has ambiguity but the safety covers only one
> avenue to the confusing situation.
>
> And the only way I can think of to avoid that kind of confusion is
> to forbid creation of a subset of possible names by reserving a set
> of known (but arbitrary) prefixes---which I am not sure is a good
> way to go.  At least not yet.

Just for the record: after seeing the respective arguments, I consider
it the sanest way.

It's conceivable to give a configuration option for augmenting the set
of reserved prefixes.  That would allow to adapt the arbitrariness to
match the policies or ref name choices of a particular project while
keeping the set of references addressed by the standard git commands in
check automagically.

-- 
David Kastrup
