From: Junio C Hamano <gitster@pobox.com>
Subject: Re: problem with setlocale trick in gettext.c
Date: Tue, 25 Sep 2012 10:31:36 -0700
Message-ID: <7va9wevwjr.fsf@alter.siamese.dyndns.org>
References: <CACsJy8A+YvdGc6LM5baFqHoB91p6TAjQ9kKXuaPspvL--mfe0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
	<avarab@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 25 19:31:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGYz9-0008UK-Sr
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 19:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757576Ab2IYRbk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2012 13:31:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52319 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753893Ab2IYRbj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2012 13:31:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FCCE8991;
	Tue, 25 Sep 2012 13:31:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ANpNisLSWmsGlfItFMkzTETahxE=; b=A1zybV
	qTvW9Zlk23DD+tTHSydCvCokgPTOLzeYlxQrftp0aRmu0nwrJZmjDx0KicLjsjC0
	lSSmKqVx4cC4oRzgzpcmOReef6WhSpDozks4J7P9d4gzjI/MWXJe+q8QbXrCA9pa
	9yqbY8o1/kYWmzpXqfHJPAwM5H1BxyB12FPQU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G9ssBbpm6NRQFg4270rx/vQw2/RGttrO
	T4ZQh5YQ44I6VHzc+dYIOeVvyfWdQ1+/f5fkspRgM4tjG0F4hjm0UkuhwEUR88Mf
	kAPAc91wkvnindFCj8sDmsZnyUgMz51GUG9u3PVs3MCi6cYSZncyyKB3qvJLWhP2
	0I017QXrbus=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D1178990;
	Tue, 25 Sep 2012 13:31:38 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 02DCD898F; Tue, 25 Sep 2012
 13:31:37 -0400 (EDT)
In-Reply-To: <CACsJy8A+YvdGc6LM5baFqHoB91p6TAjQ9kKXuaPspvL--mfe0Q@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Mon, 24 Sep 2012 21:08:57 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DC4D0B54-0736-11E2-95C0-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206367>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> I think the setlocale() trick in init_gettext_charset() messes up
> locale support from library. Currently I get
>
> fatal: Could not switch to '/foo/': Kh?ng c? t?p tin ho?c th? m?c nh? v?y

That pretty much matches what the big comment before your patch
disables, doesn't it?  Could it be that newer/older libc differ
in the behaviour around this code?
