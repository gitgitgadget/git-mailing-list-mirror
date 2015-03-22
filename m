From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/5] Add tests for git-log --merges=show|hide|only
Date: Sun, 22 Mar 2015 18:40:13 -0400
Message-ID: <CAPig+cT-EJMBZN72N=DREZjn=c1rxgMsnJ=HNS4R3sGTUPUu0A@mail.gmail.com>
References: <1427048921-28677-1-git-send-email-koosha@posteo.de>
	<1427048921-28677-4-git-send-email-koosha@posteo.de>
	<550F1E9F.40801@web.de>
	<550F3D3B.7080104@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Git List <git@vger.kernel.org>
To: Koosha Khajehmoogahi <koosha@posteo.de>
X-From: git-owner@vger.kernel.org Sun Mar 22 23:40:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZoXj-0007bx-Ns
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 23:40:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbbCVWkS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Mar 2015 18:40:18 -0400
Received: from mail-yh0-f53.google.com ([209.85.213.53]:33587 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895AbbCVWkO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Mar 2015 18:40:14 -0400
Received: by yhpt93 with SMTP id t93so60966933yhp.0
        for <git@vger.kernel.org>; Sun, 22 Mar 2015 15:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=bd+zsx7UjJRi0oOGnk1rWdhYGafhhrk14m6CgM1XZdA=;
        b=cB95JNxg7RqjMhJQJzbvcyx21qvIgV0068E5QvKLZjCB8x2ex9yy9FcAzkL3mll1he
         l4RejZYamHccq0t0ZdNmHbb8EtlMTvjMiTn5vz0C4d7azi69/W0BKaEyKCsObHIqfIoS
         4Jl/vmKo8T3+Ahy9z7CsjnKf0DHvgp9stwcnrik7H5ptMAJITznbPuxoEJYbtN1uBJL6
         Onygsu4Z7FthminXsO/OVmPKmtjG3FnHldggHrPrxKn8e7bxSWctrwdJaTzfwbckOyIg
         0pp+GOYj6/vtdh0CbLjpjOTQx+BRv8H1K39Md7xL3yvI3VIs0Fd60WowxpOhTqMDeQ8k
         kqAw==
X-Received: by 10.236.202.98 with SMTP id c62mr12824642yho.166.1427064013858;
 Sun, 22 Mar 2015 15:40:13 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Sun, 22 Mar 2015 15:40:13 -0700 (PDT)
In-Reply-To: <550F3D3B.7080104@posteo.de>
X-Google-Sender-Auth: iJZFdcy770XJ7LB3_sVZn8k3Hj4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266100>

On Sun, Mar 22, 2015 at 6:07 PM, Koosha Khajehmoogahi <koosha@posteo.de=
> wrote:
> On 03/22/2015 08:57 PM, Torsten B=C3=B6gershausen wrote:
>> On 22.03.15 19:28, Koosha Khajehmoogahi wrote:
>>> Signed-off-by: Koosha Khajehmoogahi <koosha@posteo.de>
>>> ---
>>> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
>>> index 5f2b290..ab6f371 100755
>>> --- a/t/t4202-log.sh
>>> +++ b/t/t4202-log.sh
>>> @@ -428,6 +428,147 @@ cat > expect <<\EOF
>>>  * initial
>>>  EOF
>>>
>>> +test_expect_success 'log with config log.merges=3Dshow' '
>>> +    git config log.merges show &&
>>> +    git log --pretty=3Dtformat:%s >actual &&
>>> +    test_cmp both_commits_merges actual &&
>>> +    git config --unset log.merges
>> Do we need the unset here?
>> The log.merges is nicely set up before each test case, so can we dro=
p the unset lines ?
>> (Or do I miss something ?)
>
> Good point; we can drop only those unset lines whose next test sets t=
he log.merges.
> However, if the next test does not set it, we must unset it as it aff=
ects the
> default behavior of git-log.

Such an approach would be too fragile. Tests may be re-ordered, added,
or removed. Better is to make each test as self-contained as possible.
See my review[1] of this patch for alternate suggestions.

[1]: http://article.gmane.org/gmane.comp.version-control.git/266099
