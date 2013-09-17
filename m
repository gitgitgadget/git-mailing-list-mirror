From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: git bisect should accept "paths-to-be-excluded"
Date: Tue, 17 Sep 2013 10:02:33 -0700
Message-ID: <xmqqsix3z8ie.fsf@gitster.dls.corp.google.com>
References: <5236FBEA.80909@gmx.de>
	<CAP8UFD0qC3UM3Dgt2dhpcBHt34yZ3HwNO6y7Z=EBtyRYpyc+Bw@mail.gmail.com>
	<vpqvc1z6eoo.fsf@anie.imag.fr>
	<CAP8UFD1u9hPFcbftpacDFdp27Jmp0YLGbpHPP12uEtjzEmnPQA@mail.gmail.com>
	<CACsJy8AEoUUat-1smJ1BmDuDBLseWf8oZ+EJyuadSLncb1UMSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Toralf =?utf-8?Q?F=C3=B6rster?= <toralf.foerster@gmx.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 17 19:02:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLyfh-0007Wp-O5
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 19:02:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753634Ab3IQRCi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 13:02:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50781 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753541Ab3IQRCh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 13:02:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9356340819;
	Tue, 17 Sep 2013 17:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mhQbjNKKGsMbkMu+RUupJLPDqU4=; b=cgoDVs
	RNM/8h4J9sh7YFFhWg8acpKUdiN4wYA5A5byGrbN0egTXVIX+f59jD2e7R8ndeFl
	Rkn0Akrl0rNO9Vy7aLA9KhbEGp3CT16HXW3bUIWclCSWhSMwhaZxdff5vvIseySI
	DVZPlJQ4ZOSz3hr6CjX/yZF5uW/en35SGjkYk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LQ0DmbDzjvH9jzSby6QMfpbNr/ldRCrI
	5iJ+NTOOaZlcXEnDJDzDIwm8WtgORLipGeushtxKnpvmt0nTDwA/cdhDGc/m/mYf
	ViNr6vc/McrCk9zNI/LEbyzHk66huZpx9fwMoiBEC5mu9DwszuOVX/invFtVXgb5
	vFb1WsJwqFc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8882A40818;
	Tue, 17 Sep 2013 17:02:36 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A5F0B4080F;
	Tue, 17 Sep 2013 17:02:35 +0000 (UTC)
In-Reply-To: <CACsJy8AEoUUat-1smJ1BmDuDBLseWf8oZ+EJyuadSLncb1UMSw@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 17 Sep 2013 18:45:00 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F343729C-1FBA-11E3-816D-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234889>

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Sep 17, 2013 at 4:03 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> On Tue, Sep 17, 2013 at 10:21 AM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>> Christian Couder <christian.couder@gmail.com> writes:
>>>
>>>> In practice though, as git bisect is a kind of binary search, if what
>>>> you want to exclude is exclusively touched by half the commits, it
>>>> will only add one more bisection step if you don't exclude it.
>>>
>>> Actually, I think the same remark would apply to any other Git command
>>> that deal with a set of revisions. If you want to review code with "git
>>> log -p", but you don't care about a subdirectory, you may want a "git
>>> log -p --ignore-dir foo/" or so, too.
>>
>> Yeah, and there was a patch series about that 2 years ago:
>>
>> http://thread.gmane.org/gmane.comp.version-control.git/182830/
>
> And that's just one of the few attempts if I remember correctly. I
> guess it's time revisit it. A few things to sort out before we get to
> the implementation:
>
> Support flat or nested negation (i.e.include A, ignore A/B, but
> include A/B/C..). Nested thing complicates things so I'm towards the
> flat exclusion (exclude B means all inside B, no buts nor excepts) and
> probably cover most use cases

Yeah, it is easy to say that

	git log -- A ':(exclude)A/B' A/B/C

has two positive (A, A/B/C) and one negative (A/B), and then the
most specific one A/B/C matches a path A/B/C/D and hence A/B/C/D is
included.

But to actually _design_ it, there are ambiguities that makes
understanding and explaining the semantics, especially given
pathspecs can have wildcards, icase matches, etc.  For example, is
":(exclude,icase)A/B/?"  more specific than "A/?/C" or less?

So I tend to agree that we should aim for an easier to explain, if
less capable, approach.

> Interaction with "git grep --depth"

I am not sure how that affects anything.  Conceptually, isn't
"--depth" an independent axis to filter out paths that have too many
components after given positive pathspec elements?  E.g. given

	git grep --depth=2 pattern -- A B/C

we will grab paths from two levels starting at A and B/C (so A/1/2
and B/C/1/2 may hit but not A/1/2/3 nor B/C/1/2/3).  Shouldn't
negative pathspecs just filter that depth filtering, i.e. if you
have ":(exclude)*/1/*", even though both "A/1/2" and "A/a/b" may
pass the --depth=2 filter, the former is excluded while the latter
is not.

> Syntax. I guess --ignore (or --exclude) is more intuitive than
> ":(exclude)something" but then it might collide with existing options
> (I did not check if --ignore or --exclude is used anywhere though).
> The latter also enables combining with other filters, such as
> case-insensitive matching..

I do not think it is an option to do this with any mechanism other
than negative pathspecs.
