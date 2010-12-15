From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH] branch: do not attempt to track HEAD implicitly
Date: Tue, 14 Dec 2010 19:50:44 -0500
Message-ID: <AANLkTi=PPx-pLEeR4gLw0KzV_=ZnuqqH_CGc6L7RzU7M@mail.gmail.com>
References: <6ee1f0174b757e25ab873d2d037545ac7db698ee.1292351886.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Dec 15 01:50:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSfZz-0008A0-No
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 01:50:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760298Ab0LOAuq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Dec 2010 19:50:46 -0500
Received: from mail-ew0-f45.google.com ([209.85.215.45]:55971 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760269Ab0LOAup convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Dec 2010 19:50:45 -0500
Received: by ewy10 with SMTP id 10so837210ewy.4
        for <git@vger.kernel.org>; Tue, 14 Dec 2010 16:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aroFZnV27leMGyZxilwF0y+DFjXHhtEKRw2oVt4x2wY=;
        b=tslAdH9sVfs5UbWcvVpJntpqB0T31QEFNcOpJB4nXmjM1YLKeGQfBuOcaMe5O9+hgp
         d6vSNt6a3dsTPjZsBfFIQgrmNH5J6iKbyzOA/FOSEf8P8mC6B5vadUkdId9zs8nGMwzr
         Lq3Tu1jOT7yFtCk7P0E/pe3V8/qd/Xd7GAYJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qNjsDVr/Rnjvpe6M+yFJoJ7/vbjK16X5TFtKSB9NXAoGjni7lWtKR0jnZDqWRT7HhB
         +zov4/skdzinii5r5AbxCHJOkxtaXCybF3opzzLvC9Xp2jbpjZ0mcPqxwyRBBYIWR296
         wC+H+GV4AtlimsHtiTpm0vLgqbrms05oJlqF0=
Received: by 10.14.11.226 with SMTP id 74mr1002232eex.5.1292374244477; Tue, 14
 Dec 2010 16:50:44 -0800 (PST)
Received: by 10.14.124.197 with HTTP; Tue, 14 Dec 2010 16:50:44 -0800 (PST)
In-Reply-To: <6ee1f0174b757e25ab873d2d037545ac7db698ee.1292351886.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163726>

On Tue, Dec 14, 2010 at 1:38 PM, Thomas Rast <trast@student.ethz.ch> wr=
ote:
> With branch.autosetupmerge=3Dalways, 'HEAD' becomes a valid target fo=
r
> branch tracking. =C2=A0This is a bit silly, and in fact the code alre=
ady
> guards against it when attempting it explicitly:
>
> =C2=A0$ git checkout HEAD^0
> =C2=A0$ g branch -t foo

missing the "it" in "git"

> =C2=A0fatal: Cannot setup tracking information; starting point is not=
 a branch.
>
> Silently drop the HEAD candidate in the implicit (i.e. without -t
> flag) case, so that the branch starts out without an upstream.

Thanks. This has been on my todo list for a while.

Should it only check for HEAD? How about ORIG_HEAD and FETCH_HEAD?
Simply anything outside of refs/ maybe? Would that make sense?

/Martin
