From: Elijah Newren <newren@gmail.com>
Subject: Re: How do I show only log messages for commits on a specific branch?
Date: Wed, 16 Dec 2009 11:05:52 -0700
Message-ID: <51419b2c0912161005n1596d4a1n92ed555c98aee4c6@mail.gmail.com>
References: <20091216101647.GB27373@bc-bd.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: bd@bc-bd.org
X-From: git-owner@vger.kernel.org Wed Dec 16 19:06:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKyGJ-0003TI-Ef
	for gcvg-git-2@lo.gmane.org; Wed, 16 Dec 2009 19:06:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762689AbZLPSFz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Dec 2009 13:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762678AbZLPSFy
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Dec 2009 13:05:54 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:60850 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762728AbZLPSFx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Dec 2009 13:05:53 -0500
Received: by pzk1 with SMTP id 1so874853pzk.33
        for <git@vger.kernel.org>; Wed, 16 Dec 2009 10:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2mOOsaMkCAV4z2alSJAUOs82Y6lsT6LAr/qUOYrLhO8=;
        b=SqpO2a4ZT3n7915H9GshJTYivkidXKr1tFTqxUHvdGCc3ueD6kgSIiOdvbXztJ8MnN
         xOYnPyNDOapvBaC+09dMzvkC6cY0ztJvhAnp/G7zzdSXT655SSHxax9YdBWUCVhkWTfZ
         V+wJbOvsoVvDGAw5Hc9nxQ/OwkBuuAPpwc8CQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vMnMk3yG+HerLt2//8Jsnn/Om7qCtSJm4WgGkMFotXzUkURL/C9DsfypcrsX0f8L63
         KvW2R3HBZQCfGJEXVXc2KYBIWtc9RRDzrW5lb43tvBvZmZEC0o4vtlvAAb7T2qyFieuy
         gc8W0RAPMV5epTk5OQdGsQjmwMnYKosI/d96U=
Received: by 10.115.113.6 with SMTP id q6mr912174wam.55.1260986752764; Wed, 16 
	Dec 2009 10:05:52 -0800 (PST)
In-Reply-To: <20091216101647.GB27373@bc-bd.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135336>

On Wed, Dec 16, 2009 at 3:16 AM,  <bd@bc-bd.org> wrote:
> imagine this:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --A--*--B (new)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/
> =C2=A0 =C2=A0 =C2=A0 =C2=A0*--X--*--Y (master)
>
> Now I'd like to list only log messages for A..B (X..B would be okay t=
oo).
>
> I know of
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git log master..new
>
> however then I need to remember that I branched new of master, and to=
 be honest,
> sometimes I forget.
>
> So how do I:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git please-tell-me-the-branch-I-started-th=
is-branch-from new

In the above example, you technically did not create 'new' off of
'master', you created new starting at X.  You may think of it in terms
of branching off of 'master', but
  git branch new master
resolves 'master' to the commit it points at and creates 'new'
pointing at that commit.  That's all that is recorded.  But I believe
the info you are really interested in is where new started, rather
than the fact that it branched off master.  Is that correct?  If so,
just use new@{30.years.ago} (or any other sufficiently long period of
time):
  git log new@{30.years.ago}..new
(You'll get a warning that 'new' hasn't existed for 30 years but it
doesn't hurt anything)

Hope that helps,
Elijah
