From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [GSoC 2011 v2] Git Sequencer
Date: Wed, 6 Apr 2011 10:11:47 +0200
Message-ID: <BANLkTim5B1PGHr+TKGFaekywUh9r6K_Htg@mail.gmail.com>
References: <20110403172054.GA10220@kytes>
	<20110405200008.GC25644@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Stephen Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 10:11:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7NqH-0002QK-I0
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 10:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754818Ab1DFILw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Apr 2011 04:11:52 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34160 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754125Ab1DFILt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Apr 2011 04:11:49 -0400
Received: by wwa36 with SMTP id 36so1437081wwa.1
        for <git@vger.kernel.org>; Wed, 06 Apr 2011 01:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CwmuU2FY6zbhjSxKVYIHA2mw7Zexy978LsBKhenCslY=;
        b=mPVFLutYSKZ0Jgz+XMahR51Evdr1TYb/NFXtjNSBVUc1WEhujmifnmTDb2qlc7RTNx
         Mha3NvkV4+SjaCX/HV73k4zsHdBOXTDjjz6fsrmP7Bc7PvrvVt37iehrUC7120lIV5DG
         C7YqFP3U9F3z8RjgnA8PYbC99pxixzkVUndU0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=AmR43JArjdGISNxozDV6IOPipncbmy8aYTyLc9wkejA1HJT868ChrIE1r2j30eB0nk
         wg0zVSEMZOlvsmzF9FAB6xH3qpctJQ1UCilOArBzjkLfFCBlqWqXLIxh4shdhvgtm5TJ
         lLo4Xh4l1Qz+BxHWlmbyct7R9nagIAQZiQvIc=
Received: by 10.216.171.133 with SMTP id r5mr6120294wel.91.1302077507737; Wed,
 06 Apr 2011 01:11:47 -0700 (PDT)
Received: by 10.216.89.12 with HTTP; Wed, 6 Apr 2011 01:11:47 -0700 (PDT)
In-Reply-To: <20110405200008.GC25644@kytes>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170954>

Hi,

On Tue, Apr 5, 2011 at 10:00 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
>
> 2. Build a sequencer so that just has cherry-picking functionality.
> This mostly involves moving code written in (1) around, and crafting =
a
> general API for handling conflicts.
>
> 2.1. Factor out the 'cherry-pick' code from 'revert.c' into a new
> 'builtin/sequencer.c'.
>
> 2.2. Write an API for handling conflicts, so that the sequencer is
> ultimate entry/ exit point for all user intervention in a multi-step
> process [4].

This one may be more difficult than we can guess right now, and it is
linked with 2.4 that is optional too. And I wouldn't like you to spend
too much time on it if it appears to be quite difficult. So I'd
suggest that you switch 2.2 and 2.3 and make the new 2.3 optional.

> 2.3. Implement a fresh 'cherry-pick.c' on top of the sequencer. =A0Ma=
ke
> sure that all the existing tests pass.
>
> 2.4 [Optional] Patch 'builtin/merge.c' to use the conflict handler in
> the sequencer.
>
> 3. Extend the sequencer to accomodate the functionality provided by
> 'rebase -i'.

s/accomodate/accommodate/

> 3.1. Parse commands like 'execute', 'reword', 'squash', and 'fixup'
> that are specific to interactive rebasing. =A0Carefully implement the
> functionality for each of these keywords in a step-wise manner.

I think that here you could add something like:

3.2. Make 'rebase -i' use the sequencer when '--preserve-merges'
option is not used.

> 3.2. [Optional] Port the '--preserve-merges' option of 'rebase' to th=
e
> sequencer. =A0Port relevant tests from 't3409'.

> 4. [Optional] Lib'ify the sequncer.

s/sequncer/sequencer/

> Modify the API to
> include rebase-related functionality. =A0Write 'rebase.c' as a bunch =
of
> API calls to the sequencer. =A0Make sure that the existing tests pass=
=2E
>
> 5. [Optional] Re-implement 'git-am.sh' as a thin wrapper over the
> sequncer: 'am.c'.

s/sequncer/sequencer/

> Bulk of this should be mbox parsing code. =A0Make sure
> that all existing tests pass.
>
> [Optional] should be read as "If time permits"

Otherwise I like it very much.

Thanks,
Christian.
