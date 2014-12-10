From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Blobs not referenced by file (anymore) are not removed by GC
Date: Wed, 10 Dec 2014 08:07:09 -0800
Message-ID: <xmqqbnnbjxoy.fsf@gitster.dls.corp.google.com>
References: <5485D03F.3060008@fu-berlin.de> <20141209141457.GA18544@peff.net>
	<CAFY1edaEG040jnfTJA4G9a0bAkFJHc3N5sHjtwOOdXmndsu9YQ@mail.gmail.com>
	<20141209161133.GA17756@peff.net>
	<CAFY1edY=Ren9krK1-yFoxt92AAushUyqnbt=69hdXMeiBFAK=w@mail.gmail.com>
	<20141210071119.GA18104@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Roberto Tyley <roberto.tyley@gmail.com>,
	Martin Scherer <m.scherer@fu-berlin.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 10 17:07:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyjnM-0007FJ-5x
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 17:07:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbaLJQHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 11:07:14 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53367 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932180AbaLJQHN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 11:07:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8674B23CDC;
	Wed, 10 Dec 2014 11:07:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=greE2AxLXVu0Xj+07LB/G6KRAGw=; b=OREEoJ
	m/1pHAATO0tlWHok7NdC6gZdmuFO0+EiQEQPqrs2fxA6gv6fE7V9nmSTGNiebbbb
	5vfeJ556TiHDZyvQR2tsE2W/UFsZynKuPJpRME3Nm5vWkXsQTDd0kpG3f8IPACXO
	QEMCXVEhjv7V/BD+yqXCtKukHStBGlWo4KGfo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TPdMPfHDMO1s81yY6N7S/rZB2DzqpwiJ
	9mmjifJ9p4C9plfZfu6HZVbp1QILmVbDZvcB+sGdV920LGkF1Fha+tkaAYyJidpy
	MPfSCn5WccLLrU9TAludLQFQszTo54dSqc67YI25xSdONEd5YKr/zd9kRtiFkSDK
	5EJSBZwb7fY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C1EC23CDB;
	Wed, 10 Dec 2014 11:07:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EECB723CD9;
	Wed, 10 Dec 2014 11:07:10 -0500 (EST)
In-Reply-To: <20141210071119.GA18104@peff.net> (Jeff King's message of "Wed,
	10 Dec 2014 02:11:19 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 991083D6-8086-11E4-AA24-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261221>

Jeff King <peff@peff.net> writes:

>> ... I'd be happy to
>> contribute a patch that gives 'gc' a flag to do the equivalent of:
>> 
>> git reflog expire --expire=now --all && git gc --prune=now --aggressive
>> 
>> Maybe:
>> 
>> git gc --purge
>
> Yeah, that is common enough that it might be worthwhile (you probably
> want --expire-unreachable in the reflog invocation, though).

Also you would not want an unconditional --aggressive.
