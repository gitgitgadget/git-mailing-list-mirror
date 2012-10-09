From: Shawn Pearce <spearce@spearce.org>
Subject: Re: upload-pack is slow with lots of refs
Date: Mon, 8 Oct 2012 23:46:05 -0700
Message-ID: <CAJo=hJsJgqZqPxucRcSgYSa0N3pcw5seT9vcu2BE8WwfJVrvKQ@mail.gmail.com>
References: <CACBZZX70NTic2WtrXooTg+yBbiFFDAEX_Y-b=W=rAkcYKJ3T2g@mail.gmail.com>
 <20121003180324.GB27446@sigill.intra.peff.net> <7vobkj4cb4.fsf@alter.siamese.dyndns.org>
 <20121003185542.GA3635@sigill.intra.peff.net> <CAJo=hJtZ_8H6+kXPpZcRCbJi3LPuuF7M1U8YsjAp-iWvut9oMw@mail.gmail.com>
 <506E7D01.8080509@viscovery.net> <CAJo=hJsYVdWeG0ZyqexEXNfOq_k1XDR_gGP+fy_z==LvdnWJTQ@mail.gmail.com>
 <5072EBD1.40500@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Oct 09 08:46:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLTaQ-0008Ol-F6
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 08:46:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988Ab2JIGq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 02:46:29 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:53777 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089Ab2JIGq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 02:46:27 -0400
Received: by mail-qa0-f53.google.com with SMTP id s11so2654097qaa.19
        for <git@vger.kernel.org>; Mon, 08 Oct 2012 23:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=b6UTKob2cy0DwcYdPp7vH6MM8a44dUvOgWpUg3abWHY=;
        b=CAhwsUIFGPRuoaScEvqb3k1PLh3fyXnb0+6BmN2wkzdTvwjn21R2MgbTVhaVeTgB0M
         AIeLX56jf+TbaO6nSNuBHUO0nPxbcxvLF8dyz2nuHLEE57hE6ogSLFRHsJh2l9AVsj1B
         rR1vnsDn+hHZq48elcYGd1EB5s1P4cffIv19c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=b6UTKob2cy0DwcYdPp7vH6MM8a44dUvOgWpUg3abWHY=;
        b=QJa4ix8Tnwh9rRimGmP9gTwOKwMurhp4tqG6YQx5eaK7SNXIispBaTZ72jL5JG7wnO
         S1KVlOXxh+Kk4xCsPxmJ70shH5Km9xBTMM6mdnaAjgbPbcSxRHcw30VqNOrBql6LryW/
         7th04xnQwlFbNIvq/beeRWfbcFEgORhg2mlkiBt0ANQxzZtqLPZHud2eIQBImeuWc2h0
         GAj+UA7CHVI5MIm6SaxDfA64gtBbuqwVgwna7N30vLkaOVU/2+1FOrgvEJcWv0RjK0V5
         TiTKQSwoVCQ9y/JlRTjGKhiR5t1rRJJ//yxWJ49zhMR1zl/Ol7zVgHGki6HqFbXPegN4
         YMxQ==
Received: by 10.224.175.204 with SMTP id bb12mr33423418qab.14.1349765186566;
 Mon, 08 Oct 2012 23:46:26 -0700 (PDT)
Received: by 10.49.35.75 with HTTP; Mon, 8 Oct 2012 23:46:05 -0700 (PDT)
In-Reply-To: <5072EBD1.40500@kdbg.org>
X-Gm-Message-State: ALoCoQlKqv3iznVs9cgtR7i9Ekv8Qpd34I1bEI3gZgP+Ch18DcrTVZ+FELf80iyViBBtkAx+lvus
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207303>

On Mon, Oct 8, 2012 at 8:05 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 05.10.2012 18:57, schrieb Shawn Pearce:
>> On Thu, Oct 4, 2012 at 11:24 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>>> Upload-pack can just start
>>> advertising refs in the "v1" way and announce a "v2" capability and listen
>>> for response in parallel. A v2 capable client can start sending "wants" or
>>> some other signal as soon as it sees the "v2" capability. Upload-pack,
>>> which was listening for responses in parallel, can interrupt its
>>> advertisements and continue with v2 protocol from here.
>>>
>>> This sounds so simple (not the implementation, of course) - I must be
>>> missing something.
>>
>> Smart HTTP is not bidirectional. The client can't cut off the server.
>
> Smart HTTP does not need it: you already posted a better solution (I'm
> refering to "&v=2").

Yes but then it diverges even further from the native bidirectional protocol.

>> Its also more complex to code the server to listen for a stop command
>> from the client at the same time the server is blasting out useless
>> references to the client.
>
> At least the server side does not seem to be that complex. See below.
> Of course, the server blasted out some refs, but I'm confident that in
> practice the client will be able to signal v2 capability after a few packets
> of advertisements. You can switch on TCP_NODELAY for the first line with
> the capabilities to ensure it goes out on the wire ASAP.
...
> +static int client_spoke(void)
> +{
> +       struct pollfd pfd;
> +       pfd.fd = 0;
> +       pfd.events = POLLIN;
> +       return poll(&pfd, 1, 0) > 0 &&
> +               (pfd.revents & (POLLIN|POLLHUP));

Except doing this in Java is harder on an arbitrary InputStream type.
I guess we really only care about basic TCP, in which case we can use
NIO to implement an emulation of poll, and SSH, where MINA SSHD
probably doesn't provide a way to see if the client has given us data
without blocking. That makes supporting v2 really hard in e.g. Gerrit
Code Review. You could argue that its improper to attempt to implement
a network protocol in a language whose standard libraries have gone
out of their way to prevent you from polling to see if data is
immediately available, but I prefer to ignore such arguments.

As it turns out we don't really have this problem with git://. Clients
can bury a v2 request in the extended headers where the host line
appears today. Its a bit tricky because of that \0 bug causing
infinite looping, but IIRC using \0\0 is safe even against ancient
servers. So git:// and http:// both have a way where the client can
ask for v2 support before the server speaks, and have it transparently
be ignored by ancient servers.


The only place we have a problem is SSH. That exec of the remote
binary is just super-strict. Its good to be paranoid, but its also
locked out any chance we have at doing the upgrade over SSH without
having to run two SSH commands in the worst case. I guess the best
approach is to try the v1 protocol by default, have the remote
advertise it supports v2, and remember this on a per-host basis in
~/.gitconfig for future requests. Users could always force a specific
preference with remote.NAME.uploadpack variable or --uploadpack
command line flag.
