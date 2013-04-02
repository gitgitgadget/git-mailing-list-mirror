From: Junio C Hamano <gitster@pobox.com>
Subject: Re: ZSH segmentation fault while completing "git mv dir/"
Date: Tue, 02 Apr 2013 09:48:36 -0700
Message-ID: <7va9pgg9p7.fsf@alter.siamese.dyndns.org>
References: <vpqd2v686fi.fsf@grenoble-inp.fr> <513DF4D1.6000500@gmail.com>
 <vpq8v5uueug.fsf@grenoble-inp.fr> <513E3190.20100@gmail.com>
 <20130312013736.GB7105@unpythonic.net> <vpqwqtdkq9z.fsf@grenoble-inp.fr>
 <CAMP44s3ocY7qpESHCDRdHJBsH1DV+k1Z5OwSqsWndMZd_s6oBQ@mail.gmail.com>
 <vpqwqslgfzf.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff Epler <jepler@unpythonic.net>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Apr 02 18:49:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN4OR-0006FN-St
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 18:49:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760045Ab3DBQsj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 12:48:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43860 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756980Ab3DBQsi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 12:48:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B9A511D3B;
	Tue,  2 Apr 2013 16:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Vy/mr3A14JZ7Q0k/lcj0SmUkmzg=; b=olyP3b
	8U11PiO39NGOz0EqJVM6yHrgty8JkJPT1nsuokl9mLA9yBhIzIW5BF/BjiHjWRI5
	oTRzZA2YeIdZUfniRifhldZDL89qCEDlDOINemlIjLnAC4iAkl8xvESP8wipdJ4q
	FbVBuE1/ZLT0Jhwy1fKCMKvlop7o7Rq24D1dY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bM78LFQ1sq1KjuPosDOn6Pz6+ugBKkWI
	DG4K9HMzkgqDtvW6leehMkOpj3pk9npjcr0c/7t/JSYBcK+JiY22Q4jN1Mi6wLrf
	DFndkULYMmOZ6nbGteDApqiAChSripUMiGJ+q7iLgu7bAI5IQV8sVbniE4HCRW6j
	K6vK88Z/qEk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BBD611D3A;
	Tue,  2 Apr 2013 16:48:38 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F0C611D38; Tue,  2 Apr
 2013 16:48:37 +0000 (UTC)
In-Reply-To: <vpqwqslgfzf.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Tue, 02 Apr 2013 16:32:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2A52369A-9BB5-11E2-B11D-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219795>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> And this is a workaround:
>>
>> --- a/contrib/completion/git-completion.zsh
>> +++ b/contrib/completion/git-completion.zsh
>> @@ -66,7 +66,7 @@ __gitcomp_file ()
>>
>>         local IFS=$'\n'
>>         compset -P '*[=:]'
>> -       compadd -Q -p "${2-}" -f -- ${=1} && _ret=0
>> +       compadd -Q -p "${2-}" -- ${=1} && _ret=0
>>  }
>
> OK, not something we want to apply to git.git, but this means a
> workaround for users is to ...

Would it help users more to have that as part of the instruction at
the beginning of contrib/completion/git-completion.zsh where it
already says "here is how you use it via fpath", than leaving it
here in the list archive?

> (Hope this helps in case someone has the same problem and finds this
> thread ...)
