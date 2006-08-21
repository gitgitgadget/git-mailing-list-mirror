From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Helper function to shell quote all arg values at once.
Date: Mon, 21 Aug 2006 07:15:28 +0200
Message-ID: <200608210715.28585.chriscool@tuxfamily.org>
References: <20060820080749.e31276dd.chriscool@tuxfamily.org> <7vsljrxbg8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 21 07:10:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GF23J-0007RQ-Kg
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 07:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbWHUFKN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 21 Aug 2006 01:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965057AbWHUFKN
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 01:10:13 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:54209 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S964987AbWHUFKM convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Aug 2006 01:10:12 -0400
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 8199A9643;
	Mon, 21 Aug 2006 07:10:10 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <7vsljrxbg8.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25780>

Le lundi 21 ao=FBt 2006 00:57, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
>=20
> > The new sq_quote_argv function is used to refactor the
> > tracing code in "git.c" and "exec_cmd.c".
> > This function allocates memory and fills it with a string
> > containing the quoted argument values. Then it returns a
> > pointer to this memory that must be freed afterwards.
>=20
> Sorry, I do not see a point in this.
>=20
> If your original were doing malloc-print-free per iteration,
> then perhaps it makes sense to first format all into one
> allocated buffer, print all, and then free at once, like this
> patch does.  But that was not what the original had.

I thought that malloc-print-free was Ok, since there is already sq_quot=
e
in quote.c that does it and is used in connect.c (except perhaps that t=
he result from sq_quote is not freed).

> If the new function were to get a (const char **) array and
> FILE *, and print them, quoted and separated with spaces, then
> it would have shortened what two call sites did, which would
> have been an improvement.  But that is not what this patch does,
> either.

The patch still shortens the 3 calls site in git.c (-8 lines) and exec_=
cmd.c (-5 lines).
But anyway I will rewrite it so that the new function takes (FILE*, con=
st char **, int count) as argument.

Or perhaps I need only make this new function call sq_quote_argv ? So I=
 only need to send another patch on top of this one ?

Thanks,
Christian.
