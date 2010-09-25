From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Add --exclude-dir option to git grep
Date: Fri, 24 Sep 2010 22:51:26 -0700
Message-ID: <7vsk0ynzfl.fsf@alter.siamese.dyndns.org>
References: <20100924042614.GA25944@nulllenny.dreamhost.com>
 <7v1v8iq3tu.fsf@alter.siamese.dyndns.org> <4C9D596C.4060906@ripton.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Ripton <dripton@ripton.net>
X-From: git-owner@vger.kernel.org Sat Sep 25 07:51:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzNfj-0005ON-RB
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 07:51:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756115Ab0IYFvf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 01:51:35 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35868 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754788Ab0IYFve (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 01:51:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 50358D96BF;
	Sat, 25 Sep 2010 01:51:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sw6Qi2cjp7c50dIyZMEEhz5UZQs=; b=ucLUZM
	y0Uiak80XplWtqpFB7QCiFunbGAKvVS0tVWU71C4wsi/RGqcUD/CNyqokWCFlmhI
	uYirXtyazUMqK5MXzZQNDTd3UFqF21IS6Y+POQwx+NqXhH/KT0GV+AmwsYOA2SEG
	HNIW2Ji3H9YESqxyGns7XM59tF2rnv9G/A2Uo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LKmFbV4e7Wo330qNowzWmOvWLUnX2A9k
	x7vMLxOLPzdl7lQcLN71htjGHN8fvWiKepFOS9iC64P8XEdXXnldDfPPmWjVSz5H
	NFiK3ZaUS8OANxl5WDh1DnuLBa2mOg6IaEMQ3aueRAXdohaayq4559amSwdY9Qhm
	1FU4tC4EtvU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DBE8D96BC;
	Sat, 25 Sep 2010 01:51:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8DDC1D96A6; Sat, 25 Sep
 2010 01:51:27 -0400 (EDT)
In-Reply-To: <4C9D596C.4060906@ripton.net> (David Ripton's message of "Fri\,
 24 Sep 2010 22\:07\:40 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F1B31330-C868-11DF-9BB8-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157121>

David Ripton <dripton@ripton.net> writes:

>>> +static int exclude_dir_callback(const struct option *opt, const char *arg,
>>> +				int unset)
>>> +{
>>> +	struct string_list *exclude_dir_list = opt->value;
>>> +	char *s1 = (char *)arg;
>>
>> What is this cast for?
>
> It avoids:
>
> "builtin/grep.c:893: warning: initialization discards qualifiers from
> pointer target type"

And the reason why s1 cannot be of type "const char *" is...?
