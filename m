From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCHv3 04/13] strbuf: add strbuf_read_once to read without blocking
Date: Mon, 21 Sep 2015 23:29:14 -0700
Message-ID: <CA+P7+xpC+EiNTBqgwd0We+f-_xqfY0xx2BzvTGC7Owk-ay10fw@mail.gmail.com>
References: <1442875159-13027-1-git-send-email-sbeller@google.com>
 <1442875159-13027-5-git-send-email-sbeller@google.com> <xmqqoagv71es.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 08:29:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeH58-0000Qv-KV
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 08:29:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756147AbbIVG3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 02:29:34 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:33636 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445AbbIVG3e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 02:29:34 -0400
Received: by igbkq10 with SMTP id kq10so93920906igb.0
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 23:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XuH9H3ooYvl/VxGhtlcYtQYmgWXvGUF6Tu8m61xCr5k=;
        b=DicgOx1+jkRLFnTpvq/tA7EfgHv8aN9u4F4qWBmosyrAwnRVJq/9QexaehH7vaMCsc
         lm1KT1YQA0Tg2yq+Ln+q9Bt4XArlwydikleDYn3cehl30Hio01SzfSr8rZwmkWj0xHaC
         ZWtkmD5q44OsZuAL/PWLGEeJK9gaIWB5YUgauAMmAF58bgVNJ8iRGaV1EpPiuToOXtwB
         WlWcZcs9GWTsedt3kS8mwteoGE5dCXEqCoBzUXXBDV8D1AgnPm6jUHGs+GSI00wh0Qdq
         LCM1mdFzzzFd9LQqO8Qd+5EhAsyX6e+zhOP+sw/fSi0B4FoJO5MyqWGWnQDVzxd6XTSS
         vLBw==
X-Received: by 10.50.178.145 with SMTP id cy17mr15791208igc.92.1442903373592;
 Mon, 21 Sep 2015 23:29:33 -0700 (PDT)
Received: by 10.107.132.155 with HTTP; Mon, 21 Sep 2015 23:29:14 -0700 (PDT)
In-Reply-To: <xmqqoagv71es.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278381>

On Mon, Sep 21, 2015 at 5:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> The new call will read a fd into a strbuf once. The underlying call
>
> "read from a fd"
>
>> xread_nonblock is meant to execute non blockingly if the fd is set to
>> O_NONBLOCK.
>
> The latter sentence adds more questions than it answers.  If the
> file descriptor is not set to non-blocking, what happens?  Is it a
> bug in the caller, and if so do we give help to diagnose such a bug?
>

I would vote for adding debugging for calling xread with O_NONBLOCK
and for calling xread_nonblock without O_NONBLOCK.. I'm not sure the
best way to do this, but it certainly feels like a bug to call xread
with O_NONBLOCK set... And the same here...

Regards,
Jake
