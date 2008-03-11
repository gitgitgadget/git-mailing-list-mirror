From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v4 2/5] git-submodule summary: show commit summary
Date: Tue, 11 Mar 2008 17:37:40 +0800
Message-ID: <46dff0320803110237t6fcd6675t48949423e14f64a5@mail.gmail.com>
References: <1205171657-16216-1-git-send-email-pkufranky@gmail.com>
	 <1205171657-16216-2-git-send-email-pkufranky@gmail.com>
	 <7vod9ld8iu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 10:38:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ0w9-00077a-M8
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 10:38:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbYCKJhn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 05:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751690AbYCKJhn
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 05:37:43 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:48076 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbYCKJhl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 05:37:41 -0400
Received: by an-out-0708.google.com with SMTP id d31so563473and.103
        for <git@vger.kernel.org>; Tue, 11 Mar 2008 02:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=W7aQYMl5VIrlQ4cbrnsQMbzqhTjlIh8yZ6nO7+A18vQ=;
        b=pHseoHhmOi81qIVGEkRgaJARF82KdVQDAY280ymXp2qTAwM1ElJJiHh5yxi+YiP0CvcLbb6l+uC2c5LzSTYcchJvsqgX42LaKmL41BzrR5fFdNuikun+OwE3tzs1S+WSM4edndh/0m2HV83V+9qhKSheqkw7TmcZxPaVBVzicjw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y6W08nEDMFGExHU96pYcZ2LWSodPlkRhdUKfV8DBbFvIvQKaCK3dR0CTQhYrDXj8VuwmxxVd3KzIboI2yyQqJ6uGK8coqFvLUyiMPOuLIXI3J3IZP5N6r8oGLch0fkJpN4KQvtGh4fyeVwLNF2n+KmRtl2y4wzqKvAqphka3tOw=
Received: by 10.100.108.20 with SMTP id g20mr12978237anc.8.1205228261014;
        Tue, 11 Mar 2008 02:37:41 -0700 (PDT)
Received: by 10.100.5.18 with HTTP; Tue, 11 Mar 2008 02:37:40 -0700 (PDT)
In-Reply-To: <7vod9ld8iu.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76820>

On Tue, Mar 11, 2008 at 3:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ping Yin <pkufranky@gmail.com> writes:
>
>  > This patch does the hard work to show submodule commit summary.
>  > ...
>
>  I've spent considerable amount of time cleaning up your commit log
>  messages for the entire series from the last round when I queued them to
>  'pu', but you seem to have discarded all of them.  As I do not have time
>  to waste doing clean-ups only to have others to discard, and I do not have
>  infinite amount of time, I won't be replacing them with this series
>  tonight.
>

Sorry about this. This is my first big patch series and I have little
experience about submiting patches again and again. So i don't even
see your pu series except the documentation one you have mentioned in
the email (I thought other ones didn't change).

I'll resend my patches finally merging you commit log.

>
>  > Signed-off-by: Ping Yin <pkufranky@gmail.com>
>
>  And you did not describe anything about the improvements from the previous
>  round anywhere.  interdiff shows that this part is somewhat different:
>
>
>  > +             then
>  > +                     case "$mod_dst" in
>  > +                             160000)
>  > +                             sha1_dst=$(GIT_DIR="$name/.git" git rev-parse HEAD)
>  > +                             ;;
>  > +                             100644)
>  > +                             sha1_dst=$(git hash-object $name)
>  > +                             ;;
>  > +                     esac
>
>  Earlier, you were ignoring the one that is not checked out anymore, but
>  now you blindly assume "rev-parse HEAD" to give you a usable sha1_dst.
>  Why?

The path will not reach here for ignored submodules. Only user-cared
modules will get into the "$modules" variables (see "# Get modified
modules cared by user" part).
>
>  If a path that previously was a module is changed to a symlink, what
>  happens?
>



-- 
Ping Yin
