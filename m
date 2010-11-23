From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [RFC PATCH 1/6] msvc: opendir: use xmalloc
Date: Tue, 23 Nov 2010 19:12:08 +0100
Message-ID: <AANLkTimXgnYePPwZNDapS53JSnmO-D-xLxHbLaP8HVv0@mail.gmail.com>
References: <1290533444-3404-1-git-send-email-kusmabite@gmail.com>
 <1290533444-3404-2-git-send-email-kusmabite@gmail.com> <20101123174050.GB12113@burratino>
 <AANLkTiknTQp96PeiBd+MqCO6uEs1mCzFYDsW8NwYpBsm@mail.gmail.com> <20101123180250.GF12113@burratino>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 19:12:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKxM6-0001RF-Sj
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 19:12:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756101Ab0KWSMd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Nov 2010 13:12:33 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63584 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756005Ab0KWSMc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Nov 2010 13:12:32 -0500
Received: by fxm13 with SMTP id 13so4131941fxm.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 10:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=pOswM3eNqavQq5SS0+AVEWY0sCqBu1KUL7MLSNt5lFo=;
        b=wBzUKANqbZ+qZs/dp5+0+rW5iDCv9a+JHoK6K/OaX82mmJeJQLUm2ic8eeXJmDPOat
         spWjnpoVqsgY3uL370Ye7+sY/MmsR7HolqW+E4hX5e7HGaaWZkYhtB3dWAbd66IVhsjG
         zickk6vuvsUjAGw808DLfNNQX6dGMrf84ZrRE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=bN2qT8LgEck8WBq+lQ/pjDu2l7qHQZunYSpg66FxzKN2oC3mLt/YpJUJRtMCBF7iyN
         72cOF6p0QI1Ty7CKUCWeYcWHENeWOi00IHH6U3LEbskXQ+IqCHNjkuyLRA1Zqmu9ndrW
         H0aEbrfNVvQHMkKS/1Tjw0fmNE151sE6ja0Tc=
Received: by 10.223.120.84 with SMTP id c20mr275472far.102.1290535951277; Tue,
 23 Nov 2010 10:12:31 -0800 (PST)
Received: by 10.223.72.206 with HTTP; Tue, 23 Nov 2010 10:12:08 -0800 (PST)
In-Reply-To: <20101123180250.GF12113@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162001>

On Tue, Nov 23, 2010 at 7:02 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Erik Faye-Lund wrote:
>
>> The motivation is just to avoid having to deal with the error, like =
we
>> do other places. It's not a big deal though. I could also set errno =
to
>> ENOMEM and return NULL if that's preferable. I just don't see how it
>> is.
>
> I don't disagree; just fishing for a commit message. :)
>

Yes, but after stopping to think about it a tad more, I tend to like
it working more similar to existing POSIX implementations.

I am adding a commit message this time, though! ;)

>> I also slightly dislike setting an error not listed in POSIX'
>> documentation of opendir, even though it's probably allowed.
>
> For future reference, here's what POSIX has to say.
>
> =A0 =A0 =A0 =A0Implementations shall not generate a different error
> =A0 =A0 =A0 =A0number from one required by this volume of
> =A0 =A0 =A0 =A0POSIX.1-2008 for an error condition described in this
> =A0 =A0 =A0 =A0volume of POSIX.1-2008, but may generate additional
> =A0 =A0 =A0 =A0errors unless explicitly disallowed for a particular
> =A0 =A0 =A0 =A0function.
>
> So ENOMEM would have been allowed from that front.
>

Thanks for the clarification.
