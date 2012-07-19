From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH 3/7] autoconf: remove some redundant shell indirections
Date: Thu, 19 Jul 2012 19:50:51 +0200
Message-ID: <500848FB.8060907@gmail.com>
References: <cover.1342649928.git.stefano.lattarini@gmail.com> <4392b87d8e6c73cfa06459a24b1721b8a8e13a81.1342649928.git.stefano.lattarini@gmail.com> <7v394owq3l.fsf@alter.siamese.dyndns.org> <5007B7B1.8000909@gmail.com> <7vfw8nvf3u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 19:51:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Srusc-0006Ub-BG
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 19:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752825Ab2GSRvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jul 2012 13:51:08 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56346 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821Ab2GSRvH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2012 13:51:07 -0400
Received: by bkwj10 with SMTP id j10so2702435bkw.19
        for <git@vger.kernel.org>; Thu, 19 Jul 2012 10:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=NS1Q+pgS8fMi20fml6lxnVBXdAEgBI4lHcukoRhSvgk=;
        b=C64p+2mT8wS3bUM9K8AFKxUTJJ69miRmbzYRZP+QhsAYGkY4FqcnVTH7gVXHwXNIf0
         7ZsKf7x/Xl9NUyIs0beUBDtEy0FfZK/ffeAHJ5y57Ep2pxL8lLS45azMtKtiShc+sxlJ
         aJNoqfhB1cFdYXKh0guEtJmJtxB2hWX+1qD3ORb2yVFgvK7vE17DEyQ+iJ2aq/FZ7qTs
         mIy9k3L7xa6CdoJzGxjNmDfyLpy0ooOOgB5C7ZwA3AsdP72+ceEve3KFtZAz93qrgzin
         4zEBQBSyyvyPQLJtpbVBO9eHQaNrZmM9d1WnL7hlVekUgXJDuJIOov/Rx/gP3QKpzX5y
         Dt5w==
Received: by 10.204.152.6 with SMTP id e6mr1559487bkw.85.1342720265900;
        Thu, 19 Jul 2012 10:51:05 -0700 (PDT)
Received: from [192.168.178.21] (host105-96-dynamic.4-87-r.retail.telecomitalia.it. [87.4.96.105])
        by mx.google.com with ESMTPS id 14sm1655566bkq.12.2012.07.19.10.51.02
        (version=SSLv3 cipher=OTHER);
        Thu, 19 Jul 2012 10:51:03 -0700 (PDT)
In-Reply-To: <7vfw8nvf3u.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201750>

On 07/19/2012 07:24 PM, Junio C Hamano wrote:
> Stefano Lattarini <stefano.lattarini@gmail.com> writes:
> 
>> On 07/19/2012 02:29 AM, Junio C Hamano wrote:
>>>
>>> The inconsistency between the existing one that does not quote the
>>> string that is not substituted, i.e.
>>>
>>> 	GIT_UC_PROGRAM[]_PATH=$withval
>>>
>>> and the new one that quotes _PATH, i.e.
>>>
>>> 	GIT_CONF_SUBST(GIT_UC_PROGRAM[_PATH], [])
>>>
>>> looks somewhat strange, though.
>>>
>> Will fix that in the re-roll.
> 
> I see you already used the []_PATH in your reroll, and I do not
> think it matters either way in pracice, but I suspect that it is
> technically more correct to have _PATH part inside the bra-ket
> quotes (of course, changing the style to maximally quote like that
> is a totally different topic, and should be done as a separate
> patch,
>
Yep, that's what I thought.  Glad I got it right, saved another
re-roll :-)

>so I think your reroll is the right thing to do within the
> scope of this series).
>
And as an aside, if we'd somehow got '_PATH' to be a defined macro,
I say that something would be very, very wrong with the current setup
(Autoconf strives to be very namespace-clean these days, apart from
some old m4 builtins, which must remain available out of the 'm4_'
and 'AC_' namespaces for sake of backward-compatibility).

Today, excluding few exceptions, I'd say that the main reason to
properly quote macro arguments is to avoid commas or quoting characters
in macro invocations or expansion, or even quoting characters themselves,
to be spuriously considered as metacharacters and thus processed.

> Thanks.
>
Thanks to you for the quick feedback.

Regards,
  Stefano
