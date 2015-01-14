From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame.c: fix garbled error message
Date: Wed, 14 Jan 2015 09:22:52 -0800
Message-ID: <xmqqr3uxb7kj.fsf@gitster.dls.corp.google.com>
References: <1420925601-21615-1-git-send-email-git@cryptocrack.de>
	<xmqq4mrv95qt.fsf@gitster.dls.corp.google.com>
	<xmqqzj9n623h.fsf@gitster.dls.corp.google.com>
	<20150112231231.GA4023@peff.net>
	<xmqqzj9n4k11.fsf@gitster.dls.corp.google.com>
	<20150113015427.GA5497@peff.net>
	<20150114142146.16390.54937@typhoon.lan>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Lukas Fleischer <git@cryptocrack.de>
X-From: git-owner@vger.kernel.org Wed Jan 14 18:23:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBRem-0001KO-SD
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 18:23:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754277AbbANRW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 12:22:56 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52633 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754272AbbANRWz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 12:22:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E3B102B784;
	Wed, 14 Jan 2015 12:22:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/tGcoBGLVrSzvi1vznDhpR6P2OI=; b=gQkvzi
	T6z+ojpywVK7jmpUwOcc84DmCrFreVONfRJkOFjZZpiOa5/2O4+nuR0XDhUu0/ZY
	Ckukjx4fLdrYOQR6ohCgLUdJYd5S/GEuDkWRaUukWZdK/p6uYRNPb5dK6VVO4uJW
	AyRr2j5UVv8diwTS+RzT/J1oCxGuxSui4Fi0U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hsX1pEMiofZWkit1SSu/c6eNLwq8eDmj
	nm70YXOXOBKdl7eqzCTTXbqa8luiDZINhWWFm48F9yNDKtFgfTRu9cR2I5hIMXXG
	RLCvgg+cnSru0OuuQfh6IIO0RwkRq5afzyBEwm6awvhYAkwnKLqBJUFrb6IxW0az
	SO6qAO3cZnc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DBA1D2B783;
	Wed, 14 Jan 2015 12:22:54 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1CEC02B781;
	Wed, 14 Jan 2015 12:22:54 -0500 (EST)
In-Reply-To: <20150114142146.16390.54937@typhoon.lan> (Lukas Fleischer's
	message of "Wed, 14 Jan 2015 15:21:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F9735EDC-9C11-11E4-A0E5-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262392>

Lukas Fleischer <git@cryptocrack.de> writes:

>>   [1/5]: git-compat-util: add xstrdup_or_null helper
>>   [2/5]: builtin/apply.c: use xstrdup_or_null instead of null_strdup
>>   [3/5]: builtin/commit.c: use xstrdup_or_null instead of envdup
>>   [4/5]: use xstrdup_or_null to replace ternary conditionals
>>   [5/5]: blame.c: fix garbled error message
>> 
>
> Looks good to me! I am not sure whether those patches should be built on
> top of (a fixed version of) my patch, though, which would make
> backporting the fix to the maintenance branch straightforward. Junio?

We can queue these five on top of 1da1e07c (clean up name allocation
in prepare_revision_walk, 2014-10-15), which changed the rule of the
game to break this code, that only is in v2.2 and later.

And the result should merge just fine to 'maint'.
