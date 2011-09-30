From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git is not scalable with too many refs/*
Date: Fri, 30 Sep 2011 09:52:34 -0700
Message-ID: <7vfwjeotv1.fsf@alter.siamese.dyndns.org>
References: <4DF6A8B6.9030301@op5.se>
 <7c0105c6cca7dd0aa336522f90617fe4@quantumfyre.co.uk>
 <4E84B89F.4060304@lsrfire.ath.cx> <201109291411.06733.mfick@codeaurora.org>
 <4E8587E8.9070606@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Fick <mfick@codeaurora.org>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri Sep 30 18:52:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9gKN-0007dI-Um
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 18:52:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886Ab1I3Qwh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Sep 2011 12:52:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48649 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752028Ab1I3Qwg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Sep 2011 12:52:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 40482461B;
	Fri, 30 Sep 2011 12:52:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=jmLPpt9fFHa0
	WRxtSX5AgdSSGBI=; b=I6mZZQ9w6jz/RVB4vpYcafDbfoxOZCHNofMO4y23DMe3
	hky9ieH0WKpY4lOe8HSlHBys+zc1MigxXokf3HnTsLeZZUx4W32DUK55PFbhxwmT
	RsVby9HgynBCTs9Ku9bHqNC6SnynAO2FV/8EZxISMhxZsZG0kI5KVeYkb3UjSuE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=hSoiu1
	d19fVtxx+jxGeYp9+ffE0+7ekPSqZ2fwi6uGnz6vAkE60u5Nz69cBWbvYNFfJ2bx
	2DiUK9cFKhpKQWPCtYlnLR2rsns9FCFtdrKJQA7m+iZCA/0xA0YQFENK7k0J8irR
	FzGYOynMWs/coDRqkUNXELsnR3PdKhAtnvtGM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3854B4619;
	Fri, 30 Sep 2011 12:52:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B38594618; Fri, 30 Sep 2011
 12:52:35 -0400 (EDT)
In-Reply-To: <4E8587E8.9070606@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Fri, 30 Sep 2011 11:12:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 99174DD2-EB84-11E0-8F5B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182493>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Hi Martin,
>
> Am 29.09.2011 22:11, schrieb Martin Fick:
>> Your patch works well for me.  It achieves about the same=20
>> gains as Julian's patch. Thanks!
>
> OK, and what happens if you apply the following patch on top of my fi=
rst
> one?  It avoids going through all the refs a second time during clean=
up,
> at the cost of going through the list of all known objects.  I wonder=
 if
> that's any faster in your case.
> ...
>  static void describe_one_orphan(struct strbuf *sb, struct commit *co=
mmit)
> @@ -690,8 +689,7 @@ static void orphaned_commit_warning(struct commit=
 *commit)
>  	else
>  		describe_detached_head(_("Previous HEAD position was"), commit);
> =20
> -	clear_commit_marks(commit, -1);
> -	for_each_ref(clear_commit_marks_from_one_ref, NULL);
> +	clear_commit_marks_for_all(ALL_REV_FLAGS);
>  }

The function already clears all the flag bits from commits near the tip=
 of
all the refs (i.e. whatever commit it traverses until it gets to the fo=
rk
point), so it cannot be reused in other contexts where the caller

 - first marks commit objects with some flag bits for its own purpose,
   unrelated to the "orphaned"-ness check;
 - calls this function to issue a warning; and then
 - use the flag it earlier set to do something useful.

which requires "cleaning after yourself, by clearing only the bits you
used without disturbing other bits that you do not use" pattern.

It might be a better solution to not bother to clear the marks at all;
would it break anything in this codepath?
