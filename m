From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 5/5] builtin/clone: support submodule groups
Date: Wed, 25 Nov 2015 10:08:38 -0800
Message-ID: <CAGZ79kZrBRo9dfU=p8-bgvSpp=SSiXQHZGm7iCQ=9v0f_f_-aQ@mail.gmail.com>
References: <1448415139-23675-1-git-send-email-sbeller@google.com>
	<1448415139-23675-6-git-send-email-sbeller@google.com>
	<5655F544.6050003@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Eric Sunshine <ericsunshine@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Nov 25 19:08:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1eUj-000175-TH
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 19:08:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751944AbbKYSIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 13:08:40 -0500
Received: from mail-yk0-f169.google.com ([209.85.160.169]:33092 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566AbbKYSIj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 13:08:39 -0500
Received: by ykdv3 with SMTP id v3so64703040ykd.0
        for <git@vger.kernel.org>; Wed, 25 Nov 2015 10:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=TnICb8jhvwrGsM0jsJr8KXS/GBbRcLgnRuoCANem3Wg=;
        b=DQ65Rf4VpjI3Rq5AzrBg3VVBJPhi8BoT1mTAR8Vq51r+9NeCdRAOCoM0bWbWiaNg1+
         VMPmbaFqZJqS1k8nsCPU88mc8d47nX4bq/hUMw5LpTq+kiAtHWIa5MG/e1GEUj04YfPf
         kwLWb4dHQQhfD0Ad5PtfKjgGPkn0lzjGdfjT8HlenMw6zUp/sRjJdrjjShBbwCystcxE
         NNjsfnCB124MsOPo85iD//bPDybIGZUXKuZiIE77crJ1Qw3zkFeRhdCvgY4i9YIe++vI
         6cFrEawyzWFVFnEjYItVS7f6pGj12cf+cRW16sO/I104HoM0SYGfrBcCWWx8GkaNQXoQ
         n5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=TnICb8jhvwrGsM0jsJr8KXS/GBbRcLgnRuoCANem3Wg=;
        b=V/AIZYjMz6+yHiuVmYB+oeh7FPFepplSTIKOlYinfeWaoaPMjBgXNopI5DjquAHsx+
         VpKiqquVrsFMdRmy2T/eGgtO6lkYxUoj6ZRzbCu/DukKXr3firdTja8DSF47wEz7Ryk4
         G3R8lXMrTOcPAWvWlhf2+X2pa9RsAODA0IwL3HfIyK1qljdPL1KR7r03kb8VjDC72mEQ
         g6mNDUyBNRrf1qip9W6s96LOA/3I7nirEXzYukll6e3+7ebU3LCvKv1hCXTWdm1IktO4
         YMspkZoC+YwJTkMvEKwoXCDXq3m84rqlDXyRPvyLTySlStRlFiZTQPUb/Roi+dXX5fhB
         C6Mg==
X-Gm-Message-State: ALoCoQmjGFcoCmVzHPxhfjxiiCUBgGjXdR0LZF1/6mVKpWWhSVhN2DRT1+q1cvEqoK9+GYvTrZPr
X-Received: by 10.13.251.2 with SMTP id l2mr33801654ywf.44.1448474918529; Wed,
 25 Nov 2015 10:08:38 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Wed, 25 Nov 2015 10:08:38 -0800 (PST)
In-Reply-To: <5655F544.6050003@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281724>

On Wed, Nov 25, 2015 at 9:52 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> +--group::
>> +       After the clone is created, all submodules which are part of the
>> +       group are cloned. This option can be given multiple times to
>> specify
>> +       different groups.
>
>
> Ah, that answers my question in my response to the cover letter ;-)
>
>> This option will imply automatic submodule
>> +       updates for the groups by setting `submodule.update=groups`.
>
>
> Please don't. The per-submodule update setting configures how a
> submodule has to be updated, adding a global one with a completely
> different meaning (what submodules should be updated?) is confusing.
> Why not "submodule.groups=<groups>"?

The documentation is out of date :/ as I was churning through lots of ideas,
so we do have a config submodule.groups=<groups> by now, but the
documentation is wrong.

>
>> +       The group selection will be passed on recursively, i.e. if a
>> submodule
>> +       is cloned because of group membership, its submodules will
>> +       be cloned according to group membership, too. If a submodule is
>> +       not cloned however, its submodules are not evaluated for group
>> +       membership.
>
>
> What do you mean by the last sentence? Did the clone fail? Then you
> cannot update the submodule anyway ...

Consider nested submodules:

    A: superproject containing
        B: which contains
            C.

If you clone A with group <C-but-not-B> you won't get C as we do not traverse
the submodules of B, as we don't clone B. Maybe it's obvious?

>> @@ -864,6 +876,21 @@ int cmd_clone(int argc, const char **argv, const char
>> *prefix)
>>                 option_no_checkout = 1;
>>         }
>>
>> +       if (option_recursive && submodule_groups.nr > 0)
>> +               die(_("submodule groups and recursive flag are
>> incompatible"));
>
>
> Me thinks this contradicts your description of the --group option
> in the man page. I don't see why such a restriction would make
> sense, what incompatibility are you trying to avoid here? Maybe
> we need another submodule-specific setting to tell update what
> groups to use inside that submodule?

So you want something like
    "In the top level respect the groups, but recursively get all of them"?

My thinking is that groups are implying recursive, whereas recursive implies
"all groups", so a git clone --group <half-the-submodules> --recursive
makes not much sense to me as it begs the question, what does --recursive
mean? Probably recurse into all submodules which are implied by the group
<half-the-submodules>. And then get all the nested submodules. But in case
you use the grouping feature, you could just mark the nested submodules with
groups, too?
