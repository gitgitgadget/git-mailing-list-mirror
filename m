From: Thomas Adam <thomas@xteddy.org>
Subject: Re: [PATCHv5 03/17] gitweb/lib - Very simple file based cache
Date: Wed, 6 Oct 2010 23:46:29 +0100
Message-ID: <AANLkTi=spE+RGdwz5f4xOTo-ijCNWF9fhZ06aA-tvu7j@mail.gmail.com>
References: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
 <1286402526-13143-4-git-send-email-jnareb@gmail.com> <AANLkTinPCOfknoN4aO_EdPwKorRiM6NU6ep0z_nnNug8@mail.gmail.com>
 <AANLkTik1RzGno+TsZe5OZSU7SeJOhDKWFCZYmrFhH6SZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 00:46:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3clD-0006tx-Vh
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 00:46:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759985Ab0JFWqq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Oct 2010 18:46:46 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50265 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759971Ab0JFWqq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Oct 2010 18:46:46 -0400
Received: by bwz11 with SMTP id 11so72167bwz.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 15:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=Vr9mbJgXXw672oDUAurfb1R7VHGio4tCFdI9At9PUvw=;
        b=nnl/0O+ymmo0C9tIx0QcEptDK8gE2KsiBN4sK9rbsA4r8LJmGqnfxPdn48WwKb5M0+
         uI4s300ew956WYqfVcJYQlkQ0+n4EjD520U3jmCzmcBM3eip6CmW7WZLUCjJyYI5Vaqy
         blGKB16mjyZ0ifZ746dKFeXJICzinfhg1kFUA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=o7YJHiU5yao96gjrdnQy9D2TajaTHPqXIN+++wBjVDpHCV8GUAKOaniTD7M2Cw/3GF
         ZGXOMOlppNJfkzSNfoaBbjvV8Z9J7oSvp3Cw6H1rZi0MVKeDcDaqYfbx5tIwDhcN8h7w
         rpyqZ9iYYKQ6RrolRAyOp4z1ikLXf0ZDSuFDw=
Received: by 10.204.76.140 with SMTP id c12mr10466156bkk.7.1286405204265; Wed,
 06 Oct 2010 15:46:44 -0700 (PDT)
Received: by 10.204.75.155 with HTTP; Wed, 6 Oct 2010 15:46:29 -0700 (PDT)
In-Reply-To: <AANLkTik1RzGno+TsZe5OZSU7SeJOhDKWFCZYmrFhH6SZ@mail.gmail.com>
X-Google-Sender-Auth: t93nTHqCbc-HW31GnLNR-cKCn20
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158338>

On 6 October 2010 23:44, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab=
@gmail.com> wrote:
> On Wed, Oct 6, 2010 at 22:41, Thomas Adam <thomas@xteddy.org> wrote:
>> On 6 October 2010 23:01, Jakub Narebski <jnareb@gmail.com> wrote:
>>> +# creates get_depth() and set_depth($depth) etc. methods
>>> +foreach my $i (qw(depth root namespace)) {
>>> + =C2=A0 =C2=A0 =C2=A0 my $field =3D $i;
>>> + =C2=A0 =C2=A0 =C2=A0 no strict 'refs';
>>
>> For each item, you'll set "no strict refs"? =C2=A0This might be bett=
er off
>> outside the loop. =C2=A0It's still scoped appropriately inside the
>> subroutine.
>>
>>> + =C2=A0 =C2=A0 =C2=A0 my $file =3D $self->path_to_key($key);
>>> + =C2=A0 =C2=A0 =C2=A0 return undef unless (defined $file && -f $fi=
le);
>>
>> PBP (Perl Best Practises) will tell you that explicitly returning
>> undef is discouraged -- "undef" should be reserved for those errors
>> you cannot handle, not ones you don't want to.
>
> [...]
>
>>> + =C2=A0 =C2=A0 =C2=A0 return unless (defined $key && defined $data=
);
>>
>> return what?
>
> false. You're right that "return undef;" is bad style, but "return;"
> is what you should use instead.

I didn't mean that.  :)  It was a question to ensure this is what was
wanted, and not another undef.  I am well aware of the differences.

-- Thomas Adam
