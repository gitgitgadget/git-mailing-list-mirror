From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Tue, 23 Mar 2010 20:23:36 +0800
Message-ID: <41f08ee11003230523h2c5f93b1l7e94d6c85a93a706@mail.gmail.com>
References: <81b0412b1003201335g7b37c51mfa3e2280210ebb7e@mail.gmail.com>
	 <m38w9jjqqd.fsf@localhost.localdomain>
	 <41f08ee11003230338y5cf70a13xa649e67071bc2a72@mail.gmail.com>
	 <201003231222.40745.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, gitzilla@gmail.com,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 23 13:23:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nu39C-0004La-Ec
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 13:23:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449Ab0CWMXm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Mar 2010 08:23:42 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:57044 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946Ab0CWMXh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Mar 2010 08:23:37 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1516944qwh.37
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 05:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5nHOetpgivcS2r/p3/XtSMsgg3SF9Eqb2lhC4i765xw=;
        b=bbR4obTAIQZyLCREQK9IPZu9wHNqLnWXv//WJLz06KOyc07TOJWypx5bXWGvo+iW/L
         tEITu160U34lGrILXsnGFls7g05Ftge58tGeucv+/gtYN3lkVgSLYJpUmhwyUo32nV/r
         BE5Lp7Ml9NwP6bry+zefJPxwIkRfEBq8KW+9A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=o7hbuzE+lywpwVvgYoCbHcg6oHp8ulVOJSK+9nxMcWsNLs7uTdJrnM7Y4MeXykXIAU
         epF5cVhbnI53XcncIiyui6UHw/q7PJe2R5CJkpdCyKPUe3XJEhfy3jyrIedfIaPfwF8h
         xRHXk40AWaXlSwseUPqpUBul+h1trzU8DykRY=
Received: by 10.229.131.39 with SMTP id v39mr733129qcs.66.1269347016631; Tue, 
	23 Mar 2010 05:23:36 -0700 (PDT)
In-Reply-To: <201003231222.40745.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143010>

Hi,

On Tue, Mar 23, 2010 at 7:22 PM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
>
> This would work with the simplest case, but not in more complicated
> cases, like for example preimage and postimage with different size.
>
> Take for example the following chunk (fragment):
>
> diff --git a/run-command.c b/run-command.c
> index 2feb493..3206d61 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -67,19 +67,21 @@ static int child_notifier =3D -1;
>
> =A0static void notify_parent(void)
> =A0{
> - =A0 =A0 =A0 write(child_notifier, "", 1);
> + =A0 =A0 =A0 ssize_t unused;
> + =A0 =A0 =A0 unused =3D write(child_notifier, "", 1);
> =A0}
>
> =A0static NORETURN void die_child(const char *err, va_list params)
>
> If you follow ssize_t line, it is created. =A0If you follow line with
> write, which is 2nd line in postimage, its previous version is 1st
> line in preimage.
>
>
> Another example would be reordering of lines, or reordering with
> some change.

Ah, yes, you are right.

And now, I really get the difference between the understanding about
line level browser of us. :) When users want to browsing the history
of some line or line range, you want to display only the related lines
to them, but I want to display the minim diff hunk to them. :)
And I think displaying the minimum diff hunk is sensible and feasible.
Could you please tell me how do you think about this?

Regards!
Bo
