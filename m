From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 2/2] Teach commit about CHERRY_PICK_HEAD
Date: Wed, 16 Feb 2011 16:33:15 -0500
Message-ID: <AANLkTi=YF51i41St6B=ZpdBYm5MRoMStea+i7TrYTtfF@mail.gmail.com>
References: <1297850903-65038-1-git-send-email-jaysoffian@gmail.com>
 <1297850903-65038-3-git-send-email-jaysoffian@gmail.com> <7vpqqrit8r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 22:33:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppp0R-0004kX-VR
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 22:33:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754301Ab1BPVdr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Feb 2011 16:33:47 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47466 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753738Ab1BPVdq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Feb 2011 16:33:46 -0500
Received: by iyj8 with SMTP id 8so1666749iyj.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 13:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=0jTPvmYJGfL6z5xaIaSc/ZMDidqmlL7XfNCnbogdeV4=;
        b=IWq1SaI1SwQ51beLE4mcPqnzYzrVyzvoq2RajbwYnfKVuiwY+ab31AY0RdiQUrbX9r
         lGwpWgfx9JtwBVXQd6VgGVI/OrWhuSB2+s9sBapinux4DKHKXGRi98DUbYmwxq1o1TUs
         ndAlg0aQxjV0zANNTajnEbDEUkFdnIoSzkQhs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=MnCc5c3ZOOjfwtyK6h1sJLm3ZPTopYTAnUuifk5jWK599yaydD1ar3DutM23xLBDCw
         iUinusSmxrsvjNgBGfd+HHXCNmNqu+Xl2njmztJgfUq+W8n8sv4XyvWysUJdGbc1G6ne
         he/M6XmYwv4ouUBZHYauo6or8uFYOnRUX69W0=
Received: by 10.42.226.69 with SMTP id iv5mr1692490icb.43.1297892025641; Wed,
 16 Feb 2011 13:33:45 -0800 (PST)
Received: by 10.231.40.2 with HTTP; Wed, 16 Feb 2011 13:33:15 -0800 (PST)
In-Reply-To: <7vpqqrit8r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167004>

On Wed, Feb 16, 2011 at 4:07 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jay Soffian <jaysoffian@gmail.com> writes:
>
>> If the user wishes to reset authorship, that must now be done explic=
itly
>> via --reset-author.
>
> This is not a new requirement, is it? =C2=A0Even "commit -c $that_com=
mit"
> before the previous "commit -c CHERRY_PICK_HEAD" does use the origina=
l,
> no?

It is a new requirement for when the user does a bare "commit" _and_
CHERRY_PICK_HEAD exists.

Normally a bare "commit" creates new authorship, but when
CHERRY_PICK_HEAD exists, authorship is taken from CHERRY_PICK_HEAD
commit unless --reset-author is specified.

> I think the changed code is _MUCH_ easier to follow compared to the
> previous round; the only thing the reader needs to keep in mind is th=
at
> the most of the change essentially is "s/in_merge/whence !=3D FROM_CO=
MMIT/"
> and making that work.

I think I was trying to be too clever in the previous round.

>> * We remove a unused import from revert.c
>
> Micronit: s/import/include/.

Okay.

> So I think the above is the right thing to do, but we probably need a=
 bit
> of in-code comment to describe why we say "whence !=3D FROM_MERGE" he=
re.

Will do. It took me several tries to understand what that code block
was trying to do, so a comment will certainly help future readers.

Thanks,

j.
