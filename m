From: =?UTF-8?Q?Pierre=2DFran=C3=A7ois_CLEMENT?= <likeyn@gmail.com>
Subject: Re: Git reset --hard with staged changes
Date: Tue, 10 Jun 2014 18:30:13 +0200
Message-ID: <CANWD=rWRT1iarnZzyd75g6gr0nyo3rrdH01j+Bjq0t4q2UUhhg@mail.gmail.com>
References: <CANWD=rWmzgAwTp=E_1=th0Myk-dh4m5Y9PE3=fpHeirsVVQKwQ@mail.gmail.com>
 <CANWD=rX-MEiS4cNzDWr2wwkshz2zu8-L31UrKwbZrJSBcJX-nQ@mail.gmail.com>
 <87vbsayy9w.fsf@fencepost.gnu.org> <CANWD=rVB249Vu1QMk64V+FxfCfJPzxqZgCfyEuixJJ_iKoTLPQ@mail.gmail.com>
 <xmqq61k9d5nk.fsf@gitster.dls.corp.google.com> <CANWD=rUz9Wgoktp7-NkQMvWDmYOPv0kMqUNoe4FPJ9+Ax_UJBA@mail.gmail.com>
 <871tuwss2p.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Jun 10 18:31:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuOwk-000123-EN
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 18:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbaFJQag convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jun 2014 12:30:36 -0400
Received: from mail-ve0-f169.google.com ([209.85.128.169]:40048 "EHLO
	mail-ve0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbaFJQaf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jun 2014 12:30:35 -0400
Received: by mail-ve0-f169.google.com with SMTP id pa12so2141056veb.0
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 09:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=j6puxk2w9oaFnQVhv9DvylI7WBI8pao/E9a6LGdiTB0=;
        b=LJv9YqKFeW6on3FbPHrZIfpLOS3XEZfOBnuuH7TSFMNUiTSciAU25EVmO7ASvmjdG8
         mylN/t5vs2bGJOemX7fcz6L7OwolN6BUu2gQL6c4JdjVT03juYYgmuhaNaOTJ3IwvEIP
         uqY7SMeIy5MIl8EHO1pxAwlYeptQlRHauGVKv2bmJpjvJ0CSlESL6/K8B98XbwIUrIlK
         nAEnTgun25JuiUe6c0z3XwQ0/HficKXkMzFz6uHyvFB9XqytBdtLOy5+OWvvJmEROlwE
         eAZujpKAPKqu4G5cbpI3DNL4LLu69qUqmfP55utktD738UYQ0atADGHWRuSxurvstGiL
         gMSw==
X-Received: by 10.52.121.19 with SMTP id lg19mr14027918vdb.54.1402417835016;
 Tue, 10 Jun 2014 09:30:35 -0700 (PDT)
Received: by 10.58.182.104 with HTTP; Tue, 10 Jun 2014 09:30:13 -0700 (PDT)
In-Reply-To: <871tuwss2p.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251203>

2014-06-10 17:27 GMT+02:00 David Kastrup <dak@gnu.org>:
> Pierre-Fran=C3=A7ois CLEMENT <likeyn@gmail.com> writes:
>
>> 2014-06-10 1:28 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
>>> Pierre-Fran=C3=A7ois CLEMENT <likeyn@gmail.com> writes:
>>>
>>>> Hm, I didn't think of "git apply --index"... Makes sense for this
>>>> special use, but I'm not sure about the other use cases.
>>>
>>> Try merging another branch that tracks a file your current branch
>>> does not know about and ending up with conflicts during that merge.
>>> Resetting the half-done result away must remove that new path from
>>> your working tree and the index.
>>
>> Hm I see. Even though the documentation doesn't make it very clear
>> about what happens to such files, it turns out the scenario we
>> stumbled upon seems to be the special use case after all. Thanks for
>> shedding some light on this :) I wonder why does git-reset's hard mo=
de
>> not always remove untracked files then?
>
> Because it never removes them?  Git only removes files once it tracks
> them.  This includes the operation of removing _and_ untracking them,
> like with git reset --hard.
>
> The only command which explicitly messes with untracked files is
> git-clean.
>
> --
> David Kastrup

Yeah sorry, I just noticed the emails on the definition of what are
(un)tracked files
(http://thread.gmane.org/gmane.comp.version-control.git/251071/focus=3D=
251151),
as I didn't get them in my inbox for some reason. So staged files
which aren't in HEAD are also considered tracked -- which explains it
all. Someone told me that too on the "Git for human beings" Google
Group, but I couldn't find a definition that backs this in the man
pages (maybe the git-glossary would be a good place for it?), and the
one from the Git-Scm book only confused me in thinking the opposite.
Thanks for the clarification

--
Pierre-Fran=C3=A7ois CLEMENT
Application developer at Upcast Social
