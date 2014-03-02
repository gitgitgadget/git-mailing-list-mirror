From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/3] rebase: accept -<number> as another way of saying HEAD~<number>
Date: Sun, 02 Mar 2014 16:55:27 +0100
Message-ID: <vpqlhwsr3ww.fsf@anie.imag.fr>
References: <1393506078-7310-1-git-send-email-pclouds@gmail.com>
	<1393728794-29566-1-git-send-email-pclouds@gmail.com>
	<1393728794-29566-3-git-send-email-pclouds@gmail.com>
	<CAPig+cSPKSsVG_yqaQfOCswaENKdUGrWt_YcQ3yZCpgG5jQ+JQ@mail.gmail.com>
	<CAPig+cSFWT6kwZUFFUE3=TcfHRUJnx54+fcZCzJwmOSJKFsYeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Philip Oakley <philipoakley@iee.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 16:56:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WK8kQ-000363-LN
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 16:56:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbaCBPzt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Mar 2014 10:55:49 -0500
Received: from mx1.imag.fr ([129.88.30.5]:54868 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751301AbaCBPzs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2014 10:55:48 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s22FtROE000825
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 2 Mar 2014 16:55:27 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s22FtS5s007831;
	Sun, 2 Mar 2014 16:55:28 +0100
In-Reply-To: <CAPig+cSFWT6kwZUFFUE3=TcfHRUJnx54+fcZCzJwmOSJKFsYeA@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 2 Mar 2014 03:55:01 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 02 Mar 2014 16:55:27 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s22FtROE000825
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1394380528.89868@BHaMvHu22BAa0HovKCEo6A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243151>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sun, Mar 2, 2014 at 3:53 AM, Eric Sunshine <sunshine@sunshineco.co=
m> wrote:
>> On Sat, Mar 1, 2014 at 9:53 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com> wrote:
>>> This is "rev-list style", where people can do "git rev-list -3" in
>>> addition to "git rev-list HEAD~3". A lot of commands are driven by =
the
>>> revision machinery and also accept this form. This addition to reba=
se
>>> is just for convenience.
>>
>> I'm seeing some pretty strange results with this. If I use -1, -2, o=
r
>> -3 then it rebases the expected commits, however, -4 gives me 9
>> commits, and -5 rebases 35 commits. Am I misunderstanding how this
>> works?
>
> Nevermind. I wasn't paying attention to the fact that I was attemptin=
g
> to rebase merges.

Your remark is actually interesting. Most (all?) Git commands taking
-<n> as parameters act on n commits, regardless of merges.

So, this commit creates an inconsistency between e.g. "git log -3" (sho=
w
last 3 commits) and "git rebase -3" (rebase up to HEAD~3, but there may
be more commits in case there are merges).

I don't have a better proposal, but at least the inconsistancy should b=
e
documented (e.g. "note that this is different from what other commands
like 'git log' do when used with a -<number> option since ..." in the
manpage).

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
