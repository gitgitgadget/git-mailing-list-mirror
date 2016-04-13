From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1] Documentation: add setup instructions for Travis CI
Date: Wed, 13 Apr 2016 10:39:36 -0700
Message-ID: <xmqq4mb5l86f.fsf@gitster.mtv.corp.google.com>
References: <1460526571-93634-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 13 19:47:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqOtH-0000VY-2B
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 19:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754553AbcDMRrh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 13:47:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63978 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752819AbcDMRrf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 13:47:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6AA3B12839;
	Wed, 13 Apr 2016 13:39:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=E9lKcT/7g2yl0zIUCxvJoIMXu6c=; b=RyVPMf
	AWtzMY8S99ZQxJoc+rheovk4nHbDJfIRsVJSeLiWJgAfaVgiogemYJzVj1t60LMb
	xLdJ9QepMKzmGw4n/pSiQYDg6GSsvuAFH1qqUj2a5uk60zSWVWXRR0Z5JHT3DZOK
	sTdC1zIT/UNz9Qh5OkA4UUMD6Ea/TogEhVAV0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c6pNzlcgH+S3uwDGaSVncEKQUOBfnGhO
	X5eJIVvWA3Ouu1q/jJY9cycx8/BwORrXXYDZAjC3UdTzyqbFK56HW55eUUIkHEir
	M+O2sq/Up4FIdAAjO84MrUYq70PhdV1M8qPbgqlrbKBSrhHIc4O6FDb2yBH87wAV
	twDai9OiPhQ=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 617E012838;
	Wed, 13 Apr 2016 13:39:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3B8A912837;
	Wed, 13 Apr 2016 13:39:38 -0400 (EDT)
In-Reply-To: <1460526571-93634-1-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Wed, 13 Apr 2016 07:49:31
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B1E76BF0-019E-11E6-ABF3-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291470>

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  Documentation/SubmittingPatches | 39 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 36 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index 98fc4cc..79e9b33 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -63,10 +63,43 @@ t/README for guidance.
>  When adding a new feature, make sure that you have new tests to show
>  the feature triggers the new behaviour when it should, and to show the
>  feature does not trigger when it shouldn't.  Also make sure that the
> +test suite passes after your commit.

This is not a new issue, but it sounds as if you do not have to test
if you are not doing a new shiny toy.  Perhaps we should rephrase
the last sentence a bit.

	After any code change, make sure that the entire test suite
	passes.  After any documentation change, make sure that the
	resulting documentation set formats well.

By the way, can you teach our Travis thing to check for the "make
doc" failures?

> +We recommend to use our CI infrastructure to ensure your new feature
> +passes all existing tests as well as your new tests on Linux, Mac, and
> +(hopefully soon) Windows.  Follow these steps for the initial setup:
> +
> + (1) Sign in to GitHub: https://github.com
> +     Please sign up first if you haven't already, it's free.

Three issues:

 * None of the things utilized by the reader of this section looks
   like "our" infrastructure to me.

 * The above makes it sound as if we recommend everybody to become
   GitHub customer, which is not really the case.

 * This is overly long and deserves to be its own separate section,
   just like we have MUA specific hints, this is GitHub-Travis
   specific hints.

How about just saying

	If you have an account at GitHub (and you can get one for
	free to work on open source projects), you can use their
	Travis CI integration to test your changes on Linux, Mac,
	and (hopefully soon) Windows.  See GitHub-Travis CI hints
	section for details.
	
here, create a "GitHub-Travis CI hints" section just before "MUA
specific hints" section, and move these numbered entries and the two
paragraphs that follow to the new section.  As the introductory text
for the new section itself, it may make sense to repeat a rephrased
version of the above there, e.g.

	--------------------------------------------------
        GitHub-Travis CI hints

	With an account at GitHub (you can get one for free to work
	on open source projects), you can use Travis CI to test your
	changes on Linux, Mac, and (hopefully soon) Windows.

	Follow these steps for the initial setup:

	(1) ...
        

I'd mildly prefer to leave "Please sign up first" line out
of the first entry.

> + ...
> + (7) Enable Travis CI builds for your Git fork
> +
> +After the initial setup you can push your new feature branches to your
> +Git fork on GitHub and check if they pass all tests here:
> +https://travis-ci.org/<Your GitHub handle>/git/branches
> +
> +If they don't pass then they are marked "red". If that happens then
> +click on the failing Travis CI job and scroll all the way down in the
> +log. Find the line "<-- Click here to see detailed test output!" and
> +click on the triangle next to the log line number to expand the detailed
> +test output (example: https://travis-ci.org/git/git/jobs/122676187).
> +Fix the problem and push an updated commit to your branch to ensure
> +all tests pass.
> +
> +Do not forget to update the documentation to describe the updated
> +behaviour of your new feature. It is currently a liberal mixture of US
>  and UK English norms for spelling and grammar, which is somewhat
>  unfortunate.  A huge patch that touches the files all over the place
>  only to correct the inconsistency is not welcome, though.  Potential
