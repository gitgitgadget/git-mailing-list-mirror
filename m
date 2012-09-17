From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH 2/2] git-gui: remove .git/CHERRY_PICK_HEAD after committing
Date: Mon, 17 Sep 2012 12:52:32 +0100
Message-ID: <878vc8kgsf.fsf@fox.patthoyts.tk>
References: <1345280851-6626-1-git-send-email-bbolli@ewanet.ch>
	<1345280851-6626-2-git-send-email-bbolli@ewanet.ch>
	<7vobm8rllv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Beat Bolli <bbolli@ewanet.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 13:53:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDZsz-00017J-7U
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 13:53:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756068Ab2IQLxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 07:53:00 -0400
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:17395 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755942Ab2IQLw7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Sep 2012 07:52:59 -0400
Received: from know-smtpout-1.server.virginmedia.net ([62.254.123.1])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120917115257.BEMO10247.mtaout01-winn.ispmail.ntl.com@know-smtpout-1.server.virginmedia.net>;
          Mon, 17 Sep 2012 12:52:57 +0100
Received: from [94.171.229.22] (helo=fox.patthoyts.tk)
	by know-smtpout-1.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1TDZsP-0001AL-0U; Mon, 17 Sep 2012 12:52:33 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 5BBAA22E5E; Mon, 17 Sep 2012 12:52:32 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <7vobm8rllv.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 18 Aug 2012 13:28:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
X-Cloudmark-Analysis: v=1.1 cv=GaEGOwq9FwezmTggA+b6yC6zDZF2HYaK6RN/tSqdnVA= c=1 sm=0 a=O9HYxzjLEG8A:10 a=0L7TnOSJ2uEA:10 a=CtgcEeagiGAA:10 a=kj9zAlcOel0A:10 a=ybZZDoGAAAAA:8 a=Rf460ibiAAAA:8 a=pNMNhURK2xukGAjD6CUA:9 a=CjuIK1q_8ugA:10 a=qIVjreYYsbEA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205676>

Junio C Hamano <gitster@pobox.com> writes:

>Beat Bolli <bbolli@ewanet.ch> writes:
>
>> Adding __git_ps1() to one's bash prompt displays various repo status
>> info after each command. After committing a git cherry-pick -n using
>> git-gui, the prompt still contains the "|CHERRY-PICKING" flag.
>>
>> Delete the file causing this flag when cleaning up.
>>
>> Signed-off-by: Beat Bolli <bbolli@ewanet.ch>
>> ---
>>  git-gui/lib/commit.tcl |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/git-gui/lib/commit.tcl b/git-gui/lib/commit.tcl
>> index 78c5eeb..864b687 100644
>> --- a/git-gui/lib/commit.tcl
>> +++ b/git-gui/lib/commit.tcl
>> @@ -409,6 +409,7 @@ A rescan will be automatically started now.
>>  	catch {file delete [gitdir MERGE_MSG]}
>>  	catch {file delete [gitdir SQUASH_MSG]}
>>  	catch {file delete [gitdir GITGUI_MSG]}
>> +	catch {file delete [gitdir CHERRY_PICK_HEAD]}
>>  
>>  	# -- Let rerere do its thing.
>>  	#
>
>It makes me wonder if the above sequence of file delete should all
>be removed and use "git commit" instead of "git commit-tree" in the
>implementation of this Tcl procedure instead.
>
>Pat?
>

I agree - this looks like the code in contrib/examples/git-commit.sh so
presumably predates the builtin 'commit' command.
For now I've applied the above - but this should be changed to just call
commit normally from what I can see. Thats added to my todo.
-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
