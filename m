From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PULL REQUEST] initial pack v4 support
Date: Tue, 10 Sep 2013 14:52:20 -0700
Message-ID: <xmqqk3iowdij.fsf@gitster.dls.corp.google.com>
References: <alpine.LFD.2.03.1309091526430.20709@syhkavp.arg>
	<xmqqtxhswexg.fsf@gitster.dls.corp.google.com>
	<alpine.LFD.2.03.1309101729310.20709@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyn =?utf-8?Q?Th=C3=A1i?= Ngc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Sep 10 23:52:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJVrH-0003XL-P5
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 23:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312Ab3IJVwY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 17:52:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44009 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963Ab3IJVwX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 17:52:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69C8A407EE;
	Tue, 10 Sep 2013 21:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=iAvAcKeFrl1iZrBe/cFYHnGwqTU=; b=gmhCgu
	2GF/35nrJ9JWrjoEsuPHnMYYdKFEURQ0HiXr/CxV7HVCJiJwrL98xGoRlUz6vB3Y
	N5nOVAEiUZIE1LlZHtFbPoEsuP9Q36lGHhoHtPw0DhhPQZEi2InWva5aevZ3KehC
	bv5UF4KVdOYAJ190a7oP+v8tN9qSNdEKvPRWo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S1ZIfdEzDwvRigNfSDs1vI//HBZRZj0I
	scVaFkyM/XUjPjdqC2GPTkB3j+sGO+T+2rdyiV/Z9PqbdE8xxq2vy9z+3lb5p0tS
	pjL8+BhU7VubsnFGtfMo83omu4DMjpEV3RO/rovaXahFHqyKD2BIIoKYy4edw5c3
	WQ6bCL9aFrE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A1E6407EC;
	Tue, 10 Sep 2013 21:52:22 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AD821407E5;
	Tue, 10 Sep 2013 21:52:21 +0000 (UTC)
In-Reply-To: <alpine.LFD.2.03.1309101729310.20709@syhkavp.arg> (Nicolas
	Pitre's message of "Tue, 10 Sep 2013 17:32:50 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4540F7D4-1A63-11E3-B35A-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234487>

Nicolas Pitre <nico@fluxnic.net> writes:

> On Tue, 10 Sep 2013, Junio C Hamano wrote:
>
>> Nicolas Pitre <nico@fluxnic.net> writes:
>> 
>> > Junio, would you please pull the following into pu:
>> >
>> > 	git://git.linaro.org/people/nico/git
>> >
>> > This is the pack v4 work to date which is somewhat getting usable.  It 
>> > is time it gets more exposure, and possibly some more people's attention 
>> > who would like to work on the missing parts as I need to scale down my 
>> > own involvement.
>> 
>> Thanks.  Parked on 'pu'.
>
> Good.
>
>> >       packv4-parse.c: allow tree entry copying from a canonical tree object
>> 
>> This one needed a small fix-up to make it compile.
>> 
>> I do not particularly like reusing that "size" variable, but it
>> seemed to be dead at that point, so...
>
> Feel free to fold this in the original commit.
>
> I'm curious... what compiler are you using?  My gcc version is just 
> happy to do arithmetic on void pointers.

I have -Werror -Wpointer-arith -Woverflow -Wno-pointer-to-int-cast
defined in my private build script (the todo branch is checked out
as Meta/ subdirectory of git.git, and "Meta/Make --pedantic" is how
I build things).
