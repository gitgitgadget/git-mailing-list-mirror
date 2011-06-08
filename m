From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 03/19] t5800: document some non-functional parts of remote helpers
Date: Wed, 8 Jun 2011 23:13:16 +0200
Message-ID: <BANLkTi=-roQ5DH6RQ75+EwfDr9LutU0jrw@mail.gmail.com>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
 <1307558930-16074-4-git-send-email-srabbelier@gmail.com> <20110608192850.GF27715@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 23:14:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUQ4g-0008Ba-SY
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 23:14:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753057Ab1FHVN5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jun 2011 17:13:57 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:38117 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660Ab1FHVN5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2011 17:13:57 -0400
Received: by qwk3 with SMTP id 3so434595qwk.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 14:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=//JloKdDm9WOw/B9AxXXNai5142N90OeqfLalKJhlYc=;
        b=osljEoBFwKQ7X0aKkI0yMvcfijgGmu6oGgsdvemUbL6B9qtLhlEig6qZ5j88qTOPTO
         2D7eAIMkehPVW45knRnuaor6LZa4LhKW92JNVkUJ604viwl4OVDUipE4wHW9ov4xXmMs
         inrgVW8EOeb17Od+FZ6VeDxNLNr+leedIpMYw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=FzeFxqGV4a39N9gnt5YW6GFQxq5Izu5lnRxSAm80LLBUZwVb9gvBsPIWEqZ2foQMHu
         qhrKjt9InEIYUEBfcOeqfULPFXSFvoJi07+Acof4M+ZhWQ8tsuUzTzWgz89G7tacZ8RD
         9B6cT2vgwF/LiV6Z9BNcRjtZrrYI11iumzToI=
Received: by 10.229.127.105 with SMTP id f41mr6015095qcs.15.1307567636083;
 Wed, 08 Jun 2011 14:13:56 -0700 (PDT)
Received: by 10.229.83.203 with HTTP; Wed, 8 Jun 2011 14:13:16 -0700 (PDT)
In-Reply-To: <20110608192850.GF27715@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175460>

Heya,

On Wed, Jun 8, 2011 at 21:28, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
>> +test_expect_failure PYTHON_24 'fetch new branch' '
>
> Side note: this repeated PYTHON_24 implementation detail as a
> prerequisite feels wrong. =C2=A0Would it make sense to do something l=
ike
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if test_have_prereq PYTHON_24
> =C2=A0 =C2=A0 =C2=A0 =C2=A0then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_set_prere=
q REMOTE_TESTGIT
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fi
>
> at the start and use that?

I don't know, it already says:

if test_have_prereq PYTHON && "$PYTHON_PATH" -c '
import sys
if sys.hexversion < 0x02040000:
    sys.exit(1)
'
then
    # Requires Python 2.4 or newer
	test_set_prereq PYTHON_24
fi

At the start. Are you suggesting to rename PYTHON_24 to REMOTE_TESTGIT?

> It would also be interesting to test tag pushes and pushes by object
> name.

I was going to test this, but it seems there's a problem with my
series. Peff, if you want to look into it, (if not I'll try to look at
it tomorrow) it's up at my github fork [0].

ok 12 - push when remote has extra refs

expecting success:
	(cd clone &&
	 git checkout -b new-name  &&
	 echo content >>file &&
	 git commit -a -m seven &&
	 git push origin new-name
	) &&
	compare_refs clone HEAD server refs/heads/new-name

Switched to a new branch 'new-name'
[new-name f29f436] seven
 Author: A U Thor <author@example.com>
 1 files changed, 1 insertions(+), 0 deletions(-)
Unpacking objects: 100% (3/3), done.
To testgit::file:///home/sverre/code/git/t/trash
directory.t5800-remote-helpers/server
 * [new branch]      master
error: Trying to write ref refs/remotes/origin/master with nonexistant
object 0000000000000000000000000000000000000000
error: Cannot update the ref 'refs/remotes/origin/master'.

[0] https://github.com/SRabbelier/git/commits/remote-helpers

--=20
Cheers,

Sverre Rabbelier
