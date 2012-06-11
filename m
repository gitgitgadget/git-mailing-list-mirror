From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How can I specify the "sendmail" program for git-send-email?
Date: Mon, 11 Jun 2012 08:57:34 -0700
Message-ID: <7v4nqh96z5.fsf@alter.siamese.dyndns.org>
References: <20120611073232.GA5602@richard>
 <CABPQNSbwtP0hp8QYznwXjLAaoKVj_ZUWXQQCDG80Xb+TME1MWw@mail.gmail.com>
 <20120611090431.GA23447@richard>
 <CABPQNSZ1dyAfCVLGcLxbeBdS_9A_arYOhzgKBtndReK5zxu_MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Richard Yang <weiyang@linux.vnet.ibm.com>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Jun 11 17:57:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se6zt-0003IO-QG
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 17:57:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828Ab2FKP5h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 11:57:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33742 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751659Ab2FKP5h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 11:57:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71E539906;
	Mon, 11 Jun 2012 11:57:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EK+fk6rQCLtNlD0yA1ykCMvKqZY=; b=w9/i6C
	FRUIOqE95UsfY32lUKMMO/svHw8ID5h0RzHMia/3ynQAKIWAtevmDPRESYWYDKhp
	k1MBOQaEYeOVV7Zva+s/wngJiSXly1R6rfQthJZyiIrPmRq6350V1QeYWulzPkji
	RRHDMxta+hbHJX20zwB5RpUSibd/T7fK86VTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=REHoRq7TGmmB6HGfgN9BFpS4+s4iQvte
	pszrhVS9BWrFjRZRMg4EAcChqUkMOgoWJZ2qpZ+WzD8RI+SpvxVqOJXRH+PcWj25
	q9UTKfFiPZj9jL+hfJoyv+oIR/XF4kOAAPKEmu0HpLN2Ki/yenZ/DL26Of8hI0Ni
	j9yBRPoVa78=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68C579905;
	Mon, 11 Jun 2012 11:57:36 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F28009904; Mon, 11 Jun 2012
 11:57:35 -0400 (EDT)
In-Reply-To: <CABPQNSZ1dyAfCVLGcLxbeBdS_9A_arYOhzgKBtndReK5zxu_MA@mail.gmail.com> (Erik
 Faye-Lund's message of "Mon, 11 Jun 2012 11:15:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 299C2824-B3DE-11E1-AA44-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199667>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> Well, I've always been slightly annoyed by the "send-mail" vs
> "sendemail" inconsistency.

Hrm, isn't it between "sendmail" (as in /usr/lib/sendmail) and
"send-email" (a subcommand of git)?

> Perhaps we could do something along these
> lines (plus all documentation-updates, omitted for clarity) to reduce
> the risk of confusion?

Assuming that the contrast between "sendmail" and "git send-email"
is what you are trying to address, I fail to see how it would help
reducing the confusion if you start naming configuration variables
used by "git send-email" without E.

If the proposal were to give "send-email.$var" synomyms to
corresponding "sendemail.$var" variables, I would have been
persuaded to believe it may alleviate potential confusion, though.

> Yeah, the leaking of $identity between different sections is a bit
> suboptimal, but as a fallback-mechanism I don't think it actually
> matters much.
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 03292fd..d167d96 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -375,7 +375,11 @@ sub read_config {
>  	}
>  }
>
> -# read configuration from [sendemail "$identity"], fall back on [sendemail]
> +# read configuration from [sendmail "$identity"], fall back on [sendmail]
> +$identity = Git::config(@repo, "sendmail.identity") unless (defined $identity);
> +read_config("sendmail.$identity") if (defined $identity);
> +read_config("sendmail");
> +# same as above, but with legacy "sendemail"
>  $identity = Git::config(@repo, "sendemail.identity") unless (defined
> $identity);
>  read_config("sendemail.$identity") if (defined $identity);
>  read_config("sendemail");
