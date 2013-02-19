From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: inotify to minimize stat() calls
Date: Tue, 19 Feb 2013 15:27:56 +0530
Message-ID: <CALkWK0mgzzGTqjMxaEm1t+f69X=U7R203BiVugnnXE_MN2zFZw@mail.gmail.com>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com>
 <7vehgqzc2p.fsf@alter.siamese.dyndns.org> <7va9rezaoy.fsf@alter.siamese.dyndns.org>
 <7vsj56w5y9.fsf@alter.siamese.dyndns.org> <9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com>
 <CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com>
 <7vliaxwa9p.fsf@alter.siamese.dyndns.org> <CAKXa9=qQwJqxZLxhAS35QeF1+dwH+ukod0NfFggVCuUZHz-USg@mail.gmail.com>
 <CACsJy8BvN0xX_=fx78hVLw=2Wyk=RUHYs_x9r5RJ0TvBAoA83g@mail.gmail.com> <CAKXa9=pCSWtXq+5x_LcZ9gsSpa1yT0QD5DsBguTqosoH0cj-nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Robert Zeh <robert.allan.zeh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 10:58:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7jyL-00011g-Lg
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 10:58:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758453Ab3BSJ6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 04:58:22 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:45512 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758388Ab3BSJ6R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 04:58:17 -0500
Received: by mail-ie0-f170.google.com with SMTP id c11so8371418ieb.29
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 01:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=93XPH+bdcpxAXsfBzoLrTIboO7f1vmbqXQPwVsd8tzk=;
        b=k862vmQQRTohMcjOOUowgbhmdtRiSJITxMZVe1ku6zKOBMB4Ou6+19avj0clGl3AmU
         77RU+PIFcXljEkeSsQinrXa4xP1PN+l4WlGlwwg8iG3WBqf3JMZ2lL9Wo5jO0/jfXFwd
         ovxp+ndRNcRkfbIMIBfa45W7l+sDCh4+Qam0YYm08U3YzjPZRUQcCnofn7jXPYw1ljjb
         5XuBBlb+9LZ3Dqf7gibAUtFzTNfOq3lJki8ooeGYlO5RMnfqQm7kLlqAv50S8MUC7WNk
         9U03sV7AwH1mLMNr4Yb7ErRgPfMwSpcEoKvYrEqU2Pwot16TZ1wnBQSnYOocnyaJTMcW
         fbSA==
X-Received: by 10.50.181.167 with SMTP id dx7mr3200067igc.12.1361267896097;
 Tue, 19 Feb 2013 01:58:16 -0800 (PST)
Received: by 10.64.166.33 with HTTP; Tue, 19 Feb 2013 01:57:56 -0800 (PST)
In-Reply-To: <CAKXa9=pCSWtXq+5x_LcZ9gsSpa1yT0QD5DsBguTqosoH0cj-nw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216588>

Robert Zeh wrote:
> On Sun, Feb 10, 2013 at 9:21 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Mon, Feb 11, 2013 at 2:03 AM, Robert Zeh <robert.allan.zeh@gmail.com> wrote:
>>> On Sat, Feb 9, 2013 at 1:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>>>>
>>>>> This is much better than Junio's suggestion to study possible
>>>>> implementations on all platforms and designing a generic daemon/
>>>>> communication channel.  That's no weekend project.
>>>>
>>>> It appears that you misunderstood what I wrote.  That was not "here
>>>> is a design; I want it in my system.  Go implemment it".
>>>>
>>>> It was "If somebody wants to discuss it but does not know where to
>>>> begin, doing a small experiment like this and reporting how well it
>>>> worked here may be one way to do so.", nothing more.
>>>
>>> What if instead of communicating over a socket, the daemon
>>> dumped a file containing all of the lstat information after git
>>> wrote a file? By definition the daemon should know about file writes.
>>>
>>> There would be no network communication, which I think would make
>>> things more secure. It would simplify the rendezvous by insisting on
>>> well known locations in $GIT_DIR.
>>
>> We need some sort of interactive communication to the daemon anyway,
>> to validate that the information is uptodate. Assume that a user makes
>> some changes to his worktree before starting the daemon, git needs to
>> know that what the daemon provides does not represent a complete
>> file-change picture and it better refreshes the index the old way
>> once, then trust the daemon.
>>
>> I think we could solve that by storing a "session id", provided by the
>> daemon, in .git/index. If the session id is not present (or does not
>> match what the current daemon gives), refresh the old way. After
>> refreshing, it may ask the daemon for new session id and store it.
>> Next time if the session id is still valid, trust the daemon's data.
>> This session id should be different every time the daemon restarts for
>> this to work.
>
> I think we could do this without interactive communication,
> if we did the following:
>    1) The Daemon waits to see $GIT_DIR/lstat_request, and atomically
>        writes out $GIT_DIR/lstat_cache.  By atomically I mean that it writes
>        things out to a temporary file, and then does a rename.
>
>    2) The client erases $GIT_DIR/lstat_cache, and writes
>       $GIT_DIR/lstat_request
>
> I think this is better than socket based communication because there
> are fewer places to check
> for failures.

My main problem with file-based solutions is this: how will the daemon
accumulate inotify change events over time, and report it in a batch
to a git application that is spawned?  Will it append to the
.git/inotify_changes file everytime there's a change?  Wouldn't you
prefer to accumulate the events in-memory and report it over a socket
upon explicit request, to minimize IO?
