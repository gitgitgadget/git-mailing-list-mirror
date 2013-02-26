From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possible regression in ref advertisement
Date: Tue, 26 Feb 2013 07:46:37 -0800
Message-ID: <7v621fnkma.fsf@alter.siamese.dyndns.org>
References: <1361811516.3212.14.camel@centaur.cmartin.tk>
 <7vvc9gxn2y.fsf@alter.siamese.dyndns.org>
 <1361819916.24515.5.camel@centaur.cmartin.tk>
 <7vip5gxkgy.fsf@alter.siamese.dyndns.org>
 <1361822092.30765.12.camel@centaur.cmartin.tk>
 <7v1uc4ximl.fsf@alter.siamese.dyndns.org>
 <1361824519.31692.12.camel@centaur.cmartin.tk>
 <7vfw0kt7qc.fsf@alter.siamese.dyndns.org>
 <1361891069.9005.11.camel@flaca.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, peff@peff.net
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Tue Feb 26 16:47:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAMkE-0006sF-HJ
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 16:47:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112Ab3BZPql convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Feb 2013 10:46:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43259 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932104Ab3BZPqk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Feb 2013 10:46:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B37CCADED;
	Tue, 26 Feb 2013 10:46:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0NVuHNIiqiNw
	K4p5JbZdoaaVyXM=; b=vfvHRgK/ZNREsSzgbs245JBhF9ksxB0d06XJf4i7nnmP
	qmk3X7Ws/25KGVShBax7d7vonczQACjlUUz4Ozokr8Sx5EgaZ35x8vWpJLFbjhPV
	mE/79l89jqAXzjGQMd2EkTijwcqPlAqFkUpO7iJR7JuDKDzP0zFI9O0wE4JfR8c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=vqtXUR
	XQAb4yHVz7TrS3Zh8FUlTNpjViFBgin4NAWCKiAMqfbvsjhpbQFvLIX/vVQktrTm
	NDY+nUDvx+ygXm1x/LY++jFW1pfgXQF4odAjH97xIRgHzbmqGNtGBcpihDQnIi5p
	sYdMM1OOiB6P8cHwYfTT3nUbro3wDh4c71bd4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A7EDFADEB;
	Tue, 26 Feb 2013 10:46:39 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 23870ADE7; Tue, 26 Feb 2013
 10:46:39 -0500 (EST)
In-Reply-To: <1361891069.9005.11.camel@flaca.cmartin.tk> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Tue, 26 Feb 2013 16:04:29
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B57FC7FA-802B-11E2-A460-F3C82E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217138>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> Since the libgit2 parser seems to work with it, it's perfectly possib=
le
> I did mess about with the file and then promptly forgot. An error wou=
ld
> definitely not help here, but I do think a warning should be issued i=
f
> the file isn't quite as it should be. It seems the parser can already
> detect this, so it could be as easy as adding a fprintf(stderr, "..."=
).

Yeah, another thing that may be worth checking is if this was
written/corrupted by hand, in which case there is no need to worry
about it further, or by something else, e.g. reimplementations such
as jgit and libgit2, or a third-party tool that wants to be
compatible with Git, in which case we do want to see that get fixed.
