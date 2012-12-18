From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: track TCLTK_PATH as it used to be tracked
Date: Tue, 18 Dec 2012 09:07:05 -0800
Message-ID: <7vk3sfguh2.fsf@alter.siamese.dyndns.org>
References: <20121218145753.28253.98431.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Dec 18 18:07:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tl0dh-00012g-O0
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 18:07:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221Ab2LRRHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 12:07:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42351 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932119Ab2LRRHM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 12:07:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07B52A361;
	Tue, 18 Dec 2012 12:07:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wBebq/OcLksZK0mVS95pdOLYW/0=; b=E7mMzo
	FzA1/O5ufRtxfBQjPbyKYeVQaMiQot0VI9FcM0/2V5I69EO/EvWd34kDQcrq0vzy
	NigTIh46okTn2gI8cOzlZRDwTXV8uLWXKhUfHogIcMtOdwafWXXqdiiYO2nOXTia
	XQFIDR+pZEZw5OGuzJwq/8oUh8Wt3uoxGavV4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D7XDM4o8pQQ1bd+pQBf0OswDAGrGkDUO
	jB9XydB+ZZGA58RT2d/NdPTNmsvLSXj+6w07vrxTSnSEepMFcxGqDdIW299wUavN
	9MuxXtq8x++apcRsHyEpIERbOnwfNRNGuW5uDhlydD25bDG8liOSibSPNcQRLsuL
	L4pxApcUdvk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E7F76A360;
	Tue, 18 Dec 2012 12:07:11 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B47C6A35F; Tue, 18 Dec 2012
 12:07:06 -0500 (EST)
In-Reply-To: <20121218145753.28253.98431.chriscool@tuxfamily.org> (Christian
 Couder's message of "Tue, 18 Dec 2012 15:57:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5A0DA46E-4935-11E2-8DF1-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211763>

Christian Couder <chriscool@tuxfamily.org> writes:

> A long time ago, gitk used to live at the root of the git.git
> repository. In 62ba514 (Move gitk to its own subdirectory,
> 2007-11-17) it was moved to a subdirectory, but some code used
> to track TCLTK_PATH was left in the main Makefile instead
> of being moved to the new Makefile that was created in gitk-git/.
>
> The code left in the main Makefile in git.git should now have
> been removed because it was found useless.
>
> And this patch puts some code back to track TCLTK_PATH properly
> where it should be.

It is more like "should have been moved to gitk's Makefile back
then, but didn't.  Make it so.".

>
> Note that there is already some code to do that in git-gui.
>
> At the same time this patch creates a .gitignore and also marks
> some targets in the Makefile as PHONY.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> Hi Paul,
>
> In this thread:
>
> http://thread.gmane.org/gmane.comp.version-control.git/211641
>
> Junio asked me to send you this patch.
> So here it is, for you to apply to your tree.

Paul, just to clarify, I didn't review the contents of the patch; I
merely redirected the patch in the right direction, so this still
needs to be vetted by you ;-)

> ...
> +GIT-TCLTK-VARS: FORCE
> +	@VARS='$(TRACK_TCLTK)'; \
> +		if test x"$$VARS" != x"`cat $@ 2>/dev/null`" ; then \
> +			echo 1>&2 "    * new Tcl/Tk interpreter location"; \

I think in a related patch to the top-level Makefile changes it to
lose "1" to read it as "echo >&2" here.
