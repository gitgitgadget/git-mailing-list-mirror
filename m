From: Junio C Hamano <gitster-vger@pobox.com>
Subject: Re: [PATCH] git fetch one tag only
Date: Wed, 6 Jun 2012 21:37:55 -0700
Message-ID: <CAPc5daVwOuP_dPiHh5zcjV6kTvdb2FNhzXz_capEDhHgE5ZUKw@mail.gmail.com>
References: <CAH5vBdK_M+7Hjk=juVeP7Phqvs2+npknFD-=45OVR032k5S-0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: cheng renquan <crquan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 06:38:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScUUY-0004uv-He
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 06:38:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760001Ab2FGEiT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jun 2012 00:38:19 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:51758 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759760Ab2FGEiQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jun 2012 00:38:16 -0400
Received: by wibhn6 with SMTP id hn6so175267wib.1
        for <git@vger.kernel.org>; Wed, 06 Jun 2012 21:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=v8gffi/pXXNkd2GRVgxol91RlFBhU/ug7kp2PBcZAXs=;
        b=EGhTMKvZ8FQnKQ0GCNAErtZ6LeOH4k9ivL0SuU63sY2WasjY2hjwqks/lGEnfEKT8o
         RhOztlMgKnKU5b6pPcGIGCQeeX3Cx7Ez9U+ic7l9YjQ0wfDfu1QXHOWn0ydwlrazDlCD
         SnD/ShFi4FswmITvPPh26OxV8K+42nel2vl1AjB2VY8U6t7CjRQ+ZdyNQJe+32vpzfBj
         oXWGlv2/di8W7juNVfHg0MawKGvlO2orbtABHZExoq+fxurb+jsw+UTMhEWf1QR1HKL+
         g1wTIQKnZNu50/52JV11zzZYgRrgZVYaY4MnDJwoNeOp8qzotragnjqXtrIKDNAOeED4
         nMmw==
Received: by 10.216.202.134 with SMTP id d6mr619269weo.159.1339043895361; Wed,
 06 Jun 2012 21:38:15 -0700 (PDT)
Received: by 10.216.235.91 with HTTP; Wed, 6 Jun 2012 21:37:55 -0700 (PDT)
In-Reply-To: <CAH5vBdK_M+7Hjk=juVeP7Phqvs2+npknFD-=45OVR032k5S-0A@mail.gmail.com>
X-Google-Sender-Auth: pCacOvuIwOekL7exMJTlxcLb_eA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199368>

On Wed, Jun 6, 2012 at 6:40 PM, cheng renquan <crquan@gmail.com> wrote:
>
> Someone maybe like me is working in the way of following one central
> git repository
> while sometimes need to fetch some code or tags from a 3rd git repo,
> but unfortunately the 3rd repo may contain a lot of tags not all I wa=
nt
> to fetch to mess up my local repo, at this time I want to fetch only =
one tag
> from the 3rd repo, but the syntax of
> =C2=A0`git fetch 3rd-repo the-tag-name`
>
> really fetched the code of the-tag-name from 3rd-repo, but forgot the
> tag itself;


The subject of "forgot" in that sentence is you, not "git fetch".
You told "git fetch" to grab it but not store it locally in your
refs/tags namespace.

There is a convenience short-hand "tag <tagname>", i.e.

=C2=A0 git fetch 3rd-repo tag the-tag-name

that is equivalent to

=C2=A0 git fetch 3rd-repo refs/tags/the-tag-name:refs/tags/the-tag-name

So I do not think your patch is necessary for your use case, and
obviously it will
break other people's use case where they just want to fetch (and inspec=
t what is
left in FETCH_HEAD) but do not want to store.
