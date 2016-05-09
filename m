From: Armin Kunaschik <megabreit@googlemail.com>
Subject: Re: [PATCH] t6041: do not compress backup tar file
Date: Mon, 9 May 2016 19:20:13 +0200
Message-ID: <CALR6jEiFqFunqRQxWEU_meptN9XfEKPR64mTyWFtSw7D6DFzAw@mail.gmail.com>
References: <1462813748-27538-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitster@pobox.com, Git List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon May 09 19:20:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azor0-0006AK-Qj
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 19:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbcEIRUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 13:20:15 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35546 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbcEIRUO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 13:20:14 -0400
Received: by mail-yw0-f194.google.com with SMTP id v81so23992089ywa.2
        for <git@vger.kernel.org>; Mon, 09 May 2016 10:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=nrgGXf5aJij1AmiVc66TDQLLS/YZDUcqxrA58TbDjK8=;
        b=eDheZOjxxwPL3piweeR8U6HU2lGcc/3p2+rHIzqdOXktqK93FKocVWgHrRL5rJ2XGA
         J35JDrxMdyLa4LN2SHbEf5aAfWansgA4XGMk19WMzHI4byLqbnFGIn2plDcCrMTKRGKS
         HxGqxETGJPxB62Wy+sn3mgZR8b49bFReAMHE/Sx2j1i1RI4fGjn+bwuP7N0yUQbmxN/m
         QSAngoFf9yDF2BuvVD8k20vQ9M9+rC8mhJR2cAtl4VcLaX2rMQiN7+y32Gg9ToFT6aWN
         06xW0kMPm4dQVOq6iURgSMOxg8+SXp/1byKLbGrWxE4zHW9uEKlYQ1h5L6fVg8UXgB3x
         UkOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=nrgGXf5aJij1AmiVc66TDQLLS/YZDUcqxrA58TbDjK8=;
        b=bsm/a0F0u3L8eMLgE/X3Ejv8a75CLnB0lMg154YrT7uiEN3uCLdrHLoDIiyFx2m/cX
         w4lVsdKUtOqSKTLV43eJg6Xx3Iiq5a7IrbLP6to5k5ZiuxGqNpXuaBLFB2KfUApSIdJG
         4I+ESm5HAD8PyYvCYIml93tjV8bybLucyTZXbRtMQbV1STn65ktP5yiO0iuybYmgoJFL
         sOSisAxRmMN+KEYKhjNyxm7ZvKA4T9XZYRCajCCDxsb2wIEuKGQOxD4lOMMZKbpVev7O
         +xcdi4OF3kVBRHJUW+MoONmkUPIDWZ69cp3Rnsz/JWhQ1mqEmaZudXhKgGeJbbVcmyCd
         Wb3g==
X-Gm-Message-State: AOPr4FUXQEiOAc1FH7FQjccIf2Ld96EweJ304T5GG2f7/qpSOWLElHIdnwlNUdjnqIJRkXz+BCKf44OzY9WpZg==
X-Received: by 10.129.160.74 with SMTP id x71mr20307836ywg.131.1462814413673;
 Mon, 09 May 2016 10:20:13 -0700 (PDT)
Received: by 10.129.45.132 with HTTP; Mon, 9 May 2016 10:20:13 -0700 (PDT)
In-Reply-To: <1462813748-27538-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294021>

Hi Stefan,

I'm currently in the process of skipping through the failed tests on my AIX box.
There are more tests which require GNU tools like mktemp
(t7610-mergetool.sh) or readlink (t7800-difftool.sh).
But I don't have a solution or workaround for these two.
But at least there are not more failing compressed tar tests :-)

Thanks,
Armin

On Mon, May 9, 2016 at 7:09 PM, Stefan Beller <sbeller@google.com> wrote:
> The test uses the 'z' option, i.e. "compress the output while at
> it", which is GNUism and not portable.
>
> Reported-by: Armin Kunaschik <megabreit@googlemail.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
>  Thanks Armin for reporting these GNUism!
>  Are there any more? (So we can do these patches as a
>  series instead of one by one:)
>
>  developed on top of origin/sb/z-is-gnutar-ism
>
>  Thanks,
>  Stefan
