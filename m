From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] introduce git root
Date: Tue, 2 Dec 2014 11:05:36 +0100
Message-ID: <CAP8UFD2P+GZ7Da+YcmjtYiYsESt+BdWc006NN6ps_X_n-We4iA@mail.gmail.com>
References: <1417291211-32268-1-git-send-email-arjun024@gmail.com>
	<2AC7B765F56B4AA8A0DB76E8C670A889@PhilipOakley>
	<CAJFMrCEciWXhBb36MVeFPi7Y7D=9zQ2xGPpiyUz9y4_hOh_taw@mail.gmail.com>
	<vpqoaro99xd.fsf@anie.imag.fr>
	<xmqqd284rryz.fsf@gitster.dls.corp.google.com>
	<CAP8UFD2jES1i+6zOt1gXqTWFy1UHu2GBwAisQktd_Ymbj9Db2g@mail.gmail.com>
	<20141202070415.GC1948@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Arjun Sreedharan <arjun024@gmail.com>,
	Philip Oakley <philipoakley@iee.org>, Git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 02 11:05:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvkL2-0003U4-1G
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 11:05:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbaLBKFj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 05:05:39 -0500
Received: from mail-ig0-f179.google.com ([209.85.213.179]:40527 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbaLBKFg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 05:05:36 -0500
Received: by mail-ig0-f179.google.com with SMTP id r2so10508188igi.0
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 02:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HqMs78fmQ4WgRBgSOZQ4y+IJYE2UvTCtaqTzAy1dst0=;
        b=09kNlBxY1RnAP6X+S85kTopzL/XIMTjbNltx0BlzQa+t26Sz0c8J7VJyOoY9CqBTDn
         c48YuEJ3UoqxPEKVIe9PikRkWPOGtMD7sSyQC9tCAzrbQ6hIukbMc2MD9OXOCRSEkMPl
         nV2V1KrAYsggfwKh73mWIlFO+XskyYEFfYxcoEiY6NXQ0GzefQh/oJO9y67/PIB+P/b6
         dAA6aABhh/wrDTL5GR7yRBkiaif+ZX12NdpwNJ4SrnNlt4y6PDJjP24TBBBIy15kA+/e
         4cE4b62PFh3NexEdX149bVG3XDCMS1F6m7doHbe7gC2vpdEv32OJFjPltazd27Wuuryd
         059Q==
X-Received: by 10.42.155.197 with SMTP id v5mr1867393icw.52.1417514736116;
 Tue, 02 Dec 2014 02:05:36 -0800 (PST)
Received: by 10.50.30.40 with HTTP; Tue, 2 Dec 2014 02:05:36 -0800 (PST)
In-Reply-To: <20141202070415.GC1948@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260551>

On Tue, Dec 2, 2014 at 8:04 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Dec 01, 2014 at 05:17:22AM +0100, Christian Couder wrote:
>
>> On Mon, Dec 1, 2014 at 4:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> >
>> > If I were redoing this today, I would probably nominate the "git"
>> > potty as such a "kitchen synk" command.  We have "--man-path" that
>> > shows the location of the manual pages, "--exec-path[=path]" that
>> > either shows or allows us to override the path to the subcommands,
>> > and "--show-prefix", "--show-toplevel", and friends may feel quite
>> > at home there.
>>
>> I wonder if we could reuse "git config" which is already a "kitchen
>> synk" command to get/set a lot of parameters.
>> Maybe we could dedicate a "git" or "virtual" or "proc" or "sys" (like
>> /proc or /sys  in Linux) namespace for these special config parameters
>> that would not necessarily reflect something in the config file.
>>
>> "git config git.man-path" would be the same as "git --man-path".
>> "git config git.root" would be the same as "git rev-parse --show-toplevel".
>> "git config git.exec-path mypath" would allow us to override the path
>> to the subcommands, probably by saving something in the config file.
>
> What would:
>
>   git config git.root foo

That would output an error message saying that we cannot change the
git.root value.

>   git config git.root

That would output the same as "git rev-parse --show-toplevel".

> output? No matter what the answer is, I do not relish the thought of
> trying to explain it in the documentation. :)

Yeah, maybe it is better if we don't reuse "git config".

> There is also "git var", which is a catch-all for printing some deduced
> environmental defaults. I'd be just as happy to see it go away, though.

Yeah, maybe we could use "git var" for more variables.

> Having:
>
>   git --exec-path
>   git --toplevel
>   git --author-ident
>
> all work would make sense to me (I often get confused between "git
> --foo" and "git rev-parse --foo" when trying to get the exec-path and
> git-dir). And I don't think it's too late to move in this direction.
> We'd have to keep the old interfaces around, of course, but it would
> immediately improve discoverability and consistency.

I don't like reusing the git command for that puropose, because it
clutters it and makes it difficult to improve.

For example let's suppose that we decide to have a "git info" command.
It could work like this:

$ git info sequence.editor
vim

$ git info core.editor
emacs

$ git info --verbose sequence.editor
sequence.editor = vim
GIT_EDITOR = emacs
core.editor = nano

$ git info --verbose core.editor
GIT_EDITOR = emacs
core.editor = nano

So the --verbose option could explain why the sequence.editor is vim
by displaying the all the relevant options with their values from the
most important to the least important.

Best,
Christian.
