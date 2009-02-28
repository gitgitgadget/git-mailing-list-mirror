From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: git-svn, and which branch am I on?
Date: Sat, 28 Feb 2009 10:03:55 -0500
Message-ID: <eaa105840902280703w3dcc9b7fv9095ba874624dcca@mail.gmail.com>
References: <87ljrr7xof.fsf@rimspace.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Daniel Pittman <daniel@rimspace.net>
X-From: git-owner@vger.kernel.org Sat Feb 28 16:08:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdQnu-0001gA-2J
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 16:08:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbZB1PD7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Feb 2009 10:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbZB1PD7
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 10:03:59 -0500
Received: from an-out-0708.google.com ([209.85.132.243]:13583 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828AbZB1PD6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Feb 2009 10:03:58 -0500
Received: by an-out-0708.google.com with SMTP id c2so1217605anc.1
        for <git@vger.kernel.org>; Sat, 28 Feb 2009 07:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=acISuJGKowazWxeJG3w9ed9c08uebNokFvknu1pymlo=;
        b=r+RSz5E7DqiQDc0AYntZ1aCmnmsMkzOVHgqtPJLsxWShzVraWnh+PUek7qiiVcjRoh
         rFrlcG3dcMlqTdX/ZTWKbiuA/GbewQQy1ZuPIFUetmAAZt40aWQXFu8IJ9bEvCD856eE
         KpxakXrG9IsU/x0WnTJSmSQdsVSZuCnJEIXLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=OvoIO6YP2bQkkt9nYSStlhOhkxr28CIPS5Io77yKMQ2qx1/DORPbFlJo28BbH3T3//
         P3TwnX6NE5paLFGntdUnBotU7/KvwGz/tQKmipUVvxgr2KSvALtVNrvHwcd3mCcamAR5
         BJIuIrPSQXzVOGCJ+sWAdV7QMZAjOvOCUBrB0=
Received: by 10.220.81.1 with SMTP id v1mr1304481vck.6.1235833435973; Sat, 28 
	Feb 2009 07:03:55 -0800 (PST)
In-Reply-To: <87ljrr7xof.fsf@rimspace.net>
X-Google-Sender-Auth: 1e0ef8a1436d1554
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111769>

On Sat, Feb 28, 2009 at 3:50 AM, Daniel Pittman wrote:
>
> The general question was: in git, how do I identify where this branch
> came from?

> Specifically, this was about 'git svn', but also generally how to
> identify this information in git.

> ...and, finally, is the reason that I am finding it hard to explain t=
his
> because I have an expectation of how things work that doesn't match u=
p
> with git? =A0In other words, is the question actually meaningless?

You've hit the nail on the head. The question is meaningless. Git
tracks a DAG, and a branch is just that - a branch (or 'tip', if you
will) of the DAG.

Take, for example,

o--o--o--o master
 \
  o--o--o--o feature
      \
       o--o working

Which branch did 'working' come from? 'feature' or 'master'? Say I
later delete branch 'feature', since it was going in the wrong
direction. Does the answer change? What if I simply redraw the above
so that feature and working are swapped? Does the answer change? It's
still the same tree.

You can, however, answer related questions.

'git svn info' will tell you which branch a 'git svn dcommit' will
commit to, which is usually the question you actually wanted to
answer.

'git branch -r' will tell you which remote branch your local branch is
tracking. ie. which branch, if any, a plain 'git pull' will fetch and
merge from.

See also http://thread.gmane.org/gmane.comp.version-control.git/77730/f=
ocus=3D77823
and surrounding thread.

Peter Harris
