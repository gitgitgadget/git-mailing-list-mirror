From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-web--browse: recognize iTerm as a GUI terminal on OS
 X
Date: Mon, 25 Mar 2013 14:44:17 -0700
Message-ID: <7vtxnzw3wu.fsf@alter.siamese.dyndns.org>
References: <CAMxBVSs6dJFnK78E2Da7t4V9ndJFRVDZEd1fR5QuCFz=u2Bnpw@mail.gmail.com>
 <CAMxBVStw-b3J_Fm9x=h3==9ebdLUkpjBSQ9-W4+zJ9N20ojfxg@mail.gmail.com>
 <CAP8UFD2oR5tnYuw7Nbe-CzGx7fw-OpAFW+reN+1Nroh1jXjfsQ@mail.gmail.com>
 <CAMxBVStVXZGGrjHzN7kukVP6_ZGo0miyJaE2FVYPVV4Jb5U82w@mail.gmail.com>
 <CAEBDL5VNodcTGBOvQjyL30qiXhshxhnUH-Vd9xy9=RxZQgH-Yw@mail.gmail.com>
 <CAP8UFD2m8n5RHN-CgyDP1ir_AorpJGnWwNhXuRxDa=DbHfsdiw@mail.gmail.com>
 <20130325101318.GA31409@yoda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <christian.couder@gmail.com>,
	Timo Sand <timo.j.sand@gmail.com>, git <git@vger.kernel.org>
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Mon Mar 25 22:44:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKFCD-0005GG-A7
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 22:44:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758954Ab3CYVoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 17:44:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46920 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758928Ab3CYVoU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 17:44:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BECD7AB5A;
	Mon, 25 Mar 2013 17:44:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LMvTSHBK/E9nmosy/dPdWq2rUV0=; b=Q6v6O9
	rwt/GkCakQXvvNhNbvp/QTFF5Q58FAdUZkxoVxzNMwa7+QhCexufaSooqebFIYE4
	AXDp1W2rEnh2meWwkaHeKh+4r8RxULnlAMfRwCo8neZV9ibOF6Na09pUCIep24PM
	oElokS9MPYsMAutCwgNRZQMhl5RHxXM1sGNPY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wZe5vuWpzYHlWUARMw7wsAyNWxc/E+YV
	0w7b55MeSahdwnsrWuLw6Sera3LKNBGAPvXm1FVjxoEvjDFx7tbO12V2iqKmtLTx
	C+I4uf3strPbK7JVDcYxYpo7u/z5mar65xgYVv3VXu5pXT3JH+j0/fsuofXNHOHA
	mtbp5xLTGBs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B2FF6AB58;
	Mon, 25 Mar 2013 17:44:19 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 11404AB55; Mon, 25 Mar 2013
 17:44:18 -0400 (EDT)
In-Reply-To: <20130325101318.GA31409@yoda.local> (John Szakmeister's message
 of "Mon, 25 Mar 2013 06:13:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 25C3D456-9595-11E2-9E81-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219099>

John Szakmeister <john@szakmeister.net> writes:

> It turns out that the presence of SECURITYSESSIONID is not sufficient
> for detecting the presence of a GUI under Mac OS X.  SECURITYSESSIONID
> appears to only be set when the user has Screen Sharing enabled.
> Disabling Screen Sharing and relaunching the shell showed that the
> variable was missing, at least under Mac OS X 10.6.8.  As a result,
> let's check for iTerm directly via TERM_PROGRAM.
>
> Signed-off-by: John Szakmeister <john@szakmeister.net>
> ---
>
> On Sun, Mar 24, 2013 at 10:05:53PM +0100, Christian Couder wrote:
> [snip]
>> Your patch looks good to me, and I cannot really test it as I don't have a Mac.
>> Could you just had some of the explanations you gave above to the
>> commit message?
>
> Here's an updated patch.  I also noticed that git-bisect.sh is
> also trying to determine if a GUI is present by looking for
> SECURITYSESSIONID as well.  I wonder if it would be better to
> create a shell function in git-sh-setup.sh that the two scripts
> could use?

Yes, but that can come later once this settles.

Your patch makes me wonder if

	test -n "$TERM_PROGRAM"

without any SECURITYSESSIONID or explicit program name checks should
suffice, though.

>
> -John
>
> git-web--browse.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/git-web--browse.sh b/git-web--browse.sh
> index 1e82726..1ff5379 100755
> --- a/git-web--browse.sh
> +++ b/git-web--browse.sh
> @@ -120,6 +120,7 @@ if test -z "$browser" ; then
>  	fi
>  	# SECURITYSESSIONID indicates an OS X GUI login session
>  	if test -n "$SECURITYSESSIONID" \
> +		-o "$TERM_PROGRAM" = "iTerm.app" \
>  		-o "$TERM_PROGRAM" = "Apple_Terminal" ; then
>  		browser_candidates="open $browser_candidates"
>  	fi
