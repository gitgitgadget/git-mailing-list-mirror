From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-checkout.txt: Document "git checkout <pathspec>" better
Date: Wed, 10 Jun 2015 08:05:32 -0700
Message-ID: <xmqqioavob7n.fsf@gitster.dls.corp.google.com>
References: <5575F948.4060400@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, eda@waniasset.com,
	Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 10 17:05:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2hZV-0002UY-3Y
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 17:05:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933397AbbFJPFh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Jun 2015 11:05:37 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:36618 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933391AbbFJPFf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 11:05:35 -0400
Received: by igbpi8 with SMTP id pi8so37705115igb.1
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 08:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=YgXwwia6pqWgbqH7COIoLIatP9DdxTsIU9CbAETNsjc=;
        b=gijsZPMO+8jcXVaXwEn5AntWSjsE3/C2DsTzgFhTo8nrOlIQx1EZ2vCq/Sa+Uzt/r8
         EZTNV5dd3EAgg4IgqxBJAF6s4jekDRYo5x0qTt8C2zDn0x2of/CjHSL/qwD46ZyZgob+
         Ec0/LZXXKxQEhgNhnfJ6oGQIWaEPnrc/o5OrwFsir19ZZcazV8VUPaj7rG5c2wu9lrkV
         UsyKM/9QN+KAFB0F3CLuwoGhvimB2VecooBiRN4b4U+GJhykxmytQXFtEZslny6H7zyV
         onFdq33i8KI/0bz0RrYG2H7Ii7kwduxJTrQsPBNRBVlh/uSG46lYrmCWDed2GjfDWtAZ
         Jdrw==
X-Received: by 10.107.27.7 with SMTP id b7mr4691895iob.64.1433948734558;
        Wed, 10 Jun 2015 08:05:34 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b116:bf29:c748:758b])
        by mx.google.com with ESMTPSA id 191sm6174849iof.18.2015.06.10.08.05.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Jun 2015 08:05:33 -0700 (PDT)
In-Reply-To: <5575F948.4060400@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Mon, 08 Jun 2015 22:21:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271295>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> git checkout <pathspec> can be used to revert changes in the working =
tree.

I somehow thought that concensus in the recent thread was that
"restore", not "revert", is the more appropriate wording?

And I think that is indeed sensible because "revert" (or "reset")
already means something else in Git (and in other systems), while
"restore" does not have a confusing connotation.  It can only mean
"overwrite with a pristine copy", which is what the command is
about.

> -git-checkout - Checkout a branch or paths to the working tree
> +git-checkout - Switch branches or reverts changes in the working tre=
e

Two verbs in different moods; either "switch branches or restore
changes" or "switches branches or restores changes" would fix that,
and judging from "git help" output, I think we want to go with the
former, i.e. "switch branches or restore changes".

> =20
>  SYNOPSIS
>  --------
> @@ -83,7 +83,8 @@ Omitting <branch> detaches HEAD at the tip of the c=
urrent branch.
>  	When <paths> or `--patch` are given, 'git checkout' does *not*
>  	switch branches.  It updates the named paths in the working tree
>  	from the index file or from a named <tree-ish> (most often a
> -	commit).  In this case, the `-b` and `--track` options are
> +	commit).  Changes in files are discarded and deleted files are
> +	restored.

I see we are suffering from the common disease of giving one
explanation and then realizing that first explanation can be
misread, clarifying it by more explanation, after reading the
updated text three times.  Let's instead try to clarify the first
explanation to make it harder to misread.

In this case, "updates X from Y" is what causes misunderstanding, as
"updates" does not necessarily mean "restores with the original".

How about this?

  	'git checkout' with <paths> or `--patch` is used to restore
        modified or deleted paths to their original contents from
        the index file or from a named <tree-ish> (most often a
        commit) without switching branches.
