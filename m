From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Tue, 23 Mar 2010 14:57:25 -0500
Message-ID: <20100323195724.GA1843@progeny.tock>
References: <81b0412b1003201335g7b37c51mfa3e2280210ebb7e@mail.gmail.com>
 <201003231222.40745.jnareb@gmail.com>
 <41f08ee11003230523h2c5f93b1l7e94d6c85a93a706@mail.gmail.com>
 <201003231449.42190.jnareb@gmail.com>
 <41f08ee11003230823i1ca677b8q51b2413040c45c44@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, gitzilla@gmail.com,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 23 20:57:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuAEL-0002Ps-Nt
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 20:57:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753651Ab0CWT5c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Mar 2010 15:57:32 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:54235 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753271Ab0CWT5c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 15:57:32 -0400
Received: by pva18 with SMTP id 18so203845pva.19
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 12:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=UOEfFghJXsXa/4+IysgFrpsqxcU+psMHKzCXKY9Nj3U=;
        b=IS+4/4uH8bOpWUQjNs1NZQsh1RThJrHE8lxv8Fan39YCgw31kIvnbF1Isp3qZxrAo5
         7NtJlPxPS8eGVXClGVsyK9Yq8Y4CCydAgi449FohW+acRG0mFd7iSgaiqFy033uvYCfh
         acHwhCAuthEVxBPizF1va/uuuWugs/AW7kisA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=W+JWOlhkjB6vg1GVaHPGCOTgB53frSFaexCBislIbYKrMGvelwdqUnvNsExzUI5gb1
         ccU9q7MNwlzMPhxkiNzISJoER0p4ctjbmlPugF9baJbCLzxR21AgE8BQvwXoJpd0qp+F
         2ccWQdUIkX/vJ/anT1ngfqBS0brhXd3/WzdkU=
Received: by 10.115.101.14 with SMTP id d14mr407871wam.176.1269374251437;
        Tue, 23 Mar 2010 12:57:31 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm5282768iwn.15.2010.03.23.12.57.29
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 23 Mar 2010 12:57:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <41f08ee11003230823i1ca677b8q51b2413040c45c44@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143045>

Bo Yang wrote:

> It traces the preimage of the minimum related diff hunk carefully, if
> there is any case that there are more than one commit intersect with
> the preimage, we will stop and ask the users to select which way to g=
o
> on tracing.

That might be necessary, but I will admit that I suspect it to be
harder to make useful.  One of the very nice things about =E2=80=98git =
log=E2=80=99 is
that it is easy to browse through history in a nonlinear way in a
pager (by using a pager=E2=80=99s search functionality).  The =E2=80=9C=
backend=E2=80=9D =E2=80=98git
rev-list=E2=80=99 is easy to write scripts with, also because of its si=
mple
input and output.

If your program requires input from the user, how will it paginate its
output?  Most pagers expect the standard input to be available for
input from the user.

One approach (I will not say it is a good one) to the problem of
ambiguous origins for a line is to blame _both_ parents.  That is,
start following both lines of history in your revision walking.
Perhaps higher-level tools like =E2=80=98git log --graph=E2=80=99 and g=
itk could
visually represent the branched history you are showing.

Another approach is to just choose one parent automatically: for
example, prefer the first parent, or assign some score representing
the relatedness of each parent and choose the most related one.

Jonathan
