From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 00/22] Refactor to accept NUL in commit messages
Date: Sun, 23 Oct 2011 17:37:16 +1100
Message-ID: <CACsJy8CA2cqJqt7cUN1CdnOb3=qE6B2XTd1oQKZ7osVz09kSGg@mail.gmail.com>
References: <1319277881-4128-1-git-send-email-pclouds@gmail.com>
 <7vobx863v3.fsf@alter.siamese.dyndns.org> <CACsJy8B=TsC4A=R6b3jyYBCvorEDBYHQ8uA864WrB0-3pgNyKA@mail.gmail.com>
 <7vipng5k80.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, peff@peff.net,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 23 08:37:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHrgw-0005pn-VF
	for gcvg-git-2@lo.gmane.org; Sun, 23 Oct 2011 08:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754949Ab1JWGhu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Oct 2011 02:37:50 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48555 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755026Ab1JWGhs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Oct 2011 02:37:48 -0400
Received: by bkbzt19 with SMTP id zt19so6700330bkb.19
        for <git@vger.kernel.org>; Sat, 22 Oct 2011 23:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Z9c0T56ygfvn8QM0Zns05hV/u6+O74vqJDyx6ESAG/Y=;
        b=DNMDcl8IIv5P+p49dfZtdKnTYlNc7ZIb89ltTTi261gdbuvPSnrIgKfrtYcOpt21oI
         i5hR627XJL/ZP+r4tfnYD/HeNq1FVLsWAZ0Acl/R3A5B4cOmFC6OLLs9JPDNMSZ04ub2
         SJl513kFt/Mgg39DkvArzNwYJp09TQl3YEjro=
Received: by 10.204.129.155 with SMTP id o27mr1195680bks.94.1319351867293;
 Sat, 22 Oct 2011 23:37:47 -0700 (PDT)
Received: by 10.204.120.75 with HTTP; Sat, 22 Oct 2011 23:37:16 -0700 (PDT)
In-Reply-To: <7vipng5k80.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184127>

On Sun, Oct 23, 2011 at 4:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> So in that sense, I do not think it is unreasonable to chop it off at the
> first NUL, which is the current behaviour. IOW, it is entirely sane to
> argue that there is nothing to fix.

Good for me too if we go this way. I was just curious what if we
changed commit_buffer field and got hooked in.

> But as Jeff suggested, we should step back a bit and think what our goal
> is.
>
> The low level object format of our commit is textual header fields, each
> of which is terminated with a LF, followed by a LF to mark the end of
> header fields, and then opaque payload that can contain any bytes. It does
> not forbid a non-Git application to reuse the object store infrastructure
> to store ASN.1 binary goo there, and the low level interface we give such
> as cat-file is a perfectly valid way to inspect such a "commit" object.

cat-file is fine, commit-tree (or any commands that call
commit_tree()) cuts at NUL though.

I wonder how git processes commit messages in utf-16. Did a quick
test, did not look good. But that's because git-commit cuts at NUL.
But even if git-commit makes a good object, I doubt if git-log shows
it right.
-- 
Duy
