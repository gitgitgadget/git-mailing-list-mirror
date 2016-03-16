From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH/RFC/GSoC 00/17] A barebones git-rebase in C
Date: Wed, 16 Mar 2016 20:46:04 +0800
Message-ID: <CACRoPnTpHR7Bx9TVAK-dTFgSOj2XVk3F8ApBEcywxESDQUS8VA@mail.gmail.com>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
	<CACsJy8BmiqFJ1tN6-uAWqXMUyvGRdWP2DVfgwE56Y1K9KHCsfQ@mail.gmail.com>
	<xmqq8u1kaoj8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Sam Halliday <sam.halliday@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 13:46:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agAq4-0002pP-HF
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 13:46:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755175AbcCPMqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 08:46:09 -0400
Received: from mail-lf0-f44.google.com ([209.85.215.44]:33230 "EHLO
	mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696AbcCPMqF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 08:46:05 -0400
Received: by mail-lf0-f44.google.com with SMTP id h198so18251666lfh.0
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 05:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=I50RVWBh5LQsA9tFcU4LBolRPTSV7HDrin+K4qr3VKI=;
        b=HyIEfZZ4K2GjJgrJ26BYjlNimw/e7wCfyLO2A3nTNcO6ubGihoZNZ1fyr1mXHeLO/l
         bGSfEzJtEy1UU0bW0v12a3zmeoruhxXsZ6WLUoT4NTZ/PExftccG0/DX7lxxVCOsiGh5
         PqLAg5fOrNmJ8HkUJp2/tDrvlI7yorJxzq7nr4m8fGV977rx1VvkayQrfv08EDvr9zeI
         XXvKnu9ENb9HfF/eNuzQRYyFGhSZ/4rRMTSsC5D+hvKl76+eZFfErXXJqUhyl/mbcmu4
         qpM/1VlX9DI5GKGJ1NHdPBAQuyCuIulq9Ja6fh40gECp/g5NBqAeZycc9IWl6zYn427c
         YyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=I50RVWBh5LQsA9tFcU4LBolRPTSV7HDrin+K4qr3VKI=;
        b=j71GQ1g06/oIGv0m9LKw8gQpWCxd7Y0NB6rC78NJl7xf9lcw0j9dEucqUPwi/KSC5j
         m9dbYXAD5+J8YCl1Zo7TkuppePdHxX3SCaIs9rMtC7+jC3oGXigE6a8+XyfjhPOVDhd5
         /0jr6zHYr0hlhNPyn3sg+k8XOxI8S4k8mjsgDRwLy/NdhO0P8L8UziRVNxEbXchmjUir
         WIzOqkl+2gfJfUiTNoQ2FWojz5PmKaHDFHuKqP23oxgh6WjiX6Xs5YZPgvT3JUIcOGTg
         rIW6D7vU4rx31lQ9GiEj/xQ+WkHdalI+q3+QfBpwG76s2siolW3jvWLhn67Mng1h3oW5
         DQ0A==
X-Gm-Message-State: AD7BkJJnWN0lifiV7X0GgXk126cPT36FPkzvCwQeOrSWzjW3Yrkvkte/I4fPReSfX7Y0Yvo5JYLv6dmtXq9A1A==
X-Received: by 10.25.156.133 with SMTP id f127mr1370469lfe.102.1458132364181;
 Wed, 16 Mar 2016 05:46:04 -0700 (PDT)
Received: by 10.112.207.74 with HTTP; Wed, 16 Mar 2016 05:46:04 -0700 (PDT)
In-Reply-To: <xmqq8u1kaoj8.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288965>

On Tue, Mar 15, 2016 at 2:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Sat, Mar 12, 2016 at 5:46 PM, Paul Tan <pyokagan@gmail.com> wrote:
>>> So, we have around a 1.4x-1.8x speedup for Linux users, and a 1.7x-13x speedup
>>> for Windows users. The annoying long delay before the interactive editor is
>>> launched on Windows is gotten rid of, which I'm very happy about :-)
>>
>> Nice numbers :-) Sorry I can't look at your patches yet. Just a very
>> minor comment from diffstat..
>>
>>>  rebase-am.c                        | 110 +++++++++++
>>>  rebase-am.h                        |  22 +++
>>>  rebase-common.c                    | 220 ++++++++++++++++++++++
>>>  rebase-common.h                    |  48 +++++
>>>  rebase-interactive.c               | 375 +++++++++++++++++++++++++++++++++++++
>>>  rebase-interactive.h               |  33 ++++
>>>  rebase-merge.c                     | 256 +++++++++++++++++++++++++
>>>  rebase-merge.h                     |  28 +++
>>>  rebase-todo.c                      | 251 +++++++++++++++++++++++++
>>>  rebase-todo.h                      |  55 ++++++
>>
>> topdir is already very crowded. Maybe you could move all these files
>> to "rebase" subdir.
>
> I think that makes sense.  I do not expect people depending on being
> able to say "git rebase--am" and have it do something useful, so
> they won't belong to builtin/, but rebase/{am,common,...}.[ch] makes
> sense.

Sure, I'll do that.

Regards,
Paul
