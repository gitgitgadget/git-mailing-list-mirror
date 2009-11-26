From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] format-patch: fix dashdash usage
Date: Fri, 27 Nov 2009 00:14:29 +0200
Message-ID: <94a0d4530911261414o533aa108l202d4c6926da361e@mail.gmail.com>
References: <1259262720-24077-1-git-send-email-felipe.contreras@gmail.com>
	 <1259262720-24077-2-git-send-email-felipe.contreras@gmail.com>
	 <7vd4355aaw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 23:14:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDmbs-0002wD-NH
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 23:14:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752290AbZKZWOY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Nov 2009 17:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752069AbZKZWOY
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 17:14:24 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:62398 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350AbZKZWOX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Nov 2009 17:14:23 -0500
Received: by iwn1 with SMTP id 1so651365iwn.33
        for <git@vger.kernel.org>; Thu, 26 Nov 2009 14:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8qt+OeLUL6sTWWpz8CfDNNpAJ9Ia0Cw0QhIPFdQXSt4=;
        b=DayPKpuVwmYDEsdlcnl8mS2lCGD/VXsdFyEfPQnH9Z14iuIOjvleJpm2AQSa32hvrI
         OWelKSDxhQLGPxuTcjiT28VtJzQp8KGGGlHVCN8Bsg1S19heZKARy9pzIM5oJ8OI6Djd
         qka0QZ2GBnpvs7lrJZlG3M23CbvSaNPEzXc/k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Kc9e4xYEL4iv9ivMtJ15cegACJEyJqTWw2XsbO50L1/cGuOzsn80r5LXTauRDSg1XB
         +Ol5LrBYZHFh+Ben4jrY+gEALeBsd28doSN+RmnEZ5qbNZUaRsbXAIc5tlWLrK2Fx0Jg
         FBVto1Lvto5oczgO6cCL0ZxtJGXH2qET0YMPA=
Received: by 10.231.122.103 with SMTP id k39mr607195ibr.10.1259273669583; Thu, 
	26 Nov 2009 14:14:29 -0800 (PST)
In-Reply-To: <7vd4355aaw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133844>

On Thu, Nov 26, 2009 at 9:57 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Otherwise 'git format-patch <committish> -- <non-existent-path>' doe=
sn't
>> work.
>
> Instead of "doesn't work", I really wished you wrote something like:
>
> =C2=A0 =C2=A0$ git format-patch <commit> -- <path>
>
> =C2=A0 =C2=A0complains that <path> does not exist in the current work=
 tree and the
> =C2=A0 =C2=A0user needs to explicitly specify "--", even though the u=
ser _did_ give
> =C2=A0 =C2=A0a "--". =C2=A0This is because it incorrectly removes "--=
" from the command
> =C2=A0 =C2=A0line arguments that is later passed to setup_revisions()=
=2E

Complaining is one thing... failing to do anything is another.

> Remember that you are trying to help somebody who has to write Releas=
e
> Notes out of "git log" output.
>
> I actually have a bigger question, though. =C2=A0Does it even make se=
nse to
> allow pathspecs to format-patch? =C2=A0We sure are currently loose an=
d take
> them, but I doubt it is by design.

Not everyone has clean branches only with pertinent patches.

I stumbled upon this trying to re-create (cleanly) a "branch" that was
constantly merged into another "master" branch that had a lot more
stuff. Maybe there was a smarter way to do that with 'git rebase', but
that doesn't mean format-patch -- <path> shouldn't work.

> The patch itself looks good and is a candidate 'maint' material, if t=
he
> answer to the above question is a convincing "yes, because ...".

Yeah, I also think this should go into 'maint'.

--=20
=46elipe Contreras
