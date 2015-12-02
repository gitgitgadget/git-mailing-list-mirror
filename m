From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git clone fails during pre-commit hook due to GIT_WORK_TREE=. (regression 2.5 -> 2.6)
Date: Wed, 02 Dec 2015 09:09:42 -0800
Message-ID: <xmqqh9k06all.fsf@gitster.mtv.corp.google.com>
References: <CA+dzEB=2LJXiLSTqyLw8AeHNwdQicwvEiMg=hVEX0-_s1bySpA@mail.gmail.com>
	<CA+dzEB=XiGVFg+AhuJM-jUCPmgZKCJHTp3sinrFt8yzXeC_63Q@mail.gmail.com>
	<CAGZ79kY=t9SeoXjgeJjfCMD2=6g3JJxDxcnY6JeJCpUqaN+eOA@mail.gmail.com>
	<CACsJy8C7xoV9faGpbn_5XGt-CmCj--fgXaCFR-ngs=-pWUnrCA@mail.gmail.com>
	<CACsJy8Ciuirgk9D_fbQ5pgo-8u1AnM+zBdKUHcz_HLfRqM9QxQ@mail.gmail.com>
	<xmqqwpsz6y5b.fsf@gitster.mtv.corp.google.com>
	<CACsJy8A0WJYb7k6+JUOk9Y_hOMhinWP1T30GHG8fLqkmgMdbhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Anthony Sottile <asottile@umich.edu>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 18:09:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4Auj-0002SD-7Z
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 18:09:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933430AbbLBRJx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 12:09:53 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62981 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933327AbbLBRJr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 12:09:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CBA6D30EB3;
	Wed,  2 Dec 2015 12:09:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KjO0tk05VLsJLMg22XvHyyf/3FI=; b=wPTywX
	sYfPbpHQ8Q9++NtFFTW0e1M4e7G/gcZw8sC0Nam8x91hAkxM5WqYb2j2Wj+XbGwN
	w1Efl7BgdL0KmC+kKcHCCGkh0a090RlmHIsjKArgb4oSzXghad1XR+LaMX2SEjtD
	z1u/TeHmSqkaBA882PkFd+4Jv0aNJfKYCpoL0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gSznTzs5tXDPmiZbNdaZKDkV/gRDWwoG
	Jscc+Mw4qD/o01AhUjbT4RkKyXcawx3txcF9c173dm18JdEr2351/2KCPCCCoP4Y
	dLLb0/TeVU1E4qoDjoUgfUcCWk7OfsMazpMutWQqhcAJ011qplE5xE8mNpk/PAH1
	48o7ISZ2DI4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C1DD230EB2;
	Wed,  2 Dec 2015 12:09:44 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 142CC30EB1;
	Wed,  2 Dec 2015 12:09:43 -0500 (EST)
In-Reply-To: <CACsJy8A0WJYb7k6+JUOk9Y_hOMhinWP1T30GHG8fLqkmgMdbhQ@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 1 Dec 2015 18:59:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7B8FB188-9917-11E5-A39A-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281893>

Duy Nguyen <pclouds@gmail.com> writes:

> ... But let me sleep on it (and everybody please
> give ideas if you have any). Meanwhile, maybe reverting d95138e should
> be done any way for now. Broken aliases are not as bad as broken
> hooks.

OK, when/if you decide that our first step should be a revert of
d95138e please send in a patch to do so with a brief write-up of a
follow-up plan.

Thanks.
