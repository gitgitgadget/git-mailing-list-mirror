From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: master has some toys
Date: Thu, 17 Nov 2005 12:20:32 +0100
Message-ID: <81b0412b0511170320v5ad72ee2pb86bd22f247fd2e0@mail.gmail.com>
References: <20051115144223.GA18111@diana.vm.bytemark.co.uk>
	 <b0943d9e0511160311k725526d8v@mail.gmail.com>
	 <7vr79g8mys.fsf@assigned-by-dhcp.cox.net>
	 <7v7jb83w8m.fsf_-_@assigned-by-dhcp.cox.net>
	 <81b0412b0511170029xac34cdbtddf74eb766281b3c@mail.gmail.com>
	 <Pine.LNX.4.63.0511171207580.20898@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_2738_5744167.1132226432218"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 12:21:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Echoj-0008Jf-0D
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 12:20:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbVKQLUe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 06:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbVKQLUd
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 06:20:33 -0500
Received: from nproxy.gmail.com ([64.233.182.204]:42388 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750757AbVKQLUd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Nov 2005 06:20:33 -0500
Received: by nproxy.gmail.com with SMTP id k26so391835nfc
        for <git@vger.kernel.org>; Thu, 17 Nov 2005 03:20:32 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=cNOtEbnFL4DAMph2pbVNFqEX5EzmIjUpN0JCrx79bOcJ9X4RwxvRZ/IY+Yv3Whe4vByegF345VYxKXZ3B+GfjabO/yvOi1j5S0o3YdhmNyp/WkVjMv6x596tAHuO5W/1DBy8hUZzVMoLDg2yTewPw7PQLCyFdmM7CQ//JhRudtM=
Received: by 10.48.199.17 with SMTP id w17mr390294nff;
        Thu, 17 Nov 2005 03:20:32 -0800 (PST)
Received: by 10.48.247.3 with HTTP; Thu, 17 Nov 2005 03:20:32 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0511171207580.20898@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12102>

------=_Part_2738_5744167.1132226432218
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 11/17/05, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > Along with the git wrapper fixes and git-apply bugfix (it did
> >
> > cygwin is completely broken. Still debugging, but it looks like the
> > old "windows can't unlink/rename open files" problem.
>
> FWIW I had no problems on cygwin (NO_MMAP=3DYesPlease).
>

yes, that's what I had, too. Junio, how about the attached patch?

------=_Part_2738_5744167.1132226432218
Content-Type: application/xxxxx; name=cygwin-has-no-mmap.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="cygwin-has-no-mmap.patch"

diff --git a/Makefile b/Makefile
index ebff990..2b1e036 100644
--- a/Makefile
+++ b/Makefile
@@ -209,6 +209,7 @@ ifeq ($(uname_O),Cygwin)
 	NO_STRCASESTR = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	NO_IPV6 = YesPlease
+	NO_MMAP = YesPlease
 	X = .exe
 	ALL_CFLAGS += -DUSE_SYMLINK_HEAD=0
 endif

------=_Part_2738_5744167.1132226432218--
