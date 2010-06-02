From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH 2/5] refs: split log_ref_write logic into log_ref_setup
Date: Wed, 2 Jun 2010 20:16:30 -0300
Message-ID: <AANLkTikcQny9Es_cMJTg94qTJZD2s7T37h_Hur9Lt-Lv@mail.gmail.com>
References: <1274488119-6989-1-git-send-email-erick.mattos@gmail.com> 
	<1274488119-6989-3-git-send-email-erick.mattos@gmail.com> 
	<7v632bs13c.fsf@alter.siamese.dyndns.org> <AANLkTikPypcmGB6NuTl-SQZR3lnIvdmVG5E8wjVAlIej@mail.gmail.com> 
	<7vzkzdcneh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 03 01:17:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJxBB-0003Qj-Ad
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 01:16:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758222Ab0FBXQw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jun 2010 19:16:52 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:42356 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758204Ab0FBXQu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jun 2010 19:16:50 -0400
Received: by gwaa12 with SMTP id a12so5083674gwa.19
        for <git@vger.kernel.org>; Wed, 02 Jun 2010 16:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=bl4bI2iSVQC7ffM/YQb35WK3J3ADi28A5ddUMsRPTNE=;
        b=gdGvqIPVihYBrpANMn7yEMEOmmxJUEkJtuKIPxIrm0aDkHQ5RwcqZNKMQeHkYQPS1S
         +XuJnzpR52RdfHKg5A6HU1C0P4YE96uizp32Wr+OFXVK9TnERAjUzTgOiMP5UmL3VrjQ
         zG/xQTb7bRC6pPYZbTQzpwBXrYcxNTnTQMRWc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=bdFxfzU3VmCyldNSUkySRXzfIMeT08La3/1PZ5u/+StbAFU4IEbrS2Om7zI2xz9VRC
         GeyY/3mLSzPDlTpedFXxdKJUS1maJ/zy6k7sTKTjBB+bpTyaQXVEUkq5PBSmqL14kVOW
         F+87RG0rYSd6f+y/8l0TaqNDdKoiOtN1DvGp0=
Received: by 10.150.118.26 with SMTP id q26mr8522603ybc.325.1275520610117; 
	Wed, 02 Jun 2010 16:16:50 -0700 (PDT)
Received: by 10.151.39.17 with HTTP; Wed, 2 Jun 2010 16:16:30 -0700 (PDT)
In-Reply-To: <7vzkzdcneh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148276>

Hi,

2010/6/2 Junio C Hamano <gitster@pobox.com>:
> Erick Mattos <erick.mattos@gmail.com> writes:
>
>> Now just a question, Junio:
>>
>> I forgot to sign-off those patches, should I have to send them again=
?
>
> I would have appreciated a whole re-send while I was too distracted b=
y
> non-git stuff during the past few weeks, but now I am more or less se=
ttled
> in, it's Ok to just send a separate "Signed-off-by:" like this one:
>
> =C2=A0 =C2=A0http://article.gmane.org/gmane.comp.version-control.git/=
148230/raw
>

All right, following then:

2010/5/21 Erick Mattos <erick.mattos@gmail.com>:
> These series of patches are improvements to 'git checkout --orphan'.
>
> The main reason for them is a corner case which is not being solved b=
y
> actual implementation.  As it is a quite improbable situation and as =
it was
> necessary to do more extensive changes to support it then its develop=
ment
> was held to be presented in a new developing cycle.
>
> When someone set core.logAllRefUpdates to false reflogs are not creat=
ed
> automatically.  This behavior is superseeded by -l option.  Actually =
this is
> not allowed with --orphan by current implementation.  Those new patch=
es are
> made to fix that.
>
> There are also two other patches for configuring completion in bash a=
nd to
> enhance documentation.
>
> To be completely honest I don't see a point of not having the reflogs
> created and deleted automatically so I see no reason for -l and
> core.logAllRefUpdates at all.  But I do not like to do anything parti=
ally
> thus these new patches.  If someone could show me a case please do it=
=2E  ;-)
>
> [PATCH 1/5] Documentation: alter checkout --orphan description
>
> This one improves documentation text by late corrections from previou=
s
> threads.
>
> [PATCH 2/5] refs: split log_ref_write logic into log_ref_setup
>
> Prepare the field by separating the logic to set up the reflog from t=
he
> reflog writing action.
>
> [PATCH 3/5] checkout --orphan: respect -l option always
>
> This is the actual actor.
>
> [PATCH 4/5] t3200: test -l with core.logAllRefUpdates options
>
> Adjusting scripts to test everything extensively.
>
> [PATCH 5/5] bash completion: add --orphan to 'git checkout'
>
> Just do that git change.

Signed-off-by: Erick Mattos <erick.mattos@gmail.com>
