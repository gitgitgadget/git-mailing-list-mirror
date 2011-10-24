From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 00/22] Refactor to accept NUL in commit messages
Date: Mon, 24 Oct 2011 16:10:08 +1100
Message-ID: <CACsJy8AsfQnS3L1fabzB-z7BdH=jvB=XNnmP2RZu0qp7C1uGYQ@mail.gmail.com>
References: <1319277881-4128-1-git-send-email-pclouds@gmail.com>
 <7vobx863v3.fsf@alter.siamese.dyndns.org> <CACsJy8B=TsC4A=R6b3jyYBCvorEDBYHQ8uA864WrB0-3pgNyKA@mail.gmail.com>
 <7vipng5k80.fsf@alter.siamese.dyndns.org> <CACsJy8CA2cqJqt7cUN1CdnOb3=qE6B2XTd1oQKZ7osVz09kSGg@mail.gmail.com>
 <7vehy459bg.fsf@alter.siamese.dyndns.org> <20111023160744.GA22444@sigill.intra.peff.net>
 <7v39ej5uqb.fsf@alter.siamese.dyndns.org> <7vy5wb3sto.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 24 07:10:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RICoA-0001Wt-DN
	for gcvg-git-2@lo.gmane.org; Mon, 24 Oct 2011 07:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753160Ab1JXFKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Oct 2011 01:10:41 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53522 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753086Ab1JXFKk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2011 01:10:40 -0400
Received: by bkbzt19 with SMTP id zt19so7716665bkb.19
        for <git@vger.kernel.org>; Sun, 23 Oct 2011 22:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0//JMAzt0HzlofHqzY92QlfOMfTikKaLWUf3oVHzZKI=;
        b=bGtwEQyhc7r8NSRNSCQU9rjUfvfhWWUmTZ/J473UODHyIhBPiJAVxLtMjXvLuWDtGa
         HoAUeBzOggUM4x4J5FCfjek/sQ9tHQ5ZUd02nc//kk2ZcTx6VlrpefLXDSH2oGlhMIJu
         cjJMopqYjtIlFB+5Aj3hr8utEwskV0hVGOKbg=
Received: by 10.204.0.67 with SMTP id 3mr11074011bka.55.1319433039106; Sun, 23
 Oct 2011 22:10:39 -0700 (PDT)
Received: by 10.204.98.204 with HTTP; Sun, 23 Oct 2011 22:10:08 -0700 (PDT)
In-Reply-To: <7vy5wb3sto.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184151>

On Mon, Oct 24, 2011 at 3:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Jeff King <peff@peff.net> writes:
>>
>>> But as Duy mentions, we have an encoding header. Shouldn't we treat it
>>> like binary goo until we do reencode_log_message, and _then_ we can
>>> break it into lines?
>>
>> That's sensible. If we go that route, I think the "one allocation of
>> separate struct commit_buffer pointed from a pointer field in struct
>> commit to replace the current member 'buffer'" is a reasonable thing
>> to do.
>
> Having given that "sensible" comment, I am not convinced if this is worth
> it. We are talking about what is left in the ephemeral COMMIT_EDITMSG by
> the chosen editor, but are there really editors that can _only_ write in
> UTF-16 and not in UTF-8, and is it worth bending backwards to add support
> such an editor?

This is argument for the sake of argument because I don't use utf-16
and do not care much. UTF-16 can have more code points and some may
prefer utf-16 to utf-8.

I'd be happy with git's refusing to create broken commits because
people accidentally set editor encoding to utf-16. If people do use
utf-16, they'll get caught and should yell up if they want utf-16
supported.
-- 
Duy
