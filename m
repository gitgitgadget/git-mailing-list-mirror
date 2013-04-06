From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] fast-export: Allow pruned-references in mark file
Date: Sat, 6 Apr 2013 11:33:23 -0600
Message-ID: <CAMP44s1n0ALFeOvYevT919iCUt_qRP-nUZn9VqNNnqLG-Xaa1Q@mail.gmail.com>
References: <CALWbr2x4aia4DcdnmfEEBsZwCYasTEp2Jc0jwJgvsUqWSDaWTQ@mail.gmail.com>
	<1365267871-2904-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 06 20:43:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWzZ-0006Rs-0j
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 19:33:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752987Ab3DFRdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Apr 2013 13:33:25 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:39071 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516Ab3DFRdY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Apr 2013 13:33:24 -0400
Received: by mail-wi0-f171.google.com with SMTP id hn17so1461226wib.10
        for <git@vger.kernel.org>; Sat, 06 Apr 2013 10:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=F+Hs5LaEEgVFwJ+kvz+41G+HpEyjyzB54qh//tHUb7E=;
        b=bCigvu5+cPBRha+Le1J67Xk/3vuogu1dp7eJvefFIApRFc+PGe2CowI/Tdh0oQeh9c
         fzivpbxZfQ5NIXTpoYV1EsWM++VpzgXsACq66n1zGWlqYisb0KxKW+EexOmM6q6+sYn0
         1U8xOy+HLLdR/nVY8CAyUhHbYew6r+cs/a3S4yD15TSMWGMD1Scd2U32MPz15sRjUemM
         CUh1WFncbUCjsK37eQMn4zKJ++FRaM+2bU4sZMzlxurbgq6/qkI4sfv0hEJVFJ8eDgrg
         H6c6IS0twxS9Fi9+8NfNj7RACwC9bSn4dGgLxqf2XVnL+TAc5V4NieAQy/xsVHYdjdwZ
         cjZA==
X-Received: by 10.194.82.104 with SMTP id h8mr23364107wjy.3.1365269603353;
 Sat, 06 Apr 2013 10:33:23 -0700 (PDT)
Received: by 10.194.41.2 with HTTP; Sat, 6 Apr 2013 10:33:23 -0700 (PDT)
In-Reply-To: <1365267871-2904-1-git-send-email-apelisse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220268>

On Sat, Apr 6, 2013 at 11:04 AM, Antoine Pelisse <apelisse@gmail.com> wrote:
> fast-export can fail because of some pruned-reference when importing a
> mark file.
>
> The problem happens in the following scenario:
>
>     $ git fast-export --export-marks=MARKS master
>     (rewrite master)
>     $ git prune
>     $ git fast-export --import-marks=MARKS master
>
> This might fail if some references have been removed by prune
> because some marks will refer to no longer existing commits.
> git-fast-export will not need these objects anyway as they were no
> longer reachable.
>
> We still need to update last_numid so we don't change the mapping
> between marks and objects for remote-helpers.
> Unfortunately, the mark file should not be rewritten without lost marks
> if no new objects has been exported, as we could lose track of the last
> last_numid.

Makes sense to me.

Reviewed-by: Felipe Contreras <felipe.contreras@gmail.com>

-- 
Felipe Contreras
