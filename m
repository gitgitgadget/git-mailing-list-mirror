From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] worktree setup: return to original cwd if prefix is 
	set NULL
Date: Sat, 24 Jul 2010 10:50:09 +1000
Message-ID: <AANLkTin6xGRz7wFyWtYg4ysPPytEW-uQn8ij1YbjJ_m9@mail.gmail.com>
References: <1279886651-14590-1-git-send-email-pclouds@gmail.com> 
	<AANLkTimkwfetLWynKCGVxMT0ZzHOZQp_iknrohoV8A79@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 24 02:50:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcSwm-0003uu-0Z
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 02:50:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753843Ab0GXAub convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Jul 2010 20:50:31 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:57846 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752261Ab0GXAua convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jul 2010 20:50:30 -0400
Received: by pvc7 with SMTP id 7so3729463pvc.19
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 17:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=wi18vqlt28+JBylO3vlSGBNhZKT2z0fM+0u3grddt7M=;
        b=LBwX/fo+GOrG+vJprZLYnwGuJkHzQdFO3L1Y3DRk14KYiZCOtdnDTEgpy3CwhECJnq
         70DttM4tujesgo7/Xam0VU+J/SX9kr92yHWvOnwej5rBXnVC+4pBJacV+o5GebPeRYoW
         FbyaKHLYagzHVabjwiOY1duerzqPFd9tHIpN4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=FBcfVU4+WDDHgzsihJ3cQHqfrCF02S0mFBpej8Kjrzzl6Yg9inBIap8iEnhtTahx0Q
         DbvE/WX7SmDMcBOzdLcW0YxximkCkvxpQAfyRGYdmRGzFpay5cujXhex5ruWqUnV17ZD
         gB/qAgB7HCQMYPJoX61sXwivQCoHEElll6pis=
Received: by 10.142.150.28 with SMTP id x28mr4998827wfd.203.1279932630040; 
	Fri, 23 Jul 2010 17:50:30 -0700 (PDT)
Received: by 10.142.98.1 with HTTP; Fri, 23 Jul 2010 17:50:09 -0700 (PDT)
In-Reply-To: <AANLkTimkwfetLWynKCGVxMT0ZzHOZQp_iknrohoV8A79@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151586>

2010/7/24 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>:
> 2010/7/23 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.co=
m>:
>
>> +test_expect_success 'cwd is unchanged when prefix is NULL (from wit=
hin a repo)' '
>> + =C2=A0 =C2=A0 =C2=A0 (
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cd repo.git/objec=
ts &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo 1 > one &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cp one expected &=
&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo 2 >> expecte=
d &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git apply patch &=
&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_cmp expected=
 one &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rm one expected p=
atch
>> + =C2=A0 =C2=A0 =C2=A0 )
>> +'
>
> Is the rm at the end needed here?
>
> This is a minor nit, but it's generally helpful for debugging tests
> that things aren't removed if the --debug option is specified.
>

I don't want to pollute the repo early. If the test fails, rm would not=
 be run.
--=20
Duy
