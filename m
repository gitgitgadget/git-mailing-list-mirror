From: Michael Horowitz <michael.horowitz@ieee.org>
Subject: Re: git-p4.skipSubmitEdit
Date: Fri, 16 Dec 2011 19:46:11 -0500
Message-ID: <CAFLRbor3Gnqhudmg8G_U37Nbo7ENoCEy0iFVGRP4i_AmatJHxw@mail.gmail.com>
References: <1315514452.10046.0.camel@uncle-pecos>
	<4E6DB5F0.7080303@diamand.org>
	<1315847540.10046.29.camel@uncle-pecos>
	<20111018004500.GA31768@arf.padd.com>
	<4E9DBD0B.7020505@diamand.org>
	<20111020011610.GA7292@arf.padd.com>
	<CAFLRboo8DBk3zFEBF9OqKmre=d5PM7+3J9V0pHNz53MPtqjOWA@mail.gmail.com>
	<4EEBA106.9010001@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pete Wyckoff <pw@padd.com>, "L. A. Linden Levy" <alevy@mobitv.com>,
	git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sat Dec 17 01:46:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbiPp-0003b5-Lh
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 01:46:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694Ab1LQAqN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Dec 2011 19:46:13 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:37232 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752480Ab1LQAqL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Dec 2011 19:46:11 -0500
Received: by pbdu13 with SMTP id u13so967399pbd.19
        for <git@vger.kernel.org>; Fri, 16 Dec 2011 16:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MkrHXPhB5/UrxXMO9D9zXPaP2aP7sNbUxfYL7wXwdSc=;
        b=V4YZ3HIrBNQlv7mWkVP6XMCq0o0jXAxCr8rrcbXzv29wyqFW2emBL5SqHa9H7CSJFV
         TkV6zZ/9N5jZyb+k5lLnVotbDD+ZnX37WLTF7lh/axTMoN6Hp6j0TOSLjiOKTRzFcN7z
         i+xMDdp1vZk7wUp/ezA9JzGer0XR4mMxgmUAc=
Received: by 10.68.191.2 with SMTP id gu2mr14262676pbc.39.1324082771106; Fri,
 16 Dec 2011 16:46:11 -0800 (PST)
Received: by 10.143.31.6 with HTTP; Fri, 16 Dec 2011 16:46:11 -0800 (PST)
In-Reply-To: <4EEBA106.9010001@diamand.org>
X-Google-Sender-Auth: zNTl4vCOXF0SSs5I7ZkrLojkKwE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187339>

Actually, it is the opposite.  Bailout works fine, it is when I ":wq"
in Vi for example, that it fails to submit and reverts all my changes.

        if os.stat(template_file).st_mtime <=3D mtime:
            while True:
                response =3D raw_input("Submit template unchanged.
Submit anyway? [y]es, [n]o (skip this patch) ")
                if response =3D=3D 'y':
                    return True
                if response =3D=3D 'n':
                    return False
        # I think this else needs to be added here, so when the file
has been modified since it was opened in the editor, it will properly
submit the change.
        else:
            return True


Mike



On Fri, Dec 16, 2011 at 2:50 PM, Luke Diamand <luke@diamand.org> wrote:
>
> On 16/12/11 15:38, Michael Horowitz wrote:
>>
>> All,
>>
>> It appears that this change has introduced a bug that causes submit =
to
>> fail every time if you do not skip the submit edit.
>>
>> =A0From what I can tell, this is because the new edit_template metho=
d
>> does not return True at the end.
>
>
> Could you say exactly what you're doing?
>
> I've just tried it myself and it seems to work fine:
>
> git-p4 clone
> git commit -m 'a change'
> git-p4 submit
> <quit from editor, with/without modifying it>
>
> And I couldn't see any paths in edit_template that returned without a=
 value of True, except the one where the user decides to bail out.
>
> This is with Pete's skipSubmitEdit change.
>
> Thanks!
> Luke
