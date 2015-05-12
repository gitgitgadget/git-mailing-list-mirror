From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] bisect: print abbrev sha1 for first bad commit
Date: Tue, 12 May 2015 22:43:29 +0200
Message-ID: <CAP8UFD0k-=ESEu-7jhf8Y5wz+5A=MHsjtMnC7YJv_DRi30TmDw@mail.gmail.com>
References: <1431128763-28453-1-git-send-email-tbsaunde@tbsaunde.org>
	<CAGZ79kYjES6DXmvQdmXLAXrKMGrnvQ-vqJuHQU2QxVC4+6M0aA@mail.gmail.com>
	<20150509014152.GA31119@tsaunders-iceball.corp.tor1.mozilla.com>
	<20150509040704.GA31428@peff.net>
	<20150510231110.GA25157@tsaunders-iceball.corp.tor1.mozilla.com>
	<20150511011009.GA21830@peff.net>
	<xmqqmw1bg2dd.fsf@gitster.dls.corp.google.com>
	<CAP8UFD1Aq54dWvxo5JTP4Fqy5u-qhA0LAm3vRrw9=jYg3o_F+g@mail.gmail.com>
	<xmqqfv73f420.fsf@gitster.dls.corp.google.com>
	<CAP8UFD3LzM3uuUzWYS-o6mhtH-x5+-kyGhDvYnv6ZPRTC18C6w@mail.gmail.com>
	<xmqq7fsd201d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Trevor Saunders <tbsaunde@tbsaunde.org>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 12 22:43:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsH1d-00062g-Pb
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 22:43:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933012AbbELUnc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 16:43:32 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38672 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932951AbbELUna (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 16:43:30 -0400
Received: by wicnf17 with SMTP id nf17so31109223wic.1
        for <git@vger.kernel.org>; Tue, 12 May 2015 13:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=lUOZ9g0pKpEwJz1N4sWcWAMHmeO3IhExZFe++ToPp3g=;
        b=rsGipCDoDGAcUy3SgavrgZbulaU9RcQ0J9NZFNrJnqlB8h2I9w1Am/BOOgxFJiOo0B
         WuMVzjYXw5RhXWOD1ck4eevHRJdY/7ep0ztgafS2E8WzLjyV8OYeIS9DlpVyc8Xez0gh
         HV1Ehw5aNWQnmeTszP473iuEIJpl9k1RlWixxZ7EMSB20vAEzsMX6ZcLxahKMSsiwSbf
         6VpUJkVSda9J+WAfxxrSKZ4+rQam1mzTR7swYoXmpbS7cfb6IL2YJ1tR6aw/N+NfriQt
         kaa0mSaPcghY4HEDKryLLTgiOgwpDJet+s8gmFFBOIqzOZUKZ/iC3p2Ah39nOz4Ujhw2
         /h3g==
X-Received: by 10.194.178.227 with SMTP id db3mr32836826wjc.82.1431463409172;
 Tue, 12 May 2015 13:43:29 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Tue, 12 May 2015 13:43:29 -0700 (PDT)
In-Reply-To: <xmqq7fsd201d.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268881>

On Tue, May 12, 2015 at 7:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> On Mon, May 11, 2015 at 6:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> To be bluntly honest, I think the current one is sufficient as a
>>> good-enough default.  The first thing I would do after seeing that
>>> message is to either "git checkout <commit-object-name>" or "git
>>> show <commit-object-name>", and the current full 40-hex output gives
>>> me an easier mouse-double-click target than the proposed abbreviated
>>> one, so in that sense the original proposal may even be a usability
>>> regression.
>>
>> Yeah, it might also be a regression if some users have scripts that
>> depend on the current behavior.
>> ...
>>> It is tempting to say that the output can be eliminated by always
>>> checking out the first-bad-commit (i.e. only when the last answer
>>> that led to the first-bad decision was "good", do a "git checkout"
>>> of that bad commit), but in a project where a branch switching is
>>> not instantaneous, that might be problematic (unless the first step
>>> the user would have done is to check it out anyway, of course).
>>
>> Yeah, and speaking of regressions, elimiting the output might be a
>> more serious regression.
>
> I am getting somewhat annoyed by this line of thought.
>
> Who said bisect output is meant to be parseable and be read by
> scripts in the first place?  If that were the case, we wouldn't be
> having this discussion thread in the first place.

Well "git bisect run" is all about automating bisecting and we know
that some people have been using it for a long time.

See for example this message from 2007:

http://lkml.iu.edu/hypermail/linux/kernel/0711.1/1443.html

where there is:

"Today we can autonomouly
bisect build bugs via a simple shell command around "git-bisect run",
without any human interaction!"

So it is reasonnable to wonder if some scripts might be parsing
the output.
