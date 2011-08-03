From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] For Real - Fixed pluralization in diff reports
Date: Wed, 03 Aug 2011 06:38:43 -0700 (PDT)
Message-ID: <m3livdqh9h.fsf@localhost.localdomain>
References: <4E362F8E.1050105@gmail.com>
	<CAGdFq_iwEvD_-hD63KeF45WuRhWrK6JuWWqzDpjHcZ+0gHDaqg@mail.gmail.com>
	<4E36B8E4.5080900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: unlisted-recipients:; (no To-header on input) git@vger.kernel.org,
	gitster@pobox.com
To: Jon Forrest <nobozo@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 15:38:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qobes-0001Cw-KT
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 15:38:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997Ab1HCNir convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Aug 2011 09:38:47 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33407 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733Ab1HCNip convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2011 09:38:45 -0400
Received: by fxh19 with SMTP id 19so675727fxh.19
        for <git@vger.kernel.org>; Wed, 03 Aug 2011 06:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=6J8X6m9rJtswirN0Wx2d2SRhe6sqVoV5GRkZ1FmNmNI=;
        b=ReQbPo2drtfoRzxAaQLspHg7T159qZSi+msfF9KFAVotTs6vitRGVG6pIpg8cd6h28
         BIR5SjhDM7NLL1/qoiZtuk2RUZLyV9Pf2SguH1lX+U1FKpqw6E4fErzw9ig1S671Ijj7
         bR8G7DjOYmmUHqXjIBnuTBpHw/x2wpJ9Bf4ss=
Received: by 10.223.98.78 with SMTP id p14mr3170018fan.8.1312378724321;
        Wed, 03 Aug 2011 06:38:44 -0700 (PDT)
Received: from localhost.localdomain (abvd21.neoplus.adsl.tpnet.pl [83.8.201.21])
        by mx.google.com with ESMTPS id x2sm539718fal.20.2011.08.03.06.38.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 03 Aug 2011 06:38:43 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p73DbkXI002128;
	Wed, 3 Aug 2011 15:38:20 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p71FWhfs032155;
	Mon, 1 Aug 2011 17:32:43 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
	Cc:	unlisted-recipients:; (no To-header on input)git@vger.kernel.org
								     ^-missing end of address
In-Reply-To: <4E36B8E4.5080900@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178575>

Jon Forrest <nobozo@gmail.com> writes:
> On 8/1/2011 2:58 AM, Sverre Rabbelier wrote:
>> On Mon, Aug 1, 2011 at 06:46, Jon Forrest<nobozo@gmail.com>  wrote:

>>>         fprintf(options->file, "%s", line_prefix);
>>>         fprintf(options->file,
>>> -              " %d files changed, %d insertions(+), %d deletions(-=
)\n",
>>> -              total_files, adds, dels);
>>> +              " %d file%s changed, %d insertion%s(+), %d deletion%=
s(-)\n",
>>> +              total_files, total_files =3D=3D 1 ? "" : "s", adds, =
adds =3D=3D 1 ?
>>> "" : "s", dels,
>>> +               dels =3D=3D 1 ? "" : "s");
>>>   }
>>
>> Also, this is rather detrimental to the i18n effort methinks?

Besides, as it was already said, this is an API.
=20
> If the goal if the i18n effort is also to produce grammatically
> correct output in all the supported languages then the
> tests that my patch would break would have to be rewritten
> anyway.

That's not it.

The problem is that above code assumes that plural form can be formed
by adding suffix, and it assumes that is only one plural form... both
assumptions does not hold for non-English.

C.f. "Additional functions for plural forms" chapter in gettext info
page: http://www.gnu.org/s/hello/manual/gettext/Plural-forms.html

--=20
Jakub Nar=EAbski
