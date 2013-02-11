From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Git prompt
Date: Mon, 11 Feb 2013 06:13:49 +0530
Message-ID: <CAMK1S_jFUXiHM6teVwoxO9gv77B1KBQoSi-B32dwVKemXnDx9w@mail.gmail.com>
References: <CAE_TNikk-9sYVRQRwRecNpp3otQ+oc=uV9SPu+7pAkCUNbcUoQ@mail.gmail.com>
	<20130210212538.GA11720@elie.Belkin>
	<20130210224345.GA32318@sigill.intra.peff.net>
	<7vfw13rd9x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Ethan Reesor <firelizzard@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 01:44:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4hVG-0005dZ-Ql
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 01:44:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425Ab3BKAnv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 19:43:51 -0500
Received: from mail-we0-f173.google.com ([74.125.82.173]:35581 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265Ab3BKAnu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 19:43:50 -0500
Received: by mail-we0-f173.google.com with SMTP id r5so4426737wey.32
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 16:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=oEGAvsx3cWAcvVwoRZ89duAXvy19z75kC3VfZACvkKw=;
        b=rzPtfLWy1dZyM/KahdFVNeNZ4CnX3SjU1AUbo7uU50HSElySTCfgI5hm4qhDoIotLA
         8dRj46+dB7fUnM6Xcc3rnMIer6Yy5r1F4Z19e4iJFP/uzpdyOPSknbGhkLTe7AEtWG/m
         7FsV9XajdoJIfyEQLiQC9IRgHdn5MpVNelsPNj+BFyhvyUHCZ5ZGOccGVnRhcJaT0NFD
         E026Ufa+23iQcGcg5YDRaFbWD7vYRAJvpPpuvcfLybygltkDwbIm3kVTX4hDqe/647zT
         FDJZ6xzUmHyiJI2BPU+Nxk6L1CxX/ssw1LAPv/UjE6q/7DUdRWS45SsOoucEEgnVSjKF
         BNyA==
X-Received: by 10.180.105.67 with SMTP id gk3mr12838602wib.31.1360543429421;
 Sun, 10 Feb 2013 16:43:49 -0800 (PST)
Received: by 10.194.94.71 with HTTP; Sun, 10 Feb 2013 16:43:49 -0800 (PST)
In-Reply-To: <7vfw13rd9x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215974>

On Mon, Feb 11, 2013 at 4:24 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Sun, Feb 10, 2013 at 01:25:38PM -0800, Jonathan Nieder wrote:
>>
>>> Ethan Reesor wrote:
>>>
>>> > I have a git user set up on my server. It's prompt is set to
>>> > git-prompt and it's git-shell-commands is empty.
>>> [...]
>>> > How do I make the git user work like github where, upon attempting to
>>> > get a prompt, the connection is closed?
>>>
>>> I assume you mean that the user's login shell is git-shell.
>>>
>>> You can disable interactive logins by removing the
>>> ~/git-shell-commands/ directory.  Unfortunately that doesn't let you
>>> customize the message.  Perhaps it would make sense to teach shell.c
>>> to look for a
>>>
>>>      [shell]
>>>              greeting = 'Hi %(username)! You've successfully authenticated, but I do not provide interactive shell access.'
>>>
>>> setting in git's config file.  What do you think?
>>
>> I think something like that makes sense. To my knowledge there is no way
>> with stock git to customize git-shell's output (at GitHub, that message
>> comes from our front-end routing process before you even hit git-shell
>> on our backend machines).
>>
>> The "username" in our version of the message comes from a database
>> mapping public keys to GitHub users, not the Unix username.  But I
>> suspect sites running stock Git would be happy enough to have
>> %(username) map to the actual Unix username.
>
> Yeah, that greeting is cute---I like it ;-)

Indeed!  In gitolite, I borrowed that idea added to it by making it
print a list of repos you have access to, along with what permissions
(R or RW) you have :-)

I'm not suggesting git should do that, but instead of a fixed string,
a default command to be executed would be better.  That command could
do anything the local site wanted to make it do, including something
eqvt to what I just said.

This of course now means that the ~/git-shell-commands should not be
empty, since that is where this default command also will be present.
