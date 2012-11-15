From: Javier Domingo <javierdo1@gmail.com>
Subject: Re: Local clones aka forks disk size optimization
Date: Thu, 15 Nov 2012 01:40:58 +0100
Message-ID: <CALZVap=kOwOpxeu8+_+5uQYZz3GNC8Ep_JeK7WCQHtu+Hn3rUw@mail.gmail.com>
References: <CALZVapmG+HL0SQx8zx=Cfz5pWv84hJq90x-7VdjA0m2Z4dC34A@mail.gmail.com>
 <CALZVapmO61d8yXfXXGx6Qc444ka+8n7HabuNRt0rJdE5qy_7aQ@mail.gmail.com> <CAH5451nW2esQR8XaAttT3tYJZEw1Nj3OEMgkHsMZrZDxhcRXHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 01:41:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYnWQ-00088w-6I
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 01:41:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810Ab2KOAlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 19:41:20 -0500
Received: from mail-vc0-f174.google.com ([209.85.220.174]:62624 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755462Ab2KOAlT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 19:41:19 -0500
Received: by mail-vc0-f174.google.com with SMTP id fk26so1124347vcb.19
        for <git@vger.kernel.org>; Wed, 14 Nov 2012 16:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YmWkLiqUF+HFpjao7RwpOsWd7XOwvRvegiGvuviW4LM=;
        b=MeWJzcnAu6C1Cr4C1eCalirKddcY9+NvihSPEURRE73MQjrxoEI5pRIVwdh9ryzkTe
         kWbuPUDkzU+yoPc37yCfnBhYesXHTjMdtRUlSURf5xLKwqTL0e/oZ8Rz18DPmg8KeIIu
         Q9zS9h9xJuLcuAD2+GPe5koVfFon4QEmoMHml3NTfDu1A6+X+Zq7RUnNMn3Ig3ta/ljz
         ZENzYNdMk0MbRi360KHLEmbqt+2h0QQCYYDaYsl9fZwwZ4s6Cw8JtGKM2IKDRIRNw8fa
         oVEbH+PZ8xrfLoHDPo9p7Dsewxrl+/MePLAkpu/49HhybwFxXn61NikedMVS/f/hgn8u
         sBmA==
Received: by 10.58.207.196 with SMTP id ly4mr34311941vec.6.1352940078660; Wed,
 14 Nov 2012 16:41:18 -0800 (PST)
Received: by 10.58.33.200 with HTTP; Wed, 14 Nov 2012 16:40:58 -0800 (PST)
In-Reply-To: <CAH5451nW2esQR8XaAttT3tYJZEw1Nj3OEMgkHsMZrZDxhcRXHw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209775>

Hi Andrew,

The problem about that, is that if I want to delete the first repo, I
will loose objects... Or does that repack also hard-link the objects
in other repos? I don't want to accidentally loose data, so it would
be nice that althought avoided to repack things, it would also
hardlink them.
Javier Domingo


2012/11/15 Andrew Ardill <andrew.ardill@gmail.com>:
> On 15 November 2012 10:42, Javier Domingo <javierdo1@gmail.com> wrote:
>> Hi,
>>
>> I have come up with this while doing some local forks for work.
>> Currently, when you clone a repo using a path (not file:/// protocol)
>> you get all the common objects linked.
>>
>> But as you work, each one will continue growing on its way, although
>> they may have common objects.
>>
>> Is there any way to avoid this? I mean, can something be done in git,
>> that it checks for (when pulling) the same objects in the other forks?
>
> Have you seen alternates? From [1]:
>
>> How to share objects between existing repositories?
>> ---------------------------------------------------------------------------
>>
>> Do
>>
>> echo "/source/git/project/.git/objects/" > .git/objects/info/alternates
>>
>> and then follow it up with
>>
>> git repack -a -d -l
>>
>> where the '-l' means that it will only put local objects in the pack-file
>> (strictly speaking, it will put any loose objects from the alternate tree
>> too, so you'll have a fully packed archive, but it won't duplicate objects
>> that are already packed in the alternate tree).
>
> [1] https://git.wiki.kernel.org/index.php/GitFaq#How_to_share_objects_between_existing_repositories.3F
>
>
> Regards,
>
> Andrew Ardill
