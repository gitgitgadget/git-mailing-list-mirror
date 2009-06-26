From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv6 4/8] gitweb: (gr)avatar support
Date: Sat, 27 Jun 2009 01:14:52 +0200
Message-ID: <cb7bb73a0906261614x3a5dab02h1f29d68b6f5005b1@mail.gmail.com>
References: <1245926587-25074-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200906262142.28845.jnareb@gmail.com>
	 <cb7bb73a0906261508s47e8834fuc9b3313bd9f127ce@mail.gmail.com>
	 <200906270058.16686.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 01:15:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKKdJ-0007Pw-Ng
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 01:15:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483AbZFZXOx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Jun 2009 19:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752126AbZFZXOw
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 19:14:52 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:53191 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005AbZFZXOv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Jun 2009 19:14:51 -0400
Received: by bwz9 with SMTP id 9so2294297bwz.37
        for <git@vger.kernel.org>; Fri, 26 Jun 2009 16:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=H/hyLapVgqwapufjC97642/w5mK2oaanT/CjsjN0rqM=;
        b=a6aLRPy5LL1Y6nQ2yNyHEyMXc/aOt5v5STGiytkV8GY1esQzNuPSiL++ivPdQ/QIEf
         lomc192lBjKEQSwiu2cv4+ArhZeN7OwkIQQ7MHIt1nlGLDH2Uy+akBC6tAwvamJH9ce9
         /Lsh8be+RQ0B0o5Wn48/fjtbrVq+/BFmsTYJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fnXr8vsHQ4kGj7Ytw2/JYBgNoFWQAMuhruJc/PhgA/jWl7ZkQ3mm/gN+hjLY+752Xb
         3/LVmBBYKxYHkVVQFhha7PF2cn3XHZQpvpEVyv+G+x8+NgR4sgILKHMEzU92xW1JAor2
         9JNCNfj48Rz5MMZ9twma8bJsgMdlDyozrwhXg=
Received: by 10.204.64.196 with SMTP id f4mr4125977bki.151.1246058092179; Fri, 
	26 Jun 2009 16:14:52 -0700 (PDT)
In-Reply-To: <200906270058.16686.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122333>

On Sat, Jun 27, 2009 at 12:58 AM, Jakub Narebski<jnareb@gmail.com> wrot=
e:
> Do I understand this correctly that there is additional patch planned
> in new release of this series providing support for gitweb.avatar =3D=
 picon?

Yes.

And a separate patch makes the picon the fallback for gravatar too,
but I'm thinking about having something like a gitweb.gravatar_default
(or something like that) to make that configurable.

>>>> + =A0 =A0 # To enable system wide have in $GITWEB_CONFIG
>>>> + =A0 =A0 # $feature{'avatar'}{'default'} =3D ['gravatar'];
>>>> + =A0 =A0 # To have project specific config enable override in $GI=
TWEB_CONFIG
>>>> + =A0 =A0 # $feature{'avatar'}{'override'} =3D 1;
>>>> + =A0 =A0 # and in project config gitweb.avatar =3D gravatar;
>>>> + =A0 =A0 'avatar' =3D> {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 'override' =3D> 0,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 'default' =3D> ['']},
>
> NOTE, NOTE, NOTE!
>
> One thing I forgot about (and would be discovered when running t9500
> with provided patch... among other errors) is that you need to provid=
e
> 'sub' subroutine for feature to be overridable.

Duh I had forgotten aout that. But I ran the test and didn't see that
error ... maybe I'm reading the log incorrectly.

> ...And that subroutine would be responsible for returning '' (empty
> string) when feature is overridable. =A0See other feature_* subroutin=
es.

I've tried an implementation. Hopefully it's correct 8-/

>> I had considered going this way, but it made the code somewhat more
>> complex so I went for the simpler solution. I'll look into putting i=
t
>> in separate cells further on.
>
> Well, by "left for later" here I thought about later as in after this
> patch series about gravatars get accepted :-)

Me too 8-D

--=20
Giuseppe "Oblomov" Bilotta
