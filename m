From: Michael Horowitz <michael.horowitz@ieee.org>
Subject: Re: git-p4.skipSubmitEdit
Date: Fri, 16 Dec 2011 19:49:17 -0500
Message-ID: <CAFLRboqJAC0h27m=B9Tw5SFcupEgn4fe9YvWksgqxOVs20nFHw@mail.gmail.com>
References: <1315514452.10046.0.camel@uncle-pecos>
	<4E6DB5F0.7080303@diamand.org>
	<1315847540.10046.29.camel@uncle-pecos>
	<20111018004500.GA31768@arf.padd.com>
	<4E9DBD0B.7020505@diamand.org>
	<20111020011610.GA7292@arf.padd.com>
	<CAFLRboo8DBk3zFEBF9OqKmre=d5PM7+3J9V0pHNz53MPtqjOWA@mail.gmail.com>
	<4EEBA106.9010001@diamand.org>
	<CAFLRbor3Gnqhudmg8G_U37Nbo7ENoCEy0iFVGRP4i_AmatJHxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pete Wyckoff <pw@padd.com>, "L. A. Linden Levy" <alevy@mobitv.com>,
	git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sat Dec 17 01:49:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbiSp-0004Tm-5Z
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 01:49:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760512Ab1LQAtT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Dec 2011 19:49:19 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:61720 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625Ab1LQAtR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Dec 2011 19:49:17 -0500
Received: by pbdu13 with SMTP id u13so968051pbd.19
        for <git@vger.kernel.org>; Fri, 16 Dec 2011 16:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qR9n/JJyH4jx+lW9yACkuZ3Ko+K1jRLZ1HeD18Cm5tk=;
        b=WONd/qruHivsvDycfUMuAYQz7YP+NFUt6UCWuvbzMfODxYwCdlkhZZCTbmEs4wRScw
         E+HE8fP22pnhgAULY5ax+OP0x8CKzwTLbPHocM4wZeFfUs4TSTzaR20ZtxwhR7Htw7Xr
         J7BfibB8EJP+IwMWXGLeXeox6ZSRqy2cvDD5w=
Received: by 10.68.191.2 with SMTP id gu2mr14279924pbc.39.1324082957292; Fri,
 16 Dec 2011 16:49:17 -0800 (PST)
Received: by 10.143.31.6 with HTTP; Fri, 16 Dec 2011 16:49:17 -0800 (PST)
In-Reply-To: <CAFLRbor3Gnqhudmg8G_U37Nbo7ENoCEy0iFVGRP4i_AmatJHxw@mail.gmail.com>
X-Google-Sender-Auth: 8KO0En31wR68yM78nlN1QOG8njs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187341>

Oh, and in the case where you do edit the template, it doesn't give
you an error or anything, it looks like it succeeded, but you'll
notice the change never got submitted to Perforce.  If you look
carefully though, you can see it reverting each of your edited files
in the P4 tree.

Mike



On Fri, Dec 16, 2011 at 7:46 PM, Michael Horowitz
<michael.horowitz@ieee.org> wrote:
> Actually, it is the opposite. =A0Bailout works fine, it is when I ":w=
q"
> in Vi for example, that it fails to submit and reverts all my changes=
=2E
>
> =A0 =A0 =A0 =A0if os.stat(template_file).st_mtime <=3D mtime:
> =A0 =A0 =A0 =A0 =A0 =A0while True:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0response =3D raw_input("Submit templat=
e unchanged.
> Submit anyway? [y]es, [n]o (skip this patch) ")
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if response =3D=3D 'y':
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return True
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if response =3D=3D 'n':
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return False
> =A0 =A0 =A0 =A0# I think this else needs to be added here, so when th=
e file
> has been modified since it was opened in the editor, it will properly
> submit the change.
> =A0 =A0 =A0 =A0else:
> =A0 =A0 =A0 =A0 =A0 =A0return True
>
>
> Mike
>
>
>
> On Fri, Dec 16, 2011 at 2:50 PM, Luke Diamand <luke@diamand.org> wrot=
e:
>>
>> On 16/12/11 15:38, Michael Horowitz wrote:
>>>
>>> All,
>>>
>>> It appears that this change has introduced a bug that causes submit=
 to
>>> fail every time if you do not skip the submit edit.
>>>
>>> =A0From what I can tell, this is because the new edit_template meth=
od
>>> does not return True at the end.
>>
>>
>> Could you say exactly what you're doing?
>>
>> I've just tried it myself and it seems to work fine:
>>
>> git-p4 clone
>> git commit -m 'a change'
>> git-p4 submit
>> <quit from editor, with/without modifying it>
>>
>> And I couldn't see any paths in edit_template that returned without =
a value of True, except the one where the user decides to bail out.
>>
>> This is with Pete's skipSubmitEdit change.
>>
>> Thanks!
>> Luke
