From: <dag@cray.com>
Subject: Re: Subtree in Git
Date: Wed, 11 Jul 2012 11:14:04 -0500
Message-ID: <nng4npe6zsj.fsf@transit.us.cray.com>
References: <CAE1pOi2uT=wipyrOYCwy9QuXnXFV27F1gN3Ej-RaSr-fegQCfA@mail.gmail.com>
	<nngk410vrja.fsf@transit.us.cray.com> <4F9FA029.7040201@initfour.nl>
	<87fwbgbs0h.fsf@smith.obbligato.org>
	<7v8vh78dag.fsf@alter.siamese.dyndns.org>
	<4FA82799.1020400@initfour.nl> <nngzk9jvemb.fsf@transit.us.cray.com>
	<nngaa0z3p8b.fsf@transit.us.cray.com>
	<87bokpxqoq.fsf@smith.obbligato.org> <4FD89383.70003@initfour.nl>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <greened@obbligato.org>, Junio C Hamano <gitster@pobox.com>,
	"Hilco Wijbenga" <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Herman van Rink <rink@initfour.nl>
X-From: git-owner@vger.kernel.org Wed Jul 11 18:21:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SozfY-0000m4-3d
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 18:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756072Ab2GKQVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 12:21:33 -0400
Received: from exprod6og105.obsmtp.com ([64.18.1.189]:43391 "EHLO
	exprod6og105.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755957Ab2GKQVc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2012 12:21:32 -0400
X-Greylist: delayed 379 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Jul 2012 12:21:31 EDT
Received: from CFWEX01.americas.cray.com ([136.162.34.11]) (using TLSv1) by exprod6ob105.postini.com ([64.18.5.12]) with SMTP
	ID DSNKT/2oC4p/6TCAbKq1GEj6oeA6sq+K2JRy@postini.com; Wed, 11 Jul 2012 09:21:31 PDT
Received: from transit.us.cray.com (172.31.17.53) by CFWEX01.americas.cray.com
 (172.30.88.25) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 11 Jul
 2012 11:14:05 -0500
In-Reply-To: <4FD89383.70003@initfour.nl> (Herman van Rink's message of "Wed,
	13 Jun 2012 15:20:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201312>

Herman van Rink <rink@initfour.nl> writes:

>> It's hard to tell what's what with one big diff.  Each command should
>> get its own commit plus more if infrastructure work has to be done.  I
>> realize it's a bit of a pain to reformulate this but git rebase -i makes
>> it easy and the history will be much better long-term.
>>
>> Each command should be described briefly in the commit log.
>
> That would indeed be nice, but as some parts interdependent it would be
> rather complicated.

Do the interdependent parts first, then.  These should be pure
infrastructure.

> And what is the use if their not fully independently testable.

The command should be testable as soon as they are fully implemented,
no?

I'm thinking about a sequence like this:

- Infrastructure for command A (and possibly B, C, etc. if they are
  interdependent).
- Command A + tests
- Infrastructure for command B
- Command B + tests
- etc.

> If you want to fake a nice history tree then go ahead, I just don't have
> the energy to go through these commits again just for that.

Well, I can't do this either, both because it would take time to get up
to speed on the patches and because I have a million other things going
on at the moment.  So unfortunately, this is going to sit until someone
can take it up.

Unless Junio accepts your patches, of course.  :)

>> Some questions/comments:
>>
>> - Is .gittrees the right solution?  I like the feature it provides but
>>   an external file feels a bit hacky.  I wonder if there is a better way
>>   to track this metadata.  Notes maybe?  Other git experts will have to
>>   chime in with suggestions.
>
> It's similar to what git submodule does. And when you add this file to
> the index you can use it on other checkouts as well.

Well, I guess I'm not strongly opposed, I was just asking the question.

>> - This code seems to be repeated a lot.  Maybe it should be a utility
>>   function.
>
> Yes that's there three times...

So you agree it should be factored?

>> - I removed all this stuff in favor of the test library.  Please don't
>>   reintroduce it.  These new tests will have to be rewritten in terms of
>>   the existing test infrastructure.  It's not too hard.
>
> I've left it in to be able to verify your new tests. Once all the new
> tests are passing we can get rid of the old one, not before.
> And as all the old tests are contained in test.sh it should not interfere...

No, I'm very strongly against putting this back in.  The new tests will
have to be updated to the upstream test infrastructure.

                                      -Dave
