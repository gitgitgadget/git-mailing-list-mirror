From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http-push: trim trailing newline from remote symref
Date: Thu, 15 Jan 2015 17:19:24 -0800
Message-ID: <xmqqd26f4j4z.fsf@gitster.dls.corp.google.com>
References: <20150113022857.GA4087@peff.net>
	<4E1001F7-2D26-483A-9339-E2570559ECF0@gmail.com>
	<20150113195806.GA13282@peff.net>
	<05091340-887B-4743-AB62-39E609E22CEE@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 16 02:19:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBvZU-0006oj-OR
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 02:19:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755914AbbAPBT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 20:19:28 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58101 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754681AbbAPBT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 20:19:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E65430677;
	Thu, 15 Jan 2015 20:19:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MyoVc9W3QHqeQpq3EVoWLXwSrtk=; b=ksn6bN
	bDp81em+xI/+J1QPTigKPqB1DV7czhBScxh1Mw8KDByrkE4uFD/bY2Fzv83hlB5V
	dQj6ykg1ybcVRvUo205C/xmMCLjnmpP6VLAHWWiLvAjZgQF/z5oT2PCftcKImEJS
	Im7gfeY0nnEonEIwVnfzUpXU5wN34CJZ3aPRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=itROalULbydRIIvr6VMSoMl51uRvsVmo
	At45qC0ILLtTTue49ewxQSL1I1yqRBSMadEim+nNslztS4iMDe0ou/ntqAcBv/Yt
	VBfMCZJnIWgpTr3N1v1CKS0u/D2qEGfvTG6YKihV+y7n8CUaH34hNIDq08VXgzv9
	Wq5IBKDPUos=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8523230676;
	Thu, 15 Jan 2015 20:19:26 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0EBBB30674;
	Thu, 15 Jan 2015 20:19:25 -0500 (EST)
In-Reply-To: <05091340-887B-4743-AB62-39E609E22CEE@gmail.com> (Kyle J. McKay's
	message of "Tue, 13 Jan 2015 16:21:01 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B5FBE662-9D1D-11E4-9586-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262534>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> On Jan 13, 2015, at 11:58, Jeff King wrote:
> ...
> I'm running curl 7.38, and in this context "older" is anything before
> 7.40, so that would explain it.  curl 7.38 was released 2014-09-10, so
> it's only 4 months old at this point.  7.40 was only released 5 days
> ago on 2015-01-08 which is probably why there have not been a whole
> lot of reports about this so far.
>
> After updating to curl 7.40 I get:
>
> t5540-http-push-webdav.sh (Wstat: 256 Tests: 19 Failed: 1)
>   Failed test:  10
>   Non-zero exit status: 1
>
>> Anyway. I think my patch is still the right thing. But that does
>> explain
>> why we didn't notice the test failure.
>
> And then after applying your patch I'm back to:
>
> t5540-http-push-webdav.sh .. ok

I see a Ubuntu box I have nearby has this:

curl (7.35.0-1ubuntu2.3) trusty-security; urgency=medium

  * SECURITY UPDATE: URL request injection
    - debian/patches/CVE-2014-8150.patch: drop bad chars from URL in
      lib/url.c, added test to tests/data/Makefile.am, tests/data/test1529,
      tests/libtest/Makefile.inc, tests/libtest/lib1529.c.
    - CVE-2014-8150

 -- Marc Deslauriers <marc.deslauriers@ubuntu.com>  Wed, 14 Jan 2015 08:49:32 -0500

That explains why I started seeing the same on a box with 7.35.x
which looks older than 7.40.
