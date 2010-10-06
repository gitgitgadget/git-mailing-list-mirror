From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCHv5 03/17] gitweb/lib - Very simple file based cache
Date: Wed, 6 Oct 2010 22:47:45 +0000
Message-ID: <AANLkTiki1io9quVPVzmZreOOzjpW3RfRcj-12995YL6s@mail.gmail.com>
References: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
	<1286402526-13143-4-git-send-email-jnareb@gmail.com>
	<AANLkTinPCOfknoN4aO_EdPwKorRiM6NU6ep0z_nnNug8@mail.gmail.com>
	<AANLkTik1RzGno+TsZe5OZSU7SeJOhDKWFCZYmrFhH6SZ@mail.gmail.com>
	<AANLkTi=spE+RGdwz5f4xOTo-ijCNWF9fhZ06aA-tvu7j@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: Thomas Adam <thomas@xteddy.org>
X-From: git-owner@vger.kernel.org Thu Oct 07 00:48:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3cmb-0007Yf-4W
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 00:48:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754031Ab0JFWrs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Oct 2010 18:47:48 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44536 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430Ab0JFWrr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Oct 2010 18:47:47 -0400
Received: by iwn5 with SMTP id 5so106528iwn.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 15:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=huxuRPzf1FSk25QsQWFZXZaLUD5tKoD4Mg44wAo8s0s=;
        b=rL6WYzDgGDfjv/UQ+YWxfdj8JYOwlbQ0rD5/+7Fyd/45xRJUqAsXwtB1GVr2TeUd3b
         kcZ1mR/1+/hqrjtxVE8uEMs7LtY3ip/larToDDRdzHisuq9HdRXk6ts+PdtnD1a43aBH
         2VzWtKRhCjX5bhN73tAaem68VjJMN1ukMXHFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IgRml8C4/VFKNMVUcDmElPwXOZCcCgea0IG0JjGFYTviqvSpV7555pw/axU2tRW/nw
         TqH54885RQP+GlPSXOumjUyr5pSE0tGY/JbNPv1RKX4KhFaf0yRqASK285Es52xuyKj+
         +ut0HfITs/XTXbGyPvLOpjsk3pNjDiNWz9iIw=
Received: by 10.231.34.139 with SMTP id l11mr14642026ibd.141.1286405265812;
 Wed, 06 Oct 2010 15:47:45 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Wed, 6 Oct 2010 15:47:45 -0700 (PDT)
In-Reply-To: <AANLkTi=spE+RGdwz5f4xOTo-ijCNWF9fhZ06aA-tvu7j@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158339>

On Wed, Oct 6, 2010 at 22:46, Thomas Adam <thomas@xteddy.org> wrote:
> On 6 October 2010 23:44, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>> On Wed, Oct 6, 2010 at 22:41, Thomas Adam <thomas@xteddy.org> wrote:
>>> On 6 October 2010 23:01, Jakub Narebski <jnareb@gmail.com> wrote:
>>>> +# creates get_depth() and set_depth($depth) etc. methods
>>>> +foreach my $i (qw(depth root namespace)) {
>>>> + =C2=A0 =C2=A0 =C2=A0 my $field =3D $i;
>>>> + =C2=A0 =C2=A0 =C2=A0 no strict 'refs';
>>>
>>> For each item, you'll set "no strict refs"? =C2=A0This might be bet=
ter off
>>> outside the loop. =C2=A0It's still scoped appropriately inside the
>>> subroutine.
>>>
>>>> + =C2=A0 =C2=A0 =C2=A0 my $file =3D $self->path_to_key($key);
>>>> + =C2=A0 =C2=A0 =C2=A0 return undef unless (defined $file && -f $f=
ile);
>>>
>>> PBP (Perl Best Practises) will tell you that explicitly returning
>>> undef is discouraged -- "undef" should be reserved for those errors
>>> you cannot handle, not ones you don't want to.
>>
>> [...]
>>
>>>> + =C2=A0 =C2=A0 =C2=A0 return unless (defined $key && defined $dat=
a);
>>>
>>> return what?
>>
>> false. You're right that "return undef;" is bad style, but "return;"
>> is what you should use instead.
>
> I didn't mean that. =C2=A0:) =C2=A0It was a question to ensure this i=
s what was
> wanted, and not another undef. =C2=A0I am well aware of the differenc=
es.

Ah right, sorry about the noise then.
