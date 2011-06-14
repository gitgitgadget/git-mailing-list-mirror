From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Using Transifex in git.git
Date: Tue, 14 Jun 2011 16:32:16 +0530
Message-ID: <BANLkTimXLUG-MZC3AndkequF3wVNwqDOeQ@mail.gmail.com>
References: <BANLkTikQJYYd4sTJoDrL28Bo35+GpV3HgA@mail.gmail.com> <BANLkTikLJJwfGJp_nshRXGSb-yGOshwzTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dimitris Glezos <glezos@indifex.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Ericsson <ae@op5.se>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 13:02:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWRON-0001o6-4z
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 13:02:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756172Ab1FNLCj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jun 2011 07:02:39 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58872 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756167Ab1FNLCh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jun 2011 07:02:37 -0400
Received: by wwa36 with SMTP id 36so5751761wwa.1
        for <git@vger.kernel.org>; Tue, 14 Jun 2011 04:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=efWWhL/ehfIGe0GsHlEvrds15JVscTqfm1uB15mRdxA=;
        b=JCO/Lc+fwaIOId7bPJV1K16gTzgxXcKAlL08xV6NdCNnR7vfDDg9cIGV2s4HNWdWb/
         e7FOgnFlFMPtmEZ4y6vmJ4SEYbwc/3go2KUrQ5wahbGjaB7cGt+iSLCq7tjfNcVlRWdZ
         QVx6Rc+1twoIljAfg0SFqfMq8CSNuB2SHZ5T4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=bZae2buBl5Zdk7YvqsynRl3jG7qZ4ieLVYFErGkb7a2hd8CotVJSiLYIUqjt2PYURn
         PXk5snvbGoreti6qPijVctrmKNwc3yFwrh7hgBxe/RbOzicJM+/2yKBfrz1BbXJ1fFUi
         jogYtXOU7d7n2YTVEbgcW8+FWoqYzJxVoOxL0=
Received: by 10.216.143.7 with SMTP id k7mr5920211wej.95.1308049356272; Tue,
 14 Jun 2011 04:02:36 -0700 (PDT)
Received: by 10.216.1.20 with HTTP; Tue, 14 Jun 2011 04:02:16 -0700 (PDT)
In-Reply-To: <BANLkTikLJJwfGJp_nshRXGSb-yGOshwzTg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175761>

Hi =C3=86var,

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason writes:
> =C2=A0* I don't want people to *have* to use any one interface.
> =C2=A0* Any way of editing the translations will have to comply with =
git's
> =C2=A0normal patch submission process.

Thanks for the detailed response.  The way I see it, major changes are
required in two distinct areas:
1. The way the user interacts with the web-based UI.  In the current
UI (of Transifex), everything is one continuous stream; everything is
auto-saved, and the user makes no indication of a logical change.
This has to be changed to enforce creation of commit messages for the
Git project: without a valid commit message and signoff, the
translations are essentially useless.  Also, authorship information
isn't available -- so, the user accounts should have a way to keep
this information, and the Git project should be able to demand that
this information is available.
2. The way the system stores the various versions of the translation
information, and gives it back to the individual projects.  Some
projects might like the continuous stream to be squashed into one
commit that says something like "Sync translations with Transifex"
like it does current, some might like a Subversion dumpstream, while
others like the Git project might like a fast-import stream. When we
get the stream, we should be able to import it, rebase the commits as
necessary, and throw away the commits that we don't like before
integrating it.

I'll start mocking up a solution.  Are there some issues that I
haven't covered yet?

-- Ram
