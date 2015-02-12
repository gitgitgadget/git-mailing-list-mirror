From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 6/8] reflog_expire(): ignore --updateref for symbolic references
Date: Thu, 12 Feb 2015 09:04:37 -0800
Message-ID: <CAGZ79kbspWzoKFz50aPnpbPr8LXcKz9qAYTwoNe4dQfZCgt=zw@mail.gmail.com>
References: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
	<1423473164-6011-7-git-send-email-mhagger@alum.mit.edu>
	<CAGZ79kZvM4FeHQ074kh7qhsz8cHgGaHxOruP7CM2DgPJErkA-w@mail.gmail.com>
	<54DCD015.2080002@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Feb 12 18:04:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLxC3-0007kB-9i
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 18:04:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbbBLREj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 12:04:39 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:39149 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931AbbBLREi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 12:04:38 -0500
Received: by iecvy18 with SMTP id vy18so13302653iec.6
        for <git@vger.kernel.org>; Thu, 12 Feb 2015 09:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=YHu+cLKxbEFcHi9s5EQNZFwHVuqOU3ApmdCC/mAxazo=;
        b=p3PkChJxTexiWqh1Jphf+YYGz1DcAORjVN04EyJbUKJnmyQm7OIf69mFngR4bAGGXO
         k5CC63tWYLmVSH2XVdoAbxqQ8jxRGfTcWDudCyxe7S4qXuQ3aS2jW4ZavyLf21K5O4BD
         5OCdRdb/RhhFrBaC+HHa3db5e1UblXJ/vwRuQXh55s0AL9STkJSP46FxkIA+kh6g5eKt
         FyPpX4u/kUxiQ5pIHffYESZX/p83+HDQCEbNcMAS6XiXVWjyxSJgHdqxKbZayLcjYlXA
         SlPBxxPq7m+j+vdJ9oGjbkbC01v+k6zMAYwLWoOVqSv5UI7gIBVD9Xt3nh58t/807S+0
         gDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=YHu+cLKxbEFcHi9s5EQNZFwHVuqOU3ApmdCC/mAxazo=;
        b=VCEC+XdljRH4nlAwP4gBF4LBaXRjF25tUi46Fa1R8ZXjFqBvE0aLgWsy/MDGhcw11J
         NyEraCIZtcStHvN5CCZX7/VoD23f86FZtl+HNrodP074EuoiuniT9+ozIouKDuyyLKW8
         PNvIEovzmMYSL83JwBrNsfLekZzIjJqwKBhf4OrL3pHmb2EPC8fVCRvmFLtwrYyvgMQw
         1GBZjbpf0Zwh0v5pWoOpqWkWbZ6INN+onwLvu8Bq/vJFcHyoyxF6tdCzmKam19nFrhRS
         2tDnN5s4gS/LrYDGkpUBjM1HMDlJjvcD2lQwNsRPEpTw2uXuhqtcZ5NWWaHHWwMAJojT
         picQ==
X-Gm-Message-State: ALoCoQmSwC9LuSAOn1LAZctrYdSWyOVXC2aR6LCMpNMP3vAIdMQKC6E6vBEtsHzAHGmUn5C09Z+J
X-Received: by 10.50.222.44 with SMTP id qj12mr5129505igc.48.1423760678083;
 Thu, 12 Feb 2015 09:04:38 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Thu, 12 Feb 2015 09:04:37 -0800 (PST)
In-Reply-To: <54DCD015.2080002@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263744>

On Thu, Feb 12, 2015 at 8:08 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 02/11/2015 01:44 AM, Stefan Beller wrote:
>> On Mon, Feb 9, 2015 at 1:12 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>
>>> If we are expiring reflog entries for a symbolic reference, then how
>>> should --updateref be handled if the newest reflog entry is expired?
>>>
>>> Option 1: Update the referred-to reference. (This is what the current
>>> code does.) This doesn't make sense, because the referred-to reference
>>> has its own reflog, which hasn't been rewritten.
>>>
>>> Option 2: Update the symbolic reference itself (as in, REF_NODEREF).
>>> This would convert the symbolic reference into a non-symbolic
>>> reference (e.g., detaching HEAD), which is surely not what a user
>>> would expect.
>>>
>>> Option 3: Error out. This is plausible, but it would make the
>>> following usage impossible:
>>>
>>>     git reflog expire ... --updateref --all
>>>
>>> Option 4: Ignore --updateref for symbolic references.
>>>
>>
>> Ok let me ask a question first about the symbolic refs.
>>
>> We used to use symbolic links for that, but because of
>> portability issues we decided to not make it a link, but rather
>> a standard file containing the pointing link (The content of
>> .git/HEAD is "ref: refs/heads/master\n" except when detached)
>>
>> So this is the only distinction? Or is there also a concept of
>> symbolic links/pointers for the reflog handling?
>
> A symbolic reference can have a reflog just like a normal reference can.

Yes I can understand that, maybe I was thinking one step
further in the wrong direction. The question was rather:
Do we have symbolic reflogs, i.e.
$ cat .git/logs/<some_ref>:
symbolic log: find log in other reflog

>
> When a reference is updated through a symbolic reference, then
> write_ref_sha1() writes a reflog entry for both the reference and the
> symbolic reference. Also (as an extra kludge), if *any* reference is
> updated directly and it happens to be the current HEAD reference, then
> an entry is added to HEAD's reflog.

Yes because we cannot do inverse symref resolution, we have this kludge
(with the long comment, "This should do 99% of the time in theory
and 100% in practise") of checking if it is also HEAD whenever we
touch another ref.

>
> "HEAD" is the only symbolic reference that is ever transferred across
> repositories.
>
> Symbolic references are always stored loose (i.e., not in packed-refs).
>
> Does that answer your questions?
>
>>> We choose to implement option 4.
>>
>> You're only saying why the other options are insane, not why this
>> is sane.
>>
>> Also I'd rather tend for option 3 than 4, as it is a safety measure
>> (assuming we give a hint to the user what the problem is, and
>> how it is circumventable)
>
> This is a pretty exotic usage. I can't think of any real-life use case
> for using "--updateref" together with a symbolic reference. In our
> entire code base, "--updateref" is only used a single time, in
> "git-stash.sh", and that is always for "refs/stash", which is never a
> symbolic reference. "git-stash" itself is implemented in a very stylized
> way ("stylized" being a polite way of saying "bizarre"), and I doubt
> that there are many more users of this option in the wild, let alone
> "--updateref" together with a symbolic reference.
>
> So, honestly, I don't think it is worth the effort of deciding between 3
> vs. 4. Since 4 is easier to implement (and already implemented), I'd
> rather leave it as is. If you want to submit a patch implementing 3, I
> won't argue against it.

I am not going to bring a patch for option 3. I just learned to be extra
suspicious if we want to drop something silently, so I wanted to
understand in what circumstances we'd run into trouble with that.
That said:

Reviewed-by: Stefan Beller <sbeller@google.com>

>
> Michael
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
>
