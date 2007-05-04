From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH] Support ent:relative_path
Date: Fri, 4 May 2007 11:23:21 -0700
Message-ID: <56b7f5510705041123h7fc1f95djbf7c2d75466b4193@mail.gmail.com>
References: <463ADE51.2030108@gmail.com>
	 <56b7f5510705040022x2e4903d3hbe4ac1ee1a2e096f@mail.gmail.com>
	 <7v7irpuhhr.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0705040147h1bab8f6ao3ce2c486637a0d4f@mail.gmail.com>
	 <463AFAAE.853DEF7B@eudaptics.com>
	 <7vabwktsng.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <J.Sixt@eudaptics.com>, git@vger.kernel.org,
	danahow@gmail.com, "Alex Riesen" <raa.lkml@gmail.com>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 04 20:23:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk2RF-0005eh-TT
	for gcvg-git@gmane.org; Fri, 04 May 2007 20:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161434AbXEDSXY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 14:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161368AbXEDSXY
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 14:23:24 -0400
Received: from nz-out-0506.google.com ([64.233.162.229]:48288 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161451AbXEDSXW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 14:23:22 -0400
Received: by nz-out-0506.google.com with SMTP id o1so948842nzf
        for <git@vger.kernel.org>; Fri, 04 May 2007 11:23:22 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pLxf4hSEEsptfg3Z0nNwR7atFBJw7UpwqWT8y2nNUEXbeaBJBYB75P91loTRWy//BzHdFrFuN6e+dPi0N/JmYzi1DlUslZHpyWMAdGWalmgvRu3z4IVcGHPiIKWWIm5BH0mw7VDMLwH39KIJ3G4rldlDiNyhBT9wx+LmUEzwo8c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GwmyyQYtsmH/FuChJlbUCgX/It2MGjQej0hmr9n72KfRvp4YJj2ub7G5D5kc8au9kZy8U22CQNhgCtRhG+c1zAOG46Cg/uyzOVwHbISOtrp3IqY97PAUbOQb1YclmPZekeS0QIKzG6j5A0kg773d9zZqYlyWEoR2yym7hBAtwH4=
Received: by 10.114.210.2 with SMTP id i2mr1227348wag.1178303001694;
        Fri, 04 May 2007 11:23:21 -0700 (PDT)
Received: by 10.115.58.7 with HTTP; Fri, 4 May 2007 11:23:21 -0700 (PDT)
In-Reply-To: <7vabwktsng.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46197>

On 5/4/07, Junio C Hamano <junkio@cox.net> wrote:
> Johannes Sixt <J.Sixt@eudaptics.com> writes:
>
> > Alex Riesen wrote:
> >> On 5/4/07, Junio C Hamano <junkio@cox.net> wrote:
> >> > My preference is (2), (3) and then (1), but I do not have
> >> > offhand a suggestion for a good metacharacter we could use.
> >>
> >> "./" :)
> >
> > +1, without the :)
> > and ../ should DWIM, too.
>
> I think these feel more or less natural (except that we do not
> say ":/fullpath" and instead say ":fullpath" which is
> unfortunate).
>
> In the hindsight, if we had the perfect vision into the future,
> we would have made <path> relative to where you are when we
> initially did "<something>:<path>", with obvious semantics for
> things like "<something>:../<path>" and "<something>:/<path>".
>
> We didn't.  Further, we made a mistake to make :/ to mean
> something completely unrelated.  My bad.
>
> So I think "./" is the best compromise in the meantime.
>
> With your suggestion, we can train people's fingers to type "./"
> now, and perhaps later in one of those big feature release like
> the 1.5.0 was, we could switch to "default to relative".
>
> At the same time of that big "UI correction", we could make
> "<something>:/<path>" to mean "full path in commit (or
> index/stage) no matter where I am".
>
> The current ":/<string>" is about going back, looking for the
> string, so it should not have used '/'; instead it should have
> been "<something>:?<string>".  Maybe we could fix it by start
> accepting ":?" now (in addition to ":/"), give a big fat warning
> about ":/" going to mean a different thing, and encouraging
> users to use the question-mark form, in preparation for the big
> "UI correction".
>
> Do people like that plan?
>
> (soon after 1.5.2)
>
>  - start accepting "<something>:./<path>" as "relative to where I am".
>
>  - start accepting "<something>:?<string>" as "look back to find
>    the string".
>
>  - clearly explain the plan and prepare the users.
>
> (a big release in the future, perhaps 1.6.0)
>
>  - "<something>:<path>" becomes relative to where you are.
>  - stop "<something>:/<string>" and start "<something>:/<fullpath>".

I will resubmit the patch following Junio's plan.
It will include the "1.6.0" features but disabled.

I would just request that we expedite,  if possible,
at least the later switch from "<something>:/<string>"
to "<something>:/<fullpath>",
since with the patch _and_ the latter behavior enabled,
scripts can be updated to always insert "./" or "/" and
their intent will always be clear.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
