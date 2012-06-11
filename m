From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv6 1/4] Read (but not write) from
 $XDG_CONFIG_HOME/git/config file
Date: Mon, 11 Jun 2012 08:50:55 -0700
Message-ID: <7v8vft97a8.fsf@alter.siamese.dyndns.org>
References: <1338754481-27012-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <1338988885-21933-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <7vpq9aenl0.fsf@alter.siamese.dyndns.org>
 <20120608142601.Horde.Tq7UO3wdC4BP0e9ZGAy1EwA@webmail.minatec.grenoble-inp.fr> <7vvcj1dep7.fsf@alter.siamese.dyndns.org> <20120609125336.Horde.iUq0R3wdC4BP0yswpGlGBZA@webmail.minatec.grenoble-inp.fr> <7v4nqjbrdo.fsf@alter.siamese.dyndns.org> <20120610154850.Horde.gYrJO3wdC4BP1KXCOvLEiCA@webmail.minatec.grenoble-inp.fr> <CABPQNSYd0hCU8nrfKJJjR+T_jQn4WC6jEaSCJPjKsuPdumEdtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: nguyenhu@minatec.inpg.fr, git@vger.kernel.org,
	Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu.Moy@grenoble-inp.fr,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Jun 11 17:51:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se6tS-00065p-DJ
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 17:51:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755572Ab2FKPu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 11:50:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63400 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755423Ab2FKPu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 11:50:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B19D9765;
	Mon, 11 Jun 2012 11:50:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6mHyNnCMKYGeVWcvYOGtcAtDfXs=; b=beLkZ3
	mYKLNJgZyOT/iodk2NpXPPpoDdjyVut4ip4KdNTWgQdcbh0o/k06wVbtnIKb5rpk
	xTz7KqUmp+vWqZY0rLasL2HAoa84nqIKzox9OFAjkmhpBNXR5II7TLYYgbcpfKRY
	PwNezJ6udr7TLFB2cjrh6v1O6a5wkCFdycCzg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xu/LXaChOVBJpiSUx/OUOfyuY4wRDLKS
	/GoDQ74RwrKvS19ol0bcbALKN2dlRActBjQcv2SnLdQUCnBr5rzan7cealq+hrwX
	fwI5GUwCJsPxZjZBdFpm0lbw9WHTOjN/Tm7jQMZEq9PtDLMUvqC15ScPQuRk0vpa
	0leTwbo9Ybw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F9859764;
	Mon, 11 Jun 2012 11:50:57 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A024D9761; Mon, 11 Jun 2012
 11:50:56 -0400 (EDT)
In-Reply-To: <CABPQNSYd0hCU8nrfKJJjR+T_jQn4WC6jEaSCJPjKsuPdumEdtw@mail.gmail.com> (Erik
 Faye-Lund's message of "Sun, 10 Jun 2012 20:44:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3B99E3BE-B3DD-11E1-99E1-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199666>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> The awkward thing about doing this, is that the memory allocated by
> the strbuf cannot be reclaimed if you go with this. A pointer that has
> been adjusted (like cleanup_path can do) cannot be successfully fed to
> free.

Yeah, I wouldn't recommend doing that.  Either

	path = strbuf_detach(&sb, NULL);
	retval = xstrdup(cleanup_path(path));
        free(path);
        return retval;

or

	path = xstrdup(cleanup_path(sb.buf));
        strbuf_release(&sb);
        return path;
	
would be more sensible.
