From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Thunderbird and patches (was Re: [PATCH v2] Enable setting attach
   as the default in .gitconfig   for git-format-patch.)
Date: Mon, 09 Feb 2009 16:49:05 +0100
Message-ID: <49905071.6030805@drmicha.warpmail.net>
References: <498E50E2.8050309@codeweavers.com> <200902072310.12764.bss@iguanasuicide.net> <498F01C2.5080105@codeweavers.com> <alpine.DEB.1.00.0902081827140.10279@pacific.mpi-cbg.de> <499022D3.3000200@drmicha.warpmail.net> <49902EDC.6020901@beonex.com> <alpine.DEB.1.00.0902091433270.10279@pacific.mpi-cbg.de> <49903521.1060101@codeweavers.com> <49903B27.8070608@beonex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeremy White <jwhite@codeweavers.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	git@vger.kernel.org
To: Ben Bucksch <ben.bucksch.news@beonex.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 16:50:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWYPA-0004Lt-EH
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 16:50:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754763AbZBIPtO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 10:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754633AbZBIPtN
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 10:49:13 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:52210 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754573AbZBIPtN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Feb 2009 10:49:13 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 909DD29026A;
	Mon,  9 Feb 2009 10:49:11 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 09 Feb 2009 10:49:11 -0500
X-Sasl-enc: GLqNLgxkzkjf0uU/doG6aKxwUVOdStTX1ueNDuDPVreE 1234194550
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4D140C7F5;
	Mon,  9 Feb 2009 10:49:10 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <49903B27.8070608@beonex.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109086>

Currently, git-notes barks when asked to show an empty (i.e.
non-existing) note. Change this to explicitly say there is none.

Signed-off-by: Michael J Gruber 
---
 git-notes.sh     |    2 ++
 t/t3301-notes.sh |    2 +-
 2 files changed, 3 insertions(+), 1 deletions(-)


Ben Bucksch venit, vidit, dixit 09.02.2009 15:18:
> On 09.02.2009 14:52, Jeremy White wrote:
>   
>> I discovered that if I just injected charset=iso-2022-jp, format=flowed
>> would stay off!<grin>
>>    
>>     
> (This was a hack, caused by the different use of spaces in Japanese / 
> CJK, which means a different kind of "flow".)
>
>   
>> Ben, along those lines, we do have the ability to control the entire 
>> body of a possible patch before Thunderbird sees it. Would it be 
>> possible, or reasonable, for Thunderbird to look for and preserve a 
>> 'format=fixed' setting inside a body that we generated?
>>     
>
> I don't know how you're injecting the email to Thunderbird. mailto:?
>
>   
git comes with a contributed hint which suggests using the external
editor extension. There's also a script which shuffles things around and
into place for TB to accept the header lines. Alternatively, call vim as
the external editor....
> What you propose is a header, not a body.
> (I'm a bit irritated that TB would react to a charset header *in the 
> body*, but maybe that's a hack specially for charsets, in some code part 
> I don't know, given that they are unfortunately sometimes only marked in 
> content.)
>
> I think it would most likely work easily if you inject HTML (read before 
> you scream):
> mailto:fred@example.com?html-body=Here's patch revision abc from repo 
> def:<p><pre>Patch: file ....<br>+++ bla<br>line 3<br></pre>
> (properly escaped, of course)
> It should invoke the normal rich editor, with the patch properly marked 
> as preformatted. Once you send it, it would send it as plaintext, 
> depending on your prefs. During the formatting, it would see the 
> preformat section and should send it out with the lineendings as marked.
> I haven't tried the full chain, but it's something to play with.
>
> Ben
>   
OK, for the first time in I don't know how many months/years I fire up
the HTML composer in TB. Please don't tell anyone from my git
acquaintances, they'll give me an even tougher rub than usual on my next
patch submission...

I'll try and inline with <pre> a patch I sent resently... Now this looks
interesting after coming back from external editor (gvim -f). Kinda
cute. We'll see what TB makes out of it (hopefully confirming Ben's
pre-theory, uhm).

Cheers,
Michael


diff --git a/git-notes.sh b/git-notes.sh
index bfdbaa8..9cbad02 100755
--- a/git-notes.sh
+++ b/git-notes.sh
@@ -58,6 +58,8 @@ edit)
 		"$GIT_NOTES_REF" $NEW_HEAD $CURRENT_HEAD
 ;;
 show)
+	git rev-parse -q --verify "$GIT_NOTES_REF":$COMMIT > /dev/null ||
+		die "No note for commit $COMMIT."
 	git show "$GIT_NOTES_REF":$COMMIT
 ;;
 *)
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 7ef1c29..ff4ea05 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -36,7 +36,7 @@ test_expect_success 'need valid notes ref' '
 '
 
 # 1 indicates caught gracefully by die, 128 means git-show barked
-test_expect_failure 'handle empty notes gracefully' '
+test_expect_success 'handle empty notes gracefully' '
 	git notes show ; test 1 = $?
 '
 
-- 
1.6.1.2.253.ga34a
