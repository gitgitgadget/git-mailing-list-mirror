From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: git gui error with relocated repository
Date: Tue, 06 May 2014 13:10:35 +0100
Message-ID: <871tw7xg3o.fsf@fox.patthoyts.tk>
References: <CAFOYHZBPLZhVuf=bO0hPcUH2_0WXFSqk=_CqoUWBRixQc0L==Q@mail.gmail.com>
	<CAFOYHZD=wxwm0nLhtZwvXDAhQ23j0C5maArQunc0CVe_-SF_mQ@mail.gmail.com>
Reply-To: patthoyts@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 21:23:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhiQ5-0008Bg-Qr
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755368AbaEFMQ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 08:16:27 -0400
Received: from know-smtprelay-omc-5.server.virginmedia.net ([80.0.253.69]:54080
	"EHLO know-smtprelay-omc-5.server.virginmedia.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754887AbaEFMQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 08:16:26 -0400
X-Greylist: delayed 348 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 May 2014 08:16:25 EDT
Received: from fox.patthoyts.tk ([82.34.175.55])
	by know-smtprelay-5-imp with bizsmtp
	id ycAb1n05U1C56nm01cAcNU; Tue, 06 May 2014 13:10:36 +0100
X-Originating-IP: [82.34.175.55]
X-Spam: 0
X-Authority: v=2.1 cv=TdEYtHgh c=1 sm=1 tr=0 a=g1XlTrwDEGH9N8TSFs8Bjw==:117
 a=g1XlTrwDEGH9N8TSFs8Bjw==:17 a=qRKFtABOsx0A:10 a=8gcHGidUu6gA:10
 a=CtgcEeagiGAA:10 a=kj9zAlcOel0A:10 a=FP58Ms26AAAA:8 a=pGLkceISAAAA:8
 a=Rf460ibiAAAA:8 a=of6QgrYFlsJObaNzSZIA:9 a=CjuIK1q_8ugA:10 a=MSl-tDqOz04A:10
 a=AkUkIWUyXwcA:10 a=NWVoK91CQyQA:10
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id C055020A30; Tue,  6 May 2014 13:10:35 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
In-Reply-To: <CAFOYHZD=wxwm0nLhtZwvXDAhQ23j0C5maArQunc0CVe_-SF_mQ@mail.gmail.com>
	(Chris Packham's message of "Tue, 29 Apr 2014 16:23:18 +1200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248219>

Chris Packham <judge.packham@gmail.com> writes:

>On Tue, Apr 29, 2014 at 2:56 PM, Chris Packham <judge.packham@gmail.com> wrote:
>> Hi Pat,
>>
>> I'm running git 2.0.0-rc0 (haven't got round to pulling down rc1 yet)
>> which includes gitgui-0.19.0 and I'm getting a new error when I run
>> 'git gui' in a repository with a .git file (created by git submodule).
>>
>> I can send you a screencap of the error message off list if you want
>> but the text is
>>
>> "No working directory ../../../<repo>
>>
>> couldn't change working directory to ../../../<repo>: no such file or directory"
>
>My tcl is a little rusty but I think the problem might be this snippet.
>
># v1.7.0 introduced --show-toplevel to return the canonical work-tree
>if {[package vsatisfies $_git_version 1.7.0]} {
>    if { [is_Cygwin] } {
>        catch {set _gitworktree [exec cygpath --windows [git rev-parse
>--show-toplevel]]}
>    } else {
>        set _gitworktree [git rev-parse --show-toplevel]
>    }
>} else {
>    # try to set work tree from environment, core.worktree or use
>    # cdup to obtain a relative path to the top of the worktree. If
>    # run from the top, the ./ prefix ensures normalize expands pwd.
>    if {[catch { set _gitworktree $env(GIT_WORK_TREE) }]} {
>        set _gitworktree [get_config core.worktree]
>        if {$_gitworktree eq ""} {
>            set _gitworktree [file normalize ./[git rev-parse --show-cdup]]
>        }
>    }
>}
>
>The  vsatisfies call probably doesn't handle '2.0.0.rc0' and the
>fallback behaviour probably needs to normalise core.worktree
>

The _git_version variable has already been trimmed to remove such
suffixes so the version comparison here will be ok. It looks more likely
to be something to do with the .git being a file with a link being
mishandled. How did you setup this test repository with its link to a
parent?

>>
>> Here's some other info that might help
>>
>>   $ git --version
>>   git version 2.0.0.rc0
>>
>>   $ cat .git
>>   gitdir: ../.git/modules/<repo>
>>
>>   $ git rev-parse --git-dir
>>   /home/chris/src/<super>/.git/modules/<repo>
>>
>>   $ git config core.worktree
>>   ../../../<repo>
>>
>> Thanks,
>> Chris
>

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
