From: Nathan Collins <nathan.collins@gmail.com>
Subject: Re: [BUG?] Spaces not allowed in directory names in .git/info/attributes
Date: Tue, 24 May 2016 16:30:35 -0700
Message-ID: <CAO8RVve07Gvr2Bes2Dp-08_8MSQoVcBm9gjMaKTU=uAXcY_1wQ@mail.gmail.com>
References: <CAO8RVveOwrS6+pTnHY36d1Nk_B_VJD022W9i8STnNb-KyMkqNg@mail.gmail.com>
 <xmqqmvng8qle.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 25 01:31:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5LnE-0007Xj-0p
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 01:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755132AbcEXXbQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 19:31:16 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:35167 "EHLO
	mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754970AbcEXXbP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 19:31:15 -0400
Received: by mail-yw0-f181.google.com with SMTP id o16so31821734ywd.2
        for <git@vger.kernel.org>; Tue, 24 May 2016 16:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NLurfVY0cq1BSYQXduFRgZzZ5j+Mgxewrc6vOwDKToo=;
        b=o4lt/cDrZ47qfVzSf9z38Nj+bqXYvlB5F7qwQ2jV2JdxU7z4faqHSTy4nai6VnRhaR
         xiIxgaLqF0AiVDss18aOvZ5PjIQDVJmAAJVrA5HjIfSVIk26nw7vKtXH5mjZsDp4mfnC
         BGxSkUoC3i4CzqdrUoup9hWw+Zc4kKPj8jd7E4Hcecuo3uQcOGQ2sw5HMtZUGtdyDI5a
         MhRhl/VIwZdi503KNUT+gfyx9yojiJvn1wtOLtJfoxMYACoj1mGYSLqmB5IAWFifebX1
         ik2pfUXna9en3ZvhMkWoihDhQwTYgFjpobmerJvYwVqzc/W/QljO38lf/91BSHwReUUX
         SLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NLurfVY0cq1BSYQXduFRgZzZ5j+Mgxewrc6vOwDKToo=;
        b=nOV1OanLhoV3ilzdGE25kvENbHNTsG8RMr4WBd6ofJgowBjZPvQpVWKi3B1knsOcBG
         D4KLjhEbXnkJcXANorwYbao5QW4Z+vNieHeBlRib1mOIsLopclZfk9fBSHHQH9E4nlzJ
         cwPbKy7GaysmVmIub5qFfSFK5Awi10IGY8NGrXTshyGwdwaTTX/Ch3kH+4oPGZbP724x
         rpdVk+DwqzdzZ9YsoEKk7yJCA9UTvXH7scjGQ2locscBuuxOCebpu1dvb0H4A/jFL2ik
         m31oy7Df4AtLTSI68EDWN8VeiVZpwLoqEENRvGxeiJwtJjVuHn6DrXocFt27NYf4/8OE
         uxNg==
X-Gm-Message-State: ALyK8tJvPiVS5f88RbZlVcSt7lwrUXw9CVCchM/SHw75M/NGdDvcTkNv4vqFI73YyUrSfhLOuwa3wt5kWbXuyg==
X-Received: by 10.13.208.69 with SMTP id s66mr520820ywd.267.1464132674821;
 Tue, 24 May 2016 16:31:14 -0700 (PDT)
Received: by 10.83.81.5 with HTTP; Tue, 24 May 2016 16:30:35 -0700 (PDT)
In-Reply-To: <xmqqmvng8qle.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295544>

On Mon, May 23, 2016 at 1:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Nathan Collins <nathan.collins@gmail.com> writes:
>
>> Example session:
>>
>>     $ git init test.git
>>     Initialized empty Git repository in /tmp/test.git/.git/
>>     $ cd test.git
>>     $ mkdir "dir name"
>>     $ touch dir\ name/file.txt
>>     $ echo "dir\\ name/file.txt -text -whitespace" >> .git/info/attributes
>>     $ git add dir\ name/file.txt
>>     name/file.txt is not a valid attribute name: .git/info/attributes:1
>
> That's because spaces are not allowed in paths there.
>
>         echo "dir?name/file.txt -text" >.git/info/attributes
>
> may be an easy workaround for now.

Thanks, I'll use the workaround,

-nathan
