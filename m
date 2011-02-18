From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC/PATCH 0/3] Thinning the git toplevel directory
Date: Fri, 18 Feb 2011 19:33:27 +0700
Message-ID: <AANLkTikj_JsxZ2p1uGyNxhTqznrTow2YyFEBvggTzFqV@mail.gmail.com>
References: <7vmxm4onwk.fsf@alter.siamese.dyndns.org> <1297304069-14764-1-git-send-email-pclouds@gmail.com>
 <20110218022701.GA23435@elie> <AANLkTik8wUrUnjTiUxUZbg3paaQEc7UERQ6J6jUzA2u5@mail.gmail.com>
 <20110218092518.GB30648@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 13:34:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqPX9-0001Yi-Sh
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 13:34:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754445Ab1BRMeA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Feb 2011 07:34:00 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39339 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775Ab1BRMd6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Feb 2011 07:33:58 -0500
Received: by wwa36 with SMTP id 36so3687335wwa.1
        for <git@vger.kernel.org>; Fri, 18 Feb 2011 04:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=lV+klrmxLtAgPZ2MbejJKkXC7Nb9pdCKodIKya/skUY=;
        b=dSgZU9y7JyAEFJ592drqQo9ulV7LUg5mxdpPTP12BQoB2JcoYZfAG8dkG4RJPQcPpQ
         bDdzj7cViryyrIrS5L0VirLdODgiPt0MbLnOU+E9IDt1eOWDAq9s+mYsE+4OqOdlUQPu
         8oo59psACdNjVB+Mn29ARqLX6MPz7abPEcC0c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Ep5+vPVFK0DwaJhAxM0UVrIh6np6DVl/XoBneKJJUTmKS3XKoADvdSfHqdF7zs/6SV
         W0zB4IJBEv3zZooHVeWQVn1a2l6OLefZ1SqOhItKNx3voWO0jM8PxgzlZq+Mc5Yzq7I6
         aWhz8o5EezzsGTFcWBXaO9FdLFfD5JL/1gbGQ=
Received: by 10.216.163.69 with SMTP id z47mr548119wek.43.1298032437143; Fri,
 18 Feb 2011 04:33:57 -0800 (PST)
Received: by 10.216.66.144 with HTTP; Fri, 18 Feb 2011 04:33:27 -0800 (PST)
In-Reply-To: <20110218092518.GB30648@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167201>

On Fri, Feb 18, 2011 at 4:25 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Changes since the series sent to the list:
> ...
> =C2=A0- renamed nonbuiltin/ to commands/. =C2=A0Names like
> =C2=A0 commands/add--interactive.perl even seem to make a kind of sen=
se.

I suggest cmds/ to avoid tab-completion conflict with compat.

> =C2=A0- moved the http support mini-library to http/.

Move them to commands/ as well?

> =C2=A0- renamed git_remote_helpers to python/, though I'm not very ha=
ppy
> =C2=A0 about that.

It don't like having "perl" and "python" directories (makes me thing
what if another language appears). If they are just bindings (python
dir may not be), how about "bindings" directory and throw them all
flat in there?

> This is all very off-the-cuff. =C2=A0I'd be happy for others to pick =
this
> up and remold it to their taste (after all, I'm too used to the
> current layout to remember what matters). =C2=A0It doesn't feel cooke=
d yet.

A few more things:

 - I like the fact that you leave only git.c in topdir. Straight entry
point for newcomers.
 - On the same topic of newcomers, should we pull
Documentation/technical out to topdir? A symlink is OK.
 - test-programs should be still in t/ though. I'm not an advocate for
deep layout, but it makes sense to me to keep test programs close to
test scripts.
 - perhaps we can merge block-sha1 and ppc into one? We can rename
ppc/sha1.* to sha1/ppc-sha1.*
 - I agree with Jeff that generated files should stay in the same
place with source files. Although I tend to use "git ls", untracked
files do not bother me much ;-)
--=20
Duy
