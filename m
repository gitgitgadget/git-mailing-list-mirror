From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 19/21] grep: use writable strbuf from caller in grep_tree()
Date: Fri, 17 Dec 2010 16:56:43 +0700
Message-ID: <AANLkTi=hXQqtYmhtHh+D67d9puRrDA+iScpafaYYMsAk@mail.gmail.com>
References: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
 <1292425376-14550-20-git-send-email-pclouds@gmail.com> <7vy67pjlvb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 17 10:57:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTX3x-0006fJ-8q
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 10:57:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753196Ab0LQJ5P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Dec 2010 04:57:15 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40801 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114Ab0LQJ5O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Dec 2010 04:57:14 -0500
Received: by wwa36 with SMTP id 36so474301wwa.1
        for <git@vger.kernel.org>; Fri, 17 Dec 2010 01:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=6lXjhjnCBBzik49CbX0fhPC7TI3Dxs1/Tg0feNa99yU=;
        b=JxI04gycg2O5Fb6lXfluxh8p3pGz2UEP0GjF7HC38oJDhiqxVqdxlnp3i72LqhzQZv
         7R+XsbqURntaFBh43pssh//NWm21+wKj5JopCFW/FcXOJxKs3y85Vi7oaFTap12lhE8N
         rYEZJTuqMFx7Bdpup6VQkEfKAKJRNbZrIMr9M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=D8pb5FxZVI1J/WmT36cs32ao8sFyds63UDnPwJxH5hee/aawcr6FVF/bhQPeRas/00
         Nxbuly7ZlPW5DXPTS5PeDr/5ICk8Fme9Tmgjalis5+TMVG0XDs7wQc0RdzVbO4pfC1TK
         HMNMjB6fb/kM8s5h7lrSqEYT7rRPFN+o3KCEs=
Received: by 10.216.177.9 with SMTP id c9mr870813wem.34.1292579833720; Fri, 17
 Dec 2010 01:57:13 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Fri, 17 Dec 2010 01:56:43 -0800 (PST)
In-Reply-To: <7vy67pjlvb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163868>

2010/12/17 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hit =3D grep_tree(opt, p=
athspec, &tree, &base, base.neglen);
>
> If you are going to let the users of strbuf API to refer directly to =
the
> field, I think "neglen" should be renamed to something more reasonabl=
e,
> say, "offset".
>
> I am still debating myself if this strbuf_offset is anugly hack merel=
y to
> allow the implementation of "grep" not to carry one extra offset arou=
nd
> throughout its callchain, or if it is generic enough that other/futur=
e
> callers would benefit from. =C2=A0I am leaning toward to think this i=
s an ugly
> hack, as a new caller that wants to carry _two_ offsets into a strbuf
> wouldn't get much benefit from this new API. =C2=A0But I may be missr=
eading
> your code.
>

I did not want to another offset to tree_entry_interesting. But an
extra argument would be less ugly than an extra API.
--=20
Duy
