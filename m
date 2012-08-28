From: Junio C Hamano <gitster@pobox.com>
Subject: Re: libgit2 status
Date: Tue, 28 Aug 2012 11:36:57 -0700
Message-ID: <7vvcg2zwvq.fsf@alter.siamese.dyndns.org>
References: <87a9xkqtfg.fsf@waller.obbligato.org> <5038A148.4020003@op5.se>
 <7vharpv77n.fsf@alter.siamese.dyndns.org>
 <nnglih0jotj.fsf@transit.us.cray.com>
 <7vfw78s1kd.fsf@alter.siamese.dyndns.org>
 <nngsjb8i30w.fsf@transit.us.cray.com>
 <7v6284qfw8.fsf@alter.siamese.dyndns.org> <20120827214027.GA511@vidovic>
 <nngr4qqhp7x.fsf@transit.us.cray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <dag@cray.com>, Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Andreas Ericsson <ae@op5.se>, <greened@obbligato.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 28 20:37:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6Qf1-0007nO-8z
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 20:37:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752275Ab2H1ShC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Aug 2012 14:37:02 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57493 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751014Ab2H1ShA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Aug 2012 14:37:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 94A069CF8;
	Tue, 28 Aug 2012 14:36:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=aa9Wn7EtMWUDFhykTToxMzYGM34=; b=flQ6HfKqcGOo7MIDpWbU
	xoDSnUT0Wsugh/E3G5jf7PgNFcojs/qGO2JwLzlHLFB2lkMwqL5GYkENn87uk1z3
	ZPYFKCD5qE3h/DZ0InDlZJRKCwIFX3wjTxenl9uIZ4GjPCe0WKUIF2NuzfYgDl6o
	DjJ05YqHrm+hmyXwFiDPRO8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=T1eE7gX81X9YN2DfW2n603ll3zNfCrhfJqbQLR2gcNVP56
	fjhB1NVCuyOHJ9Jr+MtZPWULCgeDGCIMR6e1mYNnSWaIIFQmVd7taC50a8vrjV11
	9rsDidDG1/G1B8x5yN+qZnGE2WgjPeVQSErrf7Ig9rgkMqtpQEekR62mz5IaA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8148F9CF7;
	Tue, 28 Aug 2012 14:36:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DE7139CF6; Tue, 28 Aug 2012
 14:36:58 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 59C5CF7A-F13F-11E1-857E-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204447>

<dag@cray.com> writes:

> Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:
>
>> Do you expect one big merge of a very stable libgit2 at some point?
>
> I don't think there's any need to merge libgit2 into the git project
> source.  As a library, it should be perfectly usable as a project of its
> own, just like libcurl and libz.
>
>> Otherwise, what about going with this optionnal "LDFLAGS += -libgit2"
>> ASAP with good disclaimer that it's only intended for development and
>> testing purpose? Then, git-core could slowly rely on functions of
>> libgit2, one after the other.
>
> This makes a lot of sense to me.

As I already said in my earlier message in $gmane/204305, I wouldn't
be surprised if some "core stuff" gets reimplemented on top of
libgit2 and distributed as part of the git-core.  But at this
moment, I see that just as a blip of possibility far in the future.

It would most likely start slowly, by adding lg-client/cat-file.c
that is linked with libgit2 when "make USE_LIBGIT2=YesPlease" was
asked for, and we compile the tried-and-true builtin/cat-file.c
otherwise ("cat-file" may actually not the most trivial first step,
though, but I think readers get the idea).

Even after most if not all commands have counterparts reimplemented
on libgit2, I do not think we can afford to drop any of the original
for a long time.  For that to happen, at the very least:

 - libgit2 must be available in major distros so that people can say
   "[yum|apt-get] install libgit2-dev"; and

 - the version of it packaged for major distros are recent and
   stable enough, so that we never have to say "distro X ships with
   libgit2 that is too old, so people on that distro have to compile
   it from the source."

which is the quality we expect from libraries we would depend on,
like -lz, -lcurl, etc.

It is OK if we have to conditionally compile out some of our code in
the periphery when libgit2 that is available on the platform is too
old (we allow it for -lcurl already).

But all of the above assumes one thing: the reimplementated result
does not suck ;-) which is a large unknown.
