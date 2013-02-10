From: Robert Zeh <robert.allan.zeh@gmail.com>
Subject: Re: inotify to minimize stat() calls
Date: Sun, 10 Feb 2013 13:03:00 -0600
Message-ID: <CAKXa9=qQwJqxZLxhAS35QeF1+dwH+ukod0NfFggVCuUZHz-USg@mail.gmail.com>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com>
	<7vehgqzc2p.fsf@alter.siamese.dyndns.org>
	<7va9rezaoy.fsf@alter.siamese.dyndns.org>
	<7vsj56w5y9.fsf@alter.siamese.dyndns.org>
	<9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com>
	<CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com>
	<7vliaxwa9p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 20:03:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4cBT-00034W-Hd
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 20:03:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756657Ab3BJTDD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 14:03:03 -0500
Received: from mail-wg0-f46.google.com ([74.125.82.46]:48088 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756239Ab3BJTDC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 14:03:02 -0500
Received: by mail-wg0-f46.google.com with SMTP id fg15so4139399wgb.13
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 11:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=8s9og8yBvPLkP2qSUi5bHoQ1mefBleXp8Pb8scaPqZQ=;
        b=THFjOqNLcRmQWfpoxP3+zKEbQQ6WJ30TUFtxm3zDpfu7YMbZ7ntMuK8AifvzzMu0Bk
         JaqN2Ix9uITUr8nSyEQ5vo96f5eiGhgcYiPQ6u/9vSXYObGcoCz0dUN0/WaTrPS4tWxA
         iXxhJ6m7WBw7ULyOGd4rhxjd9Rbfxrrza7igiOGpWA1LFImU49+1qB9JLTodV6MxQbJ6
         CxbdnFCsdibrdgE0BONZSyyJwwd95ZZbLrhu6W0P1Lp1LStLgPo7FFBFY4vQcTbgpi7N
         fz/1bUTUxJOq6v7M8grFk71sa7zH2zU0eDgF0ZAb/c1BAWYv/dLmUVuZyJIxQ6/qmPj9
         SQQA==
X-Received: by 10.180.77.68 with SMTP id q4mr12118972wiw.10.1360522980623;
 Sun, 10 Feb 2013 11:03:00 -0800 (PST)
Received: by 10.216.101.130 with HTTP; Sun, 10 Feb 2013 11:03:00 -0800 (PST)
In-Reply-To: <7vliaxwa9p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215926>

On Sat, Feb 9, 2013 at 1:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> This is much better than Junio's suggestion to study possible
>> implementations on all platforms and designing a generic daemon/
>> communication channel.  That's no weekend project.
>
> It appears that you misunderstood what I wrote.  That was not "here
> is a design; I want it in my system.  Go implemment it".
>
> It was "If somebody wants to discuss it but does not know where to
> begin, doing a small experiment like this and reporting how well it
> worked here may be one way to do so.", nothing more.

What if instead of communicating over a socket, the daemon
dumped a file containing all of the lstat information after git
wrote a file? By definition the daemon should know about file writes.

There would be no network communication, which I think would make
things more secure. It would simplify the rendezvous by insisting on
well known locations in $GIT_DIR.

Robert Zeh
