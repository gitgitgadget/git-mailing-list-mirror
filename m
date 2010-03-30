From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git cvsimport and case-insensitive config
Date: Tue, 30 Mar 2010 14:20:30 -0700
Message-ID: <7vr5n1v74x.fsf@alter.siamese.dyndns.org>
References: <hoscv7$hmn$1@dough.gmane.org>
 <7vy6h9vhuk.fsf@alter.siamese.dyndns.org>
 <cb7bb73a1003301105v691624sdcdadf6809c50b89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 30 23:20:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nwirj-0002Nu-Ay
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 23:20:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755951Ab0C3VUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 17:20:45 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36224 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755386Ab0C3VUo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 17:20:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C833FA67AC;
	Tue, 30 Mar 2010 17:20:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mn7w5P1iJ2SGYRPLt4ocdgfaq8o=; b=T37VI6
	LWUF05H/9o97l2YVpwp5Is1fdgpAZh1lasJgUlcrfnimCaaVECBq5shCUrrHvF5L
	6oSw/c6ro3FuyQ+wkvvpT4U07O+whQw5WFUdxv7ilfYl7qoaJCDHj5VWmKp64PG/
	aJQEyeLeLkBDJKqlWF4j/gHNIm09OdFqOIdtw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CXx7RlSVjiuXoQisuZx18fNCNRnlQr2L
	gRy+RpQw48Jy76mmVymEkuUAP5XzIf8KZ93eZMpOK6bkh3X0uCYaU+8goWhBBn3H
	ScmUPi5+rrkgISRp1euE1e0eve/nW6r1OnMr/huxc4CDjfz1xYPWcUJNCT4LvlF6
	E9lOx2EEkC8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CB5EA67A8;
	Tue, 30 Mar 2010 17:20:39 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 37127A67A5; Tue, 30 Mar
 2010 17:20:32 -0400 (EDT)
In-Reply-To: <cb7bb73a1003301105v691624sdcdadf6809c50b89@mail.gmail.com>
 (Giuseppe Bilotta's message of "Tue\, 30 Mar 2010 20\:05\:57 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 170426E6-3C42-11DF-803A-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143603>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> We might be able to skip (2) by relying on the fact that if the
> lowercase is boolean, the uppercase isn't, and conversely.

That was the idea I wrote in an earlier draft of my response that I later
scrapped.  I started with "cvsimport.a?  If it is 'true' then that is -a;
if it names an existing file, then it is -A."  I continued the draft up to
'-p' vs '-P' (the former would begin with a hyphen, the latter likely
wouldn't).  But I don't think you can reliably guess -s/-S (both strings).

A bigger reason is that, if you have _any_ combination that you cannot
reliably guess, you would either need the user to ask for help, or you
need to convert by reading the configuration file case-sensitively
yourself to come up with a reliable conversion.  I opted for the latter.
