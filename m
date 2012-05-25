From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] config doc: remove confusion about relative GIT_DIR from
 FILES section
Date: Fri, 25 May 2012 13:12:04 -0500
Message-ID: <20120525181204.GA4491@burratino>
References: <20120525181526.Horde.VibLf3wdC4BPv7AeKacSMiA@webmail.minatec.grenoble-inp.fr>
 <CAE1pOi0eY2=eNzuTUVGmHuvfGWvxoXSJUADWr0CfPpVe5ktxow@mail.gmail.com>
 <20120525174237.GA4267@burratino>
 <CAE1pOi3qSEY=Dj-Fqj+=anULVmCdsm72_k+B0SpdGiCO3u7L9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: nguyenhu@minatec.inpg.fr, git@vger.kernel.org,
	matthieu.moy@grenoble-inp.fr,
	Valentin DUPERRAY <Valentin.Duperray@phelma.grenoble-inp.fr>,
	Franck JONAS <Franck.Jonas@phelma.grenoble-inp.fr>,
	Lucien KONG <Lucien.Kong@phelma.grenoble-inp.fr>,
	Thomas NGUY <Thomas.Nguy@phelma.grenoble-inp.fr>,
	Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@phelma.grenoble-inp.fr>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 25 20:12:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXyzq-0007mM-MW
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 20:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758148Ab2EYSMN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 May 2012 14:12:13 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50726 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757950Ab2EYSMM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 May 2012 14:12:12 -0400
Received: by yhmm54 with SMTP id m54so802711yhm.19
        for <git@vger.kernel.org>; Fri, 25 May 2012 11:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=juV0zqdJZl4G/C5KxJr6idW8iVeJJkTAKGBzheqmv1s=;
        b=YDydR7zdgI1Y19+Du2sV/O1CUxcrhfOeV+synsRozbesNhvHycB1mTz28/wBkWMv/r
         KSb9nR5KgTWU+XJSFbboPPQa3W/ApNLCeLE0UcugwemHTrhiVn7FwJ9FTwwR4eClGAXS
         FjdXVyNUjSdrpV397jC/BM9BLUgkmM+JtRAuz+MRTRdZI1Cg68zECFJc/zv9oDxWHJ2S
         Ef32m9bkBA53pMEOodnjhP2gWPFfTj4BfK2XxuJh3m8Xh1Dww1s8sushMI3Eo5ASVQDT
         APypLuAgWmO4gaGGqfohSAzQbWB4q/VEjKfrjGxYrsKdGwa56a4k9Y9xQgqtrIXCJ54r
         X0ow==
Received: by 10.50.203.98 with SMTP id kp2mr3787579igc.42.1337969531916;
        Fri, 25 May 2012 11:12:11 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id dk9sm18470770igb.13.2012.05.25.11.12.10
        (version=SSLv3 cipher=OTHER);
        Fri, 25 May 2012 11:12:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAE1pOi3qSEY=Dj-Fqj+=anULVmCdsm72_k+B0SpdGiCO3u7L9A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198500>

=46rom the FILES section of the git-config(1) manual:

	$GIT_DIR/config::
		Repository specific configuration file. (The filename is
		of course relative to the repository root, not the working
		directory.)

That's confusing because $GIT_DIR really is relative to the working
directory.

	$ GIT_DIR=3D.git GIT_EDITOR=3D'pwd; echo editing'
	$ export GIT_DIR GIT_EDITOR
	$ git config --edit --local
	/home/jrn/src/git/Documentation
	editing .git/config

It turns out that the comment is a remnant from older days when the
heading said ".git/config" (which is indeed relative to the top of the
worktree).

It was only when the heading was changed to refer more precisely to
<git dir>/config (see v1.5.3.2~18, AsciiDoc tweak to avoid leading
dot, 2007-09-14) that the parenthesis stopped making sense.  Remove
it.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hilco Wijbenga wrote:
> On 25 May 2012 10:42, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> Regarding $GIT_DIR/config, it says "The filename is of course relati=
ve
>> to the repository root, not the working directory.". =C2=A0Is this o=
ut of
>> date? =C2=A0(Cc-ing Peff and Duy.)
>
> I'm sure it's not.

You're right --- the current wording never made sense and is not an
example of accurate documentation going stale with later behavior
changes as I had suspected.  Sorry for the noise.

Thanks,
Jonathan

 Documentation/git-config.txt |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.tx=
t
index 3f5d216a..d9463cb3 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -198,9 +198,7 @@ If not set explicitly with '--file', there are thre=
e files where
 'git config' will search for configuration options:
=20
 $GIT_DIR/config::
-	Repository specific configuration file. (The filename is
-	of course relative to the repository root, not the working
-	directory.)
+	Repository specific configuration file.
=20
 ~/.gitconfig::
 	User-specific configuration file. Also called "global"
--=20
1.7.10
