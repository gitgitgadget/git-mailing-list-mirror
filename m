From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] diff.c: guard config parser from value=NULL
Date: Mon, 11 Feb 2008 05:55:19 +0100
Message-ID: <200802110555.19383.chriscool@tuxfamily.org>
References: <20080210193534.d11d8b15.chriscool@tuxfamily.org> <20080210190145.GB5129@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio Hamano <junkio@cox.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Govind Salinas <blix@sophiasuchtig.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Feb 11 05:50:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOQcS-00014p-NO
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 05:50:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753007AbYBKEt0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Feb 2008 23:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753005AbYBKEt0
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 23:49:26 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:36683 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752917AbYBKEtZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Feb 2008 23:49:25 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 1ABB61AB2B4;
	Mon, 11 Feb 2008 05:49:22 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id BFF4B1AB2B3;
	Mon, 11 Feb 2008 05:49:21 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <20080210190145.GB5129@artemis.madism.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73466>

Le dimanche 10 f=E9vrier 2008, Pierre Habouzit a =E9crit :
> On Sun, Feb 10, 2008 at 06:35:34PM +0000, Christian Couder wrote:
> > +static int xstrdup_confval(const char *dest, const char *var, cons=
t
> > char *value)
>
>   Why not calling that "git_config_string" in config.[hc] and be
> API-consistent ?

In this function, there is:

if (!value || !*value)
	return error("%s: lacks value", var);

but in some places an empty string is not an error, and in some other p=
laces=20
we "die" in case of error instead of using "return error..."
So I am not sure this function can be generally usefull as it is now.

Maybe I should add a flag parameter to control if we should "die" or "r=
eturn=20
error" and if we should accept an empty string or not.

What do you think ?

Christian.
