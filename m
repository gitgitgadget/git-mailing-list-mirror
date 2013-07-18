From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Add the NO_SENTINEL build variable
Date: Thu, 18 Jul 2013 14:25:10 -0700
Message-ID: <7vli531ryh.fsf@alter.siamese.dyndns.org>
References: <51E4338E.4090003@ramsay1.demon.co.uk>
	<20130715181357.GF14690@google.com>
	<51E82582.1030204@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Jul 18 23:25:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzvhV-00088A-G9
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 23:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933659Ab3GRVZV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 17:25:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37935 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759195Ab3GRVZU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 17:25:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C0ADE321AA;
	Thu, 18 Jul 2013 21:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kY5kG3QcVZlKYmpQtZz0vD23Vk0=; b=vtQ+DR
	hn0N6b4NN3Pm2It5gn9y44e7j9qOey7/7rqXsoM3drGeGoYBem0h5G2tFAMc4mBj
	XLnbnvLLaqZAkjqb24187Hz6nJ7SS6B3ZDqmH7+2g+83iY22wJQUdgbAV9u4Tlha
	gnpXRAylV7C9GRu4x8n6yr0IQCrP4MqenFClg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IS6iOEkVMVev/cnPJSEFUYVY5NmIpOJI
	5YikHmBzc6rpKis64BoxU8cv5B/vP61PRvplKiFqT8Qu3zHevIdRa9wmwKOmgkII
	P9QmrjFbQyC3MWN6leohy7XeV4l4Jv3DiCWm4IhuqDnr1tKhvXE2XxGfBiHW4eSg
	utBkzZN2uO0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B66273219F;
	Thu, 18 Jul 2013 21:25:18 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0075032196;
	Thu, 18 Jul 2013 21:25:17 +0000 (UTC)
In-Reply-To: <51E82582.1030204@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Thu, 18 Jul 2013 18:27:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8B23B0CC-EFF0-11E2-A6C9-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230748>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Jonathan Nieder wrote:
>> Ramsay Jones wrote:
>> 
>>> One of the three gcc compilers that I use does not understand the
>>> sentinel function attribute. (so, it spews 108 warning messages)
>> 
>> Do you know what version of gcc introduced the sentinel attribute?
>> Would it make sense for the ifdef in git-compat-util.h to be keyed on 
>> __GNUC__ and __GNUC_MINOR__ instead of a new makefile flag?
>> 
>
> I have on old (v4.2.1) gcc repo on Linux and looking at
>
>     ~/gcc-4.2.1/gcc/ChangeLog-2004
>
> I can see that the sentinel attribute was added on 2004-09-04 by
> Kaveh R. Ghazi.
>
> Also, I find "bump version string to version 4.0.0" was on 2004-09-09
> and "bump version string to version 3.5.0" was on 2004-01-16.
>
> Several of my system header files (on Linux) imply that the
> sentinel attribute is supported by __GNUC__ >= 4. (One of them,
> ansidecl.h, states that gcc 3.5 supports it but ...)

Perhaps a message from yesterday would have helped?

 http://article.gmane.org/gmane.comp.version-control.git/230633

seems to indicate that checking for version 4 is sufficient.

Also I asked you to split the __attribute__((sentinel(n)) support
into a separate patch.  We currently do not pass anything but 0
(meaning, the sentinel is always at the end), and SENTINEL in all
capital is easy enough to grep for when somebody _does_ want to have
such a support, so I'd prefer not to see __attribute__((sentinel(n))
until it becomes necessary.

Thanks.
