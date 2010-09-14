From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/8] tree_entry_interesting(): remove dependency on struct diff_options
Date: Wed, 15 Sep 2010 08:33:41 +1000
Message-ID: <AANLkTimHykY5V=C7vmDoA-HCWYLJT_p4MEyfdMqXgB6+@mail.gmail.com>
References: <1283961023-4491-1-git-send-email-pclouds@gmail.com>
	<1283961023-4491-4-git-send-email-pclouds@gmail.com>
	<7vr5gw8geb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 15 00:33:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ove4U-0000vT-Pv
	for gcvg-git-2@lo.gmane.org; Wed, 15 Sep 2010 00:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752714Ab0INWdo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Sep 2010 18:33:44 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39334 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184Ab0INWdn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Sep 2010 18:33:43 -0400
Received: by wwd20 with SMTP id 20so332164wwd.1
        for <git@vger.kernel.org>; Tue, 14 Sep 2010 15:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fBX3qwdNROvBlKUcl+0sqDdS1XeQwWEIhlOAyb/ptSw=;
        b=RAjhMTAaB8UuKL46T16OF8Q5+mYg9eW2Y4DJpdISxK7cODziQwsnfuiGFajDyWQ43r
         okXHZbDU1bNiPciXPQQLuu+APXgz/ESW/XNLZNyy8ZJVtp6Cb8iBv2up49eIbKLW1tAZ
         KFRMJFx2R6uB4VhGW51Jtm+N8flBDQrynSp9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LB+LLCaSBwPbsjLH2Cqf+HebqBrb9XShgDjR+HOvmlcwHYgnmaOUNiL3PQfUUIM73e
         F+DTxyGbi2+1XgTne4pEIF7mHzBQT9/oennwrsGM3t/Aj6QqBCN7iNLJakl+Acl9cjHd
         rznzpdg2Ia40TZpKt/x3VFINS2II2yRq4/Ux8=
Received: by 10.216.54.9 with SMTP id h9mr4534276wec.34.1284503622055; Tue, 14
 Sep 2010 15:33:42 -0700 (PDT)
Received: by 10.216.171.134 with HTTP; Tue, 14 Sep 2010 15:33:41 -0700 (PDT)
In-Reply-To: <7vr5gw8geb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156214>

2010/9/15 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> This function can be potentially used in more places than just
>> tree-diff.c. "struct diff_options" does not make much sense outside
>> diff_tree_sha1().
>>
>> Moreover people seem to be agree that diff machinery should learn
>> proper pathspecs too (i.e. globbing, negative pathspecs...), not jus=
t
>> treating pathspecs as tree prefix.
>
> There is nothing improper about the prefix match. =C2=A0Perhaps "rich=
er"?
> I am not so sure about the need/desirability of negative match, but w=
e
> will see.

Negative match has been mentioned twice recently, once in Elijah's
sparse clone [1] and once by a user [2].

[1] http://mid.gmane.org/AANLkTikJhSVJw2hXkp0j6XA+k-J-AtSYzKWumjnqqsgz@=
mail.gmail.com

[2] http://mid.gmane.org/AANLkTikUadS+tj3ARdRqo=3DPSBVhTsJaUxaJv+=3D4hM=
f4s@mail.gmail.com

>
> About naming. =C2=A0Where else other than "tree" (in the "hierarchica=
l
> namespace" sense) context do you see pathspec? =C2=A0Does the struct =
really
> need to be called TREE_pathspec_list?

Pathspecs are usually stored in a list, const char ** and I don't want
to take the generic name "pathspec_list", unless we convert all to use
this struct. Any suggestions of other names?
--=20
Duy
