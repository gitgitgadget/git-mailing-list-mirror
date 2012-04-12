From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 07/12] completion: simplify command stuff
Date: Fri, 13 Apr 2012 02:08:25 +0300
Message-ID: <CAMP44s3hAaVr2duNgPTg5VD0MmS9EJGVA2kNGrm_5ZshSBu+ew@mail.gmail.com>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
	<1333854479-23260-8-git-send-email-felipe.contreras@gmail.com>
	<20120411221430.GT2289@goldbirke>
	<CAMP44s3hYHxs2HZ59meEO=SU7gXuxU=m489LdxV38=7PDeDFdw@mail.gmail.com>
	<20120411230157.GV2289@goldbirke>
	<CAMP44s0avJZDZjUUK3TaMDtxRJ2xXo-bELAqDB_gW1cE+LMP9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Apr 13 01:08:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIT8E-0008Un-25
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 01:08:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756836Ab2DLXI1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Apr 2012 19:08:27 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48173 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916Ab2DLXI0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Apr 2012 19:08:26 -0400
Received: by eaaq12 with SMTP id q12so619873eaa.19
        for <git@vger.kernel.org>; Thu, 12 Apr 2012 16:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=euSWMPfD4yb3sWVcXFTUhaA+F25gESb6r3etyxZlyzA=;
        b=S4AXJqCBZqjVRThGPozBMV9ac3LevzrwOGzbgADagFyg0TZRDZIsgKBdUcAcLwNxec
         iZ5v0PMOIC9W2SNAi4GGEu8tlw/EdeJ7qRz+musDQKtkLj/8VKaOhI0PzEmzVY6zNuUW
         /DY8x88sOiGE0DB0m2CpON/qKJWyuHMXTkk06Z8XuW4jBR5X3K7tpWZuhBoMCft9na2p
         q0TbXf9k8cmmTZwPR+dtq8/Ci0ZemajqtGHnVOi9bx8NEnpmFuh0PFynV8KZkKYPiaOm
         Xh95oSMLkNkcCYw2qeXSsOlRPZk1RS6pN7gKKWh6PQnU2TpDCx+pvFui/2fEhoCYz6ss
         Z/WQ==
Received: by 10.14.127.129 with SMTP id d1mr4062eei.59.1334272105449; Thu, 12
 Apr 2012 16:08:25 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Thu, 12 Apr 2012 16:08:25 -0700 (PDT)
In-Reply-To: <CAMP44s0avJZDZjUUK3TaMDtxRJ2xXo-bELAqDB_gW1cE+LMP9g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195384>

2012/4/12 Felipe Contreras <felipe.contreras@gmail.com>:
> 2012/4/12 SZEDER G=C3=A1bor <szeder@ira.uka.de>:
>> On Thu, Apr 12, 2012 at 01:21:17AM +0300, Felipe Contreras wrote:
>>> 2012/4/12 SZEDER G=C3=A1bor <szeder@ira.uka.de>:
>>> > However, this change "promotes" the command (or cmd) variable fro=
m
>>> > being just a variable in _git() to a variable that is used in oth=
er
>>> > completion functions, too. =C2=A0Why not go one more step further=
, and
>>> > denote this by adding a __git prefix (i.e. renaming the variable =
to
>>> > __git_command)?
>>>
>>> After thinking more about it, and analyzing the next patches, I don=
't
>>> think it makes sense to have such a variable; it's only used by
>>> __git_complete_remote_or_refspec, and it would be easier to make it=
 an
>>> argument to that function; that would simplify this patch series a
>>> lot.
>>
>> You mean that _git_fetch() would call
>>
>> =C2=A0__git_complete_remote_or_refspec "fetch"
>>
>> while _git_pull() and _git_push() will pass "pull" and "push",
>> respectively?
>
> Yeap. Then there would not be any need for the foo_wrap () stuff.

Actually, there would be, we need to call _git_fetch(), but if we have
generic wrap function we don't know that; all we have is the alias
(e.g. gf from 'git fetch'). I guess we could do something like 'eval
$(alias gf)' and find out the right function to call, but that already
has an 'eval' there, I'm not sure it's worth it.

Any ideas?

--=20
=46elipe Contreras
