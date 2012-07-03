From: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
Subject: Re: [Q] Branch aliases =?UTF-8?Q?=28synonyms=29=3F?=
Date: Tue, 03 Jul 2012 14:23:29 +0200
Message-ID: <93cfd6eb9045585728dfe649359a103c@ulrik.uio.no>
References: <1919214.YKUdgul2iY@laclwks004>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git mailing list <git@vger.kernel.org>
To: Brian Foster <brian.foster@maxim-ic.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 14:23:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sm290-00072r-Va
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 14:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395Ab2GCMXf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Jul 2012 08:23:35 -0400
Received: from mail-out2.uio.no ([129.240.10.58]:44313 "EHLO mail-out2.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750749Ab2GCMXe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 08:23:34 -0400
Received: from mail-mx2.uio.no ([129.240.10.30])
	by mail-out2.uio.no with esmtp (Exim 4.75)
	(envelope-from <h.b.furuseth@usit.uio.no>)
	id 1Sm28j-0005dr-3u; Tue, 03 Jul 2012 14:23:33 +0200
Received: from w3prod-wm02.uio.no ([129.240.4.215] helo=webmail.uio.no)
	by mail-mx2.uio.no with esmtpsa (TLSv1:AES256-SHA:256)
	user hbf (Exim 4.76)
	(envelope-from <h.b.furuseth@usit.uio.no>)
	id 1Sm28i-0008Mz-OR; Tue, 03 Jul 2012 14:23:33 +0200
Received: from bombur.uio.no ([129.240.6.233])
 by webmail.uio.no
 with HTTP (HTTP/1.1 POST); Tue, 03 Jul 2012 14:23:29 +0200
In-Reply-To: <1919214.YKUdgul2iY@laclwks004>
X-Sender: h.b.furuseth@usit.uio.no
User-Agent: Roundcube Webmail/0.4.2
X-UiO-Ratelimit-Test: rcpts/h 2 msgs/h 1 sum rcpts/h 2 sum msgs/h 1 total rcpts 2503 max rcpts/h 20 ratelimit 0
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=5.0, autolearn=disabled, FSL_RCVD_USER=0.001,T_RP_MATCHES_RCVD=-0.01,UIO_MAIL_IS_INTERNAL=-5, uiobl=NO, uiouri=NO)
X-UiO-Scanned: 8D5502AADC12480FCBA7FA8A6B3F839088D2F3F6
X-UiO-SPAM-Test: remote_host: 129.240.4.215 spam_score: -49 maxlevel 80 minaction 2 bait 0 mail/h: 70 total 2469745 max/h 641 blacklist 0 greylist 0 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200911>

 Brian Foster wrote:
> (...)
>  The catch is a desire(? requirement?) that, when the
>  transition ends, people used to using B can continue
>  to use B, people used to using A can continue to use A,
>  and there is no difference.  That is, after the end of
>  transition, branch names A and B are the same thing.
>  Always.  Automatically.
>
>  Using a symref seems a working answer.  That is,
>  after the merge, change B from a true branch head
>  into a symref pointing to A:
>
>       git merge ...
>       git symbolic-ref refs/heads/B refs/heads/A
>
>   =E2=96=B6 What are the gotchas?

 Git clone will turn symref B into a regular branch,
 which will not move in parallel with A.

 People may have private scripts which will
 be surprised when they encounter B.  E.g. when
 parsing the output from 'git branch'.
 Check out B, then you expect B rather than A
 to be reported as the current branch:
   git checkout B
   git branch
   * A
     B -> A

>   =E2=96=B6 Are there other solutions?

 You haven't explained the problem which led you to want "equal"
 branches.  E.g. if it's hard to teach developers to switch
 from B to A, a hook which rejects pushes to B might help.
 Possibly in addition to them using a private symref.  In this
 case, 'git symbolic-ref B refs/heads/A' might work better.

 Hallvard
