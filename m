From: Stefan Zager <szager@google.com>
Subject: Re: Make the git codebase thread-safe
Date: Wed, 12 Feb 2014 11:30:29 -0800
Message-ID: <CAHOQ7J9A7zPV-kYe1WiQrVuWXXTNDVOQJEbnB+_jzEQ2_4Umxw@mail.gmail.com>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
	<CABPQNSZ_LLg5i+mpwUj7pzXVQMY1tcXz2gJ+PWG-mP1iyjxoaw@mail.gmail.com>
	<CAHOQ7J8QxfvtrS2KdgzUPvkDzJ1Od0CMvdWxrF_bNacVRYOa5Q@mail.gmail.com>
	<CABPQNSZtQd51gQY7oK8B-BbpNEhxR-onQtiXSfW9sv1t2YW_nw@mail.gmail.com>
	<CAHOQ7J_Jrj1NJ_tZaCioskQU_xGR2FQPt8=JrWpR6rfs=c847w@mail.gmail.com>
	<CABPQNSYVGc9m0_xfAWe=3b7CXyGZ-2FfTMRbTJ=UECeZUtdgmg@mail.gmail.com>
	<52FBC9E5.6010609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: kusmabite@gmail.com, Stefan Zager <szager@chromium.org>,
	GIT Mailing-list <git@vger.kernel.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 12 20:30:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDfVz-00008M-G7
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 20:30:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753004AbaBLTac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 14:30:32 -0500
Received: from mail-ob0-f169.google.com ([209.85.214.169]:33443 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357AbaBLTab (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 14:30:31 -0500
Received: by mail-ob0-f169.google.com with SMTP id wo20so11123862obc.0
        for <git@vger.kernel.org>; Wed, 12 Feb 2014 11:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mQ4IFaFo81O/oKZP9MeXD4a8KFMT0SlxIhScJc1wlfM=;
        b=hCKXXiYDFYs/JecY0lkPA3GKNNzZNP/7Tyb+iNifWGLYQPP6SSuGAkahLNgRAjdPv/
         IkGfZCCPfs8S/y/CfiBsyAnYfNbnWYfzD5uKcnv0YvpbAZaGMWtDc3memicRwPehpXyf
         1UWTT/IL013Gyic5YW/jhu+BwCfxq9SiPn5fc1Q6Cp2kX/F3b7BwKlr2bzo8vTUP1itF
         +NsdmudNyGHvFvrvIHjPb61y9qBAOq8w3HPzXjIqUjr0Wz9lR4ryQ5SQy8zqieo688kZ
         DeqGQ2BNbOREg8FfvZ9gzS4enmFbv2IXcQUe+FIjyGxqRf60RH4v8Y9dAX+D5G9LLrmN
         dxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=mQ4IFaFo81O/oKZP9MeXD4a8KFMT0SlxIhScJc1wlfM=;
        b=Y5xXDEa+POMQd5lq/SKi83wcoDTsDDEr9V9dpa27e5wrOUA+yhTPepOgkioy2cy2Zn
         4KAqhw9dXCbGiEaEVxk0301LuDKk7uK/11A2nSdtb5IKsScdMvyqdUU/rApuyEEamAMI
         Fhhhv0npzzzFMVMfLIabDgKWpO98dCjhhdf9vKuh15H1J8vjdn9xCssdwde51EnT4Y1t
         MROZhiDRsPoBiL3SF0vRTjGysgICcV6cLI0DMioxT7ZMMnBKi8VcLWixODphjAey6n7L
         60wCW2pCpEZvmt3txp57ptAKVqX05/iJuQwhDJh3Kq61os1447wXSHJdLVd87nuaVSZZ
         hRUw==
X-Gm-Message-State: ALoCoQkMSRf3+EoGss6f1tceGsCQyz9mBbN+fBp8rxQ66wSRPZCJZToq+gNf/vkKxE3N1OHoExpupMYiI+Yo41WOSsoFZZFxw4zfYCI15rIspRiMHk0IGZNXCENPvEy9wheYuhAvUtLUOCR/s75gVk9CgDom+kqhosSIQ9AdxQ63NPpmsNLuLPUhEbqBf5jk4k74tXuOQ1f1
X-Received: by 10.182.87.69 with SMTP id v5mr1433939obz.77.1392233430041; Wed,
 12 Feb 2014 11:30:30 -0800 (PST)
Received: by 10.182.233.201 with HTTP; Wed, 12 Feb 2014 11:30:29 -0800 (PST)
In-Reply-To: <52FBC9E5.6010609@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242017>

On Wed, Feb 12, 2014 at 11:22 AM, Karsten Blees <karsten.blees@gmail.com> wrote:
> Am 12.02.2014 19:37, schrieb Erik Faye-Lund:
>> On Wed, Feb 12, 2014 at 7:34 PM, Stefan Zager <szager@google.com> wrote:
>>> On Wed, Feb 12, 2014 at 10:27 AM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>>>> On Wed, Feb 12, 2014 at 7:20 PM, Stefan Zager <szager@google.com> wrote:
>>>>>
>>>>> I don't want to steal the thunder of my coworker, who wrote the
>>>>> implementation.  He plans to submit it upstream soon-ish.  It relies
>>>>> on using the lpOverlapped argument to ReadFile(), with some additional
>>>>> tomfoolery to make sure that the implicit position pointer for the
>>>>> file descriptor doesn't get modified.
>>>>
>>>> Is the code available somewhere? I'm especially interested in the
>>>> "additional tomfoolery to make sure that the implicit position pointer
>>>> for the file descriptor doesn't get modified"-part, as this was what I
>>>> ended up butting my head into when trying to do this myself.
>>>
>>> https://chromium-review.googlesource.com/#/c/186104/
>>
>> ReOpenFile, that's fantastic. Thanks a lot!
>
> ...but should be loaded dynamically via GetProcAddress, or are we ready to drop XP support?

Right, that is an issue.  From our perspective, it's well past time to
drop XP support.
