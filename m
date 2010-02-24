From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH] git checkout -b: unparent the new branch with -o
Date: Wed, 24 Feb 2010 19:40:23 -0300
Message-ID: <55bacdd31002241440n5266edcagbe0954127f072b5d@mail.gmail.com>
References: <1266960007-16127-1-git-send-email-erick.mattos@gmail.com> 
	<7viq9nfwg8.fsf@alter.siamese.dyndns.org> <55bacdd31002241423i10ee177cnda545c9aac071b39@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 23:40:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkPuT-0000n1-V9
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 23:40:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758502Ab0BXWko convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Feb 2010 17:40:44 -0500
Received: from mail-gx0-f217.google.com ([209.85.217.217]:49876 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758482Ab0BXWko convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Feb 2010 17:40:44 -0500
Received: by gxk9 with SMTP id 9so5320299gxk.8
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 14:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=nXwL+ugjty3Tsabm+a/Em0Vcx5OHYVNIbtZKSkTiP4E=;
        b=bx8rJHy+FJZcVElyaHPWD8GUf/e+tV1RL0ysubF9wRy6WEyNv7u50DfmlfhPsx4r3s
         Uuzk0eZgaIc3wXzXtslbcVIHYD7pi1H6R4afZwBeZ365VuOZD/SF2eAwd3zzb9eDADuL
         SVE+Rk8wgZ6cW+MFIbPY5Tr/aemoBeRna9PIg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=btSV5TLIfrCO56jyh7eXHJssUDHEtmXpt/yA2KORK0+WauNesWo2SPHEMxnHo64AS/
         h3+1JarhGfRO/lQdUmQ6bP+ELraixgD1p704VRWYxGOjHl41XZCR9Ej1lLbmcZh1XNNA
         jdgCyhAb68kQBaU7HpUCEIxW7cROFe0dxLWlg=
Received: by 10.151.16.5 with SMTP id t5mr294780ybi.264.1267051243147; Wed, 24 
	Feb 2010 14:40:43 -0800 (PST)
In-Reply-To: <55bacdd31002241423i10ee177cnda545c9aac071b39@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140997>

Sorry for the e-mail sent wrong (GMANE/140995).  The message was
screwed by gmail by sending it in HTML which git list blocked.  I had
to forward another and mistakenly copied Junio's.

2010/2/24 Erick Mattos <erick.mattos@gmail.com>:
> Erick Mattos <erick.mattos@gmail.com> writes:
>
>> A good example to show the need of this option is a Debian folder of=
 control
>> files. =C2=A0Whenever a maintainer needs to debianize a source code =
to build
>> packages he needs to add a folder called Debian with a lot of files =
inside it.
>> Those files are connected to the source code of the program but they=
 are not
>> really part of the program development. =C2=A0On this situation usin=
g the new
>> option, that maintainer would do:
>>
>> =C2=A0 =C2=A0 =C2=A0 git checkout -ob debian
>> =C2=A0 =C2=A0 =C2=A0 git clean -df
>> =C2=A0 =C2=A0 =C2=A0 mkdir Debian
>> =C2=A0 =C2=A0 =C2=A0 add all control files
>> =C2=A0 =C2=A0 =C2=A0 ...hack it enough...
>> =C2=A0 =C2=A0 =C2=A0 git add Debian
>> =C2=A0 =C2=A0 =C2=A0 git commit
>
> I do not think that is a good example.
>
> If you have an extract of an upstream tarball, say frotz-1.42.tar.gz,=
 and
> you are not porting anything older than that version, why not have tw=
o
> branches, frotz and master, and do things this way?
>
> =C2=A0- frotz (or "vanilla" or "upstream") that keeps track of the "v=
endor
> =C2=A0drop" without debian/ directory;
>
> =C2=A0- master that forks from frotz and adds "debian/" and nothing e=
lse; and
>
> =C2=A0- any other topic branches that either fork from frotz if you a=
re fixing
> =C2=A0upstream bug (or enhancing the vanilla version), or fork from m=
aster if
> =C2=A0you are fixing or enhancing the debianization.
>
> When you receive frotz-1.43.tar.gz, you will advance 'frotz' branch w=
ith
> it, and probably fork maint-1.42 branch from master so that you can k=
eep
> supporting older debianized frotz, while merging frotz into master so=
 that
> you can prepare a debianized version of newer package.
>
> Your debianization will _never_ be totally independent of the vendor
> version, so there is no good reason to have it as a rootless branch.
>
