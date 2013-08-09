From: Ben Tebulin <tebulin@googlemail.com>
Subject: Re: Reproducible, corrupt packfile after fresh git-svn checkout message
Date: Fri, 09 Aug 2013 14:27:04 +0200
Message-ID: <5204E018.4000808@gmail.com>
References: <52037F47.5010302@exxcellent.de> <52037F84.9060006@exxcellent.de> <f1d8f80d6fa3678ac043bfdb19bebf6bf4261273@localhost> <877gfw4byx.fsf@linux-k42r.v.cablecom.net> <262a9f8309a3812970f47ac9f4e4b49bb972ca49@localhost> <87fvuk2wl0.fsf@linux-k42r.v.cablecom.net> <9aa1672d5c04994f416dccd84b5983c960c0fdf9@localhost> <vpqli4cfhhe.fsf@anie.imag.fr> <813506281f7a4d3a8af650c5f8ee33dd7224f193@localhost> <vpqfvukfgr5.fsf@anie.imag.fr> <edc9f41b4ffca9ce36dc50e749de7a86e4618a0e@localhost> <87fvuk1cyl.fsf@linux-k42r.v.cablecom.net> <5203B100.30008@gmail.com> <87txj0i4mc.fsf@inf.ethz.ch> <7vsiyk9j6a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ben Tebulin <tebulin@googlemail.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Stefan Beller <stefanbeller@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 14:27:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7lmm-0006zF-6h
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 14:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755677Ab3HIM1L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Aug 2013 08:27:11 -0400
Received: from mail-we0-f172.google.com ([74.125.82.172]:58606 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755030Ab3HIM1J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 08:27:09 -0400
Received: by mail-we0-f172.google.com with SMTP id t61so3474961wes.17
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 05:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Ugz9DdUfAcDWncnvsUFYwrJyVkMM01scuCaoY/26k0w=;
        b=vZZLf70XtmiUDXVaSFwxwwTOfrCHZpKpTE2pShp8eEtDi9ah4Wg2T+LnJcP074xWeJ
         XWYrs/B/a1gZM0ZPNcP4p6AsyuRySkUOTquhOr+Qs9poScbYHK/xozMsxO1wk+nQlGle
         MFIfrivUaaum29xY1dgdZ/1shBetwxZd3jC4W3+7yiZAo4wrtTnIG3380Y+35ZSx/en5
         c0HGwjyAPNTVDdWDgZG14A0xmg5Uw8KtZaesRkAAT/PudGHqsoamJP4RVql15hGWjfcx
         za9cYyzCv46zTedrSVHmZs3J/NOX5WG72BIFy4zjcTK29RXEVkaSj1qW0m9DL9GfpCbY
         ryKQ==
X-Received: by 10.194.157.99 with SMTP id wl3mr259974wjb.76.1376051227613;
        Fri, 09 Aug 2013 05:27:07 -0700 (PDT)
Received: from [127.0.0.1] (ulmg-5d84d023.pool.mediaWays.net. [93.132.208.35])
        by mx.google.com with ESMTPSA id ee5sm2559572wib.3.2013.08.09.05.27.05
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 09 Aug 2013 05:27:06 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <7vsiyk9j6a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231973>

Hello everybody!

I have some _very interesting_ news regarding this issue!
Here is the deal:

  1. I was able to *reproduce the error on a machine of a coworker!*

  2. I was able to rule out
      - HDD: It's reproducible from /dev/shm
      - Memory: Memory tests works fine

now the interesting part:

  3. Occurs on Linux kernels 3.7.10, 3.8.x, 3.9.11, 3.10.5
     _but not on:_ 3.6.11, 3.5.7 and 2.6.32

Both machines showing this problem are =BBDell Latitude E6330=AB with a=
n
=BBi5-3340M @ 2.70GHz=AB CPU. Mine running stock kernels, coworker usin=
g
plain Ubuntu 13.04.

=46urthermore I need to stress, that we never had any issues with our
devices during daily _at all_.

So what to do best now?

- Ben


Am 08.08.2013 19:38, schrieb Junio C Hamano:
>>>> Can you try to reproduce with a version older than v1.8.3?
>>>> E.g. v1.8.2.3.
>>>
>>> It seems to run 'much better'=20
>>>   v1.8.2.3 : 3/10 runs do fail
>>>   fb56570  : 9/10 runs do fail
[..]
>>> They always fail on a big blob (39MB) as I wrote in my first e-mail=
:
>>>
>>> ben@n179 /tmp/project.git $ ~/projects/git.git/git-show 49cdd0b21a3=
51f3366008615d2cf8d03ca943978 | wc -c
>>> error: sha1 mismatch 49cdd0b21a351f3366008615d2cf8d03ca943978
>>> fatal: bad object 49cdd0b21a351f3366008615d2cf8d03ca943978
>>> 0
>>> ben@n179 /tmp/project.git $ ~/projects/git.git/git-show 49cdd0b21a3=
51f3366008615d2cf8d03ca943978 | wc -c
>>> 39517156
>=20
> Hmm, from this, and a later one ...
>=20
> ... I am reading that (1) the packfile and repository is basically
> OK, (2) reading that object sometimes fails, and (3) the symptom is
> not limited to fsck but anything that reads the object with
> parse_object().  And that symptom exists only on that single machine
> (I am assuming that the repository was bit-for-bit copied, not
> "cloned", for the purpose of testing it on the other machine).  That
> makes me suspect something outside the control of Git (e.g. faulty
> memory or disk controller cable).
>=20
> Are there other big blobs in the repository, and would "show | wc" fa=
il
> if you attempt to read it on that machine?
