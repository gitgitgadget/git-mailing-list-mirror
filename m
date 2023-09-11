Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249F5CA0EC8
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 21:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349413AbjIKVda (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244368AbjIKUMM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 16:12:12 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701B2185
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 13:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1694463121; x=1695067921; i=l.s.r@web.de;
 bh=2jc68L3rufhtOYe5S4/Rcm/Frh8Eepn74aAsxneQ6UM=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=usp9GvqcW7XbH22/2DN4ZgqxQicj7VCYbdgfG8CX/E8LehEZ8KLXb6q6uvumQzM1/vDr2+8
 gAfO+bPimnqphbn0VN5pEYH812FZ14sSzAqp5K0WfyC2Q7AKV+WLQponi8IJeuB27DKFXm5gb
 ANd9QKdQdvvJ6O/dyTYvrgB/jBlnNxMdtRMcy3AZZbN05WuoLJVK+OCACAAjJUJq8GOe9Wihm
 frzZ+Jy2kR0Gc2085F2YSs9TFrpWBdJjTX6okYYsfrWqwskbZ7lt8OUBZf2Xqect0RDASIQDo
 5EEJOmzYoQXvUc/5Uc6uEZapg7gAN1kz3iCl8VekpeIh/od82xZw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.145.34]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MidDR-1q0OEZ3iGV-00fkpA; Mon, 11
 Sep 2023 22:12:00 +0200
Message-ID: <683efb6d-dc41-51ff-f048-7a23ee955e00@web.de>
Date:   Mon, 11 Sep 2023 22:12:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 1/2] parse-options: add int value pointer to struct option
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
References: <2d6f3d74-687a-2d40-5c0c-abc396aef80f@web.de>
 <ZP4NrVeqMtFTLEuf@nand.local>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <ZP4NrVeqMtFTLEuf@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YDfo3X59V1fGdn1hq+ovcDgEWCGXCpIOSIIEeEF0hM0miDH3k5E
 MCKG8Tw/sP2isL3aW6L1NG13ICUTF+JG4B7mN9TW3r+I/amTM6gsrp7um0dlnuUlG2cC1sZ
 PGo+OBsx2iVgOiUO4cLXeuuaif8nABxtVSxvAMlUd6zeddRbDKyJLTbuxWaKakfH5C4LmLk
 YtHTLsrQaEiDmEe3UPOMw==
UI-OutboundReport: notjunk:1;M01:P0:MtulBREWyTc=;I4unFgJwSA/AKchuxBdq7NTyFgg
 k3ydlb9xlabTddgLsNuVpJiZj/y4S+V0lOQFrz2om2J/tyzdbuEBx/DzCcpuO5U3mOw826IDc
 2iHBNH66/YWR1/wRnNJxpkQ83ssSTEPzeNDQ9iN7ug9vKFB2PtFP/O4ivKWDPRhfNfZfbKqMM
 Sf674tlMU4wtOBpXtoWvaBz0xCe+GTGyvwS5eIFFDJpM1djde2GyvI8Xd5ns5v77LUgH8DCTX
 YnJFwgRtmxW8KueQbmqFECuIPeYmhF6UTCrKh0SIytNmEk2+6HRP8QnetVczHi7XYStNKt/HT
 Hec0hV+WVuXVIV1Q/8b796k6eztgSGz4jRC1odmWvlAbR38M4GfjAcSF7AtuCgQsgxGkZ051Z
 nBeBTXngu/BY5L1LjOEGYasHgeAsBaQWLyWmjlS0lxuc2Qmk12TPeGz4GbANSl6verAW57Qy2
 956oMGRv8XKyxfADa5TBdBEL8OUnezlCSpGd/YaVIqaRQuPcoAaShkEHMUmH+LiUBlDAnOFkz
 eX/xWbjPy4129vVsyaBZfkuvVfv4uuzNT4zMhfq/3lbMcGFSlOCTHzEVDuBtPuuHHSHHWYqWt
 q5qejxHI8x7w1jZmia3CTiVqyuSXkLdrgQ0vjmtVNggSfXCkqTTXKqMqWZgPz+uTBXyy4szDJ
 hYNE31BcmiXrTDAIOVWQfY+053w2Txg+360W/scmGCAIzLTAz4k9QT+I5hCucPCzj59tdlIKJ
 zvaAdoc9cVeV38gcRxSQbd1fwgSLC5FlTpPmLrt0j4fyuQbfJi8aLxXcCAGWNJdsvQBR9dVQF
 OBemglrxaZPpwD4GLibnGRSX/JV7aiNUm0t6PeK5KGWXgW7OnJC7Yib2qCj2u89Sj1BrBESQh
 Sknh48h/Z6i6kVlnOwFHgOfEHpoZESVgAxNK0h6tDaQYLP12fqVJLwh7gdQgwWRXMUtOGPJBG
 smzlwNL/3lve+PzrhV9yoPbx8Tw=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.09.23 um 20:40 schrieb Taylor Blau:
> On Sat, Sep 09, 2023 at 11:10:36PM +0200, Ren=C3=A9 Scharfe wrote:
>> Add an int pointer, value_int, to struct option to provide a typed valu=
e
>> pointer for the various integer options.  It allows type checks at
>> compile time, which is not possible with the void pointer, value.  Its
>> use is optional for now.
>
> This is an interesting direction. I wonder about whether or not you'd
> consider changing the option structure to contain a tagged union type
> that represents some common cases we'd want from a parse-options
> callback, something like:
>
>     struct option {
>         /* ... */
>         union {
>             void *value;
>             int *value_int;
>             /* etc ... */
>         } u;
>         enum option_type t;
>     };
>
> where option_type has some value corresponding to "void *", another for
> "int *", and so on.

In a hand-made struct option this would only provide a very limited form
of type safety.  It reduces the number of incorrect types to choose from
from basically infinity to a handful, but still allows pointing the
union e.g. to an int for an option that takes a long or a string without
any compiler warning or error.

Convenience macros like OPT_CMDMODE could use the union to provide a
type safe interface, though, true.  This might suffice for our purposes.

> Alternatively, perhaps you are thinking that we'd use both the value
> pointer and the value_int pointer to point at potentially different
> values in the same callback. I don't have strong feelings about it, but
> I'd just as soon encourage us to shy away from that approach, since
> assigning a single callback parameter to each function seems more
> organized.

Right, we only need one active value pointer per option.

>> @@ -109,6 +110,7 @@ static enum parse_opt_result get_value(struct parse=
_opt_ctx_t *p,
>>  	const char *s, *arg;
>>  	const int unset =3D flags & OPT_UNSET;
>>  	int err;
>> +	int *value_int =3D opt->value_int ? opt->value_int : opt->value;
>>
>>  	if (unset && p->opt)
>>  		return error(_("%s takes no value"), optname(opt, flags));
>
> Reading this hunk, I wonder whether we even need a type tag (the
> option_type enum above) if each callback knows a priori what type it
> expects. But I think storing them together in a union makes sense to do.

Yes, option types (OPTION_INTEGER etc.) already imply a pointer type,
no additional tag needed.

Ren=C3=A9
