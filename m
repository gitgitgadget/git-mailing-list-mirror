From: Chris Packham <judge.packham@gmail.com>
Subject: Re: failed to push
Date: Mon, 1 Mar 2010 13:42:49 -0800
Message-ID: <a038bef51003011342j3d761d0cmd96d8641f96ed15@mail.gmail.com>
References: <4B8C2E68.3020507@gnu.org> <4B8C303E.7050605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT <git@vger.kernel.org>, bkorb@gnu.org
To: Bruce Korb <bruce.korb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 01 22:43:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmDOM-0006ml-3w
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 22:43:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581Ab0CAVmv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Mar 2010 16:42:51 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:52144 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561Ab0CAVmt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Mar 2010 16:42:49 -0500
Received: by pva4 with SMTP id 4so649122pva.19
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 13:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3/2DB6OKo85Tv1DuSJ88zC/isfsCXQ9N30LRhG8LzN0=;
        b=o6uhqsXDKOj85bMXzoyFR7Y7VIXHtnq/Uouqm1jUFrrSQsRm5r+2rBLujXWP4yfcdn
         fQjP7a5JmhQTwJaZhEIkXZohhfl0LHxO/cpwvOjRCQR0bvrTgjTZVdfEITzisnajCdYI
         LAQyc8Bjd0eg2bkqtl0bEc6Lc1KPKsE82gq1A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TwMdR4uJ+hEDQcfwOOwnJtAcwBdAZelv2MVASbcV0j3GguWA46LQPMS/iongLLDxtF
         BWqJht4aQUz6uy6XIdJAei4xKx3rjK2H6BltDRRZELN0h3DdDXVXVYml09QSoMSF1OFH
         PN8cTdleQajPWHEbVPAd1EHrj0mDPEVNXGec4=
Received: by 10.114.162.40 with SMTP id k40mr2901574wae.99.1267479769439; Mon, 
	01 Mar 2010 13:42:49 -0800 (PST)
In-Reply-To: <4B8C303E.7050605@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141354>

Hi,

On Mon, Mar 1, 2010 at 1:23 PM, Bruce Korb <bruce.korb@gmail.com> wrote=
:
> Bruce Korb wrote:
>> Hi,
>>
>> This message has no meaning at all. =C2=A0I know it failed to push.
>> I can tell from the comment "[rejected]". =C2=A0It would be nice
>> to know *WHY* it was rejected so I can fix the problem.
>> How do I determine the cause, please? =C2=A0Thank you!! =C2=A0Regard=
s, Bruce
>>
>> $ git push
>> To ssh://bkorb@autogen.git.sourceforge.net/gitroot/autogen/autogen
>> =C2=A0! [rejected] =C2=A0 =C2=A0 =C2=A0 =C2=A0master -> master (non-=
fast forward)
>> error: failed to push some refs to 'ssh://bkorb@autogen.git.sourcefo=
rge.net/gitroot/autogen/autogen'
>>

This basically means that the push you have attempted is not a simple
fast forward. This basically means that the commit your work is based
on is not present in the remote or that there have been other pushes
to the remote and you need to pull them into your repository to handle
any merging.

>
> A little follow up context:
>
> I used the "git gui citool". =C2=A0I saw a button to allow an amendme=
nt to a
> previous checkin. =C2=A0That seemed most appropriate, so I did that. =
=C2=A0I had
> previously pushed the commit to the sourceforge repository, so my gue=
ss
> was that pushing would amend the checkin at sourceforge, too. =C2=A0N=
ope.
> Won't let me push. =C2=A0Won't tell me why, either. =C2=A0Now what? =C2=
=A0Thanks.
> --

OK that kind of sheds some light. I take it you've just switch from a
centralized VCS?

In a DVCS like git all commits happen locally, the only time commits
are sent to the remote repo are when you've pushed so 'git commit
--amend' or 'git gui' with the amend box ticked only makes the change
locally it won't implicitly figure out that a commit has been pushed
out into the ether. One rule of thumb with git (I think it applies to
most DVCSes) is not to amend a commit that has been pushed for this
very reason. Strictly speaking all commits are immutable, when you
amend a commit you actually create a whole new commit and your old one
is marked for garbage collection (if nothing else is based off it).

In terms of recovering from your present situation I'd try the
following (Disclaimer: maybe you shouldn't try these based solely on
my advice. I'm still learning too)

  git pull
  <resolve merge issue, 'git mergetool' is your friend>
  git push

  I think this will basically sort things out but you may need to hand
hold a few things through a merge depending on how different the 2
commits are.

 - or -

  git push -f

  If you're the only one using that repository its probably fine but
this could cause problems for others if they've cloned the repo before
your amended commit.
