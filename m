From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH 2/2] Teach commit to handle CHERRY_HEAD automatically
Date: Tue, 15 Feb 2011 18:08:59 -0600
Message-ID: <20110216000859.GC18151@elie>
References: <1297805034-3512-1-git-send-email-jaysoffian@gmail.com>
 <1297805034-3512-3-git-send-email-jaysoffian@gmail.com>
 <20110215230015.GA17812@elie>
 <AANLkTinZ0ewJy01rV66xMMCKLon=7qz=hoJ3DbtXmtXL@mail.gmail.com>
 <20110215234735.GA18151@elie>
 <AANLkTinrQ4hSh-dg6mU=gYi6C8ZWS4eFKbAV=8eucEg2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 01:09:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpUxF-0008Kw-8J
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 01:09:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753073Ab1BPAJI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Feb 2011 19:09:08 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:37188 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027Ab1BPAJH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 19:09:07 -0500
Received: by qwa26 with SMTP id 26so629300qwa.19
        for <git@vger.kernel.org>; Tue, 15 Feb 2011 16:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Kqrk6guLJK3YOMiT0oXjCMHygriS0S8ZuxfnZgWemSc=;
        b=U32hBV2bOpFNqwMNWe1pFIvpGFJj18QnrdfPB5Oyj0ryyuZd+3ynmdL/ktVhQ8XCWY
         OEE/HyKYEvHOK1gzApx/QvDrz3AH6MnLGL5F4i9SdGae/FYmNYVA3rK8pUlx7xYumwzG
         kQKJv+y72CkVCZwdFAW7cddGyBodZlxdt/Am8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=p/XZAQdhqQNuN8g6Ahr4pMle/rtGe4jxBhRPYLh6NX3/9crTkAG565Q/Ncxv5NYpHj
         PZbBAYFRTQRB3kxPmR3yAJCFPKE8gR/xUXeed0Z8AlbXn97wDoi02SuqO+lKOZ5ubok2
         0kJk0XIX8lfBgE9p96hLOv2iUbcJg2Cqv3q5s=
Received: by 10.224.37.2 with SMTP id v2mr40206qad.92.1297814946543;
        Tue, 15 Feb 2011 16:09:06 -0800 (PST)
Received: from elie (adsl-69-209-51-217.dsl.chcgil.sbcglobal.net [69.209.51.217])
        by mx.google.com with ESMTPS id q12sm3081501qcu.18.2011.02.15.16.09.03
        (version=SSLv3 cipher=OTHER);
        Tue, 15 Feb 2011 16:09:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTinrQ4hSh-dg6mU=gYi6C8ZWS4eFKbAV=8eucEg2@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166908>

Jay Soffian wrote:

> CHERRY_PICK_HEAD is not written if you use --no-commit.  I'm going to
> punt here and say that's not my itch, thus...
>
> On Tue, Feb 15, 2011 at 6:47 PM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:

>> But that was a silly example --- -C takes care of authorship on its
>> own. =C2=A0A better example might be
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0git cherry-pick --no-commit F
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit -F the-message
>>
>> or
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0git cherry-pick --no-commit F
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit --amend -C F-prime
>
> Because CHERRY_PICK_HEAD wasn't written, commit in this case behaves
> as it did before this series.

I'll just wait for the reroll and try it.  But surely it is clear what
I am asking?

	git cherry-pick conflicting-thing
	... fix conflict ...
	git commit -F message

should either error out or respect the user's wish, and likewise

	git cherry-pick conflicting-thing
	... fix conflict ...
	git commit --amend -C something-else

should error out.
