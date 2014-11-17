From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] Introduce a hook to run after formatting patches
Date: Mon, 17 Nov 2014 11:01:44 -0800
Message-ID: <CAGZ79kZsK=hkSOCnR75eDYauOt-biCD6_v0eH3Ls_Krb_UAAvQ@mail.gmail.com>
References: <1416012460-4459-1-git-send-email-sbeller@google.com>
	<xmqqzjbryonp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 20:01:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqRYf-0002cj-JZ
	for gcvg-git-2@plane.gmane.org; Mon, 17 Nov 2014 20:01:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939AbaKQTBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 14:01:49 -0500
Received: from mail-ig0-f178.google.com ([209.85.213.178]:63817 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297AbaKQTBs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 14:01:48 -0500
Received: by mail-ig0-f178.google.com with SMTP id hl2so2831070igb.11
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 11:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=aZXzI6SyW0jFyqVMAPHCwAyO7u7y5SBIKAwSbflIpi4=;
        b=kQoTUi0l2ENeEMj1Wd+IA/3bjvP7MqTTPQ3wJ/9ioNST07a113ZOq1YKYMj+J0Um2m
         920w65ipsKuaFVK0ZAW3vOyh9arminIQD3QdJ0G4iAmxkfmcoghAJNDCOlsegajqKFGb
         PoeUi6DSBb0gnz7BkzBSt9mGyPQaZuzw7GovQxUtVFwtTVXnsdgZ3I1QRCUpJ4VFD8xh
         wXdpm7u1c0et2v1AV1zgEDdVAHOHRXPsi5ETBsc/ZP7wKdelFqcG10CB46AsHvj8Tr9Q
         UvPqkOrXStlQsOMHSbuFdAOqt0tI0CFOrzSrekb8LrpAObZGe38OmXwF2XfY4Te5mJ2n
         aiig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=aZXzI6SyW0jFyqVMAPHCwAyO7u7y5SBIKAwSbflIpi4=;
        b=EX58i27QxAUyKqrRfv8/Q3CPwTbKTJ5Zih2kcYbkIhREO3px0rY8NGIqXonw5Zq4+T
         TOHIgxdxx3Q9v2bih0PfBu0pyWBU6LbFridbxUdFEQl9mAPYJ0rVnZU83VRGUjalYbtt
         sweeEN88qXytNdk66snQBljmWT+gxzLl3IlwoUpySli92gVVbuAY0xBJzeLZmXS3KISj
         Ssxw26675jYm5WbTll8SrUBZzv1qTMHbj1ctdXY4ZW1HNRok5x+7yL4INDARAQfWlWX4
         BN96OMMLk4NTW0JV3PYvejaOXaJldfxmr9Ueg5n8oKPTDyVOq+rfJzlyF3oyl0VjpTcF
         6kBw==
X-Gm-Message-State: ALoCoQnH0ocEc7tJdaudaHr/BRCkj2pgNIGfhE4MiC7rCQ9BGWr0rlH9w5xMu2h60nEhedO1IIZ4
X-Received: by 10.50.111.226 with SMTP id il2mr27687971igb.10.1416250905035;
 Mon, 17 Nov 2014 11:01:45 -0800 (PST)
Received: by 10.107.46.163 with HTTP; Mon, 17 Nov 2014 11:01:44 -0800 (PST)
In-Reply-To: <xmqqzjbryonp.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 16, 2014 at 10:40 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> +post-format-patch
>> +~~~~~~~~~~~~
>> +
>> +This hook is called after format-patch created a patch and it is
>> +invoked with the filename of the patch as the first parameter.
>
> Such an interface would not work well with --stdout mode, would it?
>
> And if this only works with output generated into the files, then
>
>     $ git format-patch $range | xargs -n1 $your_post_processing_script
>
> would do the same without any change to Git, I would imagine.

Ok I'll try to use these commands.

>
> So I would have to say that I am fairly negative on this change in
> the presented form.

Ok, I definitely did not expect this patch to be accepted the way it is,
but rather was just proposing an idea. The post-format-patch.sample
hook file would be missing for example.

>
> An alternative design to implement this as a post-processing filter
> to work for both "to individual files" and "to standard output
> stream" output filter may be possible, but even in that case I am
> not sure if it is worth the churn.
>
> In general I'd look at post-anything hook that works locally with a
> great suspicion, so that may partly be where my comment above is
> coming from.  I dunno.
>

Git is very easy to use when importing from other VCS, because of all
the helpers like high level git-svn or low level fast-import.

Patches on mailing lists can also be easily imported as a commit,
so I think having an exporting system in place with various options
like custom post processing would help for some use cases.

Anyway I'll just drop this patch and go with your suggestion.

Thanks,
Stefan
