From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] imap-send.c: support GIT_CURL_VERBOSE
Date: Tue, 06 Jan 2015 12:17:55 -0800
Message-ID: <xmqqmw5voe8c.fsf@gitster.dls.corp.google.com>
References: <ce80e4296739f2fce0d70ddf4a710fb@74d39fa044aa309eaea14b9f57fe79c>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Bernhard Reiter <ockham@raz.or.at>,
	Git mailing list <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 21:18:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8aZn-0006Ph-Ce
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 21:18:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754080AbbAFUR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 15:17:59 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65200 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751612AbbAFUR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 15:17:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AAE222C537;
	Tue,  6 Jan 2015 15:17:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dPItC7a7N7iqvTBsSL9123wv4ro=; b=JJmUzN
	yn7BSgnnNYmqsVN28y31ysZguz4/mX9sSTKDrn2MFanAxcncNkJ1J5REeTfa3xaT
	3RsXik+JstbFsQXeFWq3EjQkAJR9K4Bi3BU+q/QI0RdZyFaVaveNuvRn/+6qdGz3
	a0Ois6ln3BE1InbT58QxlVIHAImV5ih+fclMI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D7scc0EzRp5tk5n0o2aXZrjmhQPsLquF
	nq2h5xH0/DEz1yJ2FlKYlu7F7oz0yuhBSK7uaFpygxJwDxc/2TC3TK7UaAn1COLI
	JvpQTeJnEBCe/4qvnnHbtpRfnNUlMaPUzypMqUbv0uuFGqobaOZt4U6Y2Vq30cAc
	X30Gig43Hgs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A1D742C534;
	Tue,  6 Jan 2015 15:17:57 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 26BF42C529;
	Tue,  6 Jan 2015 15:17:57 -0500 (EST)
In-Reply-To: <ce80e4296739f2fce0d70ddf4a710fb@74d39fa044aa309eaea14b9f57fe79c>
	(Kyle J. McKay's message of "Tue, 6 Jan 2015 03:00:55 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1A6FEDD0-95E1-11E4-A502-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262099>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> When using git-imap-send to send via cURL, support setting
> the GIT_CURL_VERBOSE environment variable to enable cURL's
> verbose mode.
> ...
> diff --git a/imap-send.c b/imap-send.c
> index 4dfe4c25..060df834 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -1431,7 +1431,7 @@ static CURL *setup_curl(struct imap_server_conf *srvc)
>  
>  	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
>  
> -	if (0 < verbosity)
> +	if (0 < verbosity || getenv("GIT_CURL_VERBOSE"))
>  		curl_easy_setopt(curl, CURLOPT_VERBOSE, 1L);
>  
>  	return curl;

Makes sense; thanks.
