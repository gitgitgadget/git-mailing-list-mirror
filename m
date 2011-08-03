From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/ PATCH] revert: Allow arbitrary sequencer instructions
Date: Wed, 3 Aug 2011 07:02:50 +0530
Message-ID: <CALkWK0kfOjXeuswwOvgO5eotUE89rL-X4tTtf=frGR4WdR4iAA@mail.gmail.com>
References: <1312260884-5087-1-git-send-email-artagnon@gmail.com>
 <1312260884-5087-2-git-send-email-artagnon@gmail.com> <20110802205353.GF2743@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 03:34:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoQLi-0005c7-CC
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 03:34:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812Ab1HCBdM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Aug 2011 21:33:12 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50782 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926Ab1HCBdL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Aug 2011 21:33:11 -0400
Received: by wyg8 with SMTP id 8so219375wyg.19
        for <git@vger.kernel.org>; Tue, 02 Aug 2011 18:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=N/NYKuSORmhssbN0/6BwMW2JjYLQoa4OiT3XE5i+cjs=;
        b=gWdHS9OXW/ddA8tedeG04WApNQoqfID6GQTpn14Lk0IU0guH4u5Cmy+Ry1BaWq758E
         gdc21rvSR7OP9E2SBeM7LlPmRiitcoP2WWytEdgo0gN/PO7NVVY2OAzP9ZwnOTISjLN+
         di33xfUtYrrIPgqCsSlq9GxTegejbsMzt2bVw=
Received: by 10.216.153.149 with SMTP id f21mr2241432wek.109.1312335190096;
 Tue, 02 Aug 2011 18:33:10 -0700 (PDT)
Received: by 10.216.137.134 with HTTP; Tue, 2 Aug 2011 18:32:50 -0700 (PDT)
In-Reply-To: <20110802205353.GF2743@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178535>

Hi Jonathan,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> --- a/sequencer.h
>> +++ b/sequencer.h
>> @@ -32,6 +32,16 @@ struct replay_opts {
>> =C2=A0 =C2=A0 =C2=A0 size_t xopts_nr, xopts_alloc;
>> =C2=A0};
>>
>> +struct replay_insn {
>> + =C2=A0 =C2=A0 struct commit *commit;
>> + =C2=A0 =C2=A0 enum replay_action action;
>> +};
>> +
>> +struct replay_insn_list {
>> + =C2=A0 =C2=A0 struct replay_insn *item;
>> + =C2=A0 =C2=A0 struct replay_insn_list *next;
>> +};
>
> Ah, so this allows sequences like
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0revert A
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pick B
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pick C
> =C2=A0 =C2=A0 =C2=A0 =C2=A0revert D

Exactly.

> Nit: why isn't the list-item struct something like
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct replay_insn item;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct replay_insn_list *next;
>
> which would save a little memory management and memory access
> overhead (or even
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0enum replay_action action;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct commit *operand;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct replay_insn_list *next;
>
> since every "struct replay_insn" exists in the context of an
> insn list afaict)?

Right.  Good suggestion.

> Anyway, the general idea seems good.

Nice.  Thanks for the quick early feedback.  Much appreciated.

-- Ram
