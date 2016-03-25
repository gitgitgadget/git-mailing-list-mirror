From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v10 2/2] pull --rebase: add --[no-]autostash flag
Date: Fri, 25 Mar 2016 12:37:27 -0400
Message-ID: <CAPig+cTzV5FT=BBFW6kTUqPG8=ZWXf+78Y-HG=pb2x_8h8he1g@mail.gmail.com>
References: <1458584283-23816-1-git-send-email-mehul.jain2029@gmail.com>
	<1458591170-28079-1-git-send-email-mehul.jain2029@gmail.com>
	<CAPig+cSdegoGNCMBMcHyEYiE+LUzixvdk-qu0Q-zbFvatX2=KA@mail.gmail.com>
	<CAPig+cTH-3PqZFyP_R1FyTPKhRhbbLRDeYfv2TcVq=gq=ZpRcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Paul Tan <pyokagan@gmail.com>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 17:37:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajUjt-0007fT-7z
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 17:37:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753751AbcCYQh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 12:37:29 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:36548 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753313AbcCYQh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 12:37:28 -0400
Received: by mail-vk0-f66.google.com with SMTP id z68so8296282vkg.3
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 09:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=podr0NrHhmWE3MkzboIk7xyuX1i2ld6Py11j0+VtPnI=;
        b=a5ZeAz4C8JB1UrkBTgHLC03c0yTWH9c5o/Ve/UorySCY4PWTiI/VoLyflZS31+E2nz
         2GKtmA8gDqQtkj1tzurNRcdPELw7I/vAoNR/Lqjntt2W+Z6OxsrgXehJus5IMYaxwwVG
         imV0CpV4iPs62+stjBZVhLwISSfVsBd9Cj7cV25KhLSlbNmNJ/MWKJ+5/3REub3ukPVo
         xiAleuLaJ2GgmcMqq8PTO4aofzoqLPqGJJDDQ2Kpz2UAMoJVeejSfSRjsalW8gml76zU
         93LpkD+B44d8wAytujYn5VNXb6j4aaLkaj4fcL9xPQOl1PoOB/6fE0hnBEOCVrWDVtFe
         +BWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=podr0NrHhmWE3MkzboIk7xyuX1i2ld6Py11j0+VtPnI=;
        b=bZP2hyVB0YX+j2SVHcZ/q0VilOZewOoAuOo5Ed1oRN6BJTN4bdO4Uxll/YMBSJg+pe
         gjehAODimg9VHBdZinpOLXm2PxYVtyEsTCCNfDz/EUgjEiuxoE165vd0LvQNX3xl5Q0Q
         jOJX6MUHR3ImWSwREUHeW8XP9fiBtp+fMQUvNWWqMIx22VKugT8Cf7ttdx8Gu4G9O8iK
         tBGdKtueYDksVdLHV5gBqdbC5+W+lJwHZG5W5uhKzo++dOf8WEnUK1Q7HWGIAPk04qr8
         NGlK7JeKHwXfVcfpxQaU8KVfuuWRMKpHMOot0l96bRx8UOcj3ZbfOyUHDq3+8sxZeP/X
         20EA==
X-Gm-Message-State: AD7BkJJ933r6euhQUcp0dtO+PougTPGrpa1LM6mH30F3iYXE3YTYLZhlK1TlPrECKot2dzA9AC/W6U6mOsFeLg==
X-Received: by 10.176.2.143 with SMTP id 15mr7909436uah.113.1458923847718;
 Fri, 25 Mar 2016 09:37:27 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Fri, 25 Mar 2016 09:37:27 -0700 (PDT)
In-Reply-To: <CAPig+cTH-3PqZFyP_R1FyTPKhRhbbLRDeYfv2TcVq=gq=ZpRcQ@mail.gmail.com>
X-Google-Sender-Auth: AInrMGftHzyJ9ej2Y10YnEFDX5s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289899>

On Fri, Mar 25, 2016 at 4:44 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, Mar 25, 2016 at 4:31 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>     for i in --autostash --no-autostash
>>     do
>>         test_expect_success "pull $i (without --rebase) is illegal" "
>>            test_must_fail git pull $i . copy 2>actual &&
>>            test_i18ngrep 'only valid with --rebase' actual
>>         "
>>     done
>>
>> Take special note of how use of double (") and single (') quotes
>> differ in this case from other tests since $i needs to be interpolated
>> into the test body.
>
> That's not accurate. Since $i will be visible when the test body is
> actually evaluated, it will work correctly even with the body
> single-quoted as usual (like all other tests), so swapping the quotes
> around like this is unnecessary (and Junio would prefer[1] they not be
> swapped).

Junio pointed out to me privately that I forgot to mention explicitly
that you would need to use double quotes for the test title to ensure
that $i is interpolated, but the test body can continue using single
quotes, as explained above.
