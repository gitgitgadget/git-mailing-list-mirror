From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH 2/2] Makefile: work around ksh's failure to handle missing 
	list argument to for loop
Date: Mon, 5 Jul 2010 16:29:40 -0500
Message-ID: <AANLkTin0h8DUWo3sfhRdA7NCCCPLKXfQzSDvWX7p1OPq@mail.gmail.com>
References: <80typu1ozt.fsf@tiny.isode.net>
	<8YdP-GcDDflOVZnykNVIGceOm01bqeg9PDvdgIfgqUnh29RKC-6Qi8_KBVoqLIt5iyt7g1TX5l96M5KyLrfOqg@cipher.nrlssc.navy.mil>
	<4C30D4D5.3020900@drmicha.warpmail.net>
	<4C31796E.9050109@viscovery.net>
	<7vy6dpyeqf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org,
	PWalker752@aol.com, newsletter@dirk.my1.cc,
	bruce.stephens@isode.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 05 23:29:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVtEY-0001kc-Fl
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 23:29:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755645Ab0GEV3m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Jul 2010 17:29:42 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37097 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754550Ab0GEV3l convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jul 2010 17:29:41 -0400
Received: by vws5 with SMTP id 5so6563679vws.19
        for <git@vger.kernel.org>; Mon, 05 Jul 2010 14:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ItDzC9CnAjRvBApVSCD/tRXwV6VFRbo7nqX+c/DBa4s=;
        b=SfwaslNW7q2nknE0g+MzSkHo1bZKGxQwpQOALTJt8K5Dy9SScSpsUizKO6rJremFqo
         klFhjIx7XTEzXhzTbUMt9iPwveNgcGbSbQmr2KrXNGNOrs+P/kcviwJFZITGpZ/xx5B2
         DupBpTNhzVp9AqTUThONYYqHKMNlYtQ80QnQE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=AkqrTFKsHNMKTRCtJcXI2Po6tnsP4+LIQwnd4j1fzbd5x8x7lzsawK34rGJD7rC6bu
         IyDIUhiSqbNg9DewYrYczzUx2XLsExlQrJ1e3Y3Hky2bgA24U4RzBVL/HkAkS+REj1LK
         t5gYv1yl79AN3AcyH4XaZZrXXnIhrnIfkgs2g=
Received: by 10.229.219.143 with SMTP id hu15mr1992970qcb.129.1278365380329; 
	Mon, 05 Jul 2010 14:29:40 -0700 (PDT)
Received: by 10.229.192.197 with HTTP; Mon, 5 Jul 2010 14:29:40 -0700 (PDT)
In-Reply-To: <7vy6dpyeqf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150296>

It looks like Johannes has already supplied the explanation that was
missing from my commit message.  Thanks.


On Mon, Jul 5, 2010 at 1:18 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Johannes Sixt <j.sixt@viscovery.net> writes:
>
>> Before the test for emptyness can happen, the complete statement mus=
t be
>> parsed, but ksh finds a syntax error in the statement and, therefore=
,
>> cannot even begin to execute the statement. (ksh doesn't follow POSI=
X in
>> this regard, where this would not be a syntax error.)
>
> I had to stare at Brandon's patch that was essentially:
>
> - =C2=A0 =C2=A0for p in $(FOO); do echo $$p; done
> + =C2=A0 =C2=A0foo=3D$(FOO); for p in $$foo; do echo $$p; done
>
> and the above two doesn't look like there should be any difference; y=
our
> explanation makes quite a lot of sense but that's arcane. =C2=A0I dou=
bt I will
> be able to justify and explain the latter construction without consul=
ting
> your message I am responsing to, if somebody asks "why do we assign $=
(FOO)
> to a shell variable and then iterate over it?" 6 months from now.
>
> It might make sense to use $(foreach) instead of rolling our own loop=
 in
> the shell to avoid glitches like this.

$(foreach) works too.  I only avoided it because it has already caused =
a
problem once before by creating a command line that exceeded the
maximum argument list length on IRIX.

REMOTE_CURL_ALIASES only has 3 items in it right now, and probably
won't grow much larger, if it grows at all, so there is little chance o=
f
exceeding the maximum argument list length on IRIX.  So $(foreach) is
fine with me if you think that reads better.

-Brandon
