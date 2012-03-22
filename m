From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Demonstrate failure of 'core.ignorecase = true'
Date: Thu, 22 Mar 2012 13:37:46 -0700
Message-ID: <7vk42cwew5.fsf@alter.siamese.dyndns.org>
References: <1332370222-5123-1-git-send-email-pj@irregularexpressions.net>
 <4F6ACB67.1080503@viscovery.net> <4F6B0C3E.8090501@in.waw.pl>
 <20120322141245.GB8803@sigill.intra.peff.net>
 <7vbonozi8c.fsf@alter.siamese.dyndns.org>
 <20120322173701.GA11928@sigill.intra.peff.net>
 <7viphwxyp1.fsf@alter.siamese.dyndns.org> <4F6B84DF.8040806@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>,
	"Peter J. Weisberg" <pj@irregularexpressions.net>,
	git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Thu Mar 22 21:37:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAole-0000P5-CH
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 21:37:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759727Ab2CVUhu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Mar 2012 16:37:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54955 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755785Ab2CVUht convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Mar 2012 16:37:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D12957E6A;
	Thu, 22 Mar 2012 16:37:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=uFJCXQ2HgM0z
	yMingBAN2oQNp6Y=; b=gVMg+CFCczW++dKeYxJx6MpD2QrI81ejiaX/yv9V2AOr
	PrsJtXtWIKQpzC0Q5QhwATDDevUfvT56MQxKMOAy5J2hJlIdb+gEF+zmsKuliifm
	tAR6GWXNUj2ONv1Y2wN0S0urdn97qcsgOvqM+d2Q+1N4wY4ys0W6yZNwg3K4jjs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xsz4ZF
	6+ZexofCUcEKcaXp5pfxmTWM/k2ClvjoDTfAFfnXwXgWLtdmGG6KSF1CoBZh8ZEl
	CuXzjfnHm0wZKCxyc+Dkl8sG5SSuPrKXEWJsZmLJ47bLy7l8oz0U3ESbUR84EUwW
	GStRPTBzGQQ07DfDGNBj7OBpANOlR7v05Ny2k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C792D7E69;
	Thu, 22 Mar 2012 16:37:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5C0E67E68; Thu, 22 Mar 2012
 16:37:48 -0400 (EDT)
In-Reply-To: <4F6B84DF.8040806@in.waw.pl> ("Zbigniew =?utf-8?Q?J=C4=99drze?=
 =?utf-8?Q?jewski-Szmek=22's?= message of "Thu, 22 Mar 2012 21:00:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E31CD31C-745E-11E1-9831-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193713>

Zbigniew J=C4=99drzejewski-Szmek  <zbyszek@in.waw.pl> writes:

> Even this updated text does not say _what_ happens when
> core.ignorecase is set on a case-insensitive filesystem.

That was very much on purpose. We tell users not to do that, because it=
 is
calling for an undefined behaviour. And leaving it undefined gives us a
wiggle room to later do something better if we choose to.

> Maybe:
> --- 8< ---
> When set, case-insensitive comparisons will be used when internally
> comparing file names.

When we try to create a new file with open("./Makefile", O_CREAT) syste=
m
call, we do not opendir(".")  and readdir() to see if "makefile" exists
ourselves at all, but the above makes it sound as if we would do such
things to make sure we compare filenames ignoring there case.

That is *not* what happens, and that is not what we want to say in the
documentation.
