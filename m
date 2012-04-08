From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 11/12] test: add tests for aliases in bash completion
Date: Sun, 8 Apr 2012 06:20:38 +0300
Message-ID: <CAMP44s2h==jd4fNFSSJXC2xTkHDozRSrH_2CHDzSB5=Jfu9uWA@mail.gmail.com>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
	<1333854479-23260-12-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 08 05:21:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGign-000419-IB
	for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 05:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755000Ab2DHDUk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Apr 2012 23:20:40 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44470 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754632Ab2DHDUk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Apr 2012 23:20:40 -0400
Received: by eaaq12 with SMTP id q12so893890eaa.19
        for <git@vger.kernel.org>; Sat, 07 Apr 2012 20:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=EB3KqNQOzK4HbOKeBdU/CoNTLJQePJ4kOgYxnQUpUs4=;
        b=wOiYyFIZWrF+C4kruk1VX9dpp+LNUT0UcCN7AL4dBjDIwtiaXK0BU8tD22DJ2xAKt3
         bpYLqQijA6fj4ClhQEyLDp7l6A9ROfueBjgbDgdtv/sDL00jfX4nTo6pM/RFCad4Xmt2
         KZoWJVHwDtAFPGEoycWeDEmnYsetObU/J03REkaQ/WWK82VSfW/y+oZZTIOrhtXmXAie
         iec8/yYkvIO8f04SIwy847IU5e0kEm7HwAXJE8dP3HmLeRDwtZZcKpdUQFUb93/uUdWR
         VbKb7vADQmPwQ9+YBFI+yGE5kdNotle6ZI/UR3RaFAFXNwlMhWvDl2yMZF95Y2BV7Nfb
         mBiw==
Received: by 10.213.35.196 with SMTP id q4mr193329ebd.29.1333855238875; Sat,
 07 Apr 2012 20:20:38 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Sat, 7 Apr 2012 20:20:38 -0700 (PDT)
In-Reply-To: <1333854479-23260-12-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194970>

On Sun, Apr 8, 2012 at 6:07 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
> =C2=A0t/t9902-completion.sh | =C2=A0 10 ++++++++--
> =C2=A01 file changed, 8 insertions(+), 2 deletions(-)

Maybe something like this would be better:

--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -58,7 +58,7 @@ test_completion ()
        _words=3D( $1 )
        test $# -gt 1 && echo "$2" > expected
        (( _cword =3D ${#_words[@]} - 1 ))
-       _git_wrap && print_comp &&
+       ${comp_wrap-_git_wrap} && print_comp &&
        test_cmp expected out
 }

@@ -305,4 +305,11 @@ test_expect_success 'global options extra checks' =
'
        test_completion "git --no-pager tag -d v" "v0.1 "
 '

+test_expect_success 'aliases' '
+       local comp_wrap=3D_git_fetch_wrap &&
+       git_complete gf git_fetch &&
+       test_completion "gf o" "origin " &&
+       test_completion "gf origin m" "master:master "
+'
+
 test_done


--=20
=46elipe Contreras
