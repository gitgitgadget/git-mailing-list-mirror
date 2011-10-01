From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH] contrib: add a pair of credential helpers for Mac OS X's keychain
Date: Sat, 1 Oct 2011 02:57:50 -0400
Message-ID: <CAEBDL5XhLAccfMoSyBjDA4ZsCgc4FnxEVYyqJsnGfzDW3Otudw@mail.gmail.com>
References: <1316055113-2353-1-git-send-email-jaysoffian@gmail.com>
	<20110929075627.GB14022@sigill.intra.peff.net>
	<CAEBDL5WhpVg17aPuRqrE5=2Q293kVD4fYtxGqRzx_K=87t-jgw@mail.gmail.com>
	<CAG+J_DyhcA7RmHwgGJBw4r9JRij0_ONp3ZMD6oMTJ_f4dvYW8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 01 08:58:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9tWH-0005Cg-5f
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 08:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979Ab1JAG5w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Oct 2011 02:57:52 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49230 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775Ab1JAG5v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Oct 2011 02:57:51 -0400
Received: by iaqq3 with SMTP id q3so2613840iaq.19
        for <git@vger.kernel.org>; Fri, 30 Sep 2011 23:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=SYKjpo7ial1wHP5KjoX4FfCNdF8OiK064m6fa8YhQdM=;
        b=XfV4NtaVMHtcZODMQmOpDJGQ6qEzye9HTv+CUjkdWEXwSeLZEFAx5ZMGqOj3XOK/7D
         2wQqfHDT/lZ6YcXcrDXyNgmoip5FM4QK0oCFTJgQAhMSI7VOxag4npBhpWeJEzo78A0t
         uGZ6qEw+2sqN3xGgTepxK/PvIKiPJTTmb5DpU=
Received: by 10.231.41.9 with SMTP id m9mr10273404ibe.96.1317452270734; Fri,
 30 Sep 2011 23:57:50 -0700 (PDT)
Received: by 10.231.207.83 with HTTP; Fri, 30 Sep 2011 23:57:50 -0700 (PDT)
In-Reply-To: <CAG+J_DyhcA7RmHwgGJBw4r9JRij0_ONp3ZMD6oMTJ_f4dvYW8w@mail.gmail.com>
X-Google-Sender-Auth: 9qINWCEVWeS9pKp0Aq-1XWCQ-LA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182541>

On Fri, Sep 30, 2011 at 3:33 PM, Jay Soffian <jaysoffian@gmail.com> wro=
te:
> On Thu, Sep 29, 2011 at 6:03 AM, John Szakmeister <john@szakmeister.n=
et> wrote:
>>
>> I've been working on a version of the keychain credential cache as
>> well. =C2=A0I did create a gui, although it's a bit painful.
>
> I still don't understand why a CLI app should have a GUI credential p=
rompt.

=46or one, I saw it more as being useful to things other than the git
command line.  And the Mac already presents a GUI for unlocking the
keychain if necessary.  It's not like there isn't any precedent for
it.

[snip]
>> I think that makes sense. =C2=A0I think one thing we have to be care=
ful
>> about partial matches. =C2=A0I wouldn't want the credential cache to=
 send
>> off the wrong password to a service. =C2=A0This may be me being caut=
ious,
>> but if I don't have all the necessary bits, I'd rather we fail that =
to
>> guess which entry is right.
>
> The credential helper I wrote doesn't work that way. To do so would
> mean using a rather more complicated form of the OS X Security API. I=
t
> asks for an entry using whatever fields it has, and OS X returns the
> first match that satisfies. It's up to the user to yea/nay that match
> if the credential helper isn't on the entry's ACL.

True, the user would at least have to acknowledge it.

>>>> + =C2=A0 =C2=A0 /* "GitHub for Mac" compatibility */
>>>> + =C2=A0 =C2=A0 if (!strcmp(hostname, "github.com"))
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hostname =3D "github.c=
om/mac";
>>>
>>> Nice touch. :)
>>
>> I honestly don't understand why this needs to be done.
>
> Because GitHub for Mac stores its entries using "github.com/mac" as
> the hostname.
>
>> I don't use GitHub for Mac... does that mean this is busted for me?
>
> No. It just means that the credential helper and GitHub for Mac store
> their entry in a compatible fashion. (So that each can locate the
> entry stored by the other.)

Ah, interesting.  But it does mean that it won't pick up the password
I've cached via my browser, right?

>> [snip]
>>> My series will also produce "cert:/path/to/certificate" when unlock=
ing a
>>> certificate. The other candidates for conversion are smtp-auth (for
>>> send-email) and imap (for imap-send). =C2=A0I guess for certs, you'=
d want to
>>> use the "generic" keychain type.
>>
>> There is a method for adding a certificate to the keychain:
>> =C2=A0 <http://developer.apple.com/library/mac/#documentation/Securi=
ty/Reference/certifkeytrustservices/Reference/reference.html#//apple_re=
f/doc/uid/TP30000157>
>>
>> I'm not sure what that does exactly, but I do have a cert, and it
>> shows up as "certificate" in the keychain.
>
> That's for storing a certificate itself. In this case, I think we're
> just talking about storing the passphrase which protects the
> certificate's private key.

I could've sworn the docs mentioned storing the private key, but I
don't see it.  SecIdentityCreateWithCertificate() can get you the
private key from a cert, once added.  It's not clear how to go from
cert to password in a manner that's compatible with other Mac apps.

[snip]
>> By the time you get Keychain involved, the decision has been made.
>> Most applications offer that ability... and you're right, this shoul=
d
>> probably offer the same capability. =C2=A0That also means stashing t=
hat
>> data somewhere. :-( =C2=A0OTOH, it does make for a better user exper=
ience.
>
> What, no? If you don't want git to store usernames/passwords stored i=
n
> the OS X Keychain, don't use the git-osx-keychain credential helper.

I want *some* cached, and others not.  I don't want to be forced to
remember to take git-osx-keychain out of my credentials list, or
something silly like that.  That doesn't help on the user-friendliness
front.  Having a check box and storing the fact that we shouldn't
cache the password in the repo's config seems like a reasonable
approach.  But I agree with Jeff in another part of this thread: I
think the prompting of the username and password should be a separate
mechanism.  It could prompt about whether or not to store the
password, and git could take care of whether or not to call the
credential store.

-John
