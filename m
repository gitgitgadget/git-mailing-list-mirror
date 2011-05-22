From: David Aguilar <davvid@gmail.com>
Subject: Re: git difftool does does not respect current working directory
Date: Sat, 21 May 2011 23:14:48 -0700
Message-ID: <20110522061446.GA49297@gmail.com>
References: <loom.20110514T160931-46@post.gmane.org>
 <7v1uzznr09.fsf@alter.siamese.dyndns.org>
 <20110520035856.GA13582@gmail.com>
 <20110520041045.GB13582@gmail.com>
 <7vwrhm3scl.fsf@alter.siamese.dyndns.org>
 <20110520044851.GD13582@gmail.com>
 <4DD7874A.2050604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?RnLDqWTDqXJpYw==?= Heitzmann 
	<frederic.heitzmann@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 22 08:15:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QO1wX-0002Wl-Vi
	for gcvg-git-2@lo.gmane.org; Sun, 22 May 2011 08:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329Ab1EVGO6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 May 2011 02:14:58 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:38546 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285Ab1EVGO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2011 02:14:57 -0400
Received: by pwi15 with SMTP id 15so2252087pwi.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 23:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=R8DmxOG0rcAPUVAYIfcfX384TZ49lxOhYQ/d4EcC+sc=;
        b=f95gvqIlBE0lLM/ojc8onpw6yw/e4QlMCKTwIOx9xLRRzrnngI1N70i1MgkBbbOABy
         ldQwGRD9wX1E1l8RLV4o7NUQBrxcop1u5KVwAaRSLiQShLaVJelhJP0VOmsHjs0MZDbE
         wrCK+vp86jTwNNZ61i0XoojhErkJ5BlN0kcd0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=nnIoy/Mrl7JLnebytg0ayBc0/Q+TQoDim/mxK9Zyy5MHGq1NBsJjqPKwFu/nZw0myW
         5WpSFsnKiiKlFcRCubippFpJ4vorpV/2OJy317/31sZgJ9MZyAFfr+S7CJcimiEa52uI
         Sb5XfqFYxZQrtCSmy/KQVK2I0RURtZHIDnJU0=
Received: by 10.68.22.130 with SMTP id d2mr1662145pbf.248.1306044896889;
        Sat, 21 May 2011 23:14:56 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id l9sm3544920pbc.14.2011.05.21.23.14.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 21 May 2011 23:14:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4DD7874A.2050604@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174181>

On Sat, May 21, 2011 at 11:35:06AM +0200, Fr=C3=A9d=C3=A9ric Heitzmann =
wrote:
> Reading your replies, my understanding is :
> - difftool is consistent with diff, and chdir to root directory. It
> is seems indeed very common to have diffs showing from the root
> directory.
> - on the overhand, openning gvimdiff via difftool and having a new
> cwd is for sure not consistent with usual gvim text editing.
>=20
> I am afraid I am going to need some gvim trick like :
> $ git difftool -x "gvimdiff -f -d -c 'wincmd l' -c 'cd $PWD' " my_fil=
e
>=20
> Not sure that it is less messy though ;-)
> If there is no stronger need to adapt git-difftool, for gvimdiff or
> any other difftool, we could probably settle for it.

I think updating git-difftool--helper.sh to pass a chdir to vim
might be just the thing to do.  git-difftool.perl can be
updated to set $GIT_DIFFTOOL_PWD so that the helper can use it
as -c 'cd $GIT_DIFFTOOL_PWD'.  I'll see if I can whip up a patch
in a lil bit.
--=20
					David
