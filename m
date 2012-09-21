From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: How do I run tests under Valgrind?
Date: Sat, 22 Sep 2012 01:47:46 +0530
Message-ID: <CALkWK0mk6m44J8nuqVUvgxWE+RoRtg+uAewyYjwDRFS+fDkNRw@mail.gmail.com>
References: <CALkWK0m_9OsAfG_pF3hUDW+EKCyZCn9NiDKKEW6AEOMmAw=yuA@mail.gmail.com>
 <20120917172022.GA1179@sigill.intra.peff.net> <CALkWK0m378ApSwa1xiYUqEjMny5m0wt3KacqdDRU1qt=cw6k8g@mail.gmail.com>
 <20120917173531.GB1179@sigill.intra.peff.net> <CALkWK0kDPGY_3v5SLPtyf+azUwA7msvQOvA+MaCgueZ71i2yGw@mail.gmail.com>
 <20120917174439.GD1179@sigill.intra.peff.net> <CALkWK0mkBbY7dUyaZAqqKE3ZMfE_xU6em_KCOKM9nsTjUP-9pA@mail.gmail.com>
 <20120917182957.GF1179@sigill.intra.peff.net> <CALkWK0=nMxNfmAaBTmXeADQubTayC_2_ut5Nq3QXba9yfQr9yA@mail.gmail.com>
 <CALkWK0kWvrirPjXXzBBBQxKDcwpd_+nQ2eeT6SE8gDFW5T7WFQ@mail.gmail.com> <505CCA55.6030609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 22:18:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TF9g2-0006WR-Tw
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 22:18:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757906Ab2IUUSJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 16:18:09 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:61244 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757891Ab2IUUSI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 16:18:08 -0400
Received: by qcro28 with SMTP id o28so2912361qcr.19
        for <git@vger.kernel.org>; Fri, 21 Sep 2012 13:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gq1k5PqC9otNQnlV+IVPpoOK2PaTD93zi2z+ft5SJzk=;
        b=CZ9D80ZlvPjsHayrf+smBDgMzA3KeJ4Qt0yUGgda07iQFAag6VskzygZQ9d++1zKl+
         pwmyqmd6hSDPS1iS6wjuDsvvabM11ewOzIdi3CzgT9y7aHrlAK3mccglyOvvlDjdhAur
         hchK/AbAOzqth7NPEw5rAFGpGJmJx3iXcoo2sBAKMAFJ+YXR06xWSgTy/SACOjnmpYhW
         BsG9Zu3oSx2CYMMuhiL58UUvrKLhabRlgCpoKUKU4V4Bdaftjj8ERwM21bjNl/8LPSxl
         sgYCbiWqWk65MRKRy10eiUkM5PC1T1Y5MJnVPa2or24T+Q12qbCeE8YuoPbZAYk1fLoy
         0imw==
Received: by 10.224.58.147 with SMTP id g19mr14835555qah.77.1348258687236;
 Fri, 21 Sep 2012 13:18:07 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Fri, 21 Sep 2012 13:17:46 -0700 (PDT)
In-Reply-To: <505CCA55.6030609@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206158>

Hi Stefano,

Stefano Lattarini wrote:
> Zsh doesn't do word-splitting by default on variable expansions:
>
>     $ zsh -c 'v="1 2 3"; for x in $v; do echo "$x"; done'
>     1 2 3
>
> unless you set the SH_WORD_SPLIT option, or put Zsh in Bourne-compatibility
> mode somehow:

... but didn't we set $IFS for this purpose?  The following segment of
code works:

    IFS=:
    for path in $PATH
    do
        ls "$path"/git-* 2> /dev/null |
        while read file
        do
    	    echo $file
        done
    done

Ram
