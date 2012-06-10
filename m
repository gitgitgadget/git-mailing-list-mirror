From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCHv6 1/4] Read (but not write) from $XDG_CONFIG_HOME/git/config
 file
Date: Sun, 10 Jun 2012 20:44:26 +0200
Message-ID: <CABPQNSYd0hCU8nrfKJJjR+T_jQn4WC6jEaSCJPjKsuPdumEdtw@mail.gmail.com>
References: <1338754481-27012-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <1338988885-21933-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <7vpq9aenl0.fsf@alter.siamese.dyndns.org> <20120608142601.Horde.Tq7UO3wdC4BP0e9ZGAy1EwA@webmail.minatec.grenoble-inp.fr>
 <7vvcj1dep7.fsf@alter.siamese.dyndns.org> <20120609125336.Horde.iUq0R3wdC4BP0yswpGlGBZA@webmail.minatec.grenoble-inp.fr>
 <7v4nqjbrdo.fsf@alter.siamese.dyndns.org> <20120610154850.Horde.gYrJO3wdC4BP1KXCOvLEiCA@webmail.minatec.grenoble-inp.fr>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu.Moy@grenoble-inp.fr,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
To: nguyenhu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Sun Jun 10 20:45:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sdn8U-0004Ap-HE
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 20:45:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755488Ab2FJSpI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Jun 2012 14:45:08 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:34702 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755206Ab2FJSpH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jun 2012 14:45:07 -0400
Received: by dady13 with SMTP id y13so4443935dad.19
        for <git@vger.kernel.org>; Sun, 10 Jun 2012 11:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=mRMRpNkEO5cUuhvK8WKWMaybyJWufSgnpseCGSECs7Q=;
        b=TyRrCuNCHBfwzoMQSTnbgy7KXgwn2G09cViurdGIGO2KKv1FmLZTACy33wwoYUNDEZ
         VL+zD8zh0vZaRECs5DJW5FT582z7ZM1Lm568U7CL7rboNQ4xzyCKy7QTaEyBXLg7P+bf
         xoIumx3RwCODHTSHWF3zmg1TVBA1R1zG0nAW/2KfvJUF83MqdKx+n6+9vmPdPDwic5ax
         Urjkme7hiaqM/2ZldV3eulzWPq4+hGSjAToGWSKxgOOmDPaWIyIfVN9N4FFw2E7mEI8I
         MXPcEMk7+YLR87HeX2h5prSy6gius6Uv/z5iuGqfAKJzbPjKwcTJTrHV1/unrtLMWcBT
         6I5g==
Received: by 10.68.194.105 with SMTP id hv9mr18059966pbc.126.1339353907029;
 Sun, 10 Jun 2012 11:45:07 -0700 (PDT)
Received: by 10.68.40.98 with HTTP; Sun, 10 Jun 2012 11:44:26 -0700 (PDT)
In-Reply-To: <20120610154850.Horde.gYrJO3wdC4BP1KXCOvLEiCA@webmail.minatec.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199620>

On Sun, Jun 10, 2012 at 3:48 PM,  <nguyenhu@minatec.inpg.fr> wrote:
>
> Junio C Hamano <gitster@pobox.com> a =E9crit=A0:
>
>>> char *mkpathdup(const char *fmt, ...)
>>> {
>>> =A0 =A0 =A0 =A0char *path;
>>> =A0 =A0 =A0 =A0struct strbuf sb =3D STRBUF_INIT;
>>> =A0 =A0 =A0 =A0va_list args;
>>>
>>> =A0 =A0 =A0 =A0va_start(args, fmt);
>>> =A0 =A0 =A0 =A0strbuf_vaddf(&sb, fmt, args);
>>> =A0 =A0 =A0 =A0va_end(args);
>>> =A0 =A0 =A0 =A0path =3D strbuf_detach(&sb, NULL);
>>>
>>> =A0 =A0 =A0 =A0strbuf_release(&sb);
>>> =A0 =A0 =A0 =A0return path;
>>> }
>>
>>
>> I didn't mean to suggest removing the call to clean-up-path
>> function. =A0What I meant was that strbuf_detach() is a way to take
>> the ownership of the buffer, so that you do not have to call
>> strbuf_release() on it.
>
>
> So with the call to clean-up-path function and without the call to
> strbuf_release(), mkpathdup() function becomes :
>
>
> char *mkpathdup(const char *fmt, ...)
> {
> =A0 =A0 =A0 =A0struct strbuf sb =3D STRBUF_INIT;
> =A0 =A0 =A0 =A0va_list args;
>
> =A0 =A0 =A0 =A0va_start(args, fmt);
> =A0 =A0 =A0 =A0strbuf_vaddf(&sb, fmt, args);
> =A0 =A0 =A0 =A0va_end(args);
>
> =A0 =A0 =A0 =A0return cleanup_path(strbuf_detach(&sb, NULL));
>
> }

The awkward thing about doing this, is that the memory allocated by
the strbuf cannot be reclaimed if you go with this. A pointer that has
been adjusted (like cleanup_path can do) cannot be successfully fed to
free.
