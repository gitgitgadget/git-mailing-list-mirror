From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC PATCH 01/15] README-sparse-clone: Add a basic writeup of my
 ideas for sparse clones
Date: Sun, 5 Sep 2010 13:01:06 +1000
Message-ID: <AANLkTikx89M+JcOcabU3TazGB=k8x39QLbVe7sH7Vvaa@mail.gmail.com>
References: <1283645647-1891-1-git-send-email-newren@gmail.com>
	<1283645647-1891-2-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 05:01:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os5Tz-00050d-DV
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 05:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091Ab0IEDBJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Sep 2010 23:01:09 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46008 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772Ab0IEDBI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Sep 2010 23:01:08 -0400
Received: by wwj40 with SMTP id 40so4755185wwj.1
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 20:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fnMMybkeXwvm7k7YgzwCgH3vEOIsPTybLObrnK1NRGg=;
        b=mI+vSs43nrrLMOXZGWeWa8umm/ONJEDjDeWfQDcRG5G4h7bG1QHRz/rPwxmId+BpBS
         6eXyOOylRIqZZV7SBC95z2kRfCLCL8r7m4oLzHwXlnIx84ly14RwR13W1gaBbCKaN6Ta
         e4heTrWL3fDZU5y9DZ6XefINqyHgShi8emQro=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GAs+YHByK+NNlPQXfEBraP8/5zvPBdReuWPI2KdVDEi92DIahitL9xww4fLo8x08I6
         2DbYPcQBL2Cv310ofIqx+d5Em7QuU82f6OlppytqnEg7Eo62Gvy/wH/cpBGRzSYK8XGt
         vR6d6SIdNj6D9XMJVG5ZLdMcjQb+nxtmXVnDc=
Received: by 10.216.38.84 with SMTP id z62mr1686663wea.70.1283655666871; Sat,
 04 Sep 2010 20:01:06 -0700 (PDT)
Received: by 10.216.184.17 with HTTP; Sat, 4 Sep 2010 20:01:06 -0700 (PDT)
In-Reply-To: <1283645647-1891-2-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155413>

On Sun, Sep 5, 2010 at 10:13 AM, Elijah Newren <newren@gmail.com> wrote=
:
> +To ensure minimum necessary connectivity, we also download basic
> +information from otherwise excluded commits
> + =C2=A0* parents of these commits
> + =C2=A0* trees matching the specified sparse path(s)
> +but, for security and space reasons, do not download
> + =C2=A0* author
> + =C2=A0* author date
> + =C2=A0* committer
> + =C2=A0* committer date
> + =C2=A0* log message
> +Such commits are still considered "missing" (see item I4 for more
> +details about how we handle "missing" commits).

Just an observation. When I ran pack-objects with irrelevant commits
removed (i.e. try_to_simplify_commit) on Documentation/, I got a 6MB
pack. When I ran it without commit simplification, I got 16MB pack.
That's 10MB larger.

Now I don't how much of that 10MB share is commit messages, authors,
committers and trees but I suspect trees take a large part in it.
Maybe you can just fake the trees in those fake commits as well, to
avoid downloading more trees.
--=20
Duy
