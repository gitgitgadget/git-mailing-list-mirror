From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] parseopt: do not translate empty help string
Date: Tue, 21 Aug 2012 01:03:44 +0200
Message-ID: <87harxjhdb.fsf@thomas.inf.ethz.ch>
References: <bcb1f4437760452f967737fddf26dff019d0f0b2.1345487066.git.trast@student.ethz.ch>
	<7vboi5jrn1.fsf@alter.siamese.dyndns.org>
	<87obm5jpdy.fsf@thomas.inf.ethz.ch>
	<7vzk5pi5jn.fsf@alter.siamese.dyndns.org>
	<7vvcgdi5d4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 01:04:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3b0j-00074Q-Oy
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 01:03:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756677Ab2HTXDt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 19:03:49 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:20424 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752167Ab2HTXDr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 19:03:47 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 21 Aug
 2012 01:03:43 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (46.126.8.85) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 21 Aug
 2012 01:03:44 +0200
In-Reply-To: <7vvcgdi5d4.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 20 Aug 2012 15:08:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203908>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>> Oh, I forgot that we actually had a wrapper instead of the usual _.
>>> Yes, I think that would be the better solution to guard against this.
>>
>> OK, then let's replace the patch text of your commit ;-).
>
> He, we need to update the log message a bit, too.

Thanks!  But now it's your patch :-)

> -- >8 --
> From: Thomas Rast <trast@student.ethz.ch>
> Subject: [PATCH] gettext: do not translate empty string
>
> The gettext .po files have a header, but it looks like the translation
> specification for an empty string.  This results in _("") actually
> returning that header.
>
> Prevent us from passing empty strings to gettext.  In some places,
          ^^

ourselves?  I'm not a native speaker though.

> we run _(opts->help) where opts->help may be an empty string.
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  gettext.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/gettext.h b/gettext.h
> index 57ba8bb..376297b 100644
> --- a/gettext.h
> +++ b/gettext.h
> @@ -44,6 +44,8 @@ extern int use_gettext_poison(void);
>  
>  static inline FORMAT_PRESERVING(1) const char *_(const char *msgid)
>  {
> +	if (!*msgid)
> +		return "";
>  	return use_gettext_poison() ? "# GETTEXT POISON #" : gettext(msgid);
>  }

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
