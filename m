From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Question about installing git from source
Date: Tue, 23 Dec 2014 09:03:38 -0800
Message-ID: <xmqqioh247th.fsf@gitster.dls.corp.google.com>
References: <CANCZXo42SdM8hMdTFYgvD8D+RmXua1oJvB+FfTjjfR=yWqhmkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 18:03:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3SsC-0001cj-0B
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 18:03:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754176AbaLWRDr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 12:03:47 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53886 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753901AbaLWRDr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 12:03:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EA090281BA;
	Tue, 23 Dec 2014 12:03:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZoyeFJtr4wZppT4kU38cYdUsg80=; b=hSY7l3
	acqhlMxxNYBW3oGBTb23sTMtmub4dFV75dWNWuzaIHWHmN03p8WHBH8Ir2DQeQzb
	jsc3CvvUdJbSaRRrUlS2fPeqvFumtKczKwukUI8Or2Z8Suuan5cCTLI+VE+n3Yx2
	vWl14UqwX3UF7Vf6qXerivFLPlomLZqmqbM/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ulUXWwy/WtKB3H4HOGQDrcNjiLh0Z7o3
	Xpp0c9Q+4ecDzoLMcAUXtWII34MNc5tr0bUF1GnwFid0Hz0OEtGXFrINhKMY2crW
	BdpJSreFsOBI5ktowXsu11Kz6976Y8WcE3JUheZa6x83OBQ2ALXwhd5RXjI+L3Yu
	5vIEr7FaNV4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DFFB0281B9;
	Tue, 23 Dec 2014 12:03:40 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 57EF8281B8;
	Tue, 23 Dec 2014 12:03:40 -0500 (EST)
In-Reply-To: <CANCZXo42SdM8hMdTFYgvD8D+RmXua1oJvB+FfTjjfR=yWqhmkg@mail.gmail.com>
	(Alexander Kuleshov's message of "Tue, 23 Dec 2014 14:55:06 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A4A91BD8-8AC5-11E4-865F-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261741>

Alexander Kuleshov <kuleshovmail@gmail.com> writes:

> Trying to install git from source, executing:
>
> make configure
> ./configure --prefix=/usr
> make --prefix=/usr all
> sudo make install DISTDIR=/usr

That does not seem to match any of the ways how INSTALL tells us to
build and install.

Excerpts from INSTALL

    (1) ... If you want to do a global install, you can do

        $ make prefix=/usr all doc info ;# as yourself
        # make prefix=/usr install install-doc install-html install-info ;# as root

Note how "prefix" is spelled.

   (2) Alternatively you can use autoconf generated ./configure
       script to set up install paths (via config.mak.autogen), so
       you can write instead

        $ make configure ;# as yourself
        $ ./configure --prefix=/usr ;# as yourself
        $ make all doc ;# as yourself
        # make install install-doc install-html;# as root

Note how "make" does not have any "prefix".

Also when you install to a temporary directory so that you can tar
up the resulting hierarchy, the variable to use is spelled DESTDIR,
e.g.

	make DESTDIR=/var/tmp/git-2.2.1 install install-doc

> ...
> What's problem can be here?

Hopefully the above would be a good start to help you figure that
out.
