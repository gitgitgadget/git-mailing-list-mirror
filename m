From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] Add log.abbrevCommit config variable
Date: Mon, 16 May 2011 02:00:47 -0500
Message-ID: <20110516070047.GA26270@elie>
References: <BANLkTi=og+e6JW8t+sCvkFJUnR=SrFtWGg@mail.gmail.com>
 <1305413341-56450-1-git-send-email-jaysoffian@gmail.com>
 <7vei3zoab9.fsf@alter.siamese.dyndns.org>
 <BANLkTi=iFgJ12=_amoxT8x+hNMEhQtOVBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 16 09:01:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLrne-0006Iw-Gu
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 09:01:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937Ab1EPHBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 03:01:00 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33978 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576Ab1EPHA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 03:00:59 -0400
Received: by iyb14 with SMTP id 14so3495548iyb.19
        for <git@vger.kernel.org>; Mon, 16 May 2011 00:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=fvDdRpB9xXXvFWK/9qZosO9eaIxEH297qDPN7+trm84=;
        b=f0KY3Z81q6N/O+MbYgDx2xroOAIuHs17rRgBjl+RJNY1F9yWPs9rKkYiwIdkR/W3cQ
         knbfvYJ8AmrpUEY8fql0gB8nkTvKGheH/LgD4QoWQDtFS7doopO9g5LrsG2WNmUterbU
         Zpey7TeGDcDduWEu+3P6Kjk/YUod3u4Lxlzjo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=k3eaUy5+lyMcVRNEJR0ZKPUtYLal4RenXPhJgVMnDQt0NX5Y1FZuUeeEfzWhri1gf6
         v+mkNjKEiin9nHNgq7ywwVdDgn5vxiqfxx8yqRArfVeALJWK1W0BDBLnJE+4PbumzWW4
         4kQ+8I3CrQ1Ya39HEkvlvypMHB2ioP3+0n6AU=
Received: by 10.42.196.196 with SMTP id eh4mr4728405icb.246.1305529259086;
        Mon, 16 May 2011 00:00:59 -0700 (PDT)
Received: from elie (adsl-69-209-63-133.dsl.chcgil.ameritech.net [69.209.63.133])
        by mx.google.com with ESMTPS id g16sm2123294ibb.20.2011.05.16.00.00.56
        (version=SSLv3 cipher=OTHER);
        Mon, 16 May 2011 00:00:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTi=iFgJ12=_amoxT8x+hNMEhQtOVBg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173713>

Jay Soffian wrote:
> On Sun, May 15, 2011 at 6:42 PM, Junio C Hamano <gitster@pobox.com> wrote:

>> I am not entirely happy about this change. The "ditto" refers to an ugly
>> workaround we had to add with 4f62c2b (log.decorate: only ignore it under
>> "log --pretty=raw", 2010-04-08) only because it was too late to revert the
>> change in 72d9b22 (Merge branch 'sd/log-decorate', 2010-05-08) that was
>> about to become part of 1.7.2-rc0 release. If we knew better, we probably
>> wouldn't have added the log.decorate variable that requires this hack that
>> requires us to say that 'log --pretty=raw' is special.
>>
>> If we stop before adding a new configuration, we do not have to repeat the
>> same mistake we made earlier.
>>
>> I dunno.
>
> I disagree that log.decorate is a mistake and that the workaround is
> ugly.

I suppose part of what Junio is saying is that by the time the commits
referenced above were written, git had already broken some scripts
(including gitk) and those changes were part of a desparate attempt to
contain the damage.  So they are not a great example to look to for
the sort of smooth transition it is possible to set up proactively.

For example, maybe (after fixing the scripts we already know about,
such as tig) we could add the log.abbrevcommit variable right away but
advertise it as experimental:

	*Warning* This option is experimental and will break your
	scripts.  It is only provided to give script authors a
	chance to test this functionality and fix their scripts
	before the feature is advertised in earnest.

One transition plan could look like this:

 1. In the release notes to v1.7.6, mention that there is a change
    on the horizon that would break people's scripts and encourage
    script authors to switch to "rev-list | diff-tree -s --stdin"
    if their scripts depend on the details of "git log" format
    (in particular, if their scripts do not work correctly after
    s/log/log --abbrev-commit/).  Introduce the log.abbrevcommit
    variable to help people test, guarded by a compile-time
    option and disabled by default.

 2. In v1.7.7, introduce the log.abbrevcommit variable, advertised
    as "This will break your system --- don't use it unless you
    are trying to find such breakage and fix it".

 3. In v1.8.0, introduce the variable in earnest and recommend
    that people use it.

I think step 1 is going too far --- it should be possible to give
users rope like this without worrying that they are going to be
irresponsible about it.

Now, returning to "log --pretty=raw".  Is it plumbing or not?  It
would be nice to advertise whichever way it is decided (I guess it is
de facto plumbing) in the "git log" reference documentation and to
follow that decision in cases like this one.

Thanks for some food for thought.

Ciao,
Jonathan
