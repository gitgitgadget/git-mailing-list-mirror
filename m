From: Christian Couder <christian.couder@gmail.com>
Subject: Re: git bisect problems/ideas
Date: Mon, 17 Jan 2011 10:38:05 +0100
Message-ID: <AANLkTikNzpCwEieV8sXXctMm+DR69fkLfCF+F3xB6b-k@mail.gmail.com>
References: <855249CA-A006-475C-8F96-EFD614795064@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Aaron S. Meurer" <asmeurer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 17 10:38:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PelXT-0001E4-B8
	for gcvg-git-2@lo.gmane.org; Mon, 17 Jan 2011 10:38:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752677Ab1AQJiK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Jan 2011 04:38:10 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58210 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886Ab1AQJiH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Jan 2011 04:38:07 -0500
Received: by wwa36 with SMTP id 36so5201676wwa.1
        for <git@vger.kernel.org>; Mon, 17 Jan 2011 01:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yMO976COoJVxrsCNRxgc37BOUn9P4CCF+kyRyiOonC8=;
        b=kG9dAU2A18RAdsf1ONid+vMd6/CWIBgZl6vNwqCTnfodyYk0n/hCTPM9eOh0IgnByG
         g1rTEvPa1dduuHcEfWSrR9HIdQXtWMgAnSpAHFn3lHhANt1QwO02gFHTqMrczv+fzd5D
         0Ogasd9+/3CgIY22lApHplV6Lslypquybe1/4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ktd9I3QoC/D1JOJVtOiveGgtAFEpojr2BUm0wWgTjqpIUCspGk5dtO2UlD6QKoS96q
         uvdmWgmyMwd//Ln7ggbBlo1d7ersyG4LrhhWZ2236zO0uthULifu+T/XZjB/syZI6g2R
         35VHwTn9qzPLqw7hw6eAQJH6IcXsggh7R1iEg=
Received: by 10.216.48.211 with SMTP id v61mr3098644web.35.1295257085552; Mon,
 17 Jan 2011 01:38:05 -0800 (PST)
Received: by 10.216.50.129 with HTTP; Mon, 17 Jan 2011 01:38:05 -0800 (PST)
In-Reply-To: <855249CA-A006-475C-8F96-EFD614795064@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165170>

Hi,

On Sat, Jan 15, 2011 at 8:33 AM, Aaron S. Meurer <asmeurer@gmail.com> w=
rote:
> First off, do you guys have an issue tracker?

No, we don't. We use the mailing list.

>=A0I asked on IRC, and someone told me that he didn't think you did, a=
nd to just post here. =A0After searching your websites, as far as I can=
 tell he was right, though this is amazing to me that you can handle a =
project like this without an issue tracker. =A0If you guys really do, t=
hen sorry. =A0I would rather post this there than here (though if you r=
eally do, please make it more findable!)
>
> I just noticed this error/bug:
>
> git checkout test
> git bisect start
> <do some bisecting>
> git branch -D test
> <finish bisecting>
> git bisect reset
>
> And it gives an error, because test has been deleted. =A0This is in 1=
=2E7.3.5. =A0Now, I looked through the log of the current master of git=
 to see if anything has been done about this, and all I noticed was the=
 commit 3bb8cf88247db5, which essentially improves the error message.
>
> Now, this is good, because it seemed to me above that I was stuck bis=
ecting until I recreated the test branch. =A0I did not realize the git =
bisect <commit> syntax until later.

You mean "git bisect reset <commit>".

> But this has brought me to bother you guys about something that has b=
een bugging me for a while. I hate git bisect reset. =A090% of the time=
 I do not want to go back to where I started bisecting. =A0I would much=
 prefer to just have a git bisect stop command, which just stops the bi=
secting process, but leaves me where I am (like a shortcut to git bisec=
t reset HEAD). =A0This would be much more symmetric with git bisect sta=
rt.

If more people want it, yeah, we can create such a shortcut. But you
can also use a git alias for that.

> While we are on the topic of bisecting, I have another issue. =A0Can =
we remove the restriction that a "bad" commit come after a "good" commi=
t? =A0I'd say about 70% of the time I use bisect to find a commit that =
fixes a bug, not breaks it. =A0Whenever this happens, I have to bend my=
 mind over backwards to remind myself that the good behavior is really =
"bad" and the bad behavior is really "good". =A0Is there a reason that =
git bisect can't just introspect from which comes earlier and which com=
es later to see which is "good" or "bad" (instead of just raising an er=
ror when they are in the "wrong" order)?

Yeah, many people find it difficult to reverse the meaning of "bad"
and "good" when looking for a fix. There were some suggestions at some
points to do something about it. Some of the suggestions were to use
some aliases for "good" and "bad", but there was no agreement. Other
suggestions had a patch attached but the patch was not good enough or
something.

Anyway, the restriction is that the "bad" commit cannot be an ancestor
of a "good" commit. But the "good" commits need not be all ancestors
of the "bad" commit. For example if you have a "master" branch and a
"dev" branch that was forked from the "master" branch at one point,
like that:

A-B-C-D-E <-- master
      \F-G <-- dev

you can use one of the branch as "bad" and the other one as "good".
And that means that in this case we cannot automatically reverse the
meaning of "good" and "bad".

So if we ever implement a "--reverse" mode, I think that the best we
could do if we detect that a "bad" commit is an ancestor of a "good"
commit is to suggest the use of this "--reverse" mode. Or we could ask
and use this mode if the answer is yes.

Best regards,
Christian.
