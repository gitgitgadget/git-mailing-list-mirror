From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>
Subject: Re: another git rebase -i problem
Date: Thu, 14 Feb 2008 14:02:28 +0100
Message-ID: <20080214130228.GB28472@digi.com>
References: <20080214093730.GA20408@digi.com> <alpine.LSU.1.00.0802141232070.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 14 14:03:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPdkN-00025U-RM
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 14:03:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759152AbYBNNCx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Feb 2008 08:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759605AbYBNNCx
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 08:02:53 -0500
Received: from mail29.messagelabs.com ([216.82.249.147]:55627 "HELO
	mail29.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1759034AbYBNNCw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 08:02:52 -0500
X-VirusChecked: Checked
X-Env-Sender: Uwe.Kleine-Koenig@digi.com
X-Msg-Ref: server-7.tower-29.messagelabs.com!1202994124!5969738!7
X-StarScan-Version: 5.5.12.14.2; banners=-,-,-
X-Originating-IP: [66.77.174.21]
Received: (qmail 24570 invoked from network); 14 Feb 2008 13:02:46 -0000
Received: from unknown (HELO owa.digi.com) (66.77.174.21)
  by server-7.tower-29.messagelabs.com with SMTP; 14 Feb 2008 13:02:46 -0000
Received: from mtk-sms-mail01.digi.com ([10.10.8.120]) by owa.digi.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 14 Feb 2008 07:02:32 -0600
Received: from dor-sms-mail1.digi.com ([10.49.1.105]) by mtk-sms-mail01.digi.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 14 Feb 2008 07:02:31 -0600
Received: from zentaur.digi.com ([10.100.10.144]) by dor-sms-mail1.digi.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 14 Feb 2008 14:02:28 +0100
Received: by zentaur.digi.com (Postfix, from userid 1080)
	id 972361B27B; Thu, 14 Feb 2008 14:02:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802141232070.30505@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 14 Feb 2008 13:02:28.0926 (UTC) FILETIME=[DA6155E0:01C86F09]
X-TM-AS-Product-Ver: SMEX-8.0.0.1181-5.000.1023-15728.003
X-TM-AS-Result: No--17.290800-8.000000-31
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73876>

Johannes Schindelin wrote:
> Hi,
>=20
> On Thu, 14 Feb 2008, Uwe Kleine-K=F6nig wrote:
>=20
> > After applying the patch below, the test fails. [describes a case w=
here=20
> > all patches were applied upstream already]
>=20
> This is by design.  If no patches are to be applied, there is nothing=
 you=20
> can do interactively.  And git rebase -i should tell you as much:
>=20
> 	Nothing to do
>=20
> Maybe it should say
>=20
> 	There is nothing you can rebase interactively
>=20
> But I don't like that.
>
> Alternatively, git rebase -i could reset --hard to upstream, but I do=
n't=20
> like that either: if I rebase -i, it is because I want to reorder/arr=
ange=20
> patches.  If there is no patch to be rearranged, I did something wron=
g.
Ah, OK this disqualifies my test case, but the problem is real:

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
=2Esh
index e5ed745..f0499e6 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -362,4 +362,11 @@ test_expect_success 'rebase with a file named HEAD=
 in worktree' '
=20
 '
=20
+test_expect_success 'rebase patch already merged' '
+
+	git checkout -b branch4 twerp &&
+	FAKE_LINES=3D"1 2 4 3" git rebase -i branch3
+
+'
+
 test_done

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig, Software Engineer
Digi International GmbH Branch Breisach, K=FCferstrasse 8, 79206 Breisa=
ch, Germany
Tax: 315/5781/0242 / VAT: DE153662976 / Reg. Amtsgericht Dortmund HRB 1=
3962
