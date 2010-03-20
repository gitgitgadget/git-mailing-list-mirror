From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH] git checkout: create unparented branch by --orphan
Date: Sat, 20 Mar 2010 17:36:06 -0300
Message-ID: <55bacdd31003201336u685f4b91u5206ca719609d153@mail.gmail.com>
References: <1268928579-11660-1-git-send-email-erick.mattos@gmail.com> 
	<7vvdcrowlc.fsf@alter.siamese.dyndns.org> <55bacdd31003201206w6215c6a4qec09797fbe060725@mail.gmail.com> 
	<7v4okad9by.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 20 21:36:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt5PM-0001Ih-NS
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 21:36:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752560Ab0CTUg1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Mar 2010 16:36:27 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55726 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172Ab0CTUg0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Mar 2010 16:36:26 -0400
Received: by gyg8 with SMTP id 8so2057467gyg.19
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 13:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=dM/0gjmylK8j64LofXnmTpVp3TDjtdrOPV45B9zggn4=;
        b=KHqqkkSxE3Vb99DObZWxa3npbsxvWO0CMuv5BZUR/KgTnAGTrsPY3s3orhpVYwjNQE
         k8CS32BONvE7S5wDBfnZMxaAQF4tFehArocvjBv3ovLHfLvUMdHo8MHdWBZGOZL+ESEm
         N0SG3Q1DYT5TjsfFrJuUxl/tDK/zrHYisnUdI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=l3OQu/nDQZzrK7e/8E3qmOiZFHw1lFnLumbjn4rNZcwqAT6WghHybiTxNTnbWzpwA5
         IFgPOjSAh2xP5lMc7ZkQhWs/ufM2vDtl74a5sNt4e+ACkzzrqSvWn7X+VsLFoPdG5oga
         jQChC/KdBnpHfawINrKwvMW8+I0QoqsvRKh5w=
Received: by 10.150.13.3 with SMTP id 3mr6775994ybm.42.1269117386072; Sat, 20 
	Mar 2010 13:36:26 -0700 (PDT)
In-Reply-To: <7v4okad9by.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142748>

2010/3/20 Junio C Hamano <gitster@pobox.com>:
> Erick Mattos <erick.mattos@gmail.com> writes:
>
>>> With local changes in the index/working tree without "start commit"=
 (which
>>> should never fail) and with "start commit" (which should fail if HE=
AD and
>>> start commit has differences to the same paths as you have local ch=
anges
>>> to).
>>
>> It is behaving like that already and that is intrinsically a
>> switch_branches() logic, not a special --orphan need. =C2=A0It is no=
t part
>> of this implementation and It is probably tested elsewhere (you
>> probably do know where).
>>
>>> Also you would want to check with -t, --no-t, branch.autosetupmrebe=
 set to
>>> always in the configuration with -t and without -t from the command=
 line,
>>
>> The actual implementation is just ignoring track and -t is not even
>> allowed. =C2=A0So it is pointless.
>
> I think you misunderstood the point of having tests. =C2=A0It is not =
about
> demonstrating that you did a good job implementing the new feature, o=
r
> your implementation works as advertised in the submitted form. =C2=A0=
That is
> the job of the review process before patch acceptance.
>
> Tests are to pretect what you perfected during the patch acceptance r=
eview
> from getting broken by other people in the future, while you are not
> closely monitoring the mailing list traffic. =C2=A0Many people, me in=
cluded,
> tend to concentrate on their own new addition, without being careful
> enough not to break the existing features. =C2=A0If "-t --orphan" sho=
uld result
> in an error, it should result in an error even after somebody restruc=
tures
> the code, so it is not sufficient that it is obvious in the _current_=
 code
> structure that breakage of that feature is unlikely.
>
> If you can promise that you will be around on this list forever, and =
that
> every time somebody posts patches to the related areas, you will make=
 sure
> that the changes do not inadvertently break this feature and respond =
to
> the patches that do break it before they hit my tree, then theoretica=
lly
> we do not need to have any test to make sure this feature keeps worki=
ng as
> advertised. =C2=A0But we cannot ask that kind of time/attention commi=
tment from
> anybody.
>

All right then.  I am going to check it too.  But in this particular
case, the track is being ignored completely.  So to break this
behavior people will need to add code to --orphan.

That's not a break, it's a linkage!  :-)
