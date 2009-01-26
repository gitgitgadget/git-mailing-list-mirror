From: "Nathan W. Panike" <nathan.panike@gmail.com>
Subject: Re: [PATCH] Allow format-patch to create patches for merges
Date: Mon, 26 Jan 2009 10:27:18 -0600
Message-ID: <d77df1110901260827j2200fe41oe1b84c387d88aba@mail.gmail.com>
References: <1232978650-7008-1-git-send-email-nathan.panike@gmail.com>
	 <alpine.DEB.1.00.0901261604420.25749@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 26 17:28:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRUKM-0008Pu-Jy
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 17:28:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616AbZAZQ1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 11:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751590AbZAZQ1V
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 11:27:21 -0500
Received: from yw-out-2324.google.com ([74.125.46.28]:63012 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565AbZAZQ1U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 11:27:20 -0500
Received: by yw-out-2324.google.com with SMTP id 9so2587095ywe.1
        for <git@vger.kernel.org>; Mon, 26 Jan 2009 08:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PT8EZPtUndjBn24QSsJrwyu/hmyAjYvDjvOBd9TExN8=;
        b=OD4P0+YkfX8iqYRSr+qzIeHhiMB40mJr/zxwIgd2+ZRZbFI6YXIv5vL5Gro+pvZfUG
         UuiYmlroF7Qyd/hIwBHeKWhCAmOCTQL1t0KBHFM6kT0EIC083nsga16lX5e1zJQP738u
         fzySZRNckvSkodPNJ0wgTBYcHpnWwZtTZNs0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PsV8sZk5zmMgoOj+vO9Kkv9tPzAp1vQiOzIfKCDCTaiU7PE2iu3I42pF/CpIR3sS0W
         4pyq3og8Qo4jLBy1tt48wLR+lkjxYfCejfVOpkftv6+SkaXa7miXQtYeBx5BbeU4b6jb
         RGqLikgx/i+gyz90Xg37dmv0oe+bWRtnGE5xA=
Received: by 10.90.35.9 with SMTP id i9mr631914agi.35.1232987238609; Mon, 26 
	Jan 2009 08:27:18 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901261604420.25749@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107226>

On Mon, Jan 26, 2009 at 9:36 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 26 Jan 2009, Nathan W. Panike wrote:
>
>> The behavior for git format-patch is to ignore merge commits, producing
>> an empty patch.  The code does not allow the user to change this
>> behavior. This patch changes that behavior by allowing the user to
>> specify -c or -m at the command line to produce a patch for a merge
>> commit.
>
> Your patch is almost perfect, except that you
>
> - lack an explanation when this makes sense (format-patch is commonly used
>  for mail-based patch queues, and only -m 1 would make sense there, and
>  only if you run format-patch with --first-parent),
>
I think I have an unusual workflow where my patch makes sense,
although it probably does not for the vast majority of git users.  I
regularly use 3 machines: S, L, and H.  I keep my work synchronized by
using git.  Normally, I fetch from S to L or to H, depending on which
machine I am working on at the moment.  I also push from L or H to S.
I sporadically lose connectivity to S, so I have a hook in the repo on
S to send a backup email to me on mail server M, which has a more
reliable connection.  This email also serves as a  reminder when I
have moved from one machine to another with a degree of latency; and I
can use the mail queue on M to recreate most of my state, if I cannot
fetch from S.  In this workflow, I would really like git to create a
patch, even in the merge case, and I think I want to see that it was a
merge.

What I do not want to see is an empty patch when a non-trivial change
has occurred, which is the way it works now.

Also, I think I must be issuing the wrong command, as when I do

git format-patch --first-parent --stdout -1 $merge_commit

there is no data, with or without my patch.

> - did not add your Sign-off :-)

Oops.  Thanks for the catch.

>
> Ciao,
> Dscho
>
>
