From: konglu@minatec.inpg.fr
Subject: Re: [PATCHv5 3/3] status: don't suggest "git rm" or "git add" if
 not appropriate
Date: Fri, 01 Jun 2012 16:08:08 +0200
Message-ID: <20120601160808.Horde.ij8nYXwdC4BPyMzILrtjxYA@webmail.minatec.grenoble-inp.fr>
References: <1338384216-18782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338477344-15940-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338477344-15940-3-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <CABURp0qS-bDYTTgz75mQOOZsXzM1TkF_CNjaRNcXa4MYXAg0kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Matthieu.Moy@grenoble-inp.fr,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Kong Lucien <Lucien.Kong@ensimag.imag.fr>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 01 16:08:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaSWW-00051E-HD
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 16:08:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759950Ab2FAOIM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Jun 2012 10:08:12 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:38816 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758182Ab2FAOIL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jun 2012 10:08:11 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id 9B0971A0301;
	Fri,  1 Jun 2012 16:08:08 +0200 (CEST)
Received: from wifi-030090.grenet.fr (wifi-030090.grenet.fr [130.190.30.90])
 by webmail.minatec.grenoble-inp.fr (Horde Framework) with HTTP; Fri, 01 Jun
 2012 16:08:08 +0200
In-Reply-To: <CABURp0qS-bDYTTgz75mQOOZsXzM1TkF_CNjaRNcXa4MYXAg0kA@mail.gmail.com>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198990>


Phil Hord <phil.hord@gmail.com> a =E9crit=A0:

>> +       } else if (!del_mod_conflict && !not_deleted) {
>> +               status_printf_ln(s, c, _("  (use \"git rm =20
>> <file>...\" to mark resolution)"));
>
> Why should I be bothered when both sides delete the same file?  Does
> this case only occur when each side has made different changes to the
> file prior to deleting it, or does it occur any time each commit has
> deleted the same exact file?

If both sides delete the same file with "git rm", this case does not oc=
cur
because there is no conflict when merging. However, it can occur when
both sides rename the file and then merge.

> As this patch highlights, the only expected resolution is to 'git rm'
> the file; why can't git figure this out for me and continue on?

I agree. The only option for the user is to run "git rm". You also have
to type the whole name of the deleted file as you can't tab for complet=
ion
and you can't avoid it as it's part of "unmerged path" (so you have to
resolve the current index). It would be great if git could figure it by
itself so we don't have to go through this process. Nevertheless, the
current display of the advice shows "git add" which can infer that you
can still recover the deleted file, which is not the case. At least, wi=
th
this code, the user will avoid this confusion.
