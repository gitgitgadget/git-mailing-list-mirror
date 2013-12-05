From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pack-objects: name pack files after trailer hash
Date: Thu, 05 Dec 2013 14:59:45 -0800
Message-ID: <xmqq4n6m52fy.fsf@gitster.dls.corp.google.com>
References: <CACsJy8DbJZmBCnfzNqfmEnRpqVcc42Q_-jz3r=sYVRPhsCkS5A@mail.gmail.com>
	<5297004F.4090003@gmail.com>
	<CACsJy8AdOAPT-RfD0NfZj_cQPBSUrVKn8yS7JRe=-4k8C8TvQg@mail.gmail.com>
	<211D44CB-64A2-4FCA-B4A7-40845B97E9A1@ancientrocklab.com>
	<CACsJy8AOVWF2HssWNeYkVvYdmAXJOQ8HOehxJ0wpBFchA87ZWw@mail.gmail.com>
	<20131128092935.GC11444@sigill.intra.peff.net>
	<CAJo=hJuBTjGfF2PvaCn_v4hy4qDfFyB=FXbY0=Oz3hcE0L=L4Q@mail.gmail.com>
	<20131204200850.GB16603@sigill.intra.peff.net>
	<CAJo=hJuRz9Qc8ztQATkEs8huDfiANMA6gZEOapoofVdoY82k4g@mail.gmail.com>
	<20131205160418.GA27869@sigill.intra.peff.net>
	<20131205202807.GA19042@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 05 23:59:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vohtj-000822-AB
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 23:59:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753Ab3LEW7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Dec 2013 17:59:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47847 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751139Ab3LEW7u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 17:59:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 366655878E;
	Thu,  5 Dec 2013 17:59:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9jVLxjp0oG79NbTG1bNJ6YBYuig=; b=sOWrZR
	cSCIPA0l3Uod8QD8k86RS8DYMOgv9VqdqMu3t0tiZUw6MLDasBnqfK48n36oQESi
	kslPTJeMksuRIzfsk2gg1xF4wCnRySWjeuvyF4e1OzDImUP6aOE6zqW49PFFgDAc
	JZF6Yr8nDkWXBgEeaDX/3ov5egyZ+G/VI/GW4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JMUOqR+Zt7TOV7t5IbjZhzWJfEBnu4vV
	r9qVEQmqkfQb/GcEMYFS7PrpZboO3drlo3y4wZc7dL2lx9TSqJHdb2qVBfsNSO5h
	cSv/gH1Ba4/a00N2v0C1sL52Qiz7Ef86RgqFyLEcGqcSqRIGxtVXnz/iQHdtkz28
	1hxyrtir1nM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D2C75878B;
	Thu,  5 Dec 2013 17:59:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2F6355878A;
	Thu,  5 Dec 2013 17:59:48 -0500 (EST)
In-Reply-To: <20131205202807.GA19042@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 5 Dec 2013 15:28:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F0AB65CE-5E00-11E3-BF83-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238916>

Jeff King <peff@peff.net> writes:

> The second half would be to simplify git-repack. The current behavior is
> to replace the old packfile with a tricky rename dance. Which is still
> correct, but overly complicated. We should be able to just drop the new
> packfile, since we know the bytes are identical (or rename the new one
> over the old, though I think keeping the old is probably kinder to the
> disk cache, especially if another process already has it mmap'd).

Concurred.

> One test needs to be updated, because it actually corrupts a
> pack and expects that re-packing the corrupted bytes will
> use the same name. It won't anymore, but we can easily just
> use the name that pack-objects hands back.

Re-reading the tests in that script, I am not sure if keeping these
tests is even a sane thing to do, by the way.  It "expects" that
certain breakages are propagated, and anybody who breaks that
expectation by improving pack-objects etc. to catch such breakages
will be yelled at by breaking the test that used to pass.

Seeing that the way the test scripts are line-wrapped follows the
ancient convention, I suspect that this may be because it predates
our more recent best practice to document known breakages with
test_expect_failure.

> diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
> index fe82025..4bbb718 100755
> --- a/t/t5302-pack-index.sh
> +++ b/t/t5302-pack-index.sh
> @@ -174,11 +174,11 @@ test_expect_success \
>  test_expect_success \
>      '[index v1] 5) pack-objects happily reuses corrupted data' \
>      'pack4=$(git pack-objects test-4 <obj-list) &&
> -     test -f "test-4-${pack1}.pack"'
> +     test -f "test-4-${pack4}.pack"'
>  
>  test_expect_success \
>      '[index v1] 6) newly created pack is BAD !' \
> -    'test_must_fail git verify-pack -v "test-4-${pack1}.pack"'
> +    'test_must_fail git verify-pack -v "test-4-${pack4}.pack"'

A good thing is that the above hunks are the right thing to do, even
if we are to modernise these tests so that they document a known
breakage with expect-failure.

Thanks.
