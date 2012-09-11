From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git an case-insensitive Mac OS X filesystem
Date: Tue, 11 Sep 2012 08:40:58 -0700
Message-ID: <7vhar4k1o5.fsf@alter.siamese.dyndns.org>
References: <CAPLaKK71O3RzavOqY2uVC1tUsbs+W6WxJRWuLBDFUvTwojAN-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Roger Pau =?utf-8?Q?Monn=C3=A9?= <roger.pau@entel.upc.edu>
X-From: git-owner@vger.kernel.org Tue Sep 11 17:41:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBSaN-0000gN-JP
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 17:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756690Ab2IKPlD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Sep 2012 11:41:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64930 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754434Ab2IKPlA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Sep 2012 11:41:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4314E6337;
	Tue, 11 Sep 2012 11:41:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=iCVI7b79NjnY
	ZV/WZTb1sBgo7b4=; b=nrd4OSsn8ac0dl0Q2DHRufwn9u2pm4yrme8AfMN0jpbD
	5AX9osplsidQGWhRaP0xzOu83QFArgqsIKceLx7XewNrHas70P2tBhujWzDXy9WV
	1eV0ijSsQkeuV2TI1Gxk9pcXU2HhLzG4Msbvq7cVueRP3cP7wdWxAspAxkDkHaI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dhV3gA
	EdN/76I6xKcswhW+2J1vn7VtvOT7PvFc5IHXNzb/s1cxfrN7f4lNcJQWnPvzc+x4
	871Ror6uGsCkm8H7S1VvGzlJ9tN8BbwSVxSmsQQSMXopYIZMEBHqk2j97QQT/0iA
	LO/bU1jvJK+lodhdvembHo1/N8LwPtVWr9I5k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2EDE36335;
	Tue, 11 Sep 2012 11:41:00 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 88E7F6334; Tue, 11 Sep 2012
 11:40:59 -0400 (EDT)
In-Reply-To: <CAPLaKK71O3RzavOqY2uVC1tUsbs+W6WxJRWuLBDFUvTwojAN-g@mail.gmail.com> ("Roger
 Pau =?utf-8?Q?Monn=C3=A9=22's?= message of "Tue, 11 Sep 2012 10:21:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 15B127EC-FC27-11E1-8B0F-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205238>

Roger Pau Monn=C3=A9 <roger.pau@entel.upc.edu> writes:

> Hello,
>
> I'm using git for all my projects, and I usually work under Mac OS X
> with the default filesystem (that's case-insensitive, but
> case-preserving). I'm currently working on a project that has several
> branches, and two of them are called origin/DHCPCD and origin/dhcpcd
> respectively, that's unfortunate, but I cannot do anything about it.
> This completely breaks the git repository, because
> .git/refs/remotes/origin/DHCPD and .git/refs/remotes/origin/dhcpd are
> actually the same file, so when I try to update my repository
> performing a git pull I get the following error:
>
> error: Ref refs/remotes/origin/dhcpcd is at
> 6b371783de2def2d6e3ec2680ba731f7086067ee but expected
> 79f701ce599a27043eed8343f76406014963278a
>
> So I was wondering if anyone has stumbled upon this issue, and what's
> the best approach to fix it.

If "several" is manageably small, you can configure your refspecs to
rename them, e.g.

	[remote "origin"]
		url =3D ...
                fetch =3D +refs/heads/master:refs/remotes/origin/master
                fetch =3D +refs/heads/dhcpcd:refs/remotes/origin/dhcpcd
                fetch =3D +refs/heads/DHCPCD:refs/remotes/origin/dhcpcd=
-u

which tells

	$ git fetch origin

to use your remote tracking branch origin/dhcpcd-u to copy from
their DHCPCD.  Then you can work on it the usual way.

	$ git checkout -b dhcpcd-u origin/dhcpcd-u
        $ work work work

=46or pushing, you can rename it back in a similar way.

        $ git push origin dhcpcd-u:DHCPCD

which is a short-hand for

        $ git push origin refs/heads/dhcpcd-u:refs/heads/DHCPCD
