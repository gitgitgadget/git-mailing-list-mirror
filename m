From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git installation fails in home directory on ubuntu 12.04
Date: Tue, 18 Sep 2012 11:09:27 -0700
Message-ID: <7v627bnqy0.fsf@alter.siamese.dyndns.org>
References: <505859B4.2090205@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <stefbel@web.de>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 18 20:09:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE2Et-0000WV-5X
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 20:09:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728Ab2IRSJb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 14:09:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34340 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751490Ab2IRSJa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 14:09:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E71D8374;
	Tue, 18 Sep 2012 14:09:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PTWF3BXiX0RT98tDrhdwxQVzT3Y=; b=ydrRbO
	knjfznElzOri/DCvhbWTWtknXlJVY23M4eZxK1s1Qjh8v8wH2LAbvFO8o2hoo+8v
	rp2wa9eJTO7eCUlOMTIlYHlFAecq6Slf+SNiCVGgDoFYmhlNLm6Auwf7nfFKBd6X
	FZM+vNVF8lZoXNw4jug6XA6H8eoPjwxANeJi0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vb8D6W5HEY65RBekUAwLwExchKCWHyTm
	uZzPTn8HD0wJ5oo5hqvUj16xb6CsC5ARsyqDlezAwIUH55IpI1ujFkwiCJU0AooP
	d3wzrCgifKRPJLscCqKyVFT84NE3LCHSAQyXAnCUE+/9rUcK+gkMWrILuF9cH/MQ
	EEMZb0dCEUU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A5A28373;
	Tue, 18 Sep 2012 14:09:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 675F78371; Tue, 18 Sep 2012
 14:09:28 -0400 (EDT)
In-Reply-To: <505859B4.2090205@web.de> (Stefan Beller's message of "Tue, 18
 Sep 2012 13:23:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FCAE27D2-01BB-11E2-91BF-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205843>

Stefan Beller <stefbel@web.de> writes:

> So I did
> git fetch
> git rebase
> git describe
> v1.7.12-503-g5976753
>
> ./configure --prefix=/home/sb
> make
> make install
>     GEN perl/PM.stamp
>     SUBDIR gitweb
>     SUBDIR ../
>     SUBDIR perl
> make[1]: `perl.mak' is up to date.
> ...
> make[1]: Entering directory `/home/sb/OSS/git/perl'
> make[2]: Entering directory `/home/sb/OSS/git/perl'
> Appending installation info to /usr/local/lib/perl/5.14.2/perllocal.pod
> mkdir /usr/local/lib/perl: Permission denied at
> /usr/share/perl/5.14/ExtUtils/Command.pm line 288

I often do an equivalent of

        make prefix=/home/gitster
        make prefix=/home/gitster install

and never saw this.  I do not use ./configure, and am not actively
involved in maintaining that part of the system.

Among the people who touched configure.ac and aclocal.m4 in the past
18 months, Stefano seems to be the most clueful with that part of
the system, and among those who touched perl/Makefile.PL during the
same period, I suspect Jonathan may know a thing or two about
MakeMaker, so let's see if we can get help from these directions...
