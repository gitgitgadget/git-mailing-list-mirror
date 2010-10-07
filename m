From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] fast-import: Allow filemodify to set the root
Date: Thu, 7 Oct 2010 15:58:02 +0200
Message-ID: <AANLkTikjzQ09XBxYZXXQf6XCme3FiLKtusZ0MLTa--mM@mail.gmail.com>
References: <1286448906-1424-1-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 15:58:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3qzO-0006hr-4S
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 15:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932599Ab0JGN6Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Oct 2010 09:58:25 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:52829 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760653Ab0JGN6Y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Oct 2010 09:58:24 -0400
Received: by gxk9 with SMTP id 9so296831gxk.19
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 06:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Qm+YJEWXmEAY1Gxs6VnHK8COg0NjZq7yo29h4o8x8+Y=;
        b=DDowje4iTNZeFwLwHuNl62mVwhyDgFm+OdVp2PwKFKH7SN3UNmgiefzk1lCeeUI5yB
         RlW9bk49DSA2GeP6w/MUnpfcqavPQxluDxhjpLglSwrHCoOZ7DSugVb/HsNHc4GJU5bQ
         5IXigO01rnrriqBIzq0YBbPPuDxqLoOXt0yug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=LhA7f8vSSJPDxXQjohWgdfY6x01EPVabQViVOaMInaYShuQBHSn4/qeuEihXzG0/Kt
         0s9Gk4rCYta/Hm4B2d0AnRMf8Q9Mqxv4JmdSyQHiwOoRoyCLlC4FrcdgUvbaTa4KFqWI
         I5dNrMJeB6ZKKmYJpQmbvZnDqlBTROVXVcPNM=
Received: by 10.151.85.14 with SMTP id n14mr1172050ybl.44.1286459902466; Thu,
 07 Oct 2010 06:58:22 -0700 (PDT)
Received: by 10.151.15.8 with HTTP; Thu, 7 Oct 2010 06:58:02 -0700 (PDT)
In-Reply-To: <1286448906-1424-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heya,

On Thu, Oct 7, 2010 at 12:55, David Barr <david.barr@cordelta.com> wrot=
e:
> Most git commands do their writing to the object db via the index and
> loose objects. =C2=A0When you just have a pile of trees you want to c=
onvert
> into commits, this is wasteful; for performance-critical operations
> like filter-branch --subdirectory-filter, one might want a sort of
> hash-object --batch-to-pack to write a pack directly.

This means nothing to me, but perhaps I'm not the target audience of
this paragraph.

> Fortunately we have fast-import (which is one of the only git command=
s
> that will write to a pack directly) but there is not an advertised wa=
y
> to tell fast-import to use a given tree for its commits.

I'm with you up to "use a given tree for its commits".

> This patch changes that, by allowing
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0M 040000 <tree id> ""
>
> as a filemodify line in a commit to reset to a particular tree withou=
t
> any need to unpack it. =C2=A0For example,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0M 040000 4b825dc642cb6eb9a060e54bf8d69288f=
bee4904 ""
>
> is a synonym for the deleteall command.

Ok, so maybe I do understand, is it basically 'git read-tree
4b825dc642cb6eb9a060e54bf8d69288fbee4904' for fast-import?

--=20
Cheers,

Sverre Rabbelier
