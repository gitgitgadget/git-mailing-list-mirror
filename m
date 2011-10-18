From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH 1/4] git-gui: handle config booleans without value
Date: Tue, 18 Oct 2011 09:25:04 +0100
Message-ID: <87ehyan1un.fsf@fox.patthoyts.tk>
References: <94b050c4cf7ae8df8d79112e13613244ebff4037.1318579823.git.bert.wesarg@googlemail.com>
	<87mxczgqiw.fsf@fox.patthoyts.tk>
	<CAKPyHN3dQ+qWeJtGzigEm=fZe62ZeRW-QGq0jnycKEBVaWn=mA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Oct 18 10:25:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RG4z5-000564-GZ
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 10:25:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752691Ab1JRIZJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Oct 2011 04:25:09 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:60119 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751553Ab1JRIZH convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 04:25:07 -0400
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.2])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111018082505.MPIA21463.mtaout02-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Tue, 18 Oct 2011 09:25:05 +0100
Received: from [94.171.235.235] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1RG4yv-0004TJ-LI; Tue, 18 Oct 2011 09:25:05 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 0140B20A4D; Tue, 18 Oct 2011 09:25:04 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <CAKPyHN3dQ+qWeJtGzigEm=fZe62ZeRW-QGq0jnycKEBVaWn=mA@mail.gmail.com>
	(Bert Wesarg's message of "Tue, 18 Oct 2011 08:39:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=O9HYxzjLEG8A:10 a=F7pDX9lBjJ0A:10 a=8nJEP1OIZ-IA:10 a=mK_AVkanAAAA:8 a=FP58Ms26AAAA:8 a=Rf460ibiAAAA:8 a=toYgf15pBwTeT66CQUgA:9 a=34-xIKs9JcATXRVPtMQA:7 a=wPNLvfGTeEIA:10 a=9xyTavCNlvEA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183875>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

>On Tue, Oct 18, 2011 at 01:13, Pat Thoyts
><patthoyts@users.sourceforge.net> wrote:
>> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>>
>>>When git interprets a config variable without a value as bool it is =
considered
>>>as true. But git-gui doesn't so until yet.
>>>
>>>The value for boolean configs are also case-insensitive.
>>>
>>>Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>>>---
>>> git-gui.sh | =A0 16 ++++++++++++++--
>>> 1 files changed, 14 insertions(+), 2 deletions(-)
>>>
>>>diff --git a/git-gui.sh b/git-gui.sh
>>>index f897160..d687871 100755
>>>--- a/git-gui.sh
>>>+++ b/git-gui.sh
>>>@@ -299,7 +299,9 @@ proc is_config_true {name} {
>>> =A0 =A0 =A0 global repo_config
>>> =A0 =A0 =A0 if {[catch {set v $repo_config($name)}]} {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0
>>>- =A0 =A0 =A0} elseif {$v eq {true} || $v eq {1} || $v eq {yes}} {
>>>+ =A0 =A0 =A0}
>>>+ =A0 =A0 =A0set v [string tolower $v]
>>>+ =A0 =A0 =A0if {$v eq {} || $v eq {true} || $v eq {1} || $v eq {yes=
} || $v eq {on}} {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1
>>> =A0 =A0 =A0 } else {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0
>>
>> This looks ok - we actually have a [string is boolean $v] test we co=
uld
>> use eg:
>> =A0if {[string is boolean $v]} {
>> =A0 =A0return [expr {$v eq {} ? 1 : !!$v}]
>> =A0}
>> although I'm not sure it gains us much. This would match everything =
Tcl
>> believes to be a boolean - yes/no, on/off, true/false and 1/0. Witho=
ut
>> -strict the [string is] test will consider {} to be a boolean.
>>
>>
>>>@@ -310,7 +312,9 @@ proc is_config_false {name} {
>>> =A0 =A0 =A0 global repo_config
>>> =A0 =A0 =A0 if {[catch {set v $repo_config($name)}]} {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0
>>>- =A0 =A0 =A0} elseif {$v eq {false} || $v eq {0} || $v eq {no}} {
>>>+ =A0 =A0 =A0}
>>>+ =A0 =A0 =A0set v [string tolower $v]
>>>+ =A0 =A0 =A0if {$v eq {false} || $v eq {0} || $v eq {no} || $v eq {=
off}} {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1
>>> =A0 =A0 =A0 } else {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0
>>>@@ -1060,6 +1064,10 @@ git-version proc _parse_config {arr_name args=
} {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else =
{
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 set arr($name) $value
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} elseif {[regexp {^([^=
\n]+)$} $line line name]} {
>>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0# no va=
lue given, but interpreting them as
>>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0# boole=
an will be handled as true
>>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set arr=
($name) {}
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>> =A0 =A0 =A0 }
>>>@@ -1075,6 +1083,10 @@ git-version proc _parse_config {arr_name args=
} {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 } else {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 set arr($name) $value
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 }
>>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} elsei=
f {[regexp {^([^=3D]+)$} $line line name]} {
>>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0# no value given, but interpreting them as
>>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0# boolean will be handled as true
>>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0set arr($name) {}
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 close $fd_rc
>>
>> Is this really how git treats boolean config values? I can't seem to
>> demonstrate that to myself:
>> pat@frog:/opt/src/git-gui$ git config --unset core.xyzzy
>> pat@frog:/opt/src/git-gui$ git config --bool --get core.xyzzy
>> pat@frog:/opt/src/git-gui$ git config --bool core.xyzzy 1
>> pat@frog:/opt/src/git-gui$ git config --bool --get core.xyzzy
>> true
>>
>> I assume I'm using the wrong test for this.
>
>It looks like you can't set it with git-config. But I know, that writi=
ng:
>
>[core]
>        xyyzy
>
>into the git config file and than calling git config --bool --get
>core.xyzzy, will give you true.
>
>Bert

OK thanks for explaining.
--=20
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
