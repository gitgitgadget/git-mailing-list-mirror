From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/9] Add treap implementation
Date: Thu, 24 Jun 2010 21:08:13 +0200
Message-ID: <AANLkTinYmKl4M10l3u5V7deleqSzr7iJDqf7X6ghtwRM@mail.gmail.com>
References: <20100624105004.GA12336@burratino> <20100624105706.GD12376@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Eric Wong <normalperson@yhbt.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 21:08:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORrn1-0002B1-75
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 21:08:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755443Ab0FXTIh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jun 2010 15:08:37 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:38001 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754973Ab0FXTIg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jun 2010 15:08:36 -0400
Received: by qyk38 with SMTP id 38so289580qyk.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 12:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=lSdabk0qrej0T5S5Y4tacoDlzakn2oIzkXA5N9qLq7w=;
        b=bAQsa4tX8C4kpbksfz1dTOqOMUVVjTvpGuht/6dmbwIl0Kxvb/01QJZnq/5pFDRhM6
         2s9sDW1ey1iVwk8bkUyequa+gtICZJ3LTGElej1ku5P2bptX6C2L+UF5pWv3KkuA+J2j
         BbkgiaTOhiEjXWN3vGB0KhOkjQBgFUumdB0t4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=xFsV/fcGfqhwfF9C2e+LgIdMbPyiBQeLiBQuCASDOBtnnXbbBvpVaioRwXXjQhi1v9
         ljY3EYpmoaI+Y/LUVBdmu4vxBoaBqaDPuohckE4DE/Y9g/KsdhGGCiQq5BkeBUZ9q5F8
         O2NmlvDwmjzfGsUdPwoNHMbvHaeaWTN080ovA=
Received: by 10.224.96.229 with SMTP id i37mr6511947qan.270.1277406513260; 
	Thu, 24 Jun 2010 12:08:33 -0700 (PDT)
Received: by 10.229.45.71 with HTTP; Thu, 24 Jun 2010 12:08:13 -0700 (PDT)
In-Reply-To: <20100624105706.GD12376@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149621>

Hi again,

Jonathan Nieder wrote:
> From: Jason Evans <jasone@canonware.com>
>
> Provide macros to generate a type-specific treap implementation and
> various functions to operate on it. It uses obj_pool.h to store memor=
y
> nodes in a treap. =C2=A0Previously committed nodes are never removed =
from
> the pool; after any *_commit operation, it is assumed (correctly, in
> the case of svn-fast-export) that someone else must care about them.

This is likely to change in a few days. David is currently working on
a Java implementation of a immutable ternary treap and will
re-implement it as C macros. See the ternary-treap branch.

> =C2=A0$(VCSSVN_OBJS): \
> - =C2=A0 =C2=A0 =C2=A0 vcs-svn/obj_pool.h
> + =C2=A0 =C2=A0 =C2=A0 vcs-svn/obj_pool.h vcs-svn/trp.h

Interesting how you've shown this in every patch :)

> +/*
> + * Fibonacci hash function.
> + * The multiplier is the nearest prime to (2^32 times (=E2=88=9A5 - =
1)/2).
> + * See Knuth =C2=A76.4: volume 3, 3rd ed, p518.
> + */

Um, is it alright to put non-ascii characters in a file containing
code? I haven't seen such a thing in any of the other files. Will some
old compilers complain while parsing?

> --- /dev/null
> +++ b/vcs-svn/trp.txt
> @@ -0,0 +1,90 @@
> +treap API

The documentation is good, but I don't see it merged into the tree.
Perhaps send a patch to David? Also, you might want to include the
technical explanation for using treaps from the commit message here?

-- Ram
