Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49212EB64DA
	for <git@archiver.kernel.org>; Sat,  8 Jul 2023 07:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjGHHQa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Jul 2023 03:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGHHQ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jul 2023 03:16:26 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9891FF6
        for <git@vger.kernel.org>; Sat,  8 Jul 2023 00:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1688800578; x=1689405378; i=l.s.r@web.de;
 bh=NcZd7TAz84oLV43c9PYIGFcYnH2qojwMAu72GctPu64=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=lgebuQkOegC/a/HRlwNG01dXS0DOpttKez08cnNXu4fb/ptmnevYap8PTmxFWE6JMcgkxlL
 OzyCmzz+AbH7Xs8OdWTXsmYZ5/pl6rQA9qR6UJOgFJ1RNCGjrWZeAE04YL41NYVJ9GDwmjgb3
 BYpxYiAtRmcO4NOO4+z6UFNsK8qM3QHWVe0IedzXeOb2rlc8ikvBMTuJPQgK/pmscDrkoXIzn
 WErf8z+brfViLe/dnk3dzpz5xbYjVbAKDHfLyL2XbzYCFB1n0FjVO0elHwxFa9FyzkNh+49U4
 yBxQ+b2e0hB0pnd8B8MnuhBEvFubqA+94te2MjVxBSC0mHEhwZog==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.158.134]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N5CQh-1pshEt02ab-01135C; Sat, 08
 Jul 2023 09:16:18 +0200
Message-ID: <26f81ed0-8d1f-e0be-9696-25ce3938ae09@web.de>
Date:   Sat, 8 Jul 2023 09:16:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2alt] dir: do not feed path suffix to pathspec match
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20230707220457.3655121-1-gitster@pobox.com>
 <20230707220457.3655121-3-gitster@pobox.com> <xmqqttuf70bn.fsf_-_@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqttuf70bn.fsf_-_@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wWdVkRMLdk6g9XmbVIPfyqRUI89Oz9p2+2Ts5cNuza5TP9xJPdc
 BAMtYlYiz2NGkFXok4Aaiuh6YOG1Uv2arkEx0hk5GxcufG4JTpWs13T3BhQqQhDSGNiOTfZ
 /RG+XktWLVmoWP0bZfKpdLFFrfIdEJcmGLFyGsARVY1UF7WsJd6dg6C7reK+jOSTvNVwSSm
 qzjcWV7rrSqmuIeiZViJA==
UI-OutboundReport: notjunk:1;M01:P0:3/B+b32keGk=;AzJsBRS6bfEHiCaw8Th8VdmE/Sa
 lMrrbld9EU3Ok2o+zIMlGZAOY6V8Dc/Xztjm8a1aFt74407/Ks866Jf9yj61mfeBD64LABmu8
 YZ1NN+xfyxKIIyvxmKN6aXCeRzii3JDG7IXgggW16Iz8FEcwtusR3+rNSiSNCiGx8+FgFlA27
 dCziWyhnfg5+nc1N7Q4ZreGhVmM3e3nOiKP83fAerSBa41jRtbNHYFtOTDfxPolpVCShegvWV
 HiJbkzf7OghFMIv9svw1xXvmXVmYqkTrX+j7W8bOOVeq4jb2/34Pp6GHSpovQhFF2UrzgBKcy
 uokDTUTXeHVUFN4sb7AUoGRfUYAGnSsZKdU5xiUFhMeToR5VFfGAo+7nMtyAN7AhUvsGP6DCl
 s7/CfSwhKS3btiaqbISvBdHjFVtD90kuUMnTaQb7ndgcFA0SIPS+E72gUjpS4OjTgPD4RktNV
 IA0zN/QZzPlrmFQuh1EiQofzChuKg/k1CmgWj1qcV+9JEbK7eQJz4x2zvG0nKnQK0uMoU4n5D
 XXuwClzdOLTHp7aDT17MLOhWWvHr2VmJvkqQdTiYoSJ+5+bqebdHdm5oFSDlNChH8gQL4s5kr
 wZIsN+XdFU6Ah99pkB7+pocP5yFQ9kNWUIvZw6SmkQpbMcoVHTXDjdwoDFjy2B3GBiwP747xR
 0OqeRffn1CCb3gQ3PNsgHuRe2UTrN8gjUre7QOtC9+KsXc9YV63nRwn+vzI+Vn+ARQL/YaYP/
 TJqu54TpEAcPLSUbSagdH9VizFc834Lz+EhHI9WwgA/DnnBKYn3CoieZ03HMAALDS1CcAkErY
 ItZyXF+PgkASinttzRvs5nltQBOYUQZ+RxGzN02AUwlp1OM+RziurUXh1yp9CcRBc8XyeDNAu
 hsKso6ZAmErk2zY5VjsK/6oN3VlcqP3ncQOSRvBeS8nXySSqPX3vsmyFuDIhdZIM9Oxua7cFQ
 srr0sA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.07.23 um 01:45 schrieb Junio C Hamano:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> ...
>>  * do_match_pathspec() calls match_pathspec_item() _after_ stripping
>>    the common prefix "sub/" from the path, giving it "file", plus
>>    the length of the common prefix (4-bytes), so that the pathspec
>>    element "(attr:label)sub/" can be treated as if it were "(attr:label=
)".
>>
>> The last one is what breaks the match, as the pathspec subsystem
>> ends up asking the attribute subsystem to find the attribute
>> attached to the path "file".
>> ...
>> Update do_match_pathspec() so that it does not strip the prefix from
>> the path, and always feeding the full pathname to match_pathspec_item()=
.
>
> Here is an alternative approach with a lot smaller code footprint.
> Instead of teaching do_match_pathspec() not to strip the common
> prefix from the pathname, we teach match_pathspec_item() how to
> recover the original pathname before stripping, and use that when
> calling match_pathspec_attrs() function.  The same trick is already
> used in an earlier part of the same function, so even though it
> looks somewhat dirty, it is unlikely that it would introduce
> more breakage.
>
> As the test part is the same, I'll just show the code change
> relative to the 'master' branch.
>
> I am undecided which one is better.
>
>  dir.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git c/dir.c w/dir.c
> index a7469df3ac..635d1b058c 100644
> --- c/dir.c
> +++ w/dir.c
> @@ -374,7 +374,7 @@ static int match_pathspec_item(struct index_state *i=
state,
>  		return 0;
>
>  	if (item->attr_match_nr &&
> -	    !match_pathspec_attrs(istate, name, namelen, item))
> +	    !match_pathspec_attrs(istate, name - prefix, namelen + prefix, ite=
m))

match_pathspec_item() has only one caller, and it did the opposite, so
this is safe.  And a minimal fix like that is less likely to have side
effects.  Removing the trick will surely improve the code, though.  If
match_pathspec_item() needs the full name then we should pass it on,
and if the "prefix" offset needs to be added then it can happen right
there in that function.

>  		return 0;
>
>  	/* If the match was just the prefix, we matched */

