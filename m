From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH 2/2] pull: use git-rev-parse --parseopt for option parsing
Date: Thu, 21 May 2015 16:41:46 +0800
Message-ID: <CACRoPnS2AwxT+0By7esubp8ctF9=gcwnr=coPDF9PEvzyyji+g@mail.gmail.com>
References: <1431957296-31534-1-git-send-email-pyokagan@gmail.com>
	<1431957296-31534-3-git-send-email-pyokagan@gmail.com>
	<389cf040410c499b2f382bfbcdb526d4@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 21 10:41:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvM38-0001Lq-Sl
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 10:41:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755884AbbEUIlv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 04:41:51 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38883 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755381AbbEUIlr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 04:41:47 -0400
Received: by wichy4 with SMTP id hy4so5596653wic.1
        for <git@vger.kernel.org>; Thu, 21 May 2015 01:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=cQKF4E08W3eIM0dMhvRm8TvdPiFOuUosaqlbDpm8vb4=;
        b=PP9sS8G1184LBZGGfK2fR9kJXC5Wju/yY0r6aRxgC5quzvTzYbxC8YMewaLOn2wJKS
         wR3caDOQiuFbdTYmRCWi3ANgsWXh14PD62ixwFlKqXditnwNlTP1aSDnnZQSxB5Cv1J8
         2ZV/XxRpWbcJojZAR9+NlCXM5kLUcbd8fq4UiATx24aF4Lmpj7BwxeQjt2N2PLBYQZVX
         +eR/N2YNHl0uvXVJnYVUkjoUcVoiFrBbEWzktZrl1qrIU/ZY+81TGflxc3Lt+KG2yzOZ
         hOrj1NzGLeqKqkDoDdlY9iohajWxQwt9+0kZNSw8J/fU702WESRE9JvkVk0LNUaPFKyW
         xBUg==
X-Received: by 10.194.81.234 with SMTP id d10mr3331364wjy.84.1432197706517;
 Thu, 21 May 2015 01:41:46 -0700 (PDT)
Received: by 10.194.85.113 with HTTP; Thu, 21 May 2015 01:41:46 -0700 (PDT)
In-Reply-To: <389cf040410c499b2f382bfbcdb526d4@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269571>

Hi,

On Mon, May 18, 2015 at 10:43 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> On 2015-05-18 15:54, Paul Tan wrote:
>
>> diff --git a/git-pull.sh b/git-pull.sh
>> index 633c385..67f825c 100755
>> --- a/git-pull.sh
>> +++ b/git-pull.sh
>> @@ -4,13 +4,53 @@
>>  #
>>  # Fetch one or more remote refs and merge it/them into the current HEAD.
>>
>> -USAGE='[-n | --no-stat] [--[no-]commit] [--[no-]squash]
>> [--[no-]ff|--ff-only] [--[no-]rebase|--rebase=preserve] [-s
>> strategy]... [<fetch-options>] <repo> <head>...'
>> -LONG_USAGE='Fetch one or more remote refs and integrate it/them with
>> the current HEAD.'
>>  SUBDIRECTORY_OK=Yes
>> -OPTIONS_SPEC=
>> +OPTIONS_KEEPDASHDASH=Yes
>
> I have to admit that I was puzzled by this at first. But it seems that the intention is to handle a dashdash argument as an error, therefore we have to keep it. Is my understanding correct?

Ugh, I thought we had to keep the dashdash so that we could
disambiguate the arguments from the options, but it turns out that
rev-parse would add its own dashdash. So, no, we don't need to keep
the dashdash.

Thanks for catching this. Fixed.

Regards,
Paul
