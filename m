From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2012, #03; Mon, 5)
Date: Tue, 06 Mar 2012 10:23:07 -0800
Message-ID: <7vty21twqc.fsf@alter.siamese.dyndns.org>
References: <7vmx7uurnj.fsf@alter.siamese.dyndns.org>
 <CACsJy8BRQ63hV5e63yoMVykOMZS3u-VrdCQtvgRGBji4Yzpi4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 19:23:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4z2c-0004ae-Tv
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 19:23:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451Ab2CFSXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 13:23:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42011 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932148Ab2CFSXN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 13:23:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 03D7F7DD4;
	Tue,  6 Mar 2012 13:23:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VF0MTKreOM25N3hLsIwls1kZGbQ=; b=fgld9c
	52qZVE5PSMB9TFoKKV2HskzcMF9aBJPst0lhTarpTqd0zV4REZi5sMOiYiYP6Hmc
	AD4U6WW2VlgvZ76H1yxdryYmjJzMUt/z99YD84hJoB81uQh16jeopDjznOKmjGeN
	MbZQcuZKqhAliR/gfsvLpGRypjjdXRoPixlZA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G0DRO48oCPEIgTj83vafBgr7w/TuMiII
	lRGX73nleMxE6wK2WqlPDD3QXy5owBER/aFsoEnbGRFiWH+jJsjwuXVAE/4gz4C2
	Q+6bxccPbtfit1XZ9lV6c7ZctbXIELgDHmDhXhzFRk0SrYPwrqGaZnyy0SLEMuhM
	UZsr3fJFdm4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EFE777DD3;
	Tue,  6 Mar 2012 13:23:11 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A3D367DD1; Tue,  6 Mar 2012
 13:23:08 -0500 (EST)
In-Reply-To: <CACsJy8BRQ63hV5e63yoMVykOMZS3u-VrdCQtvgRGBji4Yzpi4A@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Tue, 6 Mar 2012 16:40:11 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6C9F5806-67B9-11E1-8B9F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192369>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

>> I've picked up only bits that deal with "use streaming API instead
>> of reading things in core" and minimally fixed them up.  These we
>> should be able to polish in time.
>
> 11/11 should be safe to go too. It simply reads config files so that
> parse_object() respects core.bigfilethreshold.

Ok.

> I'd rather leave it as is. All new test cases are test_expect_failure,
> they should not interrupt "make test". If I slack off, somebody may be
> annoyed enough with those known breakages to give me a little push.

That requires us to vet and agree that the conditions marked with
expect_failure are indeed breakages, which I would want avoid. It is
frustrating for people who has to later "fix" things and find out
that the original "bug" was marked without thinking things through.
