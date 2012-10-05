From: Shawn Pearce <spearce@spearce.org>
Subject: Re: upload-pack is slow with lots of refs
Date: Fri, 5 Oct 2012 09:57:41 -0700
Message-ID: <CAJo=hJsYVdWeG0ZyqexEXNfOq_k1XDR_gGP+fy_z==LvdnWJTQ@mail.gmail.com>
References: <CACBZZX70NTic2WtrXooTg+yBbiFFDAEX_Y-b=W=rAkcYKJ3T2g@mail.gmail.com>
 <20121003180324.GB27446@sigill.intra.peff.net> <7vobkj4cb4.fsf@alter.siamese.dyndns.org>
 <20121003185542.GA3635@sigill.intra.peff.net> <CAJo=hJtZ_8H6+kXPpZcRCbJi3LPuuF7M1U8YsjAp-iWvut9oMw@mail.gmail.com>
 <506E7D01.8080509@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Oct 05 18:58:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKBE7-0003fg-Ab
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 18:58:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756912Ab2JEQ6F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2012 12:58:05 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:50939 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756905Ab2JEQ6D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2012 12:58:03 -0400
Received: by mail-qc0-f174.google.com with SMTP id d3so1205271qch.19
        for <git@vger.kernel.org>; Fri, 05 Oct 2012 09:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3Q4VjFRnXRzX8w4TxXE9SMite3FuyX2VnIPXfsgKmBs=;
        b=ZzkJ/mi6XqRp4kcU4sxdKR02c3vce7RumWLge1M4qFvCDSDRaEhm1C97ImqV9U4GpF
         7eIUS44tkBfqVnzakKNrBeADbZZney3MsQrRiLfd3rD4BIYeqDi+mufv6vkzhqirjZPv
         0zDM3w+v+uubQ9YHJ35Z/8o/XUlfWiFDZp5sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=3Q4VjFRnXRzX8w4TxXE9SMite3FuyX2VnIPXfsgKmBs=;
        b=aS4hoYgpaIxJ9sCl8899b32c2jekLEWnWs12r5jw5p3DwwDyCGbxVRMPZ9jmfBrX3b
         I2OZwfg/eM1VCKzGG26drL4cFnJnBmn4dg8Hq7bSb/RK52iISa/9oQoXwLOkhy0amx1O
         aoZnTX5yUdwJ1MmNUr90z5AE2E8jn5N8Lv2h/+nxS/sCem7VQl9zU3wo+8SY95RBl3TS
         3r4TiMpa4HDyiU4PvWLAk/Hy8jG/Ns15dZqTtDNizk0M2udc8FRyDOChyo0ppUAiM/uP
         9I0kMr6mO60neeMXKU655kLD6Od1mURTtDW7mvyZjrmcEK8CDw92/Afebp28Y3M4wDLt
         CB2A==
Received: by 10.224.220.84 with SMTP id hx20mr18143359qab.5.1349456282042;
 Fri, 05 Oct 2012 09:58:02 -0700 (PDT)
Received: by 10.49.35.75 with HTTP; Fri, 5 Oct 2012 09:57:41 -0700 (PDT)
In-Reply-To: <506E7D01.8080509@viscovery.net>
X-Gm-Message-State: ALoCoQkr2GbWNIrz0NKbZu2+6VlhcI5YILKuQmHo8tikilhCWa6HkiaL+s9MrMQ5yAp7UbEWD155
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207112>

On Thu, Oct 4, 2012 at 11:24 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 10/3/2012 21:41, schrieb Shawn Pearce:
>> On Wed, Oct 3, 2012 at 11:55 AM, Jeff King <peff@peff.net> wrote:
>>> On Wed, Oct 03, 2012 at 11:53:35AM -0700, Junio C Hamano wrote:
>>>> Jeff King <peff@peff.net> writes:
>>>>
>>>>>> Has there been any work on extending the protocol so that the client
>>>>>> tells the server what refs it's interested in?
>>>>>
>>>>> I don't think so. It would be hard to do in a backwards-compatible way,
>>>>> because the advertisement is the first thing the server says, before it
>>>>> has negotiated any capabilities with the client at all.
>>>>
>>>> That is being discussed but hasn't surfaced on the list.
>>>
>>> Out of curiosity, how are you thinking about triggering such a new
>>> behavior in a backwards-compatible way? Invoke git-upload-pack2, and
>>> fall back to reconnecting to start git-upload-pack if it fails?
>>
>> Basically, yes. New clients connect for git-upload-pack2. Over git://
>> the remote peer will just close the TCP socket with no messages. The
>> client can fallback to git-upload-pack and try again. Over SSH a
>> similar thing will happen in the sense there is no data output from
>> the remote side, so the client can try again.
>
> These connections are bidirectional.

Smart HTTP is not bidirectional.

> Upload-pack can just start
> advertising refs in the "v1" way and announce a "v2" capability and listen
> for response in parallel. A v2 capable client can start sending "wants" or
> some other signal as soon as it sees the "v2" capability. Upload-pack,
> which was listening for responses in parallel, can interrupt its
> advertisements and continue with v2 protocol from here.
>
> This sounds so simple (not the implementation, of course) - I must be
> missing something.

Smart HTTP is not bidirectional. The client can't cut off the server.
Its also more complex to code the server to listen for a stop command
from the client at the same time the server is blasting out useless
references to the client.
