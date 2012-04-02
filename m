From: demerphq <demerphq@gmail.com>
Subject: Re: push.default: current vs upstream
Date: Mon, 2 Apr 2012 23:02:53 +0200
Message-ID: <CANgJU+V57Yz2FXStsYtL38td7FLR=ihaKzvbOBqzbR=qEFgESw@mail.gmail.com>
References: <7vd37wv77j.fsf@alter.siamese.dyndns.org>
	<20120329095236.GA11911@sigill.intra.peff.net>
	<7vbonfqezs.fsf@alter.siamese.dyndns.org>
	<20120329221154.GA1413@sigill.intra.peff.net>
	<7vfwcqq2dw.fsf@alter.siamese.dyndns.org>
	<20120330071358.GB30656@sigill.intra.peff.net>
	<7vty15ltuo.fsf@alter.siamese.dyndns.org>
	<vpqty12h995.fsf@bauges.imag.fr>
	<7vlimegjw9.fsf@alter.siamese.dyndns.org>
	<vpqy5qejbjl.fsf@bauges.imag.fr>
	<7vobraf057.fsf@alter.siamese.dyndns.org>
	<vpqwr5ydkqt.fsf@bauges.imag.fr>
	<7vzkatex02.fsf@alter.siamese.dyndns.org>
	<vpqiphhdfzw.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 02 23:02:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEoOw-0004wk-Kg
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 23:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752624Ab2DBVC4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 17:02:56 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55547 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554Ab2DBVCy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 17:02:54 -0400
Received: by ghrr11 with SMTP id r11so1500309ghr.19
        for <git@vger.kernel.org>; Mon, 02 Apr 2012 14:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jlS4/H9bFrlL7HK+A4FG95Au/bRMQDgoHWRCUur8Rew=;
        b=AWwS0Nl/MCwI3kI82N4mJz5rgcrRh1GVrIIGwn7D5LXnvQHbl7AWgapzb8apM8pFJL
         kyLEYBm2usZwroHDdCXfuL0as6dKr9QJApWNP6xR40pL2puwqu+NdrHBg5OK5/BzdVG5
         gbtcbulmrRRREVggImYexGyEkfQmSDzMZYi9Qo/yTx0vZyy1RfDcdhp/HMIIPRJTyxov
         Yxr5FXnPDBJ7CPNzQj2ih9OnrRZCvMOM8PLLbPh2MIcgd1KHRTCxcPsWvIA3499upoY9
         cuSJgzkz9L6HZloNeLYf7fOc1MBfNbDQM/pF66A0NiDE6DqmyftOsEaT1GFWqkFGv07Q
         3B6A==
Received: by 10.236.161.232 with SMTP id w68mr8344838yhk.56.1333400574063;
 Mon, 02 Apr 2012 14:02:54 -0700 (PDT)
Received: by 10.236.111.11 with HTTP; Mon, 2 Apr 2012 14:02:53 -0700 (PDT)
In-Reply-To: <vpqiphhdfzw.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194563>

On 2 April 2012 22:40, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> No more words from me on this subthread.
>
> It's a pity. I still have no answer to my question:
>
> | But why doesn't the same applies to "git pull"? Why would it be natural
> | for "git pull" to pull from a branch other than the one with the same
> | name?

The choice of "fetch" and "pull" and "push" were in some respects
unfortunate. They sound like opposites, but they are not. The very
fact that you have two commands "pull" and "fetch" both of which are
more or less the semantic opposites of "push" leads to confusion.

And actually I find your use of "git pull" and "pull" in the
expression "pull from a branch other than one with the same name"
confusing. Barring misconfiguration pull operates on only one local
branch and it is usually the one with the same name. However push
operates on multiple local branches. So from the point of view of
"what local branches are involved in the operation" the current
default leads to inconsistency.

If you had replaced "pull" with "fetch" then your argument somewhat
makes sense, but IMO is overriden by the observation that "fetch" is
essentially non-destructive, it modifies only local copies of the
remotes state, and even if you consider that destructive it is
destructive of your own data , push on the other hand *is* potentially
destructive, and destructive of data on a remote system.

Lastly I have never really encountered any confusion with explaining
the default behaviour of git-fetch, nor actually git-pull, but I have
encountered lots of confusion of people using git-push.  They expect
git-push to be the opposite of git-pull not git-fetch.

Yves

-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
