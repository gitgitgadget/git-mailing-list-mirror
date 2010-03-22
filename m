From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH 1/3] gitk: Avoid calling tk_setPalette on Windows
Date: Mon, 22 Mar 2010 22:52:45 +0000
Message-ID: <87tys8c6ki.fsf@fox.patthoyts.tk>
References: <1268418709-4998-1-git-send-email-patthoyts@users.sourceforge.net>
	<20100320063256.GA26519@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 23:52:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtqUU-0007z8-3e
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 23:52:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756634Ab0CVWww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 18:52:52 -0400
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:57479 "EHLO
	smtp-out5.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751031Ab0CVWww (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Mar 2010 18:52:52 -0400
Received: from [172.23.170.146] (helo=anti-virus03-09)
	by smtp-out5.blueyonder.co.uk with smtp (Exim 4.52)
	id 1NtqUL-00025k-DI; Mon, 22 Mar 2010 22:52:49 +0000
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out5.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1NtqUJ-0003Il-0i; Mon, 22 Mar 2010 22:52:47 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id DFCDA201F7; Mon, 22 Mar 2010 22:52:45 +0000 (GMT)
X-Url: http://www.patthoyts.tk/
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
In-Reply-To: <20100320063256.GA26519@progeny.tock> (Jonathan Nieder's message of "Sat\, 20 Mar 2010 01\:32\:56 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142973>

Jonathan Nieder <jrnieder@gmail.com> writes:

>Pat Thoyts wrote:
>
>> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
>> ---
>>  gitk |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>> 
>> diff --git a/gitk b/gitk
>> index 1f36a3e..dc9b8a8 100755
>> --- a/gitk
>> +++ b/gitk
>> @@ -10845,10 +10845,11 @@ proc setselbg {c} {
>>  
>>  # This sets the background color and the color scheme for the whole UI.
>>  # For some reason, tk_setPalette chooses a nasty dark red for selectColor
>>  # if we don't specify one ourselves, which makes the checkbuttons and
>>  # radiobuttons look bad.  This chooses white for selectColor if the
>>  # background color is light, or black if it is dark.
>>  proc setui {c} {
>> +    if {[tk windowingsystem] eq "win32"} { return }
>
>Do you know whether the situation described by the comment has been addressed
>for Tk?  Maybe gitk could check for an appropriate Tk version to avoid this
>workaround on all platforms.

This has never been true for Windows which has always used the native
images for check and radio buttons. So the comment there is relevant
only to X11. I believe in Tk 8.5 the check/radio buttons now use
images by default (the ttk versions will look appropriate to the
current theme - however that may be defined).

However, messing about with this on X11 would need testing that I
can't do on Windows. Hence the suggested fix.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
