From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Mon, 31 Oct 2011 15:18:28 -0700
Message-ID: <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com>
References: <20111026202235.GA20928@havoc.gtf.org> <1319969101.5215.20.camel@dabdike>
 <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com>
 <1320049150.8283.19.camel@dabdike> <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
 <7vy5w1ow90.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Mon Oct 31 23:19:13 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1RL0CF-0008IX-4C
	for glk-linux-kernel-3@lo.gmane.org; Mon, 31 Oct 2011 23:19:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934584Ab1JaWSx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 31 Oct 2011 18:18:53 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:35410 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933934Ab1JaWSu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2011 18:18:50 -0400
Received: by wwi36 with SMTP id 36so2217127wwi.1
        for <multiple recipients>; Mon, 31 Oct 2011 15:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=aVgV1hH/89mGQsd7wNJzIr2WBZ3rPXsqn596oJBMkPo=;
        b=UJZPhCytm90Y74E3HVdbaqNG3tlZrMkX8URYAftKdwAKLS1aIHEGxpMYH+vHzcfdyj
         Vs+67zn46AI8e0d1YNAED9O+eALo0SldyJ1X0+6RhZbBc7gwxyGte7xGfkENTh+nTW+d
         KAa5HiWe2pDNWbkCfInTPs+c4J8b5oEgyRN14=
Received: by 10.216.24.39 with SMTP id w39mr3620929wew.67.1320099529133; Mon,
 31 Oct 2011 15:18:49 -0700 (PDT)
Received: by 10.216.166.3 with HTTP; Mon, 31 Oct 2011 15:18:28 -0700 (PDT)
In-Reply-To: <7vy5w1ow90.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: 0QRcxAUslDWj-6p9YtPbqh5bcBw
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184526>

On Mon, Oct 31, 2011 at 11:23 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>
> It certainly lets you run "git tag --verify" after you pulled and wil=
l
> give you assurance that you pulled the right thing from the right per=
son,
> but what do you plan to do to the tag from your lieutenants after you
> fetched and verified? =A0I count 379 merges by you between 3.0 (2011-=
07-21)
> and 3.1 (2011-10-24), which would mean you would see 4-5 tags per day=
 on
> average. =A0Will these tags be pushed out to your public history?

No, you misunderstand.

I can do that kind of "crazy manual check of a tag" today. And it's
too painful to be useful in the long run (or even the short run - I'd
much prefer the pgp signature in the email which is easier to check
and more visible anyway). Fetching a tag by name and saving it as a
tag is indeed pointless.

But what would be nice is that "git pull" would fetch the tag (based
on name) *automatically*, and not actually create a tag in my
repository at all. Instead, if would use the tag to check the
signature, and - if we do this right - also use the tag contents to
populate the merge commit message.

In other words, no actual tag would ever be left around as a turd, it
would simply be used as an automatic communication channel between the
"git push -s" of the submitter and my subsequent "git pull". Neither
side would have to do anything special, and the tag would never show
up in any relevant tree (it could even be in a totally separate
namespace like "refs/pullmarker/<branchname>" or something).

                                 Linus
