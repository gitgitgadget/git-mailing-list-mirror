From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Teach rebase to rebase even if upstream is up to
 date  with -f
Date: Thu, 12 Feb 2009 15:22:09 -0800
Message-ID: <7viqnfi6la.fsf@gitster.siamese.dyndns.org>
References: <1234468061-29923-1-git-send-email-srabbelier@gmail.com>
 <7vbpt7jq4c.fsf@gitster.siamese.dyndns.org>
 <bd6139dc0902121357l1eea7b8xe890513b756e97c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailinglist <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Wong <normalperson@yhbt.net>,
	"Shawn O. Pear, Sverre Rabbelier <srabbelier@gmail.com>"@b-sasl-quonix.sasl.smtp.pobox.com
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 00:23:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXkuI-0001sf-VK
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 00:23:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbZBLXWU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Feb 2009 18:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760844AbZBLXWU
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 18:22:20 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37273 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760784AbZBLXWT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Feb 2009 18:22:19 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EB32799B5C;
	Thu, 12 Feb 2009 18:22:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id F264399B59; Thu,
 12 Feb 2009 18:22:10 -0500 (EST)
In-Reply-To: <bd6139dc0902121357l1eea7b8xe890513b756e97c2@mail.gmail.com>
 (Sverre Rabbelier's message of "Thu, 12 Feb 2009 22:57:17 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FD623B80-F95B-11DD-A5F5-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109680>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Thu, Feb 12, 2009 at 22:34, Junio C Hamano <gitster@pobox.com> wro=
te:
>> For that, I would prefer to see:
>> =C2=A0(1)=C2=A0 =C2=A0git format-patch --stdout origin >my.mbox
>> =C2=A0(2)=C2=A0 =C2=A0git fetch origin
>> =C2=A0(3)=C2=A0 =C2=A0git checkout origin =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 ;# yes, detach
>> =C2=A0(4)=C2=A0 =C2=A0git am --whitespace=3Dfix my.mbox
>> =C2=A0(5)=C2=A0 =C2=A0make test
>> =C2=A0(6)  =C2=A0git format-patch -o to-send-out origin
>> =C2=A0(7)=C2=A0 =C2=A0git send-email ..options.. to-send-out
>
> If I understand things correctly 'git rebase -f --whitespace=3Dfix
> origin' does only 1 and 4, yes? In my workflow I do 2 and 5 as 'git
> pull --rebase' before I push anything, and since I push rather then
> send-email, I never use 6 and 7. That leaves 3, which I guess is
> specific to your workflow? I am guessing you detach to make it easier
> to easily test many different topic branches.
>
>> It fixes whitespace breakages, but more importantly, the procedure m=
akes
>> sure that what you will be sending out will apply cleanly to the ori=
gin
>> that may have progressed since you last looked at it.
>
> Mhhh, would 'git fetch && git rebase -f whitespace=3Dfix orgin' do th=
e
> same? Do you see any other problems with the patch?

No, because I didn't read the patch text; I don't read patches that are
larger than 20 lines during the day-job hours.

I was only commenting on your "rebase does not work if I am up to date
with respect to origin and here is my workaround".

Obviously neither the "fetch origin and reapply" nor "pull --rebase" wo=
uld
make any difference if you were indeed up to date.
