From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v10 1/5] command-list: prepare machinery for upcoming
 "common groups" section
Date: Thu, 21 May 2015 10:16:02 -0400
Message-ID: <CAPig+cSegd8P5vFAmmLNU_YDTuk6HXqoGtEi2qUTR+61vDv3ww@mail.gmail.com>
References: <1432213989-3932-1-git-send-email-sebastien.guimmara@gmail.com>
	<1432213989-3932-2-git-send-email-sebastien.guimmara@gmail.com>
	<CAPig+cTV2pm5+76H_jh0WBJ-NeOOP=aMOAwg7kmdp_dqO1LV+w@mail.gmail.com>
	<555DE3DB.1000406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?S=C3=A9bastien_Guimmara?= <sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 21 16:16:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvRGa-0004cp-Q4
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 16:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754818AbbEUOQF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 May 2015 10:16:05 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:33650 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753638AbbEUOQD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 May 2015 10:16:03 -0400
Received: by igbpi8 with SMTP id pi8so11164151igb.0
        for <git@vger.kernel.org>; Thu, 21 May 2015 07:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=LD1IEqp0lv4KbDjfaGW9nU2DuWvb/kSS8d+LV6V72dM=;
        b=kxw41tPd6weOBpL4e1CZtICCy5kPdLUOK1wmwC+qELhhSrreCUHIMzq7v4MD9h6m7u
         GKtCdntjRxPDITG6guLwEZJxjMuuqs5XFgYJTdpU5aGNM9VQ6yEckAox7v1Ql48G/1kZ
         5vlK03vzbda3/dOSgacfnm22NsI1gQ5uvDqrnGXBV2zgnlB5LgiYykLaSE0I7rpwtJrf
         CmQBtsdlpGJdO94ePbXWXhtxUOZ8rK9pzEmG8HJNLAKBPdZ7ATvnQ3jm2iAg8Kkw93y+
         flg3uTbh1FnjOWGUhe/MJZWVtkgmGqWhL3fskOmH05Mgg120LNg93PnLtrd34dSnisEJ
         32hg==
X-Received: by 10.107.137.80 with SMTP id l77mr3507148iod.92.1432217762764;
 Thu, 21 May 2015 07:16:02 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Thu, 21 May 2015 07:16:02 -0700 (PDT)
In-Reply-To: <555DE3DB.1000406@gmail.com>
X-Google-Sender-Auth: LLG4VfLr81JXVl3gJ9nJZU9aQUc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269595>

On Thu, May 21, 2015 at 9:55 AM, S=C3=A9bastien Guimmara
<sebastien.guimmara@gmail.com> wrote:
> On 05/21/2015 03:48 PM, Eric Sunshine wrote:
>> On Thu, May 21, 2015 at 9:13 AM, S=C3=A9bastien Guimmara
>> <sebastien.guimmara@gmail.com> wrote:
>>> The ultimate goal is for "git help" to classify common commands by
>>> group. Toward this end, a subsequent patch will add a new "common
>>> groups" section to command-list.txt preceding the actual command li=
st.
>>> As preparation, teach existing command-list.txt parsing machinery, =
which
>>> doesn't care about grouping, to skip over this upcoming "common gro=
ups"
>>> section.
>>>
>>> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
>>> Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.co=
m>
>>> ---
>>> @@ -95,7 +95,9 @@ your language, document it in the INSTALL file.
>>>   that categorizes commands by type, so they can be listed in appro=
priate
>>>   subsections in the documentation's summary command list.  Add an =
entry
>>>   for yours.  To understand the categories, look at git-commands.tx=
t
>>> -in the main directory.
>>> +in the main directory.  If the new command is part of the typical =
Git
>>> +workflow and you believe it common enough to be mentioned in 'git =
help',
>>> +map this command to a common group in the column [common].
>>
>> I think you meant to squash the documentation update into patch 2/5
>> where the "common groups" block is actually introduced. It doesn't
>> really belong in this patch which is about updating machinery in
>> preparation for the new block.
>
> I don't mind squashing it with another commit, but in this case, woul=
dn't it
> make more sense to squash it with 4/5, when the 'common' tag is remov=
ed and
> the file is in its final form ?

In my mind, the most logical point at which the documentation should
start talking about the new "common coups" is when "common groups"
actually comes into existence since the new documentation is directly
related to birth of that new section of the file. The documentation
update is, at best, only very peripherally related to removal of the
old 'common' tag, so it doesn't really seem logical to tie the
documentation update to 'common' removal in 4/5. But that's just my
opinion...

>> Also, it's now spelled "### common groups" rather than "[common]".
>
> actually, this [common] is not the one I added in a previous series,
> but the one that was already present:
>
> # command name      category [deprecated] [common]

Ah, right. Thanks for clarifying.
