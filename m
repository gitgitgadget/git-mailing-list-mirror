From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for
 push.default
Date: Tue, 13 Mar 2012 21:46:54 -0700
Message-ID: <7vbonzssap.fsf@alter.siamese.dyndns.org>
References: <vpqobs65gfc.fsf@bauges.imag.fr>
 <1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr>
 <1331288715.21444.38.camel@beez.lab.cmartin.tk>
 <4F5A4C45.7070406@xiplink.com> <4F5AF1A8.4050604@alum.mit.edu>
 <4F5E12A5.6030701@xiplink.com> <vpqzkblixmb.fsf@bauges.imag.fr>
 <20120312183725.GA2187@sigill.intra.peff.net>
 <vpqy5r44zg7.fsf@bauges.imag.fr>
 <CAHkcotg1FKxfMR4Fe9Xfo_i4nuxzXdfVWe80HZu0wQEkiXhhmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org, gitster@pobox.com
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 05:47:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7g76-0006lm-6o
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 05:47:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753279Ab2CNEq6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 00:46:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48666 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752608Ab2CNEq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 00:46:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C57D47CE2;
	Wed, 14 Mar 2012 00:46:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CoCYs/+YqPOamz2oHHUdU2N0xAk=; b=S4L89R
	rrKwPfZkID04w88FoJyKuY/MFKeq6hvtUKePctmpz66ysky1EZwhwKhzVXfN+0Hn
	FN/hYmp9rJDHCIBLigxW9EhezDKbgY+ol5CB/DVS9kURZyQSWE6vIQvRPdOpyRmx
	x8b4xPWIG97Fvyh5CNXLvQ79ctn732PQ7mcL8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Hf/bdLm8VeUz4Usyunbv9VDLQ/PiLjot
	hRVtKomR1qAb+1yAjTFbtTXlrNQsP0BdyVNm+Nkf7uGJmMDHGQKypSG6ghxE0oIW
	pvcIUyYgEmpaveZQ2k7yulnB5V5zmQ05b0fznhHVsdNSdJLwVgeG/Imy0XoXhvrz
	LYA5Cl8/MDI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB7CB7CE1;
	Wed, 14 Mar 2012 00:46:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0ED6D7CE0; Wed, 14 Mar 2012
 00:46:55 -0400 (EDT)
In-Reply-To: <CAHkcotg1FKxfMR4Fe9Xfo_i4nuxzXdfVWe80HZu0wQEkiXhhmA@mail.gmail.com> (Dmitry
 Potapov's message of "Tue, 13 Mar 2012 21:08:52 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B9FDCC90-6D90-11E1-9EB7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193083>

Dmitry Potapov <dpotapov@gmail.com> writes:

>> One can easily get in this situation even in a kernel-style workflow:
>> work from your desktop, push, work from your laptop, try to push and it
>> fails.
>
> IMHO, when you often switch between your desktop and laptop, 'matching'
> makes much more sense. If 'push' fails then usually I want to force non-
> fast-forward push, because the new series contain reworked patches that
> already were on the other computer.

You are free to live dangerously, but please do not teach that to other
people.

Switching between two machines A and B is done a lot more safely if you
arrange them to cross pull from each other, i.e. on machine A, remotes/B/*
is where you keep copies of branches of B to with either of these

	machineA$ git fetch B refs/heads/*:refs/remotes/B/*
	machineB$ git push A refs/heads/*:refs/remotes/B/*

(the latter is to emulate the former "fetch" you wish to run on A to get
data from B in the reverse direction), and similarly on machine B, you use
remotes/A/* to keep copies of branches of A.

That way, the risk of losing your work because the "usually" in your "then
usually I want to force" turns out to be untrue is greatly reduced.
