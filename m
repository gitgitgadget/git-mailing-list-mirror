From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH/RFC v2 1/4] Add "core.eolStyle" variable to control 
	end-of-line conversion
Date: Sun, 9 May 2010 13:02:34 -0400
Message-ID: <u2p76718491005091002v516429ddrf118c35f3312c3ab@mail.gmail.com>
References: <cover.1273352819.git.eyvind.bernhardsen@gmail.com>
	 <c8ef28b72709013f17e093954a0f4e2ad1fb9652.1273352819.git.eyvind.bernhardsen@gmail.com>
	 <alpine.LFD.2.00.1005081455450.3711@i5.linux-foundation.org>
	 <E2A9C4D2-010F-44B2-BF6A-627DE8B72FB5@gmail.com>
	 <BFFD3CAC-E7D9-49D8-9B67-C3F5157646F3@gmail.com>
	 <20100509070043.GB14069@dpotapov.dyndns.org>
	 <CD080D38-811C-4BBF-A5CB-6B613555FE72@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	mat <matthieu.stigler@gmail.com>,
	hasen j <hasan.aljudy@gmail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Robert Buck <buck.robert.j@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 09 19:08:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OB9zf-0001Og-9T
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 19:08:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754065Ab0EIRCf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 May 2010 13:02:35 -0400
Received: from mail-yw0-f198.google.com ([209.85.211.198]:58352 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754384Ab0EIRCf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 May 2010 13:02:35 -0400
Received: by ywh36 with SMTP id 36so1522716ywh.4
        for <git@vger.kernel.org>; Sun, 09 May 2010 10:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=gj8PGcutmeh4rdGAwcsnQmIxtZJHx6rnSeil8VshJCY=;
        b=hONf40SEBV1riodUCtgr2rGXVUJmLCVRCJc0iFZLoN2AlNANxJcWlkLMW7dyjFqlY5
         M7jziTSegoqL7wRVBp6srsyoP2qUDc04G7t8lNiMDCw3NsYSfyGwpfs10bDs8DUgbHXa
         7lCEpMrUechGTHqmdxfGy56xflO8vNi+jHa/s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=VMmq9DOYHqWkx6EwmLXwdROvYe58BdZQeIwaaxUwRDYErAFpVSCxoL9KpbtgmgjAb/
         Ls2v4ktqn7nfCriKKw46pcWuPY+xjDlqfpACVVN0QoJQHLsKhP/h4pGJsQGRAf83FRjq
         36YhA81gK2I6B5jWOARaaz0iI4VyEDHEP6iDI=
Received: by 10.231.145.146 with SMTP id d18mr1874829ibv.16.1273424554171; 
	Sun, 09 May 2010 10:02:34 -0700 (PDT)
Received: by 10.231.34.8 with HTTP; Sun, 9 May 2010 10:02:34 -0700 (PDT)
In-Reply-To: <CD080D38-811C-4BBF-A5CB-6B613555FE72@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146728>

On Sun, May 9, 2010 at 6:42 AM, Eyvind Bernhardsen
<eyvind.bernhardsen@gmail.com> wrote:
> I guess I should nail my flag to the mast: Here's what I would have done, with the benefit of plenty of hindsight, had we not had core.autocrlf, and also what I think we should do to approach that ideal.
>
> Please don't get hung up too much on the names, they were chosen to not match anything suggested so far so that I can refer back to them unambiguously.
>
> My user interface would have been:
>
> - an attribute "eolconv" that enables or disables line ending conversion
> - a config variable "core.eolconv" that sets "eolconv" for all files where it is unset
> - a config variable "core.localeol" that decides whether LF or CRLF is preferred
>
> This provides the means to enable normalization on a per-project ("eolconv") or per-repository ("core.eolconv") basis, and allows the user to override the platform native line ending when normalization is in effect.
>
> [...]
>
> My current thinking on how to change my series now runs along these lines:
>
> - keep the current "crlf=auto" change
> - rename "core.eolStyle" to "core.localcrlf"
> - add a "core.crlf" that sets the "crlf" attribute on paths where it isn't explicitly configured
> - keep "core.autocrlf" for backwards compatibility, but make "core.autocrlf=input" and "core.autocrlf=true" complain if they are in conflict with the other config settings.

Bah. I think relegating the old names to "deprecated, for
compatibility" is absolutely the right thing to do. Is there a use
case where the existing crlf setup is preferable? If not, why not just
mark them as deprecated in the documentation and say "see ..."
pointing to the new functionality and use the new names as you
suggest.

$0.02. :-)

j.
