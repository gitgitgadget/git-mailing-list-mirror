From: Doug Kelly <dougk.ff7@gmail.com>
Subject: Re: [PATCH 1/3] prepare_packed_git(): find more garbage
Date: Thu, 26 Nov 2015 00:18:41 -0600
Message-ID: <CAEtYS8RHk8dbXs2jBRaCDkOHNEEFHWOxCAMFHY9+wJhWSSFpYQ@mail.gmail.com>
References: <CAGZ79kYPv2OLzMX6t9=mejes9F8CzxAJiERs8GGxDnaAG8Q64g@mail.gmail.com>
	<1447461987-35450-1-git-send-email-dougk.ff7@gmail.com>
	<CAGZ79kaCNT06mAGQbHNgZmdBQUyxGFTFA2Y2FXvG2UG+P7s2kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@github.com>, Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 07:18:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1ptE-00029G-9U
	for gcvg-git-2@plane.gmane.org; Thu, 26 Nov 2015 07:18:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966AbbKZGSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2015 01:18:43 -0500
Received: from mail-qg0-f49.google.com ([209.85.192.49]:33382 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224AbbKZGSl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2015 01:18:41 -0500
Received: by qgea14 with SMTP id a14so48192054qge.0
        for <git@vger.kernel.org>; Wed, 25 Nov 2015 22:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=TbAztJBfhLersAreFlg2sJbkdEtedj0V0R+UzckXojM=;
        b=dWeZU0/PVwn4bmAIgm80RU2/ZxLYhpiWqlm5AlvnU5aWWr6pfAEi7y8C3wB+vmbHTd
         HNpNT+2nmq7ZmJlzIComheRMiF/ONFyiBOQ+aQUlIb/I+2+WQH3Fh5O1adqplgIk0TdO
         r6fEgAnx+2AdAjPMeb3DH1+wXxAETTuygmtMswcg6c8x0YCifkHmsbyMJoOKbSUqpuWN
         YlYXnrzsdUlxHXmI6WPV1u5HIyaHMay98WXeayT227rkwek+xSiDMZoVEGpKaAwoP1lR
         E44mi9yzTp98+BqxsTLIdoV/MYN9FcqCaw/IrmUb5i7TrV2H+hLoNhCtpZBqN3M/OwU2
         gqPw==
X-Received: by 10.140.18.168 with SMTP id 37mr24024139qgf.12.1448518721141;
 Wed, 25 Nov 2015 22:18:41 -0800 (PST)
Received: by 10.55.195.4 with HTTP; Wed, 25 Nov 2015 22:18:41 -0800 (PST)
In-Reply-To: <CAGZ79kaCNT06mAGQbHNgZmdBQUyxGFTFA2Y2FXvG2UG+P7s2kg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281760>

Apparently, I fixed this and forgot to re-run format-patch, so I sent
out the same patch the second time... My fault on that one.  I've at
least checked what I sent this time around, and it seems to match
what's in my current tree. :) The second and third patches should be
unmodified.

Thanks for catching that, Stefan!

On Wed, Nov 25, 2015 at 12:43 PM, Stefan Beller <sbeller@google.com> wrote:
> On Fri, Nov 13, 2015 at 4:46 PM, Doug Kelly <dougk.ff7@gmail.com> wrote:
>>                 return "no corresponding .idx";
>> -       case PACKDIR_FILE_IDX:
>> +       else if (seen_bits & PACKDIR_FILE_IDX && seen_bits ^ ~PACKDIR_FILE_PACK)
>
> Did you intend to use
>     (seen_bits & PACKDIR_FILE_IDX && !(seen_bits & PACKDIR_FILE_PACK))
> here?
>
> I was just looking at the state in peff/pu and it still has the xor
> variant, which exposes more
> than just the selected bit to the decision IIRC.
