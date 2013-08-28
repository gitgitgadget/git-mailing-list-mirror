From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/8] remote-bzr: fix export of utf-8 authors
Date: Wed, 28 Aug 2013 16:38:54 -0500
Message-ID: <CAMP44s1P1NgusfH4oS4y-NNCXsNNrECSd5je01D6HL_=p7OHBw@mail.gmail.com>
References: <1377717793-27170-1-git-send-email-felipe.contreras@gmail.com>
	<1377717793-27170-2-git-send-email-felipe.contreras@gmail.com>
	<vpqhae97f8j.fsf@anie.imag.fr>
	<CAMP44s2bu9gUE=McYq1prhjC3O2CRj1W_Yc+-CjTkk6Gc3JFTw@mail.gmail.com>
	<CALWbr2xi1+EKHry4GRwLv=SwRUsaTKLQc6RUfuPKEre4pcpaFg@mail.gmail.com>
	<CAMP44s2G0Nm56q30EXgjpatsJhQZgiJ6uxr83o_74TsUAnHt3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 28 23:39:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEnS8-00020X-Fy
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 23:39:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754993Ab3H1Vi4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Aug 2013 17:38:56 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:38017 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754222Ab3H1Viz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Aug 2013 17:38:55 -0400
Received: by mail-lb0-f182.google.com with SMTP id r12so3500lbi.41
        for <git@vger.kernel.org>; Wed, 28 Aug 2013 14:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=UFqyEYedJ9AascMVOmQmubUU4wC5snOxl9rhi7JFGyw=;
        b=xA37Lp3uyTcv7XLjwonJioP7peGGhJkplt3G89I+bCzXagRAMaKguDJWya9GZufWNp
         wSL4cZ8aV3ZulWmhjrzSc8kV45FLD6xiO44SrNEWQvqVeGKdMJul+kuSTKymIRuwKFdj
         IEbEhGzSd/qwDJ1RH9GYv1RJWVNGDBexee6mNHdtaSeVbfKgyocCU9ElhheKZLfqpMNG
         YoyeNN7gPeEjSggVen9SfeAXmKHS0BnS2PBrZbWozrCD0oxPCCHRvnpHrHeLrgYk1yyu
         2YCW1Worc9Z/xNay6s6PSNNmnBePyZvpYUPvPEFLLYCuiYuKmcBC5Ddx2S6M5ITPIIuo
         bqhw==
X-Received: by 10.152.27.202 with SMTP id v10mr77504lag.43.1377725934594; Wed,
 28 Aug 2013 14:38:54 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Wed, 28 Aug 2013 14:38:54 -0700 (PDT)
In-Reply-To: <CAMP44s2G0Nm56q30EXgjpatsJhQZgiJ6uxr83o_74TsUAnHt3w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233219>

On Wed, Aug 28, 2013 at 4:21 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Wed, Aug 28, 2013 at 3:54 PM, Antoine Pelisse <apelisse@gmail.com>=
 wrote:
>> On Wed, Aug 28, 2013 at 10:48 PM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>> On Wed, Aug 28, 2013 at 3:05 PM, Matthieu Moy
>>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>>
>>>>> +     echo greg >> content &&
>>>>> +     git add content &&
>>>>> +     git commit -m one
>>>>
>>>> test_commit would make it shorter.
>>>
>>> And it would make it inconsistent with the rest of the script.
>>>
>>>>> +     bzr log | grep "^committer: " > ../actual
>>>>> +     ) &&
>>>>> +
>>>>> +     echo "committer: Gr=C3=A9goire <committer@example.com>" > e=
xpected &&
>>>>
>>>> Git's source code usually says >../actual and >expected, without s=
pace
>>>> after '>'.
>>>
>>> Not that usually:
>>>
>>> % git grep ' > ' t/*.sh | wc -l
>>> 1943
>>
>> There are many false positive in that count.
>>
>> As in this one:
>> $ git grep ' >[^ ]' -- t/*.sh | wc -l
>> 10354
>
> Ten thousand is still a lot, and the claim remains: it's far from
> unusual to follow this style.

Er, I read that command wrong, but whatever the actual number is, the
point is that there's a lot.

In fact, I could only count 43 false positives in that command:

t/annotate-tests.sh:test_expect_success 'blame -L X (X > nlines)' '
t/annotate-tests.sh:test_expect_success 'blame -L ,Y (Y > nlines)' '
t/lib-diff-alternative.sh:    if(n > 1)
t/lib-diff-alternative.sh:    if(n > 2)
t/lib-diff-alternative.sh:+    if(n > 2)
t/lib-diff-alternative.sh:-    if(n > 1)
t/t3800-mktag.sh: > 0 +0000
t/t4041-diff-submodule-option.sh:  > Add foo3 ($added foo3)
t/t4041-diff-submodule-option.sh:  > Add foo3 ($added foo3)
t/t4041-diff-submodule-option.sh:  > Add foo3 ($added foo3)
t/t4041-diff-submodule-option.sh:  > Add foo5 ($added foo5)
t/t4041-diff-submodule-option.sh:  > Add foo4 ($added foo4)
t/t4041-diff-submodule-option.sh:  > change
t/t4041-diff-submodule-option.sh:  > change
t/t4041-diff-submodule-option.sh:  > change
t/t4041-diff-submodule-option.sh:  > change
t/t4041-diff-submodule-option.sh:  > change
t/t4041-diff-submodule-option.sh:  > change
t/t4041-diff-submodule-option.sh:  > change
t/t4041-diff-submodule-option.sh:  > change
t/t7401-submodule-summary.sh:  > Add foo2
t/t7401-submodule-summary.sh:  > Add foo2
t/t7401-submodule-summary.sh:  > Add foo2
t/t7401-submodule-summary.sh:  > Add foo3
t/t7401-submodule-summary.sh:  > Add foo3
t/t7401-submodule-summary.sh:  > Add foo5
t/t7401-submodule-summary.sh:  > Add foo4
t/t7401-submodule-summary.sh:  > Add foo5
t/t7401-submodule-summary.sh:  > Add foo4
t/t7401-submodule-summary.sh:  > Add foo5
t/t7401-submodule-summary.sh:  > Add foo7
t/t7401-submodule-summary.sh:  > Add foo9
t/t7401-submodule-summary.sh:  > Add foo9
t/t7401-submodule-summary.sh:  > Add foo9
t/t7401-submodule-summary.sh:#   > Add foo9
t/t7508-status.sh:#   > Add foo
t/t7508-status.sh:#   > Add foo
t/t7508-status.sh:#   > Add bar
t/t7508-status.sh:#   > Add bar
t/t7508-status.sh:#   > Add bar
t/t7508-status.sh:#   > 2nd commit
t/t7508-status.sh:;   > Add bar
t/t7508-status.sh:;   > 2nd commit

--=20
=46elipe Contreras
