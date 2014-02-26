From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 21/25] checkout: support checking out into a new
 working directory
Date: Thu, 27 Feb 2014 06:19:48 +0700
Message-ID: <CACsJy8BkAOk4d3nFP_CtUN4Feer0sHy8H8vpbUWcZcYMLYgYyg@mail.gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
 <1392730814-19656-22-git-send-email-pclouds@gmail.com> <CAPig+cSDT72MHFdwnZHBwEUiJQiQAkc-nv0vK166O8EuXVtgbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Feb 27 00:20:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WInm4-0006ng-6f
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 00:20:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753074AbaBZXUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 18:20:20 -0500
Received: from mail-qa0-f48.google.com ([209.85.216.48]:34005 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752698AbaBZXUT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 18:20:19 -0500
Received: by mail-qa0-f48.google.com with SMTP id o15so3230830qap.7
        for <git@vger.kernel.org>; Wed, 26 Feb 2014 15:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ln/9rppZD5YOPeAW3Z1JxLjh6kVLze2rdO/JB/bNjzw=;
        b=yFo3vCM9/UrmchNQCQpV+XNKRaw/1zsJ+qC7eFpL8fRjUzAPeabj8g/Fnp+ooApELX
         olbbWH521VdHpvGnmVabLMSOzIVlw/ECIQUrgimNJsMM3Kh2xUWiAPfOq8fakgegf3fz
         5ilFKURiI7C1xNkaeqPo3sJ7E6X9liPprwEInj/xvZaicEEwnx2tAchBImm1GmVjJLyu
         qbLDr1/uIbhUtpPCXKgkO7o7mq6gbEDvV4GfPxQr/zKIue51zN75isZ6qjcOarkpS49D
         IB+WfYqv9tmus7QDLru2anvmOHX000O8U0XJEGOfEr6CkBqjs+P2rbO5MpZoZdNYBWKa
         +rkQ==
X-Received: by 10.140.47.212 with SMTP id m78mr3000438qga.21.1393456818389;
 Wed, 26 Feb 2014 15:20:18 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Wed, 26 Feb 2014 15:19:48 -0800 (PST)
In-Reply-To: <CAPig+cSDT72MHFdwnZHBwEUiJQiQAkc-nv0vK166O8EuXVtgbw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242772>

On Thu, Feb 27, 2014 at 3:06 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> +       len = strlen(path);
>> +       if (!len || is_dir_sep(path[len - 1]))
>> +               die(_("'--to' argument '%s' cannot end with a slash"), path);
>
> What is the purpose of this restriction?

Laziness on my part :) Because the following loop searches backward to
get the `basename $path`, trailing slash would make it return empty
base name. I could have just removed the trailing slash here instead
of dying though. Thanks for catching.

>
>> +       for (name = path + len - 1; name > path; name--)
>> +               if (is_dir_sep(*name)) {
>> +                       name++;
>> +                       break;
>> +               }



-- 
Duy
