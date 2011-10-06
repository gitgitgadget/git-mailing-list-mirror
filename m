From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] commit: teach --gpg-sign option
Date: Thu, 6 Oct 2011 12:11:07 -0500
Message-ID: <20111006171107.GA10973@elie>
References: <7vaa9f3pk8.fsf@alter.siamese.dyndns.org>
 <CAJo=hJvWbjEM9E5AjPHgmQ=eY8xf=Q=xtukeu2Ur7auUqeabDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 06 19:11:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBrTf-0007Ih-Or
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 19:11:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755788Ab1JFRLS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Oct 2011 13:11:18 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47002 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753722Ab1JFRLS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Oct 2011 13:11:18 -0400
Received: by iakk32 with SMTP id k32so3180833iak.19
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 10:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Rh0qUIGa7+mw7blKNZ+PPjkQHwtl0vu49pcccbiTqaI=;
        b=KlpvxCnjjrEoj7JvoY2D0cXjJT3JmG4obyn7HuF/TsgHfzZNkBwh63bgFiMtXs+WH7
         36d/eOTbAPHCuD4wcPrwtgtBrVu05mcoR6GdBrymOvjsvIsXfdi5idK09wjzRUiaHb0t
         BB+9+d7kWx4qnuNqdj65BOkz50fnFUG6hKScw=
Received: by 10.231.29.137 with SMTP id q9mr1048848ibc.27.1317921077654;
        Thu, 06 Oct 2011 10:11:17 -0700 (PDT)
Received: from elie (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id fy35sm12747154ibb.4.2011.10.06.10.11.16
        (version=SSLv3 cipher=OTHER);
        Thu, 06 Oct 2011 10:11:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJo=hJvWbjEM9E5AjPHgmQ=eY8xf=Q=xtukeu2Ur7auUqeabDg@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182984>

Shawn Pearce wrote:
> On Wed, Oct 5, 2011 at 17:56, Junio C Hamano <gitster@pobox.com> wrot=
e:

>> And this uses the gpg-interface.[ch] to allow signing the commit, i.=
e.
>>
>> =C2=A0 =C2=A0$ git commit --gpg-sign -m foo
>> =C2=A0 =C2=A0You need a passphrase to unlock the secret key for
>> =C2=A0 =C2=A0user: "Junio C Hamano <gitster@pobox.com>"
>> =C2=A0 =C2=A04096-bit RSA key, ID 96AFE6CB, created 2011-10-03 (main=
 key ID 713660A7)
[...]
> I like this approach better than the prior "push certificate" idea.
> The signature information is part of the history graph

I probably missed some earlier discussion (so please forgive me this),
but how is it intended to be used?  Would projects

 a. require as a matter of policy that all commits be signed
 b. just sign releases as usual, but as commits in the history graph
    instead of tags
 c. sign the occasional especially interesting commit

What happens if my old key is compromised and I want to throw away the
signatures and replace them with signatures using my new key?  How
does this relate to the "push certificate" use case, which seemed to
be mostly about authenticating published branch tips with signatures
that are not necessarily important in the long term?

In other words, something like this feature sounds like a sensible way
to commit the equivalent of a GPG-signed patch, but it doesn't seem
like a good fit for the "push certificate" use cases.
