From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] mergetool--lib: Allow custom commands to override built-ins
Date: Wed, 26 Sep 2012 11:31:45 -0700
Message-ID: <CAJDDKr4OkvAvRQFjp0NuzYkE2DSdvXh1vvTdKeaCq+bvQA4kuQ@mail.gmail.com>
References: <1348559291-71739-1-git-send-email-davvid@gmail.com>
	<CALkWK0naJt840LfMNBM7EtdyLE5nmJeAsxG-Wttj8c84O5X7jA@mail.gmail.com>
	<7vtxukubds.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Sylvain Rabot <srabot@steek.com>,
	K Gateway <kowloongateway1@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Mike Schuld <mike.schuld@foundant.com>,
	Stefan Kendall <stefankendall@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 20:31:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGwOq-0004dP-Ox
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 20:31:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756887Ab2IZSbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 14:31:47 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:36784 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755624Ab2IZSbq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 14:31:46 -0400
Received: by vbbff1 with SMTP id ff1so997118vbb.19
        for <git@vger.kernel.org>; Wed, 26 Sep 2012 11:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MyYRo8dpdl85Xkrkj/dL7m4z93tCbsJtvSwz9lSkWKs=;
        b=RJ1qRL2gcDRSrbcXv7s59CDot9vPmv+D4fzpTIlKV88UuQTXpK/PgpU/7d36dJNTpO
         Vr+dIqJK6dLs6P+OOFiFps1hKAeY4zDdX/ctFKkYhrFm40vv4uet969jntHFcu/n/4jN
         Zj+aCYCTunB7bOQGTUH2G3vYIjezSre9rJ1HGxpJBYqgL7KicBQQCbzyRuWkv6vLRSd8
         YLQ/F3WiCc5SQPEeadymy1rSYjieZMgOr0cLbJ4riKyfL+v2zONYzUA1htAOQmGm4wc/
         JZcaXQmdrULf7C/sTjtlCzkKVgAAu8DcbhpNI9MRomJaDVO8hri9/RxFBnSG+vr6+HHc
         HJYQ==
Received: by 10.52.68.199 with SMTP id y7mr625447vdt.80.1348684305769; Wed, 26
 Sep 2012 11:31:45 -0700 (PDT)
Received: by 10.58.180.39 with HTTP; Wed, 26 Sep 2012 11:31:45 -0700 (PDT)
In-Reply-To: <7vtxukubds.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206426>

On Wed, Sep 26, 2012 at 7:06 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> Hi David,
>>
>> David Aguilar wrote:
>>>  diff_cmd () {
>>> -       merge_tool_cmd="$(get_merge_tool_cmd "$1")"
>>> -       if test -z "$merge_tool_cmd"
>>> -       then
>>> -               status=1
>>> -               break
>>> -       fi
>>> -       ( eval $merge_tool_cmd )
>>> -       status=$?
>>> +       status=1
>>>         return $status
>>>  }
>>
>> Nit: Why not return 1, instead of setting $status and returning it?
>
> Perhaps because the caller "run_merge_tool" pays attention to
> $status that is a global variable?
>
> Have you traced the call chain?

Exactly.  I would like to eliminate globals whenever possible,
but this particular topic involved refactoring which aimed to keep
existing behavior w.r.t these variables unchanged.
-- 
David
