From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [1.8.0] forbid full fetchspecs in git-pull
Date: Tue, 1 Feb 2011 02:15:39 +0300
Message-ID: <AANLkTikxcd+gzeuJsQX1V5Wses8xWMnshdrOnYTvXgTq@mail.gmail.com>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
	<7vwrll57ha.fsf@alter.siamese.dyndns.org>
	<201101312255.59841.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sean Estabrooks <seanlkml@sympatico.ca>,
	=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Feb 01 00:15:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk2yH-00018P-Vp
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 00:15:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754249Ab1AaXPl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Jan 2011 18:15:41 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:55504 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824Ab1AaXPk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jan 2011 18:15:40 -0500
Received: by qwa26 with SMTP id 26so6050838qwa.19
        for <git@vger.kernel.org>; Mon, 31 Jan 2011 15:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Ldlj6CekhY8miV43Ig3RmOmx4BdZymo79b5kI4/C2Uo=;
        b=I9eEmdMlsZwgqP4JiYjas2jByUnJfYVilGXdwP+4l/2nJJXog8f4CaycRMAlyxIqcz
         ceyfqkzs52UBuSbi4EsvXFEj2hfw3buxQNrJMnv4NdPwXDiJE+BLe6SR4No+TnB9R2Km
         EFeViaDJRzslShMvgJWrtgWEqD2JfwnC+uens=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nVZmr5jpRbzGoUOfMTildIC7uyXueYmiLbKuBeuDqlvA5x7tsoY61istweUk0lpQ7A
         SGuQG2YyDYnQqdYU8FqDFwxeeXWZnnnJn1rUsNrng0nG7nUzklWpww+RaSEBMNCQ92k7
         MsSb6RVHrGdBQlV+YKY5T9+ke0y/y8l06dSSk=
Received: by 10.229.192.15 with SMTP id do15mr6306608qcb.155.1296515739528;
 Mon, 31 Jan 2011 15:15:39 -0800 (PST)
Received: by 10.229.213.4 with HTTP; Mon, 31 Jan 2011 15:15:39 -0800 (PST)
In-Reply-To: <201101312255.59841.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165774>

On Mon, Jan 31, 2011 at 10:55:59PM +0100, Thomas Rast wrote:
> Proposal:
>
> git-pull inherits the full fetchspec invocation syntax from git-fetch=
,
> so that you can do e.g.
>
> =A0git pull origin master:master
>
> usually shooting yourself in the foot in the process. =A0See e.g.
>
> =A0http://thread.gmane.org/gmane.comp.version-control.git/130819/focu=
s=3D130879 [item 1]
>
> Prohibit this invocation, i.e., disallow any second argument to
> git-pull that contains ':'.

Hmm... I have always thought about "git pull repo refspec" as
"git fetch repo refspec && git merge FETCH_HEAD"
and "git fetch" refuses to fetch into the current branch of a non-bare
repository, so I expected "git merge" to fail in this case too, but it
succeeded though with some warning that fetch updated the current
branch head. I think it is inconsistent and should be fixed, and that
will fix the mentioned confusion as well.

As to disallowing ':' in refspec completely, I am not so sure... Not
that I think it is very useful, but also I don't see how it can hurt
someone provided that the target branch cannot be the current branch.


Dmitry
