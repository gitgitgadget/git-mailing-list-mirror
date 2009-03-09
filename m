From: Daniel Cheng <j16sdiz+freenet@gmail.com>
Subject: Re: [freenet-dev] [PoC PATCH JGIT 0/2] Proof of concept code for Git 
	Freenet transport
Date: Mon, 9 Mar 2009 19:35:38 +0800
Message-ID: <ff6a9c820903090435n375b2e0ftde4c47f122d8132e@mail.gmail.com>
References: <1541866875@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Discussion of development issues <devl@freenetproject.org>
X-From: git-owner@vger.kernel.org Mon Mar 09 12:37:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgdnC-0008Vb-9G
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 12:37:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbZCILfm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Mar 2009 07:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbZCILfl
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 07:35:41 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:55438 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732AbZCILfl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Mar 2009 07:35:41 -0400
Received: by wa-out-1112.google.com with SMTP id v33so937598wah.21
        for <git@vger.kernel.org>; Mon, 09 Mar 2009 04:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=bNG3CnEFlGD0fqV7VjB8CQXOCU7a9pOdbjUt2XnONT0=;
        b=ND3glFxbqOU7PC0uCcqhpBzE8FQUlDCxYSJNeugSwEXIVl5B6H49JWidEPsOsxc5N2
         5OJuP2PunyyBqLoHgfkB36bHS4vnLhKXdVaxbIwGPnEbv3+a0PHr8S48shroOSYBuFNo
         Pj3n/KYgaAHIwKiOSgmQcp5kbnw+LPRQrQq7g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=FqbExiTSLPiR0dav3pA3kDJn46Ge2x5GnSC3JvgP57muJmoYTIpYoFBYiS14RRsi+0
         vB9LTnWAptW5NzN3D/0CGk26gZC7SoSYw1fKk6hQ4e+En4K21NSZNrFr4rdJXyo2KBXZ
         M0iTq/p/TfdbSs6xACwWOoueka9OYUP48aMKA=
Received: by 10.114.202.15 with SMTP id z15mr3473720waf.67.1236598538492; Mon, 
	09 Mar 2009 04:35:38 -0700 (PDT)
In-Reply-To: <1541866875@web.de>
X-Google-Sender-Auth: 92fd331f60fafee1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112689>

On Mon, Mar 9, 2009 at 6:46 PM,  <bo-le@web.de> wrote:
>> -----Urspr=FCngliche Nachricht-----
>> Von: "Daniel Cheng (aka SDiZ)" <j16sdiz+freenet@gmail.com>
>> Gesendet: 09.03.09 04:36:25
>> An: =A0git@vger.kernel.org
>> Betreff: [freenet-dev] [PoC PATCH JGIT 0/2] Proof of concept code fo=
r Git Freenet transport
>
>> Hi JGit / Freenet community,
>>
>> Here is some proof-of-concept code for Git-over-Freenet.
>> I am sending this to see the feedback from communities.
>>
>> The code need some more cleanups, so it it is not ready for apply (y=
et).
>>
>> This is a real-life example
>>
>> Push:
>> =A0 =A0$ git remote add fcp fcp://SSK@[my public key]^[my private ke=
y]/test.git
>> =A0 =A0$ ./jgit push fcp refs/remotes/origin/stable:refs/heads/maste=
r
>>
>> =A0/ALTERNATIVLY/
>>
>> =A0 =A0Insert a bare repository under USK@<.....>/test.git/-1/
>>
>> Pull:
>> =A0$ ./jgit clone fcp://SSK@[my public key]^[my private key]/test.gi=
t
>
> a pull from fproxy should be possible. so the average user can grab a=
nd build sources with an unpatched/regular git version
> $ git clone http://127.0.0.1:8888/key/app.git =A0//grab & build a app
> $ git clone http://127.0.0.1:8888/key/jFreeGit.git =A0//ha, bootstrap=
! grab & build the modified git for creating repos in freenet
>
>>
>>
>> To workaround the metadata update problem, this client translate the
>> path seperator to "-", that means:
>
> you need to mangele path names properly, it may fail on names with '-=
' inside.

It doesn't matter -- we don't have to convert it back.

>> On push:
>> =A0 =A0objects/aa/bbbbbbbb =A0 --> USK@..../test.git-objects-aa-bbbb=
bbb/-1/
>> =A0 =A0refs/heads/xxx =A0 =A0 =A0 =A0--> USK@..../test.git-objects-r=
ef-heads-xxx/-1/
>>
> why not 'USK@..../test.git/1/objects/aa/bbbbbbb' ?

In freenet,
all files under   USK@..../test.git/1/* are packed in a zip file and
must be updated at once.
If we do this, we have to upload all pack files again on every push --
this is very bad.

see http://wiki.github.com/j16sdiz/egit-freenet for more detail reply.

>> On pull:
>> =A0 =A0To support uploading from jSite,
>> =A0 =A0 when we load the info/refs we first check USK@..../test.git-=
info-refs/-1/
>> =A0 =A0 if it is unavailiable, we would use USK@..../test.git/-1/inf=
o/refs
>>
>> =A0 =A0The "traditional" type (USK@..../test.git/-1/objects) reposit=
ory is
>> =A0 =A0always added as an alternative objects database. No other inf=
o/alternatives
>> =A0 =A0are supported
>>
>> FIXME:
>> =A0- How to store the private key of repository?
> hg have a per repository config. was quite easy here ;)
>
>> =A0 =A0Currently, we use URI of form fcp://SSK@<public key>^<private=
 key>/some-id
>> =A0 =A0This is quite ugly. Could we use a per remote Config ? How ca=
n I get remote
>> =A0 =A0name from transport?
>>
>> =A0- Make pushing async, could we?
> inserting to an USK should be blocking until the toplevel chunk is in=
=2E this is a helpful tactic to hold the edition chain clean.
