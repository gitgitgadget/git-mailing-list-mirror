From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/9] t3510 (cherry-pick-sequencer): use exit status
Date: Fri, 9 Dec 2011 15:00:58 -0600
Message-ID: <20111209210058.GN20913@elie.hsd1.il.comcast.net>
References: <1323445326-24637-1-git-send-email-artagnon@gmail.com>
 <1323445326-24637-6-git-send-email-artagnon@gmail.com>
 <20111209202149.GH20913@elie.hsd1.il.comcast.net>
 <CALkWK0=a=-4N4aZHuu=5zkNtwmfLsog5WkBVbuJAbYpvaLUsAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 22:01:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ7Z8-0006fp-6T
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 22:01:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753680Ab1LIVBF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Dec 2011 16:01:05 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:46021 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459Ab1LIVBE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Dec 2011 16:01:04 -0500
Received: by ggnr5 with SMTP id r5so3742616ggn.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 13:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Y5yOCFjgs7qIkitgml8w8S14vUYXrJnXpJTvLSimFyw=;
        b=IYmvMYmFs8CX5oscdYrExaP+nCC51PyMowPoULqClMqa45pETiZF222pT39MrJNYah
         VWGWYg3xUp0ptdLm+bAd5icnIlpIec/RcGViNWim6WwRy1bxpzsiZ2PiwPoXoM+w1xLz
         DAa1Qm7i7Msimkk2a1MD6WvJfFu4fVNwPLiC0=
Received: by 10.182.41.69 with SMTP id d5mr828190obl.47.1323464463566;
        Fri, 09 Dec 2011 13:01:03 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id t9sm883673obv.8.2011.12.09.13.01.02
        (version=SSLv3 cipher=OTHER);
        Fri, 09 Dec 2011 13:01:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALkWK0=a=-4N4aZHuu=5zkNtwmfLsog5WkBVbuJAbYpvaLUsAg@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186695>

Ramkumar Ramachandra wrote:
> Jonathan Nieder wrote:
>> Ramkumar Ramachandra wrote:

>>> - =C2=A0 =C2=A0 test_must_fail git cherry-pick -s -m 1 --strategy=3D=
recursive -X patience -X ours base..anotherpick &&
>>> + =C2=A0 =C2=A0 test_expect_code 128 git cherry-pick -s -m 1 --stra=
tegy=3Drecursive -X patience -X ours base..anotherpick &&
>>> =C2=A0 =C2=A0 =C2=A0 test_path_is_dir .git/sequencer &&
>>
>> Encountered conflicts, preserving options, but the exit is with stat=
us
>> 128? =C2=A0Smells like a bug.
>
> No bug.

Ok.  I'm fuzzy on the details, but is it possible to make this change
in such a way as to make that obvious?  For example, perhaps this
should be split into several tests: one to check that such mistaken
use of "-m 1" with non-merge commits correctly interrupts the
cherry-pick and pleads to the user for advice (should it?), another to
check that doing so produces an exit status of 128 (if it should), and
another to make sure that doing so, fixing things up somehow, and
resuming the sequence allows the effect of "-m 1" to carry over to
later commits.
