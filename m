From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: PEBKAC or bug: unable to create path-like branch names
Date: Sat, 14 Nov 2009 21:36:47 -0800
Message-ID: <8c9a060911142136s68a08892ifa27989f3a5bfdfb@mail.gmail.com>
References: <20091115020605.GE15966@cl.cam.ac.uk> <20091115050227.GD5934@penguin.codegnome.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 15 06:37:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9Xnn-00035o-4n
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 06:37:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbZKOFhD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Nov 2009 00:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751547AbZKOFhC
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 00:37:02 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:58823 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbZKOFhB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Nov 2009 00:37:01 -0500
Received: by pwi3 with SMTP id 3so2708478pwi.21
        for <git@vger.kernel.org>; Sat, 14 Nov 2009 21:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=qLQwp76biXDn5+JPWn3rwY3yvR4hr4wUrEvZ0L787wQ=;
        b=dz9aLSfJYFUdcrvSnzOzTzZMEYP+Tsoyj+KcLA1F/5zKX/NhkzKQ9sSzA9XFN7VkKW
         W0AxIxEDKJQ7P03wq79xiLySRZV7IpqIKleHqvEtEkgP5WYJHbGDGJ9APl/lkRG8deZZ
         OzQkkEN+59O6oMsXVSyjg5xT7VVMcicJx97tM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=hPdmE+AjspP6JHbMGoo6ln7MIqPKEFC7IoADrZnAK7Mrh77oJI1vGLxW6xAyS85BVj
         72Yv8aLKidAIOp0zunFz3To+EPAEDVW/gwkT/e3ZNdt7s0DTxEd4jlk1Ncp+Pr2KlIFr
         7bcIQBZEMfpixamBcCPAJeDHpNjeMMLKMl+Lg=
Received: by 10.140.143.19 with SMTP id q19mr356719rvd.17.1258263427074; Sat, 
	14 Nov 2009 21:37:07 -0800 (PST)
In-Reply-To: <20091115050227.GD5934@penguin.codegnome.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132910>

On Sat, Nov 14, 2009 at 21:02, Todd A. Jacobs <nospam@codegnome.org> wr=
ote:
> I want to create a nested feature branch, but git keeps complaining i=
f I
> nest more than one level deep:
>
> =C2=A0 =C2=A0$ git checkout -b dev/feature/foo
> =C2=A0 =C2=A0error: unable to resolve reference refs/heads/dev/featur=
e/foo:
> =C2=A0 =C2=A0Not a directory
> =C2=A0 =C2=A0fatal: Failed to lock ref for update: Not a directory
>
> Based on my reading of the manual pages, it seems like I should be ab=
le
> to nest branch names as long as it conforms to certain rules. I read
> git-branch(1), which points me to git-check-ref-format(1), which seem=
s
> to say that the rules are being followed.
>
> On the other hand, running:
>
> =C2=A0 =C2=A0$ git check-ref-format foo; echo $?
>
> always results in a non-zero error code, even with a literal 'foo' as=
 a
> branch name, so clearly it isn't saying what I think it's saying.
> *shrug*
>
> Can someone provide a little clarity here?
>
> --
> "Oh, look: rocks!"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0-- Doctor Who, "Destiny of the Daleks"
>

What version of git are you using?  git checkout -b foo/bar/baz works
for me on 1.6.5.2.  As far as git check-ref-format, it works (returns
0) if I do 'refs/heads/foo', but returns 1 on 'foo'.  This makes
sense, given rule 2 from the manpage: They must contain at least one
/. This enforces the presence of a category like heads/, tags/ etc.
but the actual names are not restricted.

Hope this helps.

-Jacob
