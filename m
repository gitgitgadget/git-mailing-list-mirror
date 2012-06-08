From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv6 1/4] Read (but not write) from
 $XDG_CONFIG_HOME/git/config file
Date: Fri, 08 Jun 2012 08:08:04 -0700
Message-ID: <7vvcj1dep7.fsf@alter.siamese.dyndns.org>
References: <1338754481-27012-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <1338988885-21933-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <7vpq9aenl0.fsf@alter.siamese.dyndns.org>
 <20120608142601.Horde.Tq7UO3wdC4BP0e9ZGAy1EwA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>, git@vger.kernel.org,
	Matthieu.Moy@grenoble-inp.fr,
	NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: nguyenhu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Fri Jun 08 17:08:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sd0nN-0005Bi-4U
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 17:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760248Ab2FHPIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jun 2012 11:08:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48718 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757788Ab2FHPIH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 11:08:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC0AE8805;
	Fri,  8 Jun 2012 11:08:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hL1WJkAZ7hBS4C6A8qx3e//GjBk=; b=AMsnnz
	rDFEs3bjInN2Gs7XG0+RwTvQgGnzJ/THs3XH9BcmQiAiC7CTo2u+g5IEHvzn4eHP
	6CMD9Bz3ba3U7H/pyfybt2GGjBXX0SRq7KSEByBN6k9cjZYq8qnOjvGpQKl32MVJ
	7eTqUkyOqUUQBaTUQhRReWOHUXmPW8ncme1V8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QTkPn+zs5+Uc9lCwsUOS2ebBb9j9T9Zg
	UAVomHzUDh+0iNk6LA8d7ENTCJAFO9L/yS+DZoMRxtSvLQYX8bukCqV4meCzogcm
	tUKYdmP3+n+Cb+yfT3dTmV7gQjMS//f23DT3468Ofl0oaM0H27AUlSaEcjqsVOP8
	94QZZ8pgo8I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A1CA28804;
	Fri,  8 Jun 2012 11:08:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 33D598802; Fri,  8 Jun 2012
 11:08:06 -0400 (EDT)
In-Reply-To: <20120608142601.Horde.Tq7UO3wdC4BP0e9ZGAy1EwA@webmail.minatec.grenoble-inp.fr> (nguyenhu@minatec.inpg.fr's message of "Fri, 08 Jun 2012 14:26:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C0421046-B17B-11E1-B7C3-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199503>

nguyenhu@minatec.inpg.fr writes:

> What about this ?

What about that ;-)?

> char *mkpathdup(const char *fmt, ...)
> {
> 	char *path;
> 	struct strbuf sb = STRBUF_INIT;
> 	va_list args;
>
> 	va_start(args, fmt);
> 	strbuf_vaddf(&sb, fmt, args);
> 	va_end(args);
> 	path = sb.buf;
>
> 	strbuf_release(&sb);
> 	return xstrdup(cleanup_path(path));
> }

Modulo

	path = strbuf_detach(&sb, NULL);

that is more or less what I meant.
