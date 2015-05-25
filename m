From: Stephen Kelly <steveire@gmail.com>
Subject: Re: Pushing and pulling the result of `git replace` and objects/info/alternates
Date: Mon, 25 May 2015 11:49:17 +0200
Message-ID: <5562F01D.8000601@gmail.com>
References: <CACHsx4Kz3_bMbKqd1O7-ZXLBUqJBs6hTsiRNAALNJhDV44v6Rw@mail.gmail.com> <CAP8UFD3G8_ChRX6HHtieFTksUJBiXu9FLNbewFQVj7qPyGh8EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 25 11:49:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ywp0q-0007sI-A7
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 11:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbbEYJtb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 05:49:31 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:36033 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859AbbEYJta (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2015 05:49:30 -0400
Received: by wizk4 with SMTP id k4so43099365wiz.1
        for <git@vger.kernel.org>; Mon, 25 May 2015 02:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=9/ZHqMLo8IKfqxg/KE4zL9H0Vf9gdDdWUiVOT+4TkC8=;
        b=xDxssKhRvFsb6cpnJ9pySnVyNBvV/goQ7rosseJ/BtQiVSv9OwyIyCxwZdk5+CZ7Dv
         FRYKnP22V7OriStsTmw3vlpFQ/ZD8wIjEaIAjXJKKQYNOh/Wic3B7DoT36t4Rdv7FFnu
         k/gYKSHC6l4SjS9WdBJqDx4SUZCJXPg3ehizeSHDDLC3ux0b+tFt1q6mQVOpe0yPFsT3
         rUwLhjqH/zEMuSeFii3JVv6TMxXcPmXeJLOj23EZoMQTRqpAdkwJ9EFsuZYCvIJOYAOK
         C6jDGZxGAMZ7TOsSecsLcrwkD44QRJpFHoRbzL4q8GeHBYZqbcxTiIi/PtTdLRt15L1U
         ovhA==
X-Received: by 10.180.231.41 with SMTP id td9mr29949005wic.69.1432547369061;
        Mon, 25 May 2015 02:49:29 -0700 (PDT)
Received: from [192.168.1.25] (x55b2fc65.dyn.telefonica.de. [85.178.252.101])
        by mx.google.com with ESMTPSA id fh6sm11055296wic.5.2015.05.25.02.49.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 May 2015 02:49:28 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <CAP8UFD3G8_ChRX6HHtieFTksUJBiXu9FLNbewFQVj7qPyGh8EQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269833>

On 05/24/2015 07:28 AM, Christian Couder wrote:
> Hi,
>
> On Fri, May 22, 2015 at 4:38 PM, Stephen Kelly <steveire@gmail.com> wrote:
>> I have tried out using `git replace --graft` and
>> .git/objects/info/alternates to 'refer to' the history in the origin
>> repo instead of 'duplicating' it. This is similar to how Qt5 repos
>> refer to Qt 4 history in a different repo.
>>
>> Question 1) Is this a reasonable thing to do for this scenario?
> I think it should work without too much work, but see the answer to
> the next question.

Ok, thanks. The concern is that there is plenty of documentation for
git-filter-branch, but no documentation or porcelain for info/alternates
and little out on the internet about it or git replace and using them
together.

However, it seems to be a reasonable thing to do.

>> echo "../../calculator/objects" >
>> ../.git/modules/compute/objects/info/alternates
>> git replace --graft HEAD $extraction_sha
> Maybe use the following instead of the above line:
>
> git fetch 'refs/replace/*:refs/replace/*'

Thanks.

>> # And now we see the history from the calculator repo. Great. But, it
>> required user action after the clone.
> Yeah, but if the 2 above commands are in a script maybe it's
> reasonable to ask the user to launch the script once after cloning.

Would it be possible to do this in a hook in the 'integration repo'
which contains both submodules in the example I posted? Like a fetch
hook or something?

Thanks,

Steve.
