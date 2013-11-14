From: Ken Tanzer <ken.tanzer@gmail.com>
Subject: Re: git rm / format-patch / am fails on my file: patch does not apply
Date: Wed, 13 Nov 2013 23:26:35 -0800
Message-ID: <CAD3a31X_o3cXr10ARiZjMFvG-yzj9hUUpmoLnjDXTjM4nHiD=w@mail.gmail.com>
References: <CAD3a31XPKsnuNE+szw7xgvaDrcxhKZ2jTDHKzTwdwtnCwFb_0w@mail.gmail.com>
 <xmqqhabilpzx.fsf@gitster.dls.corp.google.com> <CAD3a31UVkNaPTCWCAbv0NwCOTE5_2A+P7-e28VRnk9Aopa6hcQ@mail.gmail.com>
 <xmqqbo1ofd1s.fsf@gitster.dls.corp.google.com> <5ABC4D34F41F48E39205914BC8D3DC35@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Nov 14 08:27:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgrKj-0001x8-Di
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 08:27:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101Ab3KNH1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 02:27:18 -0500
Received: from mail-lb0-f179.google.com ([209.85.217.179]:33193 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087Ab3KNH1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 02:27:16 -0500
Received: by mail-lb0-f179.google.com with SMTP id w6so1230237lbh.10
        for <git@vger.kernel.org>; Wed, 13 Nov 2013 23:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=B5VmFUQN9NDXf2pveQS9D5w6mdTyBx/AbOKm4Jddcjk=;
        b=SbQFgcQGmvPtrNQ60CE51PPMGL2pbCv+zzub+L2F8/El+j7xwCdJeS6AEBEGB5IgfM
         x2Ce5IUgHmW/84W7TzSDh25yBeqlnktcmwvZGL5p0GkA8ZbCwn/ZMz+gKhnGpxEpbEGD
         R2ofDnpOXQTMDM9nksW8E4vHyqORjWujDGvweblU3Tfb1Gbs6VaEd1KyuWI9Ij+B1Tc/
         qLGv/nOfrkGHnuCEpgTyCkXCcQfLEGyr8G44cuXE3Hkd5D7Pcd/j45TVnQz2UpskOhM8
         fNwpWCC1jlqLTIZ1CGu3cuPlW88YIy1I/Ec2mR5A46ASjRdEfG2cwz/TVZROe86gUsp0
         F9/g==
X-Received: by 10.152.27.227 with SMTP id w3mr259145lag.84.1384414035368; Wed,
 13 Nov 2013 23:27:15 -0800 (PST)
Received: by 10.114.180.136 with HTTP; Wed, 13 Nov 2013 23:26:35 -0800 (PST)
In-Reply-To: <5ABC4D34F41F48E39205914BC8D3DC35@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237813>

Hi Philip.  I don't have any setting like that in either my
~/.gitconfig, or in the .git/config files.  I really haven't tweaked
my git config at all.

This is a typical .git/config file:

[core]
repositoryformatversion = 0
filemode = true
bare = false
logallrefupdates = true
[remote "origin"]
url = ssh://ktanzer@git.code.sf.net/p/agency/code
fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
remote = origin
merge = refs/heads/master

My ~/.gitconfig just has name and email settings in it.

Ken


On Wed, Nov 13, 2013 at 3:12 PM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Junio C Hamano" <gitster@pobox.com>
> To: "Ken Tanzer" <ken.tanzer@gmail.com>
> Sent: Wednesday, November 13, 2013 5:04 PM
>
>> Ken Tanzer <ken.tanzer@gmail.com> writes:
>>
>>>> I am not very much surprised if such a file misbehaves, because the
>>>> "format-patch | am" pipeline is designed to be used on patches that
>>>> can be transferred in plain-text e-mail safely.  Long lines should
>>>> probably be OK, but mixed CRLF, CR and LF may be problematic.
>>>
>>>
>>> I'm not sure I understand this comment.  format-patch seems to work
>>> fine on binary files.
>>
>>
>> Yes.
>>
>> The problematic is when you tell it to process text files, taking
>> into account various common text breakages may be introduced to the
>> payload, and line-end conversion is among the operations that the
>> user may be telling it to munge the perfectly-fine input, in an
>> attempt to compensate.
>>
>
>>> Stefan Beller <stefanbeller@googlemail.com> writes:
>>>
>>>> I do have this global config
>>>>  core.safecrlf=warn
>>>> regarding line endings.
>
>
> Ken,
>
> Do you have one of these line ending conversion settings active in your
> config file?
>
> It sounds like the 'git am' script may be silencing the warnings too
> aggressively if that is the case.
>
> Philip



-- 
AGENCY Software
A data system that puts you in control
100% Free Software
http://agency-software.org/
ken.tanzer@agency-software.org
(253) 245-3801

Subscribe to the mailing list to
learn more about AGENCY or
follow the discussion.
