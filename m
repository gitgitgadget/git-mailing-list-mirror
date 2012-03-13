From: Shawn Pearce <spearce@spearce.org>
Subject: Re: CAC enabled authentication with git transfer protocols
Date: Mon, 12 Mar 2012 18:53:31 -0700
Message-ID: <CAJo=hJsshrJc0Onjph3LcQxEkXDSzEPp8TQetGoy9Rwz6OXRuw@mail.gmail.com>
References: <B1ECBDB2E23847488F70D870CBE563F70198D579@nawespscez06v.nadsuswe.nads.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Jones, Brian P CTR SPAWARSYSCEN-PACIFIC, 63600" 
	<brian.p.jones4.ctr@navy.mil>
X-From: git-owner@vger.kernel.org Tue Mar 13 02:53:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7Gw1-0004G3-Ua
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 02:53:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758386Ab2CMBxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 21:53:52 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:64284 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758248Ab2CMBxv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Mar 2012 21:53:51 -0400
Received: by dajr28 with SMTP id r28so66625daj.19
        for <git@vger.kernel.org>; Mon, 12 Mar 2012 18:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=4JSkhRiGzoVGPTb5OZUrz7HVJj7Aw0s7w9aEDfxa/JA=;
        b=YmElwgmg9MUlISI2PPFEgGySSl+voNjFmihMyjxd0oy6RSFoLQj/iMGouXVxLWrZy+
         UDZo6xcf9Wjyqrabt6lVLzW1nZJO+2YgDniarX6XFaLD2fL6tyb7vcBjhP3GoOAxdsSV
         Q9o8aCSaXAw1OBz/Alr9+LHGABsAtllAt0Y+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=4JSkhRiGzoVGPTb5OZUrz7HVJj7Aw0s7w9aEDfxa/JA=;
        b=Hh2x6FZ0vzcXTdLP5oNh/Lhjj8dyM467aMuxDbFGmoPtOpPs43cu1kOpeGz6D59P/a
         NiSa31z0z9Fl5VWfHnLt9rG2rEto2t4KgdKh86mgFLSicBB3YVOPGMnmbVaS9ZnjKoGU
         lWFik7eE4gluvf/pZOgRHO3Nxb0CrkPm4y9L4Uk54GqYA/zNwaL41P3bhiCTYpCqury8
         f1DfVKEG1cIrp+stiA/aa6sN6WR/gBo6EyBOK1yV/ySdFCj3gXkcutgtcSoKQ9Y+9gJM
         7aTtrr+JrTmEVM5xglmRmg70ix9+L6ANlMmbeHC4v0I297+GWUzwkq2dlnh+6u56v4og
         l//A==
Received: by 10.68.226.225 with SMTP id rv1mr1010329pbc.44.1331603631066; Mon,
 12 Mar 2012 18:53:51 -0700 (PDT)
Received: by 10.68.21.132 with HTTP; Mon, 12 Mar 2012 18:53:31 -0700 (PDT)
In-Reply-To: <B1ECBDB2E23847488F70D870CBE563F70198D579@nawespscez06v.nadsuswe.nads.navy.mil>
X-Gm-Message-State: ALoCoQkeKIx3ldKdqEM0cK3TrahoAhrNO+cNx57NTCfuM2I9OisfhxEOUJReBaEOr74I3Y5H/VJG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192967>

On Mon, Mar 12, 2012 at 17:54, Jones, Brian P CTR
SPAWARSYSCEN-PACIFIC, 63600 <brian.p.jones4.ctr@navy.mil> wrote:
> Does anyone know if git is being used in a military CAC enabled environment? This means that the DoD CAC card is required to authenticate when hitting the git transfer protocol. This is a requirement before I can propose using git. I understand that git is able to use https as well as ssh or over port 9418. Is there any documentation on setting up CAC enabled git protocols?

The git:// protocol on port 9418 has no authentication. It won't meet
your requirements.


For Git over ssh://, Git just relies on the SSH client and server
binaries installed on the system. You would have to find out if these
binaries meet your requirements. If they do, you may just be able to
use SSH.


Git 1.7.9 and later on https:// can use a credential helper binary to
obtain the user's "password" string. A credential helper is an
external program Git calls to help it authenticate over HTTP using
either HTTP basic or HTTP digest authentication. It may be possible to
write a git-credential-dodcac binary that does the magic required.
Install this binary in the user's $PATH, have them enable it with a
`git config --global credential.helper dodcac` configuration setting,
and away they go.

If a DoD CAC is like a one time password scheme, it may be possible to
have the user's "password" over HTTP actually be $password:$onetimepad
or some such format, and then use a custom authentication system on
the server to decode this string and verify it.

Internally at $DAYJOB we use a custom git-credential-$DAYJOB binary to
acquire a unique token that identifies the caller and pass this to the
server over HTTPS. The HTTP server in turn verifies this string with
the authentication system. Its not really their password, its just a
mutually agreed upon blob that was passed around between the client
workstation and the server.
