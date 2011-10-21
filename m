From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] git-gui: guitools: add the path in the confirmation dialog for tools which needs one
Date: Fri, 21 Oct 2011 23:19:40 +0100
Message-ID: <87ipni3s3n.fsf@fox.patthoyts.tk>
References: <2fef219736a0787ed864b5c18adf31f7a4e8acda.1319139139.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Oct 22 00:22:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHNU5-00058P-73
	for gcvg-git-2@lo.gmane.org; Sat, 22 Oct 2011 00:22:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921Ab1JUWTo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Oct 2011 18:19:44 -0400
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:28786 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751632Ab1JUWTn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Oct 2011 18:19:43 -0400
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.4])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111021221941.DCTA13501.mtaout01-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Fri, 21 Oct 2011 23:19:41 +0100
Received: from [94.171.235.235] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1RHNRF-0004SQ-Hb; Fri, 21 Oct 2011 23:19:41 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id C4E5F20368; Fri, 21 Oct 2011 23:19:40 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <2fef219736a0787ed864b5c18adf31f7a4e8acda.1319139139.git.bert.wesarg@googlemail.com>
	(Bert Wesarg's message of "Thu, 20 Oct 2011 21:32:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=O9HYxzjLEG8A:10 a=uiPigxv7VhEA:10 a=kj9zAlcOel0A:10 a=mK_AVkanAAAA:8 a=Rf460ibiAAAA:8 a=11uPUiGnvP-qB1K4vA8A:9 a=OJPWR_Y1sjTMrTu5AfIA:7 a=CjuIK1q_8ugA:10 a=psFEWSvwNxIA:10 a=9xyTavCNlvEA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184089>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

>Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>---
> lib/tools.tcl |   10 ++++++++--
> 1 files changed, 8 insertions(+), 2 deletions(-)
>
>diff --git a/lib/tools.tcl b/lib/tools.tcl
>index 95e6e55..39e08f0 100644
>--- a/lib/tools.tcl
>+++ b/lib/tools.tcl
>@@ -87,8 +87,14 @@ proc tools_exec {fullname} {
> 			return
> 		}
> 	} elseif {[is_config_true "guitool.$fullname.confirm"]} {
>-		if {[ask_popup [mc "Are you sure you want to run %s?" $fullname]] ne {yes}} {
>-			return
>+		if {[is_config_true "guitool.$fullname.needsfile"]} {
>+			if {[ask_popup [mc "Are you sure you want to run %s on file \"%s\"?" $fullname $current_diff_path]] ne {yes}} {
>+				return
>+			}
>+		} else {
>+			if {[ask_popup [mc "Are you sure you want to run %s?" $fullname]] ne {yes}} {
>+				return
>+			}
> 		}
> 	}

This looks good. I modified the string there to use positional
parameters as sometimes translations need to re-order things and the
msgcat format can support this using [mc {%2$s and %1$d} $first $second]
-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
