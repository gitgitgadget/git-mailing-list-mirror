From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: If the ca path is not specified, use the defaults
Date: Fri, 17 Jan 2014 10:14:47 -0800
Message-ID: <xmqqlhyexyp4.fsf@gitster.dls.corp.google.com>
References: <1389807071-26746-1-git-send-email-i.gnatenko.brain@gmail.com>
	<xmqqa9ex2gi6.fsf@gitster.dls.corp.google.com>
	<7AD1C6ED-6177-415D-B342-D1FEA9F810B4@rubenkerkhof.com>
	<xmqqob3d0w7g.fsf@gitster.dls.corp.google.com>
	<20140115215024.GM18964@google.com>
	<xmqqppnry0p9.fsf@gitster.dls.corp.google.com>
	<E036CD5E-69B1-4ABD-957B-8E31D410A897@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ruben Kerkhof <ruben@rubenkerkhof.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Igor Gnatenko <i.gnatenko.brain@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 17 19:14:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4DwX-00073R-ST
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 19:14:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752974AbaAQSOz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jan 2014 13:14:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60876 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752689AbaAQSOx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 13:14:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B6B46102F;
	Fri, 17 Jan 2014 13:14:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ajmm/FEYiUw5mJz5mrhX4jjTJjY=; b=u2Xh0o
	68ipJA9U7vURrDEA5F8q0yVEih818xWMH1JUjjGCqEZUfHDJA4qAzBqiPVogI6rh
	aadTGog5YwNYcrgh6TTJp+d5JaH45fvLKBG++5Ku4ijwK/jDy/GvmDLL4u9Ku5l9
	j31GvHzw40z70BfY0zvX8XTtPAyMKid2pWsms=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cdjAeBfWDusegcyc8+Acowd6DddshvMV
	JbYZEnKClFGa370k64t0iCdmEXKSa1prpL9pZXRYm/kh3TEUlD5XS59nJnCyLlYt
	1fcA93C3vaRy/RCHSdoZfjKg8CQOZnbgq+Ky3QMYxHZTCeQ90jB6KigkYEP5hA29
	/C5pzfHKtdI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 48F556102B;
	Fri, 17 Jan 2014 13:14:52 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 95A0A6101C;
	Fri, 17 Jan 2014 13:14:51 -0500 (EST)
In-Reply-To: <E036CD5E-69B1-4ABD-957B-8E31D410A897@gmail.com> (Kyle J. McKay's
	message of "Thu, 16 Jan 2014 20:21:32 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 42137758-7FA3-11E3-B950-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240604>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> On my OS X platform depending on which version of OpenSSL I'm using,
> the OPENSSLDIR path would be one of these:
>
>   /System/Library/OpenSSL
>   /opt/local/etc/openssl
>
> And neither of those uses a "certs" directory, they both use a
> "cert.pem" bundle instead:
>
>   $ ls -l /System/Library/OpenSSL
>   total 32
>   lrwxrwxrwx  1 root  wheel    42 cert.pem -> ../../../usr/share/curl/
> curl-ca-bundle.crt
>   drwxr-xr-x  2 root  wheel    68 certs
>   drwxr-xr-x  8 root  wheel   272 misc
>   -rw-r--r--  1 root  wheel  9381 openssl.cnf
>   drwxr-xr-x  2 root  wheel    68 private
>   # the certs directory is empty
>
>   $ ls -l /opt/local/etc/openssl
>   total 32
>   lrwxrwxrwx   1 root  admin    35 cert.pem@ -> ../../share/curl/curl-
> ca-bundle.crt
>   drwxr-xr-x   9 root  admin   306 misc/
>   -rw-r--r--   1 root  admin 10835 openssl.cnf
>
> Notice neither of those refers to /etc/ssl/certs at all.
>
> So the short answer is, yes, hard-coding /etc/ssl/certs as the path on
> OS X is incorrect and if setting /etc/ssl/certs as the path has the
> effect of replacing the default locations the verification will fail.

The current code says "if nothing is specified, let's pretend
/etc/ssl/certs was specified.  Then if it is a directory, use it
with SSL_ca_path, if it is a file, use it with SSL_ca_file, if it
does not exist, do not even attempt verification."

And that "let's pretend" breaks Fedora, where "/etc/ssl/certs" is a
directory but is not meant to be used with SSL_ca_path---we try to
use /etc/ssl/certs with SSL_ca_path and verification fails miserably.

If I am reading the code correctly, if /etc/ssl/certs does not exist
on the filesystem at all, it wouldn't even attempt verification, so
I take your "the verification will fail" to mean that you forgot to
also mention "And on OS X, /etc/ssl/certs directory still exists,
even though OpenSSL does not use it."  If that is the case, then our
current code indeed is broken in exactly the same way for OS X as
for Fedora.

The proposed change in this thread would stop the defaulting
altogether, and still ask verification to the library using its own
default, so I can see how that would make the setting you described
used on OS X work properly.

In short, I agree with you on both counts (the current code is wrong
for OS X, and the proposed change will fix it).  I just want to make
sure that my understanding of the current breakage is in line with
the reality ;-)

Thanks.
