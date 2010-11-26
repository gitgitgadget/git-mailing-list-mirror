From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'git replace' and pushing
Date: Fri, 26 Nov 2010 15:18:06 -0800
Message-ID: <7vvd3jptch.fsf@alter.siamese.dyndns.org>
References: <AANLkTinzPCeCJ486cysmk981HE61=dv9MS7E8Ap4rQ5r@mail.gmail.com>
 <4CEE2060.4020507@drmicha.warpmail.net>
 <AANLkTimQ3fjPb+YVJ5i8EAgui+gd5rfnXMvdQPJPeUtA@mail.gmail.com>
 <20101126214325.GC23462@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Cory Fields <FOSS@AtlasTechnologiesInc.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 27 00:18:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM7Yh-0007gL-HG
	for gcvg-git-2@lo.gmane.org; Sat, 27 Nov 2010 00:18:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869Ab0KZXSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 18:18:21 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56102 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544Ab0KZXSV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 18:18:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A1AD23FDA;
	Fri, 26 Nov 2010 18:18:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qbymIrBxAsQZ1zdxSNJeKKbd2M8=; b=qyPOth
	3/9bQkU5qhprG7k3Owp6+DOs+U2sSUJAjJS7OpjhBQcV++/QrvlpSemPt1Go00nN
	iv2KWd7jtUUgQ1TI9O9zQOL38ULljGwzusWpQfTPYUWjERHpSNYLuzYcSH3e51YU
	uWa93xRxB2bOUwe6DqJgSbm4x7bkZeFTFYXPk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KYu3U2s+S2B56PT79hHX4uwJ/TXuOWVC
	8Vg45AlELmwJy6K2JkqgXz1NkmmuIbGFrkmrRcRt7TGzJ9aneFtGxRp3YFwlF2b5
	XuFzpC/XxZoy2G/Sw8Cc3bjJOwrqwbsWamdRd55eDLLo4Qw8Nim082hmVaH3Sm2I
	XdKEq4zBMtI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5D85B3FD9;
	Fri, 26 Nov 2010 18:18:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C79D13FD8; Fri, 26 Nov 2010
 18:18:24 -0500 (EST)
In-Reply-To: <20101126214325.GC23462@burratino> (Jonathan Nieder's message of
 "Fri\, 26 Nov 2010 15\:43\:25 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7B0E0ECA-F9B3-11DF-8286-DF8536391E49-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162283>

Jonathan Nieder <jrnieder@gmail.com> writes:

>  Real history
>  ------------
>  4' --- 5 --- 6
>
>  1 --- 2 --- 3 --- 4
>
>  Fake history
>  ------------
>  1 --- 2 --- 3 --- 4 --- 5 --- 6
>
>  Replacement ref
>  ---------------
>  4' --> 4
>
> This way, a person a person can fetch either piece of real history
> without trouble, and if they fetch the replacement ref, too, the
> history is pasted together.
>
> It is not possible in git to push a commit without its ancestors;
> replacement refs do not change that.

True, but I suspect the above picture pretty much satisfies Cory's initial
wish, no?  You can fetch recent 4'--5---6 history as if 4' were the root
commit, and if you fetched replacement that tells us to pretend that 4'
has 3 as its parent (and the history leading to 3), you will get a deeper
history.
