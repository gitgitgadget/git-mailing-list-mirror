From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 4/5] make get_short_ref a public function
Date: Tue, 7 Apr 2009 09:39:58 +0200
Message-ID: <36ca99e90904070039m15869c34jc9e12d5ccc48d82@mail.gmail.com>
References: <20090407070254.GA2870@coredump.intra.peff.net>
	 <20090407071420.GD2924@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 07 09:41:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr5w8-0002kG-UD
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 09:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663AbZDGHkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 03:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbZDGHkE
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 03:40:04 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:60963 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452AbZDGHkC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 03:40:02 -0400
Received: by bwz17 with SMTP id 17so2176153bwz.37
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 00:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=137L5fzTF22pHkrDJ+ST6PVMSz8BYJ8ScWQMdUIo1FU=;
        b=I6JO0VOtbkv2O0DQMcAvKjhIqwu6caWC4t2xqkgP7UcCaF+JOwFiJGLToe1zFlh1d+
         HLOQ5cqXurUW4HRHX9Nup4xTHJyxjLe9VggLVXz3j8+3QLv1STLiDRqhkZF7H9hLxPX7
         j78iJbABt+U0qzmEKBzAqUUYVTUVTALx4TSGk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=AQGkkBRkU4VBbCMqXE2p6+h4rjypRpDIAaya6Z7kvz+ZnYEJFc+4e8Pr4tC8/NY+Pl
         OTsP+7KrmWacHanXr6jC+AizrOO7uVTJlWkaF9xnUjIdOktTTulcaaT7BW0MpXEpI1Xq
         YL+1vvgsvuNQfDUgbd8cYB54fxitd/rDVtxJk=
Received: by 10.204.59.14 with SMTP id j14mr2462521bkh.39.1239089998996; Tue, 
	07 Apr 2009 00:39:58 -0700 (PDT)
In-Reply-To: <20090407071420.GD2924@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115919>

On Tue, Apr 7, 2009 at 09:14, Jeff King <peff@peff.net> wrote:
> Often we want to shorten a full ref name to something "prettier"
> to show a user. For example, "refs/heads/master" is often shown
> simply as "master", or "refs/remotes/origin/master" is shown as
> "origin/master".
>
> Many places in the code use a very simple formula: skip common
> prefixes like refs/heads, refs/remotes, etc. This is codified in
> the prettify_ref function.
>
> for-each-ref has a more correct (but more expensive) approach:
> consider the ref lookup rules, and try shortening as much as
> possible while remaining unambiguous.
>
> This patch makes the latter strategy globally available as
> shorten_unambiguous_ref.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Actually, I am not quite sure that this function is "more correct". It
> looks at the rev-parsing rules as a hierarchy, so if you have
> "refs/remotes/foo" and "refs/heads/foo", then it will abbreviate the
> first to "remotes/foo" (as expected) and the latter to just "foo".
>
> This is technically correct, as "refs/heads/foo" will be selected by
> "foo", but it will warn about ambiguity. Should we actually try to avoid
> reporting refs which would be ambiguous?
Back than, there was the idea that the core.warnAmbiguousRefs config
could be used for this.

Anyway

Acked-by: Bert Wesarg <bert.wesarg@googlemail.com>
