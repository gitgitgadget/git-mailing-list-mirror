From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCHv3] transport: Catch non positive --depth option value
Date: Tue, 26 Nov 2013 18:09:41 +0700
Message-ID: <CACsJy8Dfibu96VchD=p_05deLm-46mfXZzcYQg+0BqaN2=To=A@mail.gmail.com>
References: <5283A380.9030308@gmail.com> <xmqqzjp1bqm3.fsf@gitster.dls.corp.google.com>
 <528A9877.4060802@gmail.com> <xmqq61ro9utf.fsf@gitster.dls.corp.google.com>
 <528E2660.6020107@gmail.com> <xmqq1u294ih3.fsf@gitster.dls.corp.google.com>
 <CACsJy8B0qBmBkx0n2B=ivUqZTgVz-ZLhTQ_nVJ4AV0njnZksfw@mail.gmail.com>
 <5293DE93.3020008@gmail.com> <CACsJy8BV74W63Sak-j_9RMjp_5Bo8HMd3Xc93GTtSn4yWStfEA@mail.gmail.com>
 <52947B42.4080105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Andr=C3=A9s_G=2E_Aragoneses?= <knocte@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 26 12:10:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlGX5-0001no-8U
	for gcvg-git-2@plane.gmane.org; Tue, 26 Nov 2013 12:10:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755960Ab3KZLKP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Nov 2013 06:10:15 -0500
Received: from mail-qa0-f53.google.com ([209.85.216.53]:44020 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755045Ab3KZLKN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Nov 2013 06:10:13 -0500
Received: by mail-qa0-f53.google.com with SMTP id j5so7856169qaq.5
        for <git@vger.kernel.org>; Tue, 26 Nov 2013 03:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=2bRSdenO7rNZ7zVi2R81AV/jhjXXQB7W7Y4vJFiHnoc=;
        b=G4n9pOwGRjoLNsqtQZ0DeW9HYDapmJoSMSb598+xO1gbBzAokEuYt594FTAwxq8b0e
         OmPZinmuMlDsQkCCrM56Mo2RbasxfgIXA34DgUDEX9TM8P0xtKiIyFLeWO8oSb0usCn/
         TvpHJvKCTJ/O99zPbmzWT8u59eyPUcOcjXG7+6N7eD0Fy90cxZi0cD0rE325vrLQ/jbK
         YmxhLAJEqlMb8lzOnMOUSygDn6v2aS7gNuyrvqCQTeMTynTWaxn7YqnoYlJorsYeNWSk
         piYumj4I1oyooAxSmM1FXkb5gNzQac64Pwu6Y3ShziIWa4ItDL9hqfSGRTxb9iiV8rN8
         Kwtg==
X-Received: by 10.224.51.7 with SMTP id b7mr54856026qag.74.1385464212913; Tue,
 26 Nov 2013 03:10:12 -0800 (PST)
Received: by 10.96.134.68 with HTTP; Tue, 26 Nov 2013 03:09:41 -0800 (PST)
In-Reply-To: <52947B42.4080105@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238378>

On Tue, Nov 26, 2013 at 5:43 PM, "Andr=C3=A9s G. Aragoneses"
<knocte@gmail.com> wrote:
> On 26/11/13 04:06, Duy Nguyen wrote:
>> On Tue, Nov 26, 2013 at 6:34 AM, "Andr=C3=A9s G. Aragoneses"
>> <knocte@gmail.com> wrote:
>>> On 22/11/13 02:18, Duy Nguyen wrote:
>>>> On Fri, Nov 22, 2013 at 3:18 AM, Junio C Hamano <gitster@pobox.com=
> wrote:
>>>>> Have you run the tests with this patch?  It seems that it breaks
>>>>> quite a lot of them, including t5500, t5503, t5510, among others.
>>>>
>>>> I guess it's caused by builtin/fetch.c:backfill_tags(). And the ca=
ll
>>>> could be replaced with
>>>>
>>>> transport_set_option(transport, TRANS_OPT_DEPTH, NULL);
>>>>
>>>
>>> Not sure what you mean,
>>> https://github.com/git/git/blob/master/t/t5550-http-fetch.sh doesn'=
t
>>> call backfill_tags. What do you mean?
>
> That was a typo, I meant
> https://github.com/git/git/blob/master/t/t5500-fetch-pack.sh
>
>
>> I wrote "I guess" ;-) I did not check what t5550 does.
>
> Any hint on where to start looking? It doesn't look like any test is
> using a non-positive depth, so I'm really confused.

Replace die() with "*(char*)0 =3D 0;" and run t5500, I got a core dump.
Running gdb shows this

(gdb) bt
#0  0x000000000053d98b in set_git_option (opts=3D0xb63d00, name=3D0x575=
767
"depth", value=3D0x575c91 "0") at transport.c:487
#1  0x000000000053f163 in transport_set_option (transport=3D0xb63f00,
name=3D0x575767 "depth", value=3D0x575c91 "0") at transport.c:1000
#2  0x0000000000437b68 in backfill_tags (transport=3D0xb63f00,
ref_map=3D0xb64d60) at builtin/fetch.c:773
#3  0x0000000000437f91 in do_fetch (transport=3D0xb63f00, refs=3D0xb643=
c0,
ref_count=3D1) at builtin/fetch.c:869
#4  0x00000000004386d4 in fetch_one (remote=3D0xb63c20, argc=3D1,
argv=3D0x7fff32f63588) at builtin/fetch.c:1037
#5  0x0000000000438a1d in cmd_fetch (argc=3D2, argv=3D0x7fff32f63580,
prefix=3D0x0) at builtin/fetch.c:1115
#6  0x000000000040590f in run_builtin (p=3D0x7d59a8, argc=3D4,
argv=3D0x7fff32f63580) at git.c:314
#7  0x0000000000405aa2 in handle_internal_command (argc=3D4,
argv=3D0x7fff32f63580) at git.c:478
#8  0x0000000000405bbc in run_argv (argcp=3D0x7fff32f6346c,
argv=3D0x7fff32f63470) at git.c:524
#9  0x0000000000405d61 in main (argc=3D4, av=3D0x7fff32f63578) at git.c=
:607

My guess seems right.
--=20
Duy
