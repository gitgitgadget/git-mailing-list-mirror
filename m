From: Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH 2/2] gitweb: introduce localtime feature
Date: Thu, 17 Mar 2011 13:12:39 -0700
Message-ID: <AANLkTi=+aAeV4mx4YTHw4rWZahLS0tnjXsDLEgoAj9-o@mail.gmail.com>
References: <3ef1af6874437043a4451bfbcae59b2b@localhost>
	<e272fa98ecab9d30edb4457e2e215688@localhost>
	<m3d3lq57vw.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 21:13:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0JZ9-0008MT-Oh
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 21:13:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754991Ab1CQUM7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Mar 2011 16:12:59 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33641 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752955Ab1CQUM6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Mar 2011 16:12:58 -0400
Received: by fxm17 with SMTP id 17so3072467fxm.19
        for <git@vger.kernel.org>; Thu, 17 Mar 2011 13:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=s8o6xA37XG0oKrlFGT30kraQV61gVUBdTQRlnRVbCWM=;
        b=FN8cl1oFEKyABwFRveYQBTHUFF9ETJCXb/CkS8wT3oxCzWerv8gePdJ6SM4OQqnhLy
         MnUqxXEo9GsS7LBG0lMvJyZIOfG+nM3jHsLyW8bX1IM1edmBPUfSvC0WJY11Y5QG87GK
         6SjV/E/OEUJf7EyC4c7GeclpeZ37ITXeM2otY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bz7Ni22+O7NTMcGWMbpYjELdJwxPVAhm9wKhnJhwyPdGLxSGDr+a+TVFMRSK4plEX1
         +6JTtpoh+WDRJzl3dL/CYwwMYUysx3eYUqt3LEQGWLnKRTcs3a9beY7tv8f9sBGi571T
         YFff/qYGrpMqnl0uezNFozacTP0utl70AtXeQ=
Received: by 10.223.67.210 with SMTP id s18mr246177fai.41.1300392759410; Thu,
 17 Mar 2011 13:12:39 -0700 (PDT)
Received: by 10.223.61.83 with HTTP; Thu, 17 Mar 2011 13:12:39 -0700 (PDT)
In-Reply-To: <m3d3lq57vw.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169273>

On Thu, Mar 17, 2011 at 4:01 AM, Jakub Narebski <jnareb@gmail.com> wrot=
e:

Jakub,

Thanks for all of your constructive feedback.  I have taken your
suggestions into account and posted an updated series of patches.

> This does not describe why would one want such way of displaying
> timestamps, and which views would be affected.
>
> BTW. should it be timezone of web server (machine where gitweb is
> run), or local time of author / committer / tagger as described in th=
e
> timezone part of git timestamp?

The case I am currently trying to improve is the one in which all
developers are at a single site.

In the open source world it is common to have developers scattered all
over the globe, so some of them will inevitably have to perform
timezone conversions.

But Git is becoming a popular tool in the private sector and it is
common to have most/all contributors based in a single office.  In the
latter case, it is helpful to display the local timezone instead of
GMT.  This also helps make the data more readable by program managers
and other non-developers who have an interest in tracking the project.

> Why project specific override is not supported? =C2=A0I think it migh=
t make
> sense to enable this feature on project-by-project basis; some
> projects might be dispersed geographically, some might not.

Mostly ease of testing.  I did not need it for any of my projects.

It turned out to be a simple change, and it is in v2.  The cases I test=
ed were:

default 0
default 1
override 1, project unset
override 1, project 0
override 1, project 1

> Is it still an RFC 2822 conformant date? =C2=A0If it is not, then abo=
ve
> change is invalid, and we have to implement this feature in different
> way.

I believe it is still valid.

Original date: Thu, 17 Mar 2011 02:11:05 +0000
New date: Wed, 16 Mar 2011 19:11:05 -0700
Sample date from RFC 2822 Appendix A: Fri, 21 Nov 1997 09:55:06 -0600

> Hmmm... I wonder if it wouldn't be better to print both times (perhap=
s
> reversed) in this case...

I have submitted a third patch which does this.
