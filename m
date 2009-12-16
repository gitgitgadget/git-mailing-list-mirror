From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Git on QNX
Date: Wed, 16 Dec 2009 15:20:16 +0100
Message-ID: <81b0412b0912160620v1556fd12i17897269f4101128@mail.gmail.com>
References: <905315640912151323s4b158565o2e74ce018b64dc72@mail.gmail.com>
	 <7v6387zzfi.fsf@alter.siamese.dyndns.org>
	 <905315640912151413g10ee5befh58fbd171237e7659@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>, mkraai@beckman.com
To: Tarmigan <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 15:20:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKujp-0005zs-Q8
	for gcvg-git-2@lo.gmane.org; Wed, 16 Dec 2009 15:20:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934866AbZLPOUV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Dec 2009 09:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934784AbZLPOUU
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Dec 2009 09:20:20 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:61349 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934203AbZLPOUT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Dec 2009 09:20:19 -0500
Received: by bwz27 with SMTP id 27so726214bwz.21
        for <git@vger.kernel.org>; Wed, 16 Dec 2009 06:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MjAWxi0aOu+HY/J1GyZFfuntpAhHa31APz4dQKp/Z0Q=;
        b=XVYzFPqsETwA4ZYhL532w0PvvlP0gwcJrH6hEnvoAAekc/0anEsAuCoIc9jxh84vTR
         KTlRGXbQuuOf3Upxgr8PYCHaz8wZyqZcKZQUURKpDi/5vqPJ3o+CgqkxFsL1xfRjGwnU
         K2tB1A5cSn9RHiYTCmZq8K/On1XiGEZpOeoHk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mlrvPstbZSEypQGSj/nSDSTyLaQT8P6Q3IAkO7m7/1vO8Qt9m3cvjm7idTwnou1Lhp
         ePI8EDFuMzpdMfazwlVLtXVrP9KIimKaRNBubVOpw+Plt7Mtd9ooC66IGZzbh81efLX0
         UhHY7CIEP9cRqGBKhAod25gklJoRGdOYD2VHQ=
Received: by 10.204.14.82 with SMTP id f18mr517248bka.204.1260973217034; Wed, 
	16 Dec 2009 06:20:17 -0800 (PST)
In-Reply-To: <905315640912151413g10ee5befh58fbd171237e7659@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135329>

On Tue, Dec 15, 2009 at 23:13, Tarmigan <tarmigan+git@gmail.com> wrote:
> On Tue, Dec 15, 2009 at 1:42 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Tarmigan <tarmigan+git@gmail.com> writes:
>>> diff --git a/git-compat-util.h b/git-compat-util.h
>>> index 5c59687..857e938 100644
>>> --- a/git-compat-util.h
>>> +++ b/git-compat-util.h
>>> @@ -79,6 +84,7 @@
>>> =C2=A0#include <stdlib.h>
>>> =C2=A0#include <stdarg.h>
>>> =C2=A0#include <string.h>
>>> +#include <strings.h>
>>> =C2=A0#include <errno.h>
>>> =C2=A0#include <limits.h>
>>> =C2=A0#include <sys/param.h>
>>
>> Other hunks are QNX specific enough but this hunk is worrisome; you =
cannot
>> tell how you are hurting other platforms with this change. =C2=A0Can=
 you tell
>> declarations of which functions are missing on QNX without this chan=
ge?
>
> strcasecmp()
> http://www.opengroup.org/onlinepubs/000095399/functions/strcasecmp.ht=
ml

Just for completeness:
http://www.qnx.com/developers/docs/6.4.1/neutrino/lib_ref/s/strcasecmp.=
html
http://www.qnx.com/developers/docs/6.4.1/neutrino/lib_ref/s/strcmpi.htm=
l

> I agree that this change could affect other platforms and they've
> gotten along fine without it so far. =C2=A0I'm surprised no others ha=
ve
> needed it. =C2=A0Would it be better wrapped in a #ifdef?

If you put the ifdef in git-compat-util.h
