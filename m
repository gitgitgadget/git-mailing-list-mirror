From: Prem Muthedath <prem.muthedath@gmail.com>
Subject: Re: [PATCH] git-push.txt: document the behavior of --repo
Date: Wed, 28 Jan 2015 21:50:13 +0530
Message-ID: <CAHQ-GLCBXFtLxDME83Qxbw_w1sPaKONzC8xrboh9v+jtEb7-Vw@mail.gmail.com>
References: <xmqqppa1mrku.fsf@gitster.dls.corp.google.com>
	<d8bed5c1736a4a291208227b0f54c1039d67f5cc.1422361902.git.git@drmicha.warpmail.net>
	<CAPig+cQCf+vKbZ5ydFSNmGCUvmCkQW-DEPhO1JAAap1VorhXsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 21:32:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGZHo-0001zH-Fb
	for gcvg-git-2@plane.gmane.org; Wed, 28 Jan 2015 21:32:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759901AbbA1UcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2015 15:32:22 -0500
Received: from mail-qg0-f43.google.com ([209.85.192.43]:33755 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756922AbbA1UcT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2015 15:32:19 -0500
Received: by mail-qg0-f43.google.com with SMTP id e89so19089065qgf.2
        for <git@vger.kernel.org>; Wed, 28 Jan 2015 12:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MmoI9p2T6sCfxPKYHFozKmyc826oELkLiW5BORCx048=;
        b=GHuBZtuq/Obe1GDEcJqpx1DpT+SCmFPjv5nJ0pxSbIfEurZ9MaHoiomsJ6g1+oTZhF
         wAOgw3phnD4uEez/Myx8/oMknWQI5N9RPJWSnKt9kso9pOKbyloWYFOgwMkzRXtOtGyQ
         njQCHaBJZC/gE6Qk+Jg7EuR5F+mTFK/v/nhMK2K+xrk+NFUVaXH+sCERmQDWj99Adk4i
         RbLCWSWB1sGWMPch/4aIxnLMEuxhErjwvq6jiApT9aeV1aFtFJj2+mMDNhvqEVj/8nEQ
         ixVCFBt4ZlkA/iOI3fghn/Y4g5PTaTQtE3I4j26b5bSQJmrjPTmW+cxNhywtkMdhyRu2
         3Cdw==
X-Received: by 10.140.20.226 with SMTP id 89mr14138679qgj.43.1422462013907;
 Wed, 28 Jan 2015 08:20:13 -0800 (PST)
Received: by 10.96.136.132 with HTTP; Wed, 28 Jan 2015 08:20:13 -0800 (PST)
In-Reply-To: <CAPig+cQCf+vKbZ5ydFSNmGCUvmCkQW-DEPhO1JAAap1VorhXsA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263111>

Hello Junio, Michael -- thanks much for clearing this up for me.
Appreciate your time.

If the --repo option works just like the <repository> argument to git
push, then I would suggest -- just as Junio has done -- that you
deprecate this option.  Otherwise, it would confuse users.


There is also a minor typo that I noticed in the push documentation
that you may want to correct.  In the "Examples" section in git push
manual for git 2.2.2 (see paragraph below), instead of
"remote.origin.merge", I think it should be "branch.<name>.merge"
configuration variable.

git push origin
Without additional configuration, pushes the current branch to the
configured upstream (remote.origin.merge configuration variable) if it
has the same name as the current branch, and errors out without
pushing otherwise.


Thanks,
Prem

On Wed, Jan 28, 2015 at 3:37 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Jan 27, 2015 at 7:35 AM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> As per the code, the --repo <repo> option is equivalent to the <repo>
>> argument to 'git push'. [It exists for historical reasons, back from the time
>> when options had to come before arguments.]
>>
>> Say so. [But not that.]
>>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
>> index ea97576..0ad31c4 100644
>> --- a/Documentation/git-push.txt
>> +++ b/Documentation/git-push.txt
>> @@ -219,22 +219,8 @@ origin +master` to force a push to the `master` branch). See the
>>  `<refspec>...` section above for details.
>>
>>  --repo=<repository>::
>> -       This option is only relevant if no <repository> argument is
>> -       passed in the invocation. In this case, 'git push' derives the
>> -       remote name from the current branch: If it tracks a remote
>> -       branch, then that remote repository is pushed to. Otherwise,
>> -       the name "origin" is used. For this latter case, this option
>> -       can be used to override the name "origin". In other words,
>> -       the difference between these two commands
>> -+
>> ---------------------------
>> -git push public         #1
>> -git push --repo=public  #2
>> ---------------------------
>> -+
>> -is that #1 always pushes to "public" whereas #2 pushes to "public"
>> -only if the current branch does not track a remote branch. This is
>> -useful if you write an alias or script around 'git push'.
>> +       This option is equivalent to the <repository> argument; the latter
>> +       wins if both are specified.
>
> To what does "latter" refer in this case? (I presume it means the
> standalone <repository> argument, though the text feels ambiguous.)
>
> Also, both the standalone argument and the right-hand-side of --repo=
> are spelled "<repository>", so there may be potential for confusion
> when talking about <repository> (despite the subsequent "argument").
> Perhaps qualifying it as "_standalone_ <repository> argument" might
> help.
>
>>  -u::
>>  --set-upstream::
>> --
>> 2.3.0.rc1.222.gae238f2
