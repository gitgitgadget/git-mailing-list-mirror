From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git format-patch doesn't exclude merged hunks
Date: Wed, 16 May 2012 15:42:14 -0700
Message-ID: <7v4nrfd9yx.fsf@alter.siamese.dyndns.org>
References: <4FB3CAE3.6040608@draigBrady.com>
 <7vhavgc660.fsf@alter.siamese.dyndns.org> <4FB3FA59.1010707@draigBrady.com>
 <7v8vgsc544.fsf@alter.siamese.dyndns.org> <4FB40A7E.80705@draigBrady.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?P=C3=A1draig?= Brady <P@draigBrady.com>
X-From: git-owner@vger.kernel.org Thu May 17 00:42:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUmvT-0004Gw-Np
	for gcvg-git-2@plane.gmane.org; Thu, 17 May 2012 00:42:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760682Ab2EPWmS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 May 2012 18:42:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33502 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759576Ab2EPWmR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 May 2012 18:42:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69D4486FB;
	Wed, 16 May 2012 18:42:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=QY8vhISzYwYR
	xyXUY6cVUYH5vu0=; b=iNNYZCOWvZ3PaNcEG4K64bpa29vg6QMKCZ3gq+Vc2eKu
	tsp2yQsr/tROn84Ib3ur95+53jPJlOPHS4li8Xryn1U+/jetbxhcix18/O5vriVc
	MQsfCdE13orVXX2B3JCEk+6PEAso3oDaj53jeeYuOuNpM2xu864ZRBvMivGEBCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Movp5b
	xo1vd4Hz7TF/i8SutB+zoQzLTdBHVMNjeA4/DWzEyhrOacW8o4a46gMeo6okxpy0
	ff6rbTGSu2l3kQyjrw+4TAY4gqwfvd5DRqLekE7h1+DzjKV8jqcHD8v8qPWOH4iD
	syb8KtsIU6XrZkpAktoNyxz7zLo5v0i8DHm6o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5EEA486FA;
	Wed, 16 May 2012 18:42:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BC41C86F8; Wed, 16 May 2012
 18:42:15 -0400 (EDT)
In-Reply-To: <4FB40A7E.80705@draigBrady.com> (=?utf-8?Q?=22P=C3=A1draig?=
 Brady"'s message of "Wed, 16 May 2012 21:13:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 62BEA9F0-9FA8-11E1-B3E2-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197903>

P=C3=A1draig Brady <P@draigBrady.com> writes:

> On 05/16/2012 08:12 PM, Junio C Hamano wrote:
>> A patch that is reduced in a way you propose will apply to the recei=
ving
>> tree cleanly without stopping, and does not offer an editor session =
to
>> adjust the log before making a commit.  "The user has a chance to no=
tice
>> and correct" is not sufficient---nobody will spend extra effort to n=
otice
>> let alone correct.  The reminder has to be a lot stronger than that,=
 I
>> think, to cause the patch application to "fail" and require the user=
 to
>> actively look at the situation.
>
> Yes it would make sense for `git am` to balk at such reduced patches,
> while allowing standard patch utilities to process the patches as
> normal.

That certainly is one way to implement it, but "am" may not necessarily=
 be
the best place to do so, depending on how you are using the output from
format-patch.  It does not matter if you are using "format-patch" piped=
 to
"am -3" as a more efficient way to cherry-pick or rebase commits, but i=
f
you are sending the result out to somebody else, you would instead want=
 to
sanitize the mess on your end, wouldn't you?

That would mean that "format-patch" needs to do more than just "mark a
part of its output being suspicious".  This is especially true as some
people blindly send out format-patch output using the interface to "git
send-email" without first verifying if the patches they are sending out=
 is
what they want to send out.
