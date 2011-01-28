From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] git-gui: fix browser with initial path
Date: Fri, 28 Jan 2011 10:42:15 +0000
Message-ID: <87sjwdmhrs.fsf@fox.patthoyts.tk>
References: <1290497870-28673-1-git-send-email-bert.wesarg@googlemail.com>
	<AANLkTim8BhN9czr6Jx5J28iNop4XdFDcNKbbjxddW9-i@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Jan 28 11:43:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PilnA-0000tW-LG
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 11:43:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028Ab1A1Kmy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Jan 2011 05:42:54 -0500
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:55150 "EHLO
	smtp-out5.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752885Ab1A1Kmy convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jan 2011 05:42:54 -0500
Received: from [172.23.170.138] (helo=anti-virus01-09)
	by smtp-out5.blueyonder.co.uk with smtp (Exim 4.52)
	id 1Piln1-0003Fy-79; Fri, 28 Jan 2011 10:42:51 +0000
Received: from [77.100.97.230] (helo=fox.patthoyts.tk)
	by asmtp-out6.blueyonder.co.uk with esmtpa (Exim 4.72)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1PilmS-00081m-25; Fri, 28 Jan 2011 10:42:16 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 2CFFA203FB; Fri, 28 Jan 2011 10:42:16 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <AANLkTim8BhN9czr6Jx5J28iNop4XdFDcNKbbjxddW9-i@mail.gmail.com>
	(Bert Wesarg's message of "Fri, 10 Dec 2010 09:48:43 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165608>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

>Ping.
>
>On Tue, Nov 23, 2010 at 08:37, Bert Wesarg <bert.wesarg@googlemail.com=
> wrote:
>> The path given to the browser does not end in a slash, which results=
 in bad
>> path given to blame and broke [Up To Parent]. Also the path was not
>> escaped before displaying.
>>
>> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>>
>> ---
>> =A0git-gui/lib/browser.tcl | =A0 =A08 +++++++-
>> =A01 files changed, 7 insertions(+), 1 deletions(-)
>>
>> diff --git a/git-gui/lib/browser.tcl b/git-gui/lib/browser.tcl
>> index c241572..a88a68b 100644
>> --- a/git-gui/lib/browser.tcl
>> +++ b/git-gui/lib/browser.tcl
>> @@ -26,8 +26,14 @@ constructor new {commit {path {}}} {
>> =A0 =A0 =A0 =A0wm withdraw $top
>> =A0 =A0 =A0 =A0wm title $top [append "[appname] ([reponame]): " [mc =
"File Browser"]]
>>
>> + =A0 =A0 =A0 if {$path ne {}} {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if {[string index $path end] ne {/}} {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 append path /
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 }
>> +
>> =A0 =A0 =A0 =A0set browser_commit $commit
>> - =A0 =A0 =A0 set browser_path $browser_commit:$path
>> + =A0 =A0 =A0 set browser_path "$browser_commit:[escape_path $path]"
>>
>> =A0 =A0 =A0 =A0${NS}::label $w.path \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-textvariable @browser_path \
>> --
>> tg: (6f10c41..) bw/git-gui/fix-browser-up (depends on: master)
>>
>
The commit comment for this doesn't really reflect whats being
done. Commit 1ab8628 fixed the [Up To Parent] problem and this just
fixes the display on the browser title.

So I plan to take this with the commit comment as:

 git-gui: fix display of path in browser title

 Ensure the browser path is shown on the title with a / suffix and esca=
pe
 any backslashes or newlines in path elements before display.

 Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

--=20
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
