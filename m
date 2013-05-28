From: Junio C Hamano <gitster@pobox.com>
Subject: Re: contrib/git-normal-to-bare.sh
Date: Tue, 28 May 2013 13:07:44 -0700
Message-ID: <7v1u8qzx4f.fsf@alter.siamese.dyndns.org>
References: <CAOsGNST8X+crMQz1ynJQxctCMUnBw3T3K5HiMH8B_GFP63yX1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Zenaan Harkness <zen@freedbms.net>
X-From: git-owner@vger.kernel.org Tue May 28 22:07:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhQBU-0000Zz-Da
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 22:07:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755431Ab3E1UHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 16:07:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40211 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755033Ab3E1UHr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 16:07:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 67E0A226DF;
	Tue, 28 May 2013 20:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=MxHC2jcX/jU76bj7SvJysTaNRPc=; b=xYH07FWVkLicnKPgDfiE
	E1yQFQqvAFr/sHPuPWoGSof0gYVti+jG9fbZu6iGYc7o/6ZKQUvducx0TT1aMbaM
	SiV2lCEmiNUq5w4i2X0QHb+2e8x3IPPJuLrm6a1ZrHMlYbGM5RUk14PuwaFJqz6T
	waNbqs50FLdA5uJ8m6dwrGU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=SojP0q4i4lIt15ctFaMLAOH+1PiRKAFkOuzE7WJn2ZQmNW
	JacNp+0SNArw4SR1Pxtr6kJva7McCDnWTBYK7cWnx65TZ6tCeFg1jTHOOy7SuAcG
	rtmr+Ny7ULmjuzXLIoiGvNFaKdCjw1Z+1ka5WA+dPg0VTcQKItKHOwxHQLGlI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E1D1226DE;
	Tue, 28 May 2013 20:07:47 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 57D0B226DB;
	Tue, 28 May 2013 20:07:46 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 437A6C66-C7D2-11E2-A2B3-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225686>

Zenaan Harkness <zen@freedbms.net> writes:

> I needed this quite a bit in the last few days, basic script but
> serves my need. I think it would be useful for other beginners if in
> $git/contrib/ source dir.
>
> Just a start to a basic script. Needs more tests etc, but it's enough
> to get newbies (like me) off to a reasonable start. Handles multiple
> input dirs.
>
> PLEASE CC me, as I am not subscribed.
>
> (some SMTP server rejected attachment, so pasting below instead)
>
> Thanks,
> Zenaan
>
>
> #!/bin/bash

I do not think you need (nor used) any bash-ism in this script.
Saying "#!/bin/sh" here is cleaner.

>
> # Change one or more normal repos into bare repos:
> # See also https://git.wiki.kernel.org/index.php/GitFaq#How_do_I_make_existing_non-bare_repository_bare.3F
>
> for i in "$@"; do

	for i
        do

You do not have to say 'in "$@"'; it is implied.

>    echo; echo "----------------------"
>    echo Processing $i

Forgot to dq?

>
>    repo="$i"
>    repo="`basename $i`"
>    tmp_repo="${repo}.git"
>    # Insert here: may be exit if any spaces in repo fqn
>    # Insert here: check for non-existent repo/.git dir
>    # Insert here: check that we are not inside the repo
>    # Insert here: add exit/do-nothing if fail to mv dirs etc
>
>    mv $repo/.git $tmp_repo

Forgot to dq?  i.e.

	mv "$repo/.git" "$tmp_repo"

The same for all the variable references in the remainder of the
script.

More importantly, "mv" would fail if $repo is given as a full
pathname elsewhere in the filesystem that is different from your
current directory where you create $tmp_repo.

>    git --git-dir=$tmp_repo config core.bare true
>    mv $repo ${repo}.bak
>    mv $tmp_repo $repo
> done
