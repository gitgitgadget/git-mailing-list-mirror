From: Tom Werner <mojombo@gmail.com>
Subject: Re: [PATCH] upload-pack: add a trigger for post-upload-pack hook
Date: Mon, 31 Aug 2009 11:50:08 -0700
Message-ID: <12c267e40908311150n2aad598aw978c4691c27ac0fa@mail.gmail.com>
References: <1250579093-40706-1-git-send-email-tom@mojombo.com>
	 <12c267e40908251043g4f3e36aya05d9c705f5afee2@mail.gmail.com>
	 <20090825184525.GC23731@coredump.intra.peff.net>
	 <7vprajmp16.fsf@alter.siamese.dyndns.org>
	 <7v1vmycfhd.fsf@alter.siamese.dyndns.org>
	 <7vy6p69j6a.fsf@alter.siamese.dyndns.org>
	 <9e0f31700908270509o1031a027y1b49efe7ea9a4fd3@mail.gmail.com>
	 <m3ws4pl6x7.fsf@localhost.localdomain>
	 <7vljl3p2iw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johan Sorensen <johan@johansorensen.com>,
	Jeff King <peff@peff.net>,
	Tom Preston-Werner <tom@mojombo.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 20:50:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiBxN-0008Td-TK
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 20:50:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753836AbZHaSuI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Aug 2009 14:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752789AbZHaSuI
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 14:50:08 -0400
Received: from mail-pz0-f175.google.com ([209.85.222.175]:52948 "EHLO
	mail-pz0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686AbZHaSuG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Aug 2009 14:50:06 -0400
Received: by pzk5 with SMTP id 5so3044274pzk.21
        for <git@vger.kernel.org>; Mon, 31 Aug 2009 11:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vfnvaJyhpHXDoJ16ArfZrvQEO2KL9NHJGgPU/CI6lP0=;
        b=Iag50R9pFMicofL6bkHoeKXBOSBUYAW9huxbD6EIklrbhBxUYJanWeLrLVmposvBu9
         dVV6YQ9ROsHUczoyLDQGAXdnIM9SAkRHzka9O01bKu8ROlGOqB8YsEfxQfY2h7JXV+AR
         1wVP7KNIT9H+S4kGWw+k3xwRuR3SigEpMYCxc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WfMhxjyvGesWKk205XoKc6597AUUlpgk1AQaRh5oq60kyZhakL04F0IKYwIZZul62w
         7pdCXCmGV5u3Y2XT1eAXkzz3pf2rAZZvwEYUetBGPxEIPx3w/NI1oXJBJrP+wkckDYrs
         hQhB6dvgws3EGe2IyD4/itqo5zrDeVXWBokUY=
Received: by 10.142.121.3 with SMTP id t3mr24794wfc.246.1251744608708; Mon, 31 
	Aug 2009 11:50:08 -0700 (PDT)
In-Reply-To: <7vljl3p2iw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127491>

On Fri, Aug 28, 2009 at 11:17 PM, Junio C Hamano<gitster@pobox.com> wro=
te:
> Jakub Narebski <jnareb@gmail.com> writes:
>
>>> I'd like to suggest the following line from the original patch:
>>>
>>> =A0 =A0full-pack integer::
>>> =A0 =A0 =A0 =A0 1 if the request was considered a full clone, 0 if =
it was a
>>> partial update (fetch)
>>
>> If it is all "want" and no "have", it is clone or fetch into empty
>> repository. =A0If additionaly "want"s cover all refs, it is a clone.
>> No need to pass this information: it can be derived.
>
> Well, not exactly.
>
> Here is an iffy RFC patch. =A0Iffy not in the sense that its implemen=
tation
> is questionable, but in the sense that I am not really convinced if t=
he
> distinction between fetching some (or in the worst case, most) but no=
t all
> refs, and fetching full set of refs, into an empty repository is some=
thing
> worth making.
>
> Does anybody from GitHub have any input? =A0Is there something that c=
an
> still improved to suit GitHub's needs?

=46rom GitHub's perspective, we'd treat any clone or fetch into an empt=
y
repo as a clone operation, whether or not that included all of the
refs that were available. For us, the distinction between full and
partial clones is too nuanced to warrant additional code. I'd be happy
with the previous incarnation of the post-upload-pack that simply
sends the HAVEs and WANTs.

Tom
