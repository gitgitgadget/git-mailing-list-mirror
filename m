From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [Janitors] value could be NULL in config parser
Date: Sat, 9 Feb 2008 06:41:19 +0100
Message-ID: <200802090641.20171.chriscool@tuxfamily.org>
References: <7v63x0lzhw.fsf@gitster.siamese.dyndns.org> <5d46db230802081720x122a807do6c63b6b3e435b4c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Govind Salinas" <govind@sophiasuchtig.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 06:35:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNiNa-00043Q-2X
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 06:35:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbYBIFfY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Feb 2008 00:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbYBIFfY
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 00:35:24 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:50371 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751002AbYBIFfX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Feb 2008 00:35:23 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id CECF61AB2B3;
	Sat,  9 Feb 2008 06:35:19 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 924021AB2AE;
	Sat,  9 Feb 2008 06:35:19 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <5d46db230802081720x122a807do6c63b6b3e435b4c5@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73193>

Le samedi 9 f=E9vrier 2008, Govind Salinas a =E9crit :
> On 2/8/08, Junio C Hamano <gitster@pobox.com> wrote:
> > If you want to fix them (you do not have to do all of them, and
> > if you would like to help, please make one patch per function
> > fixed), the procedure is:
>
> I think I got all the erroneous ones.  I did
>
> find . -name "*.c" | xargs grep git_config\( | awk '{ idx =3D index($=
2,
> ")"); p =3D substr($2, 12, idx - 12); print  p }' | sort | uniq -u
>
> To try and get a list of all the ones that might need updating.=20

Thanks.

> I did=20
> notice that most functions never check value for null, but they don't
> directly access them.  They pass them off to other methods.  As far a=
s
> I can tell, some of these methods don't validate the NULL.  So they
> will need to be updated.
>
> Question.  Wouldn't it reduce the amount of validation we have to do
> if whoever is calling back checked null and assigned an empty string?
> If so, we can probably replace all these patches with one patch.

This was discussed in this thread:

http://thread.gmane.org/gmane.comp.version-control.git/72107/

In short we can't do that now, but it may be possible latter, if we fir=
st=20
deprecate using an empty string as boolean value "false" (while a NULL =
is=20
boolean value "true").

Christian.
