From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [RFC] Refspec patterns with * in the middle
Date: Mon, 2 Mar 2009 13:01:30 -0500
Message-ID: <76718490903021001h16009570p7ac8c66a8e8e1f90@mail.gmail.com>
References: <alpine.LNX.1.00.0903011820590.19665@iabervon.org>
	 <7viqmrn98i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 19:03:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeCTh-0001Lw-3O
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 19:02:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756759AbZCBSBd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Mar 2009 13:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756203AbZCBSBd
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 13:01:33 -0500
Received: from rv-out-0506.google.com ([209.85.198.226]:11797 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755888AbZCBSBb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Mar 2009 13:01:31 -0500
Received: by rv-out-0506.google.com with SMTP id g37so2366568rvb.1
        for <git@vger.kernel.org>; Mon, 02 Mar 2009 10:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hW8sI+NxSaKyMR8EWQo7U1RzD4J5htY6Cwy9F4jNQuo=;
        b=FWjZ+Vi0x++3a5D32axdeTS8UvFyNdgaNUEG3XJW3ZNnzuyYMSCoid0sIliifQVT2x
         97vq0+pSE9+UPe4EYNt+eGAiunWP6ODH3q0VXTxE0wMg7J9/BkuuDKsr/RPsr8e0QmZs
         3CpZTGPtmSimKjFU6k0gbyc8fJnh4WW0ALPMY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TQZCnHjt25QebMXAlsVjp7AGN7hixbMADDBdQc9BuKomRDOiBSxnW1DQJNS8j2jeEO
         icEIBOJGxZUmyC4UP9CS2KfwuGtwW9UVpueK9COFKuBIob7tBKZw7PqqUa939xKhEqWw
         KD4Vp3olps473pCJ+yd1kXfRUdJVvMbaFp0S4=
Received: by 10.141.122.1 with SMTP id z1mr3006488rvm.275.1236016890124; Mon, 
	02 Mar 2009 10:01:30 -0800 (PST)
In-Reply-To: <7viqmrn98i.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111955>

On Mon, Mar 2, 2009 at 12:08 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Daniel Barkalow <barkalow@iabervon.org> writes:
>
>> My use case is actually, more precisely:
>>
>> some/constant/stuff/$PROJ-$NUMBER/junk/my-proj
>>
>> Where $NUMBER is the version number, and $PROJ is usually, but not q=
uite
>> always "my-proj"; the exception being that it might be effectively a
>> superproject. So I'd like to have:
>>
>> =C2=A0fetch =3D some/constant/stuff/my-proj-*/junk/my-proj:refs/remo=
tes/origin/*
>
> ... and expect "some/constant/stuff/my-proj-2.5/junk/my-proj" to be m=
apped
> to "refs/remotes/origin/2.5"? =C2=A0I think it does not look too bad.
>
>> But I can live with remote branches like "my-proj-2.4" instead of "2=
=2E4".
>>
>> I think it would make sense, and limit typo damage, to say that the =
* can
>> only expand to something with a '/' in it if the star has a slash or=
 the
>> end of the string on each side.
>
> I do not understand what you mean by "* can only expand to something =
with
> a '/' in it if ..." part. =C2=A0None of the examples in your message =
have a
> case where the asterisk matches across directory boundaries, and I th=
ought
> you would simply say "* does not match /" and be done with that.
>
> What scenario do you have in mind that wants to match a slash with an
> asterisk?

I think he means the following are valid:

 - foo/bar/*/baz
 - foo/bar/baz/*

But the following is not:

 - foo/bar*/baz

IOW, '*' can only appear as a non-terminating symbol if it is bounded
by '/' on each side.

j.
