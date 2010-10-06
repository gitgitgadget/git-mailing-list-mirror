From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCHv5 03/17] gitweb/lib - Very simple file based cache
Date: Wed, 6 Oct 2010 22:44:31 +0000
Message-ID: <AANLkTik1RzGno+TsZe5OZSU7SeJOhDKWFCZYmrFhH6SZ@mail.gmail.com>
References: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
	<1286402526-13143-4-git-send-email-jnareb@gmail.com>
	<AANLkTinPCOfknoN4aO_EdPwKorRiM6NU6ep0z_nnNug8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: Thomas Adam <thomas@xteddy.org>
X-From: git-owner@vger.kernel.org Thu Oct 07 00:44:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3cj0-0005it-3z
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 00:44:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759395Ab0JFWoc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Oct 2010 18:44:32 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42597 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759350Ab0JFWoc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Oct 2010 18:44:32 -0400
Received: by iwn5 with SMTP id 5so103416iwn.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 15:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=n4zYJvG6OYzn1Oh/dMvI2I12ZqFTyrv1J0Wf6eZodEY=;
        b=I7E+W0l8G82R3J4kcEpUh+5/ARB30KAqlc/FG4WUA4WVbFS09u1JqMeA1DLEEvV0on
         errEKe/BJKU5wwWAjOAueOLv5vjPQHZQMCSsU8qG5JeeTfQBvH6v4nkIALyYXZlfIm/E
         jj12HpHPqK3NmiLwfyIuAGNd16jJRojLTCe5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mt1F9evFeR2ZIcB8CO4uIsE14bbdhnzceS/MCT4cR6VifcF39ePz1eeeIysEBPKHxu
         CxkJO5UKirdLRPhjepdcMOG2Yw2vbIsM4gOuAG6XrMKkPvlTH/zOT17wRZ496sS+ntlv
         k2XQozBzJJHl5MPC8P+kEV512IuEirzNlkrUo=
Received: by 10.231.161.80 with SMTP id q16mr14669315ibx.142.1286405071483;
 Wed, 06 Oct 2010 15:44:31 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Wed, 6 Oct 2010 15:44:31 -0700 (PDT)
In-Reply-To: <AANLkTinPCOfknoN4aO_EdPwKorRiM6NU6ep0z_nnNug8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158335>

On Wed, Oct 6, 2010 at 22:41, Thomas Adam <thomas@xteddy.org> wrote:
> On 6 October 2010 23:01, Jakub Narebski <jnareb@gmail.com> wrote:
>> +# creates get_depth() and set_depth($depth) etc. methods
>> +foreach my $i (qw(depth root namespace)) {
>> + =C2=A0 =C2=A0 =C2=A0 my $field =3D $i;
>> + =C2=A0 =C2=A0 =C2=A0 no strict 'refs';
>
> For each item, you'll set "no strict refs"? =C2=A0This might be bette=
r off
> outside the loop. =C2=A0It's still scoped appropriately inside the
> subroutine.
>
>> + =C2=A0 =C2=A0 =C2=A0 my $file =3D $self->path_to_key($key);
>> + =C2=A0 =C2=A0 =C2=A0 return undef unless (defined $file && -f $fil=
e);
>
> PBP (Perl Best Practises) will tell you that explicitly returning
> undef is discouraged -- "undef" should be reserved for those errors
> you cannot handle, not ones you don't want to.

[...]

>> + =C2=A0 =C2=A0 =C2=A0 return unless (defined $key && defined $data)=
;
>
> return what?

false. You're right that "return undef;" is bad style, but "return;"
is what you should use instead.

Then you'll get undef in scalar context, and an empty list in list
context. With "return undef" you'll always get an undef, so:

    sub blah { retur undef }
    my (@foo) =3D blah();

Will make @foo =3D (undef), which'll make it evaluate to true in scalar
context since there's an item in the array, and give you a useless
array item.
