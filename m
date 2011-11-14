From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] Copy resolve_ref() return value for longer use
Date: Mon, 14 Nov 2011 10:32:11 +0700
Message-ID: <CACsJy8BnqoPVJiM6mbq7p3gKtLh-KGUuTshcukGokC3istTxMQ@mail.gmail.com>
References: <7vobwgo3l5.fsf@alter.siamese.dyndns.org> <1321179735-21890-1-git-send-email-pclouds@gmail.com>
 <1321179735-21890-2-git-send-email-pclouds@gmail.com> <7vbosfoiuy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 14 04:32:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPnHs-0007Su-26
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 04:32:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932Ab1KNDcn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Nov 2011 22:32:43 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53719 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035Ab1KNDcn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Nov 2011 22:32:43 -0500
Received: by mail-bw0-f46.google.com with SMTP id 11so5427256bke.19
        for <git@vger.kernel.org>; Sun, 13 Nov 2011 19:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=BdRxiqFkKUMnImQOnt9nXoTFh7ixcQLZDOEuNC9ANjY=;
        b=IzzIBgYRw9XYqRkZQzVvMzY/Mzz/SQUQMY6EbYKu1tvaNkpvF54phZR1k+GMoO3cFB
         8+yMYWtI2ms5W4SNNI/+8bedDXInqF7uZ4EJJLIQQ2e5vDQI9i+wT2CgplHPadZ1FIku
         S3s1uk/rgxY1Rmak4CNnyxpJuuL56hfLHM7O8=
Received: by 10.205.124.144 with SMTP id go16mr9697684bkc.119.1321241562218;
 Sun, 13 Nov 2011 19:32:42 -0800 (PST)
Received: by 10.204.23.2 with HTTP; Sun, 13 Nov 2011 19:32:11 -0800 (PST)
In-Reply-To: <7vbosfoiuy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185361>

2011/11/14 Junio C Hamano <gitster@pobox.com>:
>> diff --git a/builtin/branch.c b/builtin/branch.c
>> index 0fe9c4d..5b6d839 100644
>> --- a/builtin/branch.c
>> +++ b/builtin/branch.c
>> @@ -115,8 +115,10 @@ static int branch_merged(int kind, const char *=
name,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 branc=
h->merge[0] &&
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 branc=
h->merge[0]->dst &&
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (refe=
rence_name =3D
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reso=
lve_ref(branch->merge[0]->dst, sha1, 1, NULL)) !=3D NULL)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reso=
lve_ref(branch->merge[0]->dst, sha1, 1, NULL)) !=3D NULL) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 reference_name =3D xstrdup(reference_name);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 reference_rev =3D lookup_commit_reference(sha1);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 if (!reference_rev)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reference_rev =3D h=
ead_rev;
>> @@ -141,6 +143,7 @@ static int branch_merged(int kind, const char *n=
ame,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 " =C2=A0 =C2=A0 =C2=A0 =C2=A0 '%s',=
 even though it is merged to HEAD."),
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name, reference_name);
>> =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 free((char*)reference_name);
>> =C2=A0 =C2=A0 =C2=A0 return merged;
>> =C2=A0}
>
> Now reference_name stores the result of xstrdup(), it does not have r=
eason
> to be of type "const char *". It is preferable to lose the cast here,=
 I
> think. The same comment applies to the remainder of the patch.

But resolve_ref() returns "const char *", we need to type cast at
least once, either at resolve_ref() assignment or at free(), until we
change resolve_ref(). Or should we change resolve_ref() to return
"char *" now?
--=20
Duy
