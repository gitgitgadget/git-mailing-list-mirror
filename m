From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv3] git apply: option to ignore whitespace differences
Date: Fri, 31 Jul 2009 18:16:43 +0200
Message-ID: <cb7bb73a0907310916i309c99cax2f2d5aa02084103f@mail.gmail.com>
References: <1248814820-25367-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<7vljm84htf.fsf@alter.siamese.dyndns.org> <cb7bb73a0907282333g26efd1d8y7d913fba8a426aa5@mail.gmail.com> 
	<20090729174000.6117@nanako3.lavabit.com> <94a0d4530907301727h171a2581ybee2a5b2d77e7c05@mail.gmail.com> 
	<7v3a8d65kv.fsf@alter.siamese.dyndns.org> <94a0d4530907310838nbca0037u1a192dc07a379e66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 18:17:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWunE-0006G1-GX
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 18:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774AbZGaQRG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Jul 2009 12:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbZGaQRF
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 12:17:05 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:49905 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbZGaQRE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Jul 2009 12:17:04 -0400
Received: by bwz19 with SMTP id 19so1286386bwz.37
        for <git@vger.kernel.org>; Fri, 31 Jul 2009 09:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=blMNfZBc7pI+HmQbX8Zutv1SBEajBuouhRr/Fwise3Q=;
        b=pwb2wQwldswi92H1rY29AU7Yc/L0PV2f+ek3swY9fxu3n2mEQnH9+dKiw2oPTgrYyP
         pZu+FrkY5YIrxpe49cXLO2MHRQK3UDgKlGypNHecj514EL+/mAYVFMjEa87iU0wKeXZR
         Ny7C4Wwk3RiqkwJrZhf2KUnddr+HfbmBpAZxA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=XIuDpt6yzv2aXFY05OC/eIjnWtvKAONC0riJBg+gMI965nDK4SIVUUSWijP/z4NdAA
         tjx5TFpgydTMQfd2P4l10Q/6n0YA179ZqyHQ1A13MbPlV0ZVpf6IWEVRqzKdskSj/GPp
         SmcEjyy1yiLrIpfdKJq6gndu1JnULSShRwBXs=
Received: by 10.204.54.143 with SMTP id q15mr3056135bkg.148.1249057023158; 
	Fri, 31 Jul 2009 09:17:03 -0700 (PDT)
In-Reply-To: <94a0d4530907310838nbca0037u1a192dc07a379e66@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124575>

On Fri, Jul 31, 2009 at 5:38 PM, Felipe
Contreras<felipe.contreras@gmail.com> wrote:
> On Fri, Jul 31, 2009 at 12:48 AM, Junio C Hamano<gitster@pobox.com> w=
rote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> Google:
>>> ignore space change: 17,300,000
>>> ignore white space: 181,000,000
>>
>> But that is not relevant either. =A0"ignore white space" is a supers=
et of
>> "ignore space change", iow the latter has more specific meaning than=
 the
>> former. =A0It is not surprising to see that search engines find larg=
er
>> number of references to more general terms than more specific ones.
>
> The fact remains the same: white space is a much more used term, and
> IMHO the only one that really matters.

Before I go on with the next revision of the patch, I would like to
have some kind of agreed convention to implement.

My suggestion would be the following:
(1) implement options --ignore-space-change, --ignore-all-space
mirroring their 'git diff' meaning.
(2) add --ignore-whitespace as a synonym to --ignore-space-change, for
consistency with 'patch'
(3) apply.ignore-whitespace accepts values
     * false,no,none,0 to mean no whitespace ignoring
     * true,yes,change,1 to mean ignore whitespace change
     * all,2 to mean ignore all whitespace

Objections?



--=20
Giuseppe "Oblomov" Bilotta
