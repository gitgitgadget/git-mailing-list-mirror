From: Stefan Saasen <ssaasen@atlassian.com>
Subject: Re: [BUG] Performance regression due to #33d4221: write_sha1_file:
 freshen existing objects
Date: Wed, 22 Apr 2015 11:46:17 +1000
Message-ID: <CADoxLGOEE8rT7SS1n+wxmBbWWsLY+a5QstM=WPC=c5EajqfVkA@mail.gmail.com>
References: <CADoxLGPYOkgzb4bkdHq5tK0aJS2M=nWGzO=YYXPDcy-gh45q-g@mail.gmail.com>
 <20150417140315.GA13506@peff.net> <CADoxLGOPXDgb0LBcSBm+xRDhbnGV_y-TXENyPV7oK_+KZzPKRQ@mail.gmail.com>
 <20150420195337.GA15447@peff.net> <xmqq1tjelg78.fsf@gitster.dls.corp.google.com>
 <20150420200956.GA16249@peff.net> <CADoxLGOdvJVgjRFrC81nM6A4=PRABSiL_EGOUtN7d-MAKXrzzg@mail.gmail.com>
 <xmqqiocpif8p.fsf@gitster.dls.corp.google.com> <xmqq4mo9gnq3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	"Kyle J. McKay" <mackyle@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 03:47:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkjlD-00007Z-FB
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 03:47:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbbDVBrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 21:47:00 -0400
Received: from na3sys009aob139.obsmtp.com ([74.125.149.251]:40602 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932116AbbDVBq7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Apr 2015 21:46:59 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]) (using TLSv1) by na3sys009aob139.postini.com ([74.125.148.12]) with SMTP
	ID DSNKVTb9ku7sjeS0I7gtnSRK6+MXSeyb0gk0@postini.com; Tue, 21 Apr 2015 18:46:59 PDT
Received: by igblo3 with SMTP id lo3so101710597igb.1
        for <git@vger.kernel.org>; Tue, 21 Apr 2015 18:46:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=ExwO6Cof/Q/GgjlsQHcDveeIzzhl30Ux9RQxxAeJ8aY=;
        b=LnQwyDkifvHEwmS6q0achr1gAgedNwabqaeDsA7KGlCZdTwyCWhdVb2QylPnJF2Vs/
         6L249zItUmzIzofn0hOyK6mb8fnH57DoImahymdxf49QooVKCj0FEWVtpwNR1Hp0cM9d
         p2yUIcPB75AtZvaZaZruTMVh84y/cx8whZTKr2/kWLnsozCQrRMq/L1Z8eBUK/4BLQBR
         7OETBiFUW+TdsBYZd7omeFBMHVHRDNjt7Hsr0X89AORoDNv9xPv1fLGaJn2MTD5jJl9r
         aI++Ibp6SUXvpDk59H82hBeMuA1Q818AUt9Mzb6RV9JJ0Vxficfp7pRmnX467MHXylnS
         DMsQ==
X-Gm-Message-State: ALoCoQmeZIHMDn+JN1NYLRkPuW+o9CQxYKaXIqbes5RQakTdugxbDS36g9JcwDypR5HHreFeEKXSkSVw4ULmImBiD0CkVjHwgqtlUoitoW/L5/0Pztf87OpoPS3qluLMWjmeTJy9OMziG36lWyVN6gjw/8si5+vs9w==
X-Received: by 10.42.164.7 with SMTP id e7mr6735707icy.70.1429667218632;
        Tue, 21 Apr 2015 18:46:58 -0700 (PDT)
X-Received: by 10.42.164.7 with SMTP id e7mr6735704icy.70.1429667218534; Tue,
 21 Apr 2015 18:46:58 -0700 (PDT)
Received: by 10.36.118.133 with HTTP; Tue, 21 Apr 2015 18:46:17 -0700 (PDT)
In-Reply-To: <xmqq4mo9gnq3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267577>

> Perhaps companies like Atlassian that rely on the stability of the
> open source Git can spare some resources and join forces with like
> minded folks on LTS of older maintenance tracks, if they are truly
> interested in.

We certainly can and would like to. I'm not entirely sure what that
would entail though?

>From reading through $gmane/264365 I've identified the following
responsibilities/opportunities to help:

>    - Monitor "git log --first-parent maint-lts..master" and find
>      the tip of topic branches that need to be down-merged;
>
>    - Down-merge such topics to maint-lts; this might involve
>      cherry-picking instead of merge, as the bugfix topics may
>      originally be done on the codebase newer than maint-lts;

and more importantly testing the maint-lts version to ensure
backported changes don't introduce regressions and the maint-lts
branch is stable.

This suggests specific, spaced LTS versions but in the same thread you
mention maint-2.1or maint-2.2.
So a different model could be maintaining old versions in a sliding
window fashion (e.g. critical issues would be backported to the last 6
months worth of git releases).

Maybe I'm getting ahead of myself here :)

Anyway, long story short. We're interested to help but I'm not
entirely sure what that would look like at the moment. Are there
formed ideas floating around or would you be looking for some form of
proposal instead?

Cheers,
Stefan
