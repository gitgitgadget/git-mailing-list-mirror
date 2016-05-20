From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH 2/2] bisect--helper: `bisect_voc` shell function in C
Date: Fri, 20 May 2016 12:53:04 +0530
Message-ID: <CAFZEwPMFBmHUaX+Y8Fpd4BnJiB8N_XBOX30hRsSvb3tm8-MX5w@mail.gmail.com>
References: <1463169737-12701-1-git-send-email-pranit.bauva@gmail.com>
	<1463169737-12701-2-git-send-email-pranit.bauva@gmail.com>
	<alpine.DEB.2.20.1605160838540.3303@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 20 09:23:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3em8-0002qS-07
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 09:23:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754634AbcETHXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 03:23:08 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34738 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753719AbcETHXF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 03:23:05 -0400
Received: by mail-yw0-f194.google.com with SMTP id i22so13645733ywc.1
        for <git@vger.kernel.org>; Fri, 20 May 2016 00:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=L0eMG+ni2BEuxP9PemZWnbUjCljP+55HzP77dle4mXg=;
        b=oQs4jWPWnYwuaZDMLdkCBI/dvxyNeI0eO9834iNW21jcekQc4+wRlz31HEPopFNqnR
         1aVZgqhngj11r2cZl2ufHJtimbxIzKQ7QHR0hdwDFiv5xP4FaeiEVx02O0cLCOPMzVp3
         oA+aomTQWAeKqQyrE0MNy/DXgzlgQyykY/yHGyrWZafYgF+wOdASLlFcVf9O/jx8qtDl
         ScbQopMLTtqk4g37et7ePDEH2kwzsqsd6i6qyAEahgWfQeZohPh9dNWxW6lzJVAKUXFj
         Hikn26jESP3G12HqbkHF49uWFUvPUsUZJYEY3TT32BIKr1R0XmTtqXcIgylVEgAyGDJw
         mz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=L0eMG+ni2BEuxP9PemZWnbUjCljP+55HzP77dle4mXg=;
        b=d+OL7lSdfecy19PHnPGqQEdmHFxIRav02IqLamb9dJlduTcBCrjjWeCwyxQ7T9ohVE
         pIPi/1UCxeUHg0jPV5nhYiKFnbguEYUa2+imE5ak3HSfmfv4FBHw4bfwutBcr4bVM8A7
         ZhNgztfvh/EE3MRMviIoXj1GFnVSlofm8bV/WwVo51/guhW35b1XcMqyGgy5edRy1TrZ
         1RqOUDjgX3Mg1akQsbpJAfIuPS7uqoYexRmRNitVXAo2bz9C7yQF9cxkTfNUDF4Fp+0V
         Xt5+jFBtM9UKyyD9Eip4hmAALfRPZx/zm/3pO1hBVKgxX/DuHNHpmkNSFvKe2WB3sHzX
         CmMQ==
X-Gm-Message-State: AOPr4FWNiFcCFhlwKYhAiSvoNwOau63PO1537hIzDPPnu7HwH4I7y1hZmrcnXQXPi1CMY7Ar+j+s/n9rs6IeTg==
X-Received: by 10.13.235.143 with SMTP id u137mr939021ywe.20.1463728984975;
 Fri, 20 May 2016 00:23:04 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Fri, 20 May 2016 00:23:04 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1605160838540.3303@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295153>

Hey Johannes,

On Mon, May 16, 2016 at 12:10 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Pranit,
>
> On Sat, 14 May 2016, Pranit Bauva wrote:
>
>> Reimplement the `bisect_voc` shell function in C. This is a too small
>> function to be called as a subcommand though the working of this
>> function has been tested by calling it as a subcommand.
>
> This leaves me puzzled as to what this patch is supposed to do. Maybe
> rename this function to have a more intuitive name, and then throw in a
> patch that makes use of the function?

Are you suggesting to first have an introductory patch which will
rename the function in the shell script and then this patch which will
convert the "new" shell function to C? I can do this. I have to think
of a nice name. How does 'good_or_bad" sound?

Regards,
Pranit Bauva
