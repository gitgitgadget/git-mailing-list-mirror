From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Minimum Perl version?
Date: Fri, 24 Sep 2010 11:05:24 +0000
Message-ID: <AANLkTimUE=hyJ-y_XzpvCokb77KvRGw3gnM+9Xxui9tG@mail.gmail.com>
References: <20100924100019.GT23563@ece.pdx.edu>
	<AANLkTi=3xNSV0y-i=0KUSDRBJ8HmfSfGO7TBHTPiv_KM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tait <git.git@t41t.com>, git@vger.kernel.org
To: Tor Arntsen <tor@spacetec.no>
X-From: git-owner@vger.kernel.org Fri Sep 24 13:05:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz65r-00057R-K8
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 13:05:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754686Ab0IXLF0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Sep 2010 07:05:26 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58766 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752272Ab0IXLFZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Sep 2010 07:05:25 -0400
Received: by iwn5 with SMTP id 5so2319007iwn.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 04:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DKyWTBcaptP+l/qiZNrsSR1LDuHfmztUy//TVyvjHz4=;
        b=GfaGtR3pcSBZS96xjImNxI4cac3MuGuLD9Gz4NnzvntXno79VVmJLwjiZLs/bhmq3n
         d4HBl45/eT1Il2RiVilVn6PQVvZpk4cQh2dpmTDTYjm2iWNM18ViYTEzAuZtymaSMHYV
         tV7Vkf+yr1lV+zbccNm3UBrtagH5pFaOrq3pE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Ln9excE32p0HZ3PgEr7Dr7YoyrQk9aI+OMtU5SaSjWXth/kCb2DOLUml7TgA3LIX9y
         sgHut8FP7v4UGh5sS3UGhgbqKqOlwz2GucopASOuiKE5/nvYzg21rciaF2j2PIL0F4Yz
         Ot8QhjfqDVPF+t9BPLolaF95uqHe/grg7RK90=
Received: by 10.231.33.205 with SMTP id i13mr3641938ibd.59.1285326324590; Fri,
 24 Sep 2010 04:05:24 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Fri, 24 Sep 2010 04:05:24 -0700 (PDT)
In-Reply-To: <AANLkTi=3xNSV0y-i=0KUSDRBJ8HmfSfGO7TBHTPiv_KM@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156973>

On Fri, Sep 24, 2010 at 10:27, Tor Arntsen <tor@spacetec.no> wrote:
> On Fri, Sep 24, 2010 at 12:00, Tait <git.git@t41t.com> wrote:
>>
>> What is the minimum Perl version git expects to support?
>>
>> I ask, because f922df8... seems to have introduced a open() syntax t=
hat
>> is not compatible with some older Perl versions.
>
> I've found that for add -p you'll need 5.8.x or newer, due to stuff l=
ike
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0my $fh =3D und=
ef;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0open($fh, '-|'=
, @_) or die;
>
> which fails in e.g. perl 5.6.
> There could be some other stuff (in addition to add -p) that also doe=
s
> this kind of thing.

If that's the case (I don't have a 5.6 here to do archeology on) then
git add -p never worked in 5.6. That was added in 5cde71d6 when it was
introduced in 2006:

    +sub run_cmd_pipe {
    +       my $fh =3D undef;
    +       open($fh, '-|', @_) or die;
    +       return <$fh>;
    +}

Can you show us the specific error you're getting, and the output of
your `perl -V` ?
