From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Patch-level-format conversion
Date: Wed, 15 Jun 2011 15:13:48 -0700
Message-ID: <7v39jakajn.fsf@alter.siamese.dyndns.org>
References: <BANLkTimRArtFBqA4BFASjkS9BC1sbSfUJQ@mail.gmail.com>
 <20110615205507.GB27172@elie>
 <BANLkTim8bdVGo8u_HzZpE_5+xmPe_O+_Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: sedat.dilek@gmail.com
X-From: git-owner@vger.kernel.org Thu Jun 16 00:14:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWyLW-0007Ec-Ea
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 00:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753281Ab1FOWNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 18:13:53 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51933 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904Ab1FOWNw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 18:13:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F21C55BC0;
	Wed, 15 Jun 2011 18:16:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xmJKytPPT2geqFGUNC9QcA6Df7c=; b=bbD0hX
	kYxCbtuv1+zJPE9Phtrhmu09Ca84lgNUCGX4HC6rfJrtA5w8XEkfTic0T03pOD40
	X2RxKgyV8Iuu3eCWOE5CEDHYqlTDuHtBYMuWHaFLTEDorm7jdSzqeK5jNI1NwEn4
	tQgiyBTpxKa0rYYnfu6oFh2c24AypdCZ9n4VE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Asz+jeTRg+EQSFdW/mfORycfgyst8Vt/
	37R+yHRe46uzrociN6zpWjmKxOL0ydMW5uuOqYQJv+7Kinuc172nN2AalFBlD8bK
	hNI2FO+1L6sZT3UWyL/RBILpzmFjQoIb316CHDLIR+heFkZnPuvEctQ+SPDs8PeX
	JEktZ56O7z8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E96875BBF;
	Wed, 15 Jun 2011 18:16:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1BC165BBC; Wed, 15 Jun 2011
 18:16:01 -0400 (EDT)
In-Reply-To: <BANLkTim8bdVGo8u_HzZpE_5+xmPe_O+_Dw@mail.gmail.com> (Sedat
 Dilek's message of "Wed, 15 Jun 2011 23:16:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0D615A8E-979D-11E0-B76A-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175854>

Sedat Dilek <sedat.dilek@googlemail.com> writes:

> I played a bit with git format-patch and git diff and got some helpful
> hints from friends of #grml and #quassel.de.
> Attached is the README.txt I produced some hours ago.
>
> Regards,
> - Sedat -
>
> Q: How to generate freetz-conform patches out of a GIT repository?
>
> A. Follow these instructions.
>
> ### Checkout freetz development branch
> svn co http://svn.freetz.org/trunk/ freetz-trunk
> cd freetz-trunk/
>
> ### Get latest revision
> revision=$(LC_ALL=C svn info | grep "Last Changed Rev" | awk {'print $4'})
> echo $revision
>
> ### Turn freetz-trunk source-dir into a GIT repository
> git add --ignore-errors ./ ; git commit -m "`basename $PWD` SVN revision $revision"

Wouldn't "add ./" add all the cruft in .svn (and its huge "pristine"
subdirectory)?  Why --ignore-errors?

> ### Edit some files and save changes
> $EDITOR file1 file2
>
> ### Extract patchset
> git format-patch --no-prefix --no-numbered $FIRST..$LAST

You would need to record your own changes made by the $EDITOR step in
commits before asking format-patch to make patch files out of them, but I
do not see that step.

Also it is unclear how you determine $FIRST and $LAST.  FIRST must name
the commit that is the _parent_ of your first commit (i.e. your sample
command line tells $FIRST to be excluded).

> ### Some git format-patch options explained:
>       --no-prefix: Do not show any source or destination prefix.
>    -n, --numbered: Name output in [PATCH n/m] format, even with a single patch.
> -N, --no-numbered: Name output in [PATCH] format.
>
>
> - Sedat Dilek <sedat.dilek@gmail.com> (15-Jun-2011)
