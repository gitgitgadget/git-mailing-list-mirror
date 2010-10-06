From: Thomas Adam <thomas@xteddy.org>
Subject: Re: [PATCHv5 03/17] gitweb/lib - Very simple file based cache
Date: Thu, 7 Oct 2010 00:12:43 +0100
Message-ID: <AANLkTikVmHgk=jLCs11tJ7yhUL4H2gnM_pKkXOJSxYq7@mail.gmail.com>
References: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
 <1286402526-13143-4-git-send-email-jnareb@gmail.com> <AANLkTinPCOfknoN4aO_EdPwKorRiM6NU6ep0z_nnNug8@mail.gmail.com>
 <201010070100.33478.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 01:13:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3dAY-0004bf-Sl
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 01:13:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759518Ab0JFXNB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Oct 2010 19:13:01 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50073 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754183Ab0JFXNA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Oct 2010 19:13:00 -0400
Received: by bwz11 with SMTP id 11so84386bwz.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 16:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=iT0VN9dMPupIEG1Ld1fbve3s4q/PgiZ1qcw139Cm0vg=;
        b=Pw3reGGgohGOc+vGj1QTk3bfJ8/0Lli6t+xinWggp2Ji8EK2NSKu4ec4QDdHFg9t2o
         eCLuPhKkTIgQ/5zD6UUuM+t25zPRQwJzd2U6JIe4eh626UyIu9Souwl9+5zvuOKVjMLo
         N3cn3VQHkME8SxMvtCfQb/xgAYDf6/gdD95OY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=NODmvzFBykUkBxhraAqYQ7kKbqmmPXKyk7wfavXeQnfSN5XeuRCdfMK9vdXQ49Ww4X
         jRUKvNhlNAdQd+nfxAxbeWd7UR+xbDUfrDgKNIzilpYzFQpwES1AzhI8ybk/0Tz0KViR
         FqNDJ475dFsMR0MZNfj01fj7TORp1VQsKgACg=
Received: by 10.204.180.75 with SMTP id bt11mr10326989bkb.115.1286406778911;
 Wed, 06 Oct 2010 16:12:58 -0700 (PDT)
Received: by 10.204.75.155 with HTTP; Wed, 6 Oct 2010 16:12:43 -0700 (PDT)
In-Reply-To: <201010070100.33478.jnareb@gmail.com>
X-Google-Sender-Auth: XtNyLjHJfaj_X1YcyD_OT6rkxPM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158350>

Hi --

On 7 October 2010 00:00, Jakub Narebski <jnareb@gmail.com> wrote:
> Thank you very much for those comments on code.

Sure.

> On the other hand this way scope where "no strict 'refs';" is active
> is limited... but I guess having "no strict 'refs';" outside loop wou=
ld
> be better.

Definitely.

>>
>> > + =C2=A0 =C2=A0 =C2=A0 my $file =3D $self->path_to_key($key);
>> > + =C2=A0 =C2=A0 =C2=A0 return undef unless (defined $file && -f $f=
ile);
>>
>> PBP (Perl Best Practises) will tell you that explicitly returning
>> undef is discouraged -- "undef" should be reserved for those errors
>> you cannot handle, not ones you don't want to.
>
> Well, Perl Best Practices are practices; sometimes there is good reas=
on
> to not take them into account (though probably not in this case).

Do not ever underestimate Conway's book, Jakub -- seriously.   It's
not a Bible, sure, but to ignore it or otherwise eschew its advise is
to shoot yourself in the foot.   :)

> I should really have run gitweb, caching modules and tests through
> perlcritic...

And your other patches.   :)

>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 last if $read_c=
nt =3D=3D 0;
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $size_left -=3D=
 $read_cnt;
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 #last if $size_=
left <=3D 0;
>> > + =C2=A0 =C2=A0 =C2=A0 }
>> > +
>> > + =C2=A0 =C2=A0 =C2=A0 close $read_fh
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 or die "Couldn'=
t close file '$file' opened for reading: $!";
>> > + =C2=A0 =C2=A0 =C2=A0 return $buf;
>> > +}
>>
>> "use Carp;" would be more useful here, and hence croak() and confess=
().
>
> For a web application we usually do not want to have too detailed err=
or
> message present to client (to web browser) to avoid leaking of sensit=
ive
> information.

Unless we use fatalstobrowser, it will still end up in Apache's error
log.  I don't see a problem here.

>> > + =C2=A0 =C2=A0 =C2=A0 # ensure that directory leading to cache fi=
le exists
>> > + =C2=A0 =C2=A0 =C2=A0 if (!-d $dir) {
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 eval { mkpath($=
dir, 0, 0777); 1 }
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 or die "Couldn't create leading directory '$dir' (mkpath): $=
!";
>> > + =C2=A0 =C2=A0 =C2=A0 }
>>
>> Why is this eval()ed? =C2=A0It will still return false and set $! ap=
propriately.
>
> IIRC mkpath *dies on error*, rather than returning false. =C2=A0For b=
etter
> error handling we would need to use make_path, but File::Path 2.0+
> is in [stable] core only since Perl 5.10.

Umm, maybe.   I've not verified this, but we shouldn't rely on this eit=
her.

> I don't want to code too defensively, but perhaps check for this is i=
n
> order... though what we should do if $code is not code reference?

confess() ahem, or otherwise die() since it's a complete fail here.
Appropriate logging is necessary here.

>>
>> unless( defined $code and ref $code eq 'CODE' )
>
> "ref($code) eq 'CODE'" would be enough; 'undef' is not reference, and
> ref(undef) returns "".

Sure, but it still assumes $code is a reference, and there's no
guarantee of that in the code path.

>> {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ....
>> }
>>
>> Wouldn't it be easier to eval{} this and check $@?
>
> So the answer is no.

=46antastic!   :)

-- Thomas Adam
