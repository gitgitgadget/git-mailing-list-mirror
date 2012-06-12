From: konglu@minatec.inpg.fr
Subject: Re: [PATCHv10 4/4] status: better advices when splitting a commit
 (during rebase -i)
Date: Tue, 12 Jun 2012 09:14:12 +0200
Message-ID: <20120612091412.Horde.lcugXXwdC4BP1uxEDLrRNgA@webmail.minatec.grenoble-inp.fr>
References: <1339075029-27109-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1339327058-29371-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1339327058-29371-4-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <7vsje161lx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lucien Kong <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 09:14:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeLIx-0004UO-9o
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 09:14:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354Ab2FLHOP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jun 2012 03:14:15 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:33277 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751125Ab2FLHOO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jun 2012 03:14:14 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id 4C2551A0241;
	Tue, 12 Jun 2012 09:14:12 +0200 (CEST)
Received: from wifi-028181.grenet.fr (wifi-028181.grenet.fr
 [130.190.28.181]) by webmail.minatec.grenoble-inp.fr (Horde Framework) with
 HTTP; Tue, 12 Jun 2012 09:14:12 +0200
In-Reply-To: <7vsje161lx.fsf@alter.siamese.dyndns.org>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199766>


Junio C Hamano <gitster@pobox.com> a =E9crit=A0:

>> +static int split_commit_in_progress(struct wt_status *s)
>> +{
>> +	int split_in_progress =3D 0;
>> +	char *head =3D read_line_from_git_path("HEAD");
>> +	char *orig_head =3D read_line_from_git_path("ORIG_HEAD");
>> +	char *rebase_amend =3D read_line_from_git_path("rebase-merge/amend=
");
>> +	char *rebase_orig_head =3D =20
>> read_line_from_git_path("rebase-merge/orig-head");
>> +
>> +	if (!head || !orig_head || !rebase_amend || !rebase_orig_head || =20
>> !prefixcmp(head, "ref: "))
>> +		return split_in_progress;
>
> I think the above
>
> 	!prefixcmp(head, "ref: ")
>
> is probably a mistake; shouldn't it be
>
> 	strcmp(s->branch, "HEAD")
>
> which is used in wt_status_print() to diagnose that you are on a
> detached HEAD (which is the normal case)?  Otherwise head may point
> at the commit object name read from "refs/heads/current" through a
> symbolic link .git/HEAD that points at "refs/heads/current".

Aah, that's the variable I was looking for.
Thanks for fixing it up :).

Lucien Kong
